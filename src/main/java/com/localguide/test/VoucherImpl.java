package com.localguide.test;

import com.baomidou.mybatisplus.extension.conditions.query.QueryChainWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.localguide.dto.Result;
import com.localguide.entity.SeckillVoucher;
import com.localguide.entity.Voucher;
import com.localguide.entity.VoucherOrder;
import com.localguide.mapper.VoucherOrderMapper;
import com.localguide.service.IVoucherOrderService;
import com.localguide.service.IVoucherService;
import com.localguide.service.impl.SeckillVoucherServiceImpl;
import com.localguide.service.impl.VoucherServiceImpl;
import com.localguide.utils.RedisIdWorker;
import com.localguide.utils.SimpleRedisLock;
import com.localguide.utils.UserHolder;
import org.springframework.aop.framework.AopContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class VoucherImpl extends ServiceImpl<VoucherOrderMapper, VoucherOrder> implements VoucherService{
    @Autowired
    private SeckillVoucherServiceImpl voucherService;
    @Autowired
    private StringRedisTemplate redisTemplate;
    public Result getVoucher(Long voucherId){
        //判断当前是否是抢购时间
        SeckillVoucher voucher = voucherService.query().eq("voucher_id", voucherId).one();
        System.out.println(voucher.getBeginTime());
        if (voucher.getBeginTime().isAfter(LocalDateTime.now())) {
            return Result.fail("当前抢购未开始");
        }
        //抢购结束
        if (voucher.getEndTime().isBefore(LocalDateTime.now())) {
            return Result.fail("当前抢购已经结束");
        }
        //库存订单
        if (voucher.getStock()==0) {
            return Result.fail("当前优惠券已经抢完");
        }

        //优惠券抢购
        Long userId = UserHolder.getUser().getId();

        //获取锁
        SimpleRedisLock redisLock = new SimpleRedisLock("order",redisTemplate);
        if (!redisLock.tryLock(10)) {
            return Result.fail("不允许重复下单");
        }
        //在类里面直接调用方法，会导致事务失效，解决用代理对象
        VoucherService proxy = (VoucherService) AopContext.currentProxy();
        Result order = proxy.createOrder(voucherId);
        redisLock.unlock();
        return order;
    }

    //涉及多张表，需要添加事务
    @Transactional
    public Result createOrder(Long voucherId){
        //是否已经有当前用户Id的优惠券订单
        Long userId = UserHolder.getUser().getId();
        Long count = query().eq("user_id", userId).count();
        if (count > 0){
            return Result.fail("当前用户已经抢购过了");
        }

        //修改库存
        boolean update = voucherService.update().setSql(" stock = stock -1")
                .eq("voucher_id", voucherId)
                .gt("stock", 0)
                .update();
        if (!update){
            return  Result.fail("优惠券库存不足");
        }
        //创建订单
        VoucherOrder voucherOrder = new VoucherOrder();
        voucherOrder.setVoucherId(voucherId);
        voucherOrder.setUserId(userId);
        Long orderId = new RedisIdWorker(redisTemplate).nextId("voucherOrder");
        voucherOrder.setId(orderId);
        save(voucherOrder);
        return Result.ok(orderId);
    }

}
