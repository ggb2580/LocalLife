package com.localguide.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import cn.hutool.core.lang.UUID;
import cn.hutool.core.util.RandomUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.localguide.dto.LoginFormDTO;
import com.localguide.dto.Result;
import com.localguide.dto.UserDTO;
import com.localguide.entity.User;
import com.localguide.mapper.UserMapper;
import com.localguide.service.IUserService;
import com.localguide.utils.RedisData;
import com.localguide.utils.RegexUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import static com.localguide.utils.RedisConstants.*;
import static com.localguide.utils.SystemConstants.USER_NICK_NAME_PREFIX;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author ggb2580
 * @since 2026-01-08
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {
    @Autowired
    private StringRedisTemplate redisTemplate;
    //登录
    @Override
    public Result login(LoginFormDTO loginForm, HttpServletRequest request) {

        String phone = loginForm.getPhone();
        if(RegexUtils.isPhoneInvalid(phone)){
            return Result.fail("手机号格式不正确");
        }

        String key = LOGIN_CODE_KEY+phone;
        //获取验证码
        String code = redisTemplate.opsForValue().get(key);

        if(code==null || !code.equals(loginForm.getCode())){
            return Result.fail("验证码不正确");
        }

        //查询用户
        User user;
        user = query().eq("phone",phone).one();

        if (user==null){
            user = createUserWithPhone(phone);
        }

        //对象转成map

        String userToken = UUID.randomUUID().toString(true);

        UserDTO userDTO = BeanUtil.copyProperties(user, UserDTO.class);
        Map<String,Object> userMap = BeanUtil.beanToMap(userDTO,new HashMap<>(),
                CopyOptions.create()
                        .setIgnoreNullValue(true)
                        .setFieldValueEditor((filedName,fieldValue)
                                ->fieldValue.toString()));

        //保存用户信息到redis
        redisTemplate.opsForHash().putAll(LOGIN_USER_KEY+userToken,userMap);
        redisTemplate.expire(LOGIN_USER_KEY+userToken,LOGIN_USER_TTL,TimeUnit.SECONDS);

        return Result.ok(userToken);
    }

    //创建用户
    private User createUserWithPhone(String phone) {
        //用户
        User user = new User();
        user.setNickName(USER_NICK_NAME_PREFIX+ RandomUtil.randomString(10));
        user.setPhone(phone);
        save(user);
        return user;
    }
}
