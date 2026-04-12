package com.localguide.service.impl;

import cn.hutool.core.util.RandomUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.localguide.dto.Result;
import com.localguide.entity.UserInfo;
import com.localguide.mapper.UserInfoMapper;
import com.localguide.service.IUserInfoService;
import com.localguide.utils.RegexUtils;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;


import java.util.concurrent.TimeUnit;

import static com.localguide.utils.RedisConstants.LOGIN_CODE_KEY;
import static com.localguide.utils.RedisConstants.LOGIN_CODE_TTL;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ggb2580
 * @since 2025-12-30
 */
@Service
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements IUserInfoService {
    @Autowired
    private StringRedisTemplate redisTemplate;

    @Override
    public Result sendCode(String phone) {
        if (RegexUtils.isPhoneInvalid(phone)){
            return  Result.fail("手机号不正确!");
        }

        String code = RandomUtil.randomNumbers(6);
        //缓存验证码到redis并设置过期时间
        redisTemplate.opsForValue().set(LOGIN_CODE_KEY+phone, code,LOGIN_CODE_TTL,TimeUnit.MINUTES);
        String code1 = redisTemplate.opsForValue().get(LOGIN_CODE_KEY+phone);
        System.out.println(code1);
        log.debug("发送验证码成功 code：【"+code+"】");
        return Result.ok();
    }




}
