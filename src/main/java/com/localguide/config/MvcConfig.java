package com.localguide.config;

import com.localguide.utils.RefreshTokenInterceptor;
import com.localguide.utils.LoginInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MvcConfig implements WebMvcConfigurer {
    @Autowired
    private StringRedisTemplate redisTemplate;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        //刷新token
        registry.addInterceptor(new RefreshTokenInterceptor(redisTemplate))
                .addPathPatterns(
                        "/**"
                ).order(0);
        //登录拦截
        registry.addInterceptor(new LoginInterceptor(redisTemplate))
                .excludePathPatterns(
                        "/shop/**",
                        "/voucher/**",
                        "/shop-type/**",
                        "/upload/**",
                        "/blog/hot",
                        "/user/code",
                        "/user/login"
                ).order(1);

    }
}

