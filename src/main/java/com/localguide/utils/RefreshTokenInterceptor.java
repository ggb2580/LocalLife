package com.localguide.utils;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import com.localguide.dto.UserDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Map;
import java.util.concurrent.TimeUnit;

import static com.localguide.utils.RedisConstants.LOGIN_USER_KEY;
import static com.localguide.utils.RedisConstants.LOGIN_USER_TTL;

public class RefreshTokenInterceptor implements HandlerInterceptor {
    private static final Logger log = LoggerFactory.getLogger(RefreshTokenInterceptor.class);
    private StringRedisTemplate redisTemplate;

    public RefreshTokenInterceptor(StringRedisTemplate redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String token = request.getHeader("authorization");
        if (StrUtil.isBlank(token)){
            return true;
        }

        //基于token获取redis数据
        Map<Object, Object> userMap = redisTemplate.opsForHash().entries(LOGIN_USER_KEY + token);


        UserDTO user = BeanUtil.fillBeanWithMap(userMap,new UserDTO(),false);
        //刷新token有效期
        redisTemplate.expire(LOGIN_USER_KEY + token,LOGIN_USER_TTL, TimeUnit.SECONDS);
        UserHolder.saveUser(user);
        return true;
    }

}
