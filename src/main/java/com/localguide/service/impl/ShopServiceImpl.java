package com.localguide.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.BooleanUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.localguide.dto.Result;
import com.localguide.entity.Shop;
import com.localguide.mapper.ShopMapper;
import com.localguide.service.IShopService;
import com.localguide.utils.RedisData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import static com.localguide.utils.RedisConstants.*;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ggb2580
 * @since 2026-01-08
 */
@Service
public class ShopServiceImpl extends ServiceImpl<ShopMapper, Shop> implements IShopService {
    @Autowired
    private StringRedisTemplate redisTemplate;

    private static final ExecutorService CACHE_REBUILD_EXECUTOR = Executors.newFixedThreadPool(10);

    //根据id查询商铺信息
    @Override
    public Result getShopById(Long id) {
        //用互斥锁解决缓存击穿
//        Shop shop = queryWithMutex(id);
        //用逻辑过期解决缓存击穿
        Shop shop = queryWithLogicExpire(id);
        if (shop==null){
            return Result.fail("店铺信息不存在");
        }
        return Result.ok(shop);

    }

    //逻辑过期
    private Shop queryWithLogicExpire(Long id) {
        //缓存是否存在
        String key = CACHE_SHOP_KEY+id;
        String lockKey = LOCK_SHOP_KEY+id;
        String s = redisTemplate.opsForValue().get(key);
        //缓存为空值 直接返回
        if (StrUtil.isBlank(s)){
            return  null;
        }

        //不为空值 判断是否过期
        RedisData data = JSONUtil.toBean(s, RedisData.class);
        JSONObject shopJson = (JSONObject) data.getData();
        Shop shop = JSONUtil.toBean(shopJson, Shop.class);

        LocalDateTime expireTime = data.getExpireTime();

        //未过期
        if (expireTime.isAfter(LocalDateTime.now())){
            return shop;
        }
        //已过期 重建
        boolean b = tryLock(lockKey);
        //获取到互斥锁
        if (b){
            //开启一个独立线程
            CACHE_REBUILD_EXECUTOR.submit(()->{
                try {
                    this.saveShopToRedis(id,30L);
                }catch (Exception e){
                    throw new RuntimeException();
                }finally {
                    unLock(lockKey);
                }
            });
        }
        return shop;
    }

    //缓存重建
    public void saveShopToRedis(Long id,Long expireTime){
        //查询数据
        Shop shop = query().eq("id", id).one();
        RedisData redisData = new RedisData();
        redisData.setData(shop);
        redisData.setExpireTime(LocalDateTime.now().plusSeconds(expireTime));
        redisTemplate.opsForValue().set(CACHE_SHOP_KEY+id,JSONUtil.toJsonStr(redisData));
    }

    //用互斥锁进行缓存重建
    private Shop queryWithMutex(Long id) {
        String key = CACHE_SHOP_KEY+id;
        String lockKey = LOCK_SHOP_KEY+id;

        //判断是否有缓存
        String shop = redisTemplate.opsForValue().get(key);
        if (StrUtil.isNotBlank(shop)){
            //返回数据
            return JSONUtil.toBean(shop, Shop.class);
        }
        //缓存为空值
        if (shop!=null){
            return null;
        }

        //重建缓存
        boolean b = tryLock(lockKey);
        if (!b){
            try {
                Thread.sleep(10);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
            return queryWithMutex(id);
        }

        //获取数据库
        Shop shop1 = query().eq("id",id).one();
        //数据不存在 缓存空值
        if (shop1==null){
            redisTemplate.opsForValue().set(CACHE_SHOP_KEY+id,"",CACHE_NULL_TTL, TimeUnit.MINUTES);
            return null;
        }
        //缓存对象
        redisTemplate.opsForValue().set(key,JSONUtil.toJsonStr(shop1),CACHE_SHOP_TTL, TimeUnit.MINUTES);

        //释放互斥锁
        try {
            unLock(lockKey);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return shop1;
    }

    private boolean tryLock(String lockKey) {
        //设置锁时间为10秒
        Boolean ifAbsent = redisTemplate.opsForValue().setIfAbsent(lockKey, "1", LOCK_SHOP_TTL, TimeUnit.SECONDS);
        //防止为空对象
        return BooleanUtil.isTrue(ifAbsent);
    }

    //释放锁
    private void unLock(String lockKey){
        redisTemplate.delete(lockKey);
    }

    //更新店铺信息
    @Transactional
    @Override
    public Result updateShop(Shop shop) {
        Long id = shop.getId();
        if (id==null){
            return Result.fail("店铺更新失败");
        }
        String key = CACHE_SHOP_KEY+id;
        save(shop);
        //删除缓存
        redisTemplate.delete(key);
        return Result.ok();
    }
}
