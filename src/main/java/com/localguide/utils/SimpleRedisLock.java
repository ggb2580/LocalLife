package com.localguide.utils;

import cn.hutool.core.lang.UUID;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.data.redis.core.script.RedisScript;

import java.util.Collections;
import java.util.concurrent.TimeUnit;

public class SimpleRedisLock implements ILock{
    private StringRedisTemplate redisTemplate;
    private String name;
    private static final String KEY_PREFIX = "lock:";
    private static final String ID_PREFIX = UUID.randomUUID().toString(true)+"-";
    private static final DefaultRedisScript<Long> UNLOCK_SCRIPT;
//    类加载时初始化
    static {

        UNLOCK_SCRIPT = new DefaultRedisScript<>();
        //加载lua脚本
        UNLOCK_SCRIPT.setLocation(new ClassPathResource("unlock.lua"));
        UNLOCK_SCRIPT.setResultType(Long.class);
    }

    public SimpleRedisLock(String name, StringRedisTemplate redisTemplate) {
        this.name = name;
        this.redisTemplate = redisTemplate;

    }
    /*
    * 获取锁
    * */
    @Override
    public boolean tryLock(long timeoutSec) {
        //获取当前当前线程
        String threadId = ID_PREFIX+Thread.currentThread().getId();
        Boolean result = redisTemplate.opsForValue().setIfAbsent(KEY_PREFIX + name,
                threadId, timeoutSec, TimeUnit.SECONDS);
        return Boolean.TRUE.equals(result);
    }

    @Override
    public void unlock() {
        redisTemplate.execute(UNLOCK_SCRIPT,
                Collections.singletonList(KEY_PREFIX+name),
                ID_PREFIX+Thread.currentThread().getId());

    }
    /*
    * 之前释放锁为两行代码 一个查询锁 一个释放锁，如果查询锁出现阻塞就会出现，就会出现误删情况
    * 现在为一行代码，就会保证原子性，要么成功，要么失败
    * */
//    @Override
//    public void unlock() {
//        //释放锁前判断是不是同一个ID
//        String threadId = ID_PREFIX + name;
//        //获取当前线程的ID
//        String id = redisTemplate.opsForValue().get(KEY_PREFIX + name);
//        //如果相等表示执行完后可以释放锁
//        if (threadId.equals(id)){
//            redisTemplate.delete(KEY_PREFIX+name);
//        }
//    }
}
