package com.localguide.test;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.concurrent.TimeUnit;

@SpringBootTest
public class RedissonTest {
    private static final Logger log = LoggerFactory.getLogger(RedissonTest.class);
    @Resource
    private RedissonClient redissonClient1;
    @Resource
    private RedissonClient redissonClient2;
    @Resource
    private RedissonClient redissonClient3;
    private RLock lock;
    @BeforeEach
    void setup(){
        RLock lock1 = redissonClient1.getLock("order");
        RLock lock2 = redissonClient1.getLock("order");
        RLock lock3 = redissonClient1.getLock("order");

        //创建联锁
        lock = redissonClient1.getMultiLock(lock1,lock2,lock3);

    }
    @Test
    void method() throws InterruptedException {
        //尝试获取锁
        boolean isLock = lock.tryLock(1L, TimeUnit.SECONDS);
        if (!isLock){
            log.error("获取锁失败~~~~");
            return;
        }
    }

}
