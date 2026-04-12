package com.localguide.test;

import cn.hutool.core.bean.BeanUtil;
import com.localguide.dto.UserDTO;
import com.localguide.utils.UserHolder;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Time;
import java.util.Map;
import java.util.concurrent.TimeUnit;

//@Configuration
public class RefreshInterceptor implements HandlerInterceptor {
    private StringRedisTemplate redisTemplate;

    public RefreshInterceptor(StringRedisTemplate redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    /*
    * 刷新token
    * */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String token = request.getHeader("authorization");
        if (token == null){
            return true;
        }

        Map<Object, Object> map = redisTemplate.opsForHash().entries(token);
        UserDTO userDTOClass = BeanUtil.fillBeanWithMap(map, new UserDTO(), false);
        UserHolder.saveUser(userDTOClass);
        redisTemplate.expire(token,30, TimeUnit.MINUTES);
        return true;
    }
}
