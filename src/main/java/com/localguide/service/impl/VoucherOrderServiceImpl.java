package com.localguide.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.localguide.dto.Result;
import com.localguide.entity.SeckillVoucher;
import com.localguide.entity.VoucherOrder;
import com.localguide.mapper.VoucherOrderMapper;
import com.localguide.service.IVoucherOrderService;
import com.localguide.utils.RedisIdWorker;
import com.localguide.utils.SimpleRedisLock;
import com.localguide.utils.UserHolder;
import lombok.extern.slf4j.Slf4j;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.aop.framework.AopContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.redis.connection.stream.*;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.data.redis.core.script.DigestUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.concurrent.*;

@Slf4j
@Service
public class VoucherOrderServiceImpl extends ServiceImpl<VoucherOrderMapper, VoucherOrder> implements IVoucherOrderService {
    @Autowired
    private VoucherServiceImpl voucherService;
    @Autowired
    private SeckillVoucherServiceImpl seckillVoucherService;
    @Autowired
    StringRedisTemplate stringRedisTemplate;
    @Autowired
    RedisIdWorker redisIdWorker;
    @Autowired
    private RedissonClient redissonClient;
//    @Autowired
    private IVoucherOrderService proxy ;

    @Autowired
    private ApplicationContext applicationContext;
    private volatile boolean running = true;          // 控制后台线程运行
    private Thread backgroundThread;                  // 保存后台线程引用

    public VoucherOrderServiceImpl() {
    }

    /*
     * 秒杀下单
     * */
//    @Override
//    public Result seckillVoucher(Long voucherId) throws InterruptedException {
//        SeckillVoucher voucher = seckillVoucherService.query().eq("voucher_id", voucherId).one();
//        //未开始
//        System.out.println("开始时间" + voucher.getBeginTime());
//        if (voucher.getBeginTime().isAfter(LocalDateTime.now())) {
//            return Result.fail("当前秒杀活动未开始!");
//        }
//        //活动已结束
//        if (voucher.getEndTime().isBefore(LocalDateTime.now())) {
//            return Result.fail("当前秒杀活动已结束!");
//        }
//        //库存不足
//        if (voucher.getStock() < 1) {
//            return Result.fail("库存不足");
//        }
//
//        //redis实现分布式锁
//        Long userId = UserHolder.getUser().getId();
//        RLock lock = redissonClient.getLock("order:"+userId);
//        boolean isLock = lock.tryLock(1,10, TimeUnit.SECONDS);
//
//
    private static final DefaultRedisScript<Long> SECKILL_SCRIPT;
    //    类加载时初始化
    static {

        SECKILL_SCRIPT = new DefaultRedisScript<>();
        //加载lua脚本
        SECKILL_SCRIPT.setLocation(new ClassPathResource("seckill.lua"));
        SECKILL_SCRIPT.setResultType(Long.class);
    }

    //创建阻塞队列
    private BlockingQueue<VoucherOrder> orderTask = new ArrayBlockingQueue<>(1024*1024);
    private static final ExecutorService SECKILL_ORDER_EXECUTOR = Executors.newSingleThreadExecutor();




    @PostConstruct
    private void init() {
        log.info("===== 秒杀订单消费线程启动成功 =====");
        // 使用独立线程运行 VoucherOrderHandler，方便后续中断
        backgroundThread = new Thread(() -> {
            proxy = applicationContext.getBean(IVoucherOrderService.class);
            new VoucherOrderHandler().run();
        }, "voucher-order-handler");
        backgroundThread.start();
    }

