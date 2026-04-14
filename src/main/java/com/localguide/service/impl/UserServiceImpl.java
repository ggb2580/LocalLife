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
import com.localguide.utils.UserHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.BitFieldSubCommands;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
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

    /*
    * 用户关注
    * */
    @Override
    public Result sign() {
        //1.获取当前用户
        Long userId = UserHolder.getUser().getId();
        //2.获取日期
        LocalDateTime now = LocalDateTime.now();
        //3.拼接key
        String keySuffix = now.format(DateTimeFormatter.ofPattern(":yyyyMM"));
        String key = USER_SIGN_KEY + userId + keySuffix;
        //4.获取今天是本月的第几天
        int dayOfMonth = now.getDayOfMonth();
        //5.写进redis SETBIT key offset 1
        redisTemplate.opsForValue().setBit(key,dayOfMonth - 1,true);
        return Result.ok();
    }

    /*
    * 签到统计
    * */
    @Override
    public Result signCount() {
        //1.获取当前登录用户
        Long userId = UserHolder.getUser().getId();
        //2.获取日期
        LocalDateTime now = LocalDateTime.now();
        //3.拼接key
        String keySuffix = now.format(DateTimeFormatter.ofPattern(":yyyyMM"));
        String key = USER_SIGN_KEY + userId + keySuffix;
        //4.获取今天是本月的第几天
        int dayOfMonth = now.getDayOfMonth();
        //5.获取本月截止今天为止的所有签到，返回的是一个十进制的数字 BITFIELD sign:5:202604 GET u14 0
        List<Long> result = redisTemplate.opsForValue().bitField(
                key,
                BitFieldSubCommands.create()
                        .get(BitFieldSubCommands.BitFieldType.unsigned(dayOfMonth)).valueAt(0)
        );
        if(result == null || result.isEmpty()){
            //没有任何签到结果
            return Result.ok(0);
        }
        Long num = result.get(0);
        if (num == null || num == 0){

            return Result.ok(0);
        }
        //6.循环遍历
        int count = 0;
        while (true){
            //6.1 让这个数字与1做运算 得到数字最后一个bit位
            if((num & 1 ) == 0){
                //如果为0 说明未签到 结束
                break;
            }else{
                //如果不为0 说明已经签到 计算器+1
                count ++;
            }
            //把数字右移一位 抛弃最后一个bit位 继续下一个bit位
            num >>>= 1;
        }

        //6.循环遍历
        return Result.ok(count);
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
