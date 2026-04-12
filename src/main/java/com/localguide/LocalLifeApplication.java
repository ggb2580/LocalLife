package com.localguide;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;


@MapperScan("com.localguide.mapper")
@EnableAspectJAutoProxy(exposeProxy = true)
@SpringBootApplication
public class LocalLifeApplication {

    public static void main(String[] args) {
        SpringApplication.run(LocalLifeApplication.class, args);
    }

}