    @PreDestroy
    public void destroy() {
        log.info("===== 关闭秒杀订单消费线程 =====");
        running = false;                     // 通知循环退出
        if (backgroundThread != null) {
            backgroundThread.interrupt();    // 中断线程（处理可能的阻塞等待）
            try {
                backgroundThread.join(5000); // 等待最多5秒
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }
    //如何让这个类初始化完成就执行这个任务  可以通过PostContruct 这个注解
    private class VoucherOrderHandler implements Runnable{
        String queueName = "stream.orders";
        @Override
        public void run() {
            while (true){
                //1.获取队列中的订单信息
                try {
                    //1. 获取消息队列中的订单消息 XREADGROUP GROUP g1 c1 COUNT 1 BLOCK 2000 STREAMS stream.orders >
                    List<MapRecord<String, Object, Object>> list = stringRedisTemplate.opsForStream().read(
                            Consumer.from("g1", "c1"),
                            StreamReadOptions.empty().count(1).block(Duration.ofSeconds(2)),
                            StreamOffset.create(queueName, ReadOffset.lastConsumed())
                    );
                    //2. 判断消息是否获取成功
                    if (list == null || list.isEmpty()){
                        //如果获取失败 说明没有消息 继续下一次循环
                        continue;
                    }
                    //3.解析消息中的订单信息
                    MapRecord<String,Object,Object> record = list.get(0);
                    Map<Object, Object> value = record.getValue();
                    VoucherOrder voucherOrder = BeanUtil.fillBeanWithMap(value, new VoucherOrder(), true);
                    //4.如果获取成功，可以下订单
                    handlerVoucherOrder(voucherOrder);
                    //5.ACK 确认SACK stream.orders g1 id
                    stringRedisTemplate.opsForStream().acknowledge(queueName,"g1",record.getId());
                } catch (Exception e) {
                    log.error("订单处理异常",e);
                    handlePendingList();
                }
            }
        }

        private void handlePendingList() {
            while (true){

                    // 1.获取pending-list 中的订单信息 XREADGROUP GROUP g1 c1 COUNT 1 STEAMS streams.order 0
                try {
                    List<MapRecord<String, Object, Object>> list = stringRedisTemplate.opsForStream().read(
                            Consumer.from("g1", "c1"),
                            StreamReadOptions.empty().count(1),
                            StreamOffset.create(queueName, ReadOffset.from("0"))
                    );
                    //2. 判断消息是否获取成功
                    if (list == null || list.isEmpty()){
                        //如果获取失败 说明没有消息 继续下一次循环
                        continue;
                    }
                    //3.解析消息中的订单信息
                    MapRecord<String,Object,Object> record = list.get(0);
                    Map<Object, Object> value = record.getValue();
                    VoucherOrder voucherOrder = BeanUtil.fillBeanWithMap(value, new VoucherOrder(), true);
                    //4.如果获取成功，可以下订单
                    handlerVoucherOrder(voucherOrder);
                    //5.ACK 确认SACK stream.orders g1 id
                    stringRedisTemplate.opsForStream().acknowledge(queueName,"g1",record.getId());
                } catch (Exception e) {
                    log.error("订单处理异常",e);
                    try {
                        Thread.sleep(20);
                    } catch (InterruptedException ex) {
                        throw new RuntimeException(ex);
                    }
                }

            }
        }


        private void handlerVoucherOrder(VoucherOrder voucherOrder) {
            //这里需要注意 由于开启的是新的线程 因此无法取到ThreadLocal里面的值
            Long userId = voucherOrder.getUserId();
            //创建锁对象
            RLock rLock = redissonClient.getLock("lock:order:"+userId);
            //获取锁
            boolean isLock = rLock.tryLock();
            //判断是否获取锁成功
            try {
                if (!isLock){
                    //获取锁失败，返回错误或重试
                    log.error("不允许重复下单");
                    return;
                }
                // 这里才是正确获取代理的地方！

                proxy.createVoucherOrder(voucherOrder);
                log.info("订单创建成功！订单ID：{}", voucherOrder.getId());
            } catch (Exception e) {
                // 必须打印完整错误！！
                log.error("下单失败！！！", e);
            }finally {
                //解锁
                if (rLock.isHeldByCurrentThread()) {
                    rLock.unlock();
                }
            }
            //返回优惠券订单ID

        }
    }


    @Override
    @Transactional
    //创建秒杀订单
    public void createVoucherOrder(VoucherOrder voucherOrder){
        //一人一单
        Long userId = voucherOrder.getUserId();

        //查询订单
        Long count = query().eq("user_id", userId).eq("voucher_id", voucherOrder.getVoucherId()).count();
        if (count > 0){
            log.error("您已经抢购过了~~~");
            return;
        }

        //扣减库存
        boolean update = seckillVoucherService.update()
                .setSql("stock = stock -1")
                .eq("voucher_id", voucherOrder.getVoucherId())
                //判断库存是否更之前一致
                .gt("stock", 0)
                .update();
        if (!update) {
            log.error("秒杀券抢购失败~~");
        }

        //创建订单

        save(voucherOrder);
    }

    ////        SimpleRedisLock redisLock = new SimpleRedisLock("order:"+userId,stringRedisTemplate);
////        //获取锁
////        boolean result = redisLock.tryLock(12);
//        if (!isLock){
//            return Result.fail("不允许重复下单");
//        }
//        //获取锁成功
//
//        //获取代理对象（事务）
//        try {
//            IVoucherOrderService proxy = (IVoucherOrderService) AopContext.currentProxy();
//            return proxy.createVoucherOrder(voucherId);
//        }finally {
//            //释放锁
//            lock.unlock();
//        }
//    }

    @Transactional
    @Override
    //创建秒杀订单
    public Result createVoucherOrder(Long voucherId){
        //一人一单
        Long userId = UserHolder.getUser().getId();

        //查询订单
        Long count = query().eq("user_id", userId).eq("voucher_id", voucherId).count();
        if (count > 0){
            return Result.fail("您已经抢购过了~~~");
        }

        //扣减库存
        boolean update = seckillVoucherService.update()
                .setSql("stock = stock -1")
                .eq("voucher_id", voucherId)
                //判断库存是否更之前一致
                .gt("stock", 0)
                .update();
        if (!update) {
            return Result.fail("秒杀券抢购失败~~");
        }

        //创建订单

        VoucherOrder voucherOrder = new VoucherOrder();
        Long order = new RedisIdWorker(stringRedisTemplate).nextId("order");
        //订单编号
        voucherOrder.setId(order);
        //秒杀券ID
        voucherOrder.setVoucherId(voucherId);
        //用户
        System.out.println(UserHolder.getUser().getNickName());

        System.out.println("用户ID" + userId);
        voucherOrder.setUserId(userId);

        save(voucherOrder);
        //返回优惠券订单ID
        return Result.ok(order);
    }

    @Override
    public Result seckillVoucher(Long voucherId) throws InterruptedException {
        //获取用户
        Long userId = UserHolder.getUser().getId();
        //执行lua脚本
        long orderId = redisIdWorker.nextId("order");
        Long result = stringRedisTemplate.execute(
                SECKILL_SCRIPT,
                Collections.emptyList(),
                voucherId.toString(),
                userId.toString(),
                String.valueOf(orderId)
        );

        //判断结果是否为0
        if (result != 0){
            return  Result.fail(result ==1?"库存不足":"不能重复下单");
        }
        //为0 有购买资格
//        proxy = (IVoucherOrderService) AopContext.currentProxy();
        //返回订单ID
        return Result.ok(orderId);
    }

}


//    @Override
//    public Result seckillVoucher(Long voucherId) throws InterruptedException {
//        //获取用户
//        Long userId = UserHolder.getUser().getId();
//        //执行lua脚本
//        Long result = stringRedisTemplate.execute(
//                SECKILL_SCRIPT,
//                Collections.emptyList(),
//                voucherId.toString(),
//                userId.toString()
//        );
//
//        //判断结果是否为0
//        if (result != 0){
//            return  Result.fail(result ==1?"库存不足":"不能重复下单");
//        }
//        //为0 有购买资格
//        long orderId = redisIdWorker.nextId("order");
//        //TODO 保存阻塞消息队列
//        VoucherOrder voucherOrder = new VoucherOrder();
//        //订单编号
//        voucherOrder.setId(orderId);
//        //秒杀券ID
//        voucherOrder.setVoucherId(voucherId);
//        //用户Id
//        voucherOrder.setUserId(userId);
//        //创建阻塞队列
//        proxy = (IVoucherOrderService) AopContext.currentProxy();
//        orderTask.add(voucherOrder);
//        //返回订单ID
//        return Result.ok(orderId);
//    }
//
//}
//
