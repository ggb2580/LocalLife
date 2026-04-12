package com.localguide.test;

import com.localguide.service.impl.ShopServiceImpl;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

@SpringBootTest
public class ShopTest {
@Resource
private ShopServiceImpl service;
    @Test
    public void test01(){
        for(int i=0;i<14;i++){
            service.saveShopToRedis(Long.parseLong(i+""),30L);
        }


    }
}
