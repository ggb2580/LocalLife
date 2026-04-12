package com.localguide.test;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import cn.hutool.core.lang.UUID;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.localguide.dto.LoginFormDTO;
import com.localguide.dto.Result;
import com.localguide.dto.UserDTO;
import com.localguide.entity.User;
import com.localguide.mapper.UserMapper;
import com.localguide.utils.RegexUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.jws.soap.SOAPBinding;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Service
public class LoginServiceImpl extends ServiceImpl<UserMapper,User> implements LoginService{
@Autowired
private StringRedisTemplate redisTemplate;
    @Override
    public Result getCode(String phone) {
       //手机号校验  为空 正则表达式
        String PHONE_REGEX = "^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\\d{8}$";
        if (StrUtil.isEmpty(phone)||!phone.matches(PHONE_REGEX)){
            return Result.fail("手机号不正确!");
        }
        //获取验证码
        String code = RandomUtil.randomNumbers(6);
        log.debug("验证码为:【"+code+"】");
        String token = UUID.randomUUID().toString();
        redisTemplate.opsForValue().set("login:code:"+phone,code,5,TimeUnit.MINUTES);
        return Result.ok();
    }

    @Override
    public Result login(LoginFormDTO loginFormDTO) {
       String phone = loginFormDTO.getPhone();
       if (RegexUtils.isPhoneInvalid(phone)){
           return Result.fail("手机号不正确!");
       }
       //获取验证码
        String code = redisTemplate.opsForValue().get("login:code:"+phone);

       if (code==null||!code.equals(loginFormDTO.getCode())){
           return Result.fail("验证码错误，请重新输入");
       }
       //查询用户
        User user = query().eq("phone",phone).one();
       if (user==null){
           user = createUserWithPhone(phone);
       }
       //存入到redis中
        UserDTO userDTO = BeanUtil.copyProperties(user, UserDTO.class);
        Map<String, Object> map = BeanUtil.beanToMap(userDTO, new HashMap<>(),
                CopyOptions.create()
                        .setIgnoreNullValue(true)
                        .setFieldValueEditor((filed, filedValue) -> filedValue.toString()));
        String key = UUID.randomUUID().toString(true);
        redisTemplate.opsForHash().putAll("user:login:"+key,map);
        //设置过期时间
        redisTemplate.expire("user:login:"+key,30,TimeUnit.MINUTES);
        return Result.ok("user:login:"+key);

    }

    //创建用户
    private User createUserWithPhone(String phone) {
        User user = new User();
        user.setPhone(phone);
        user.setNickName("user_"+RandomUtil.randomString(10));
        save(user);
        return user;
    }
}
