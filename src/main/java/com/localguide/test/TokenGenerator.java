package com.localguide.test;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import cn.hutool.core.lang.UUID;
import cn.hutool.core.util.RandomUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.localguide.dto.UserDTO;
import com.localguide.entity.User;
import com.localguide.mapper.UserMapper;
import com.localguide.utils.RedisConstants;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.StringRedisTemplate;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@SpringBootTest
public class TokenGenerator {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Test
    public void generate1000Tokens() {
        for (int i = 0; i < 1000; i++) {
            String phone = "138" + String.format("%08d", i);
            User user = userMapper.selectOne(new QueryWrapper<User>().eq("phone", phone));
            if (user == null) {
                user = new User();
                user.setPhone(phone);
                user.setNickName("test_" + RandomUtil.randomString(8));
                userMapper.insert(user);
            }

            String userToken = UUID.randomUUID().toString(true);
            UserDTO userDTO = BeanUtil.copyProperties(user, UserDTO.class);
            Map<String, Object> userMap = BeanUtil.beanToMap(userDTO, new HashMap<>(),
                    CopyOptions.create()
                            .setIgnoreNullValue(true)
                            .setFieldValueEditor((filedName, fieldValue) -> fieldValue.toString()));

            String redisKey = RedisConstants.LOGIN_USER_KEY + userToken;
            stringRedisTemplate.opsForHash().putAll(redisKey, userMap);
            stringRedisTemplate.expire(redisKey, RedisConstants.LOGIN_USER_TTL, TimeUnit.SECONDS);

            try (FileWriter fw = new FileWriter("tokens.csv", true);
                 BufferedWriter bw = new BufferedWriter(fw);
                 PrintWriter out = new PrintWriter(bw)) {
                out.println(userToken);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            System.out.println(userToken);
        }
    }
}