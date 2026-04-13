package com.localguide.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.localguide.dto.Result;
import com.localguide.dto.UserDTO;
import com.localguide.entity.Follow;
import com.localguide.entity.User;
import com.localguide.mapper.FollowMapper;
import com.localguide.service.IFollowService;
import com.localguide.utils.UserHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import static com.localguide.utils.RedisConstants.USER_FOLLOWS;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ggb2580
 * @since 2026-01-08
 */
@Service
public class FollowServiceImpl extends ServiceImpl<FollowMapper, Follow> implements IFollowService {

    @Autowired
    private StringRedisTemplate redisTemplate;
    @Autowired
    private UserServiceImpl userService;

    @Override
    public Result follow(Long followUserId, Boolean isFollow) {
        //获取登录用户
        Long userId = UserHolder.getUser().getId();
        String key = USER_FOLLOWS+userId;

        //判断是否关注
        if(isFollow){
            //2.关注 新增数据
            Follow follow = new Follow();
            follow.setUserId(userId);
            follow.setFollowUserId(followUserId);
            boolean isSuccess = save(follow);
            if (isSuccess){
                //把关注的用户id 放进redis set集合，sadd userId followerUserId
                redisTemplate.opsForSet().add(key,followUserId.toString());
            }
        }else {
            //3.取关
            boolean isSuccess = remove(new QueryWrapper<Follow>().eq("user_id", userId).eq("follow_user_id", followUserId));
            if (isSuccess){
                //把关注用户的id 从redis集合中移除
                Long remove = redisTemplate.opsForSet().remove(key, followUserId.toString());
            }
        }
        return Result.ok();
    }

    @Override
    public Result isFollow(Long followUserId) {
        Long userId = UserHolder.getUser().getId();
        Long count = query().eq("user_id", userId).eq("follow_user_id", followUserId).count();
        return Result.ok(count > 0);
    }

    @Override
    public Result followCommons(Long id) {
        //1.获取当前用户
        Long userId = UserHolder.getUser().getId();
        String key = USER_FOLLOWS+userId;
        //2.求交集
        String key2 = USER_FOLLOWS+id;
        Set<String> intersect = redisTemplate.opsForSet().intersect(key, key2);
        if (intersect == null || intersect.isEmpty()){
            //无交集
            return Result.ok(Collections.emptyList());
        }
        //解析id集合
        List<Long> ids = intersect.stream().map(Long::valueOf).collect(Collectors.toList());
        //查询用户
        List<UserDTO> users = userService.listByIds(ids)
                .stream()
                .map(user -> BeanUtil.copyProperties(user, UserDTO.class))
                .collect(Collectors.toList());
        return Result.ok(users);
    }
}
