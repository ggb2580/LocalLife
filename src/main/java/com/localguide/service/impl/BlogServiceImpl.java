package com.localguide.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.BooleanUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.localguide.dto.Result;
import com.localguide.dto.ScrollResult;
import com.localguide.dto.UserDTO;
import com.localguide.entity.Blog;
import com.localguide.entity.Follow;
import com.localguide.entity.User;
import com.localguide.mapper.BlogMapper;
import com.localguide.service.IBlogService;
import com.localguide.service.IUserService;
import com.localguide.utils.SystemConstants;
import com.localguide.utils.UserHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.stereotype.Service;

import javax.jws.soap.SOAPBinding;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import static com.localguide.utils.RedisConstants.BLOG_LIKED_KEY;
import static com.localguide.utils.RedisConstants.FEED_KEY;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ggb2580
 * @since 2026-01-08
 */
@Service
public class BlogServiceImpl extends ServiceImpl<BlogMapper, Blog> implements IBlogService {

    @Autowired
    private IUserService userService;
    @Autowired
    private StringRedisTemplate stringRedisTemplate;
    @Autowired
    private FollowServiceImpl followServiceImpl;

    /*
    * 查询博客
    * */
    @Override
    public Result queryHotBlog(Integer current) {
        // 根据用户查询
        Page<Blog> page = query()
                .orderByDesc("liked")
                .page(new Page<>(current, SystemConstants.MAX_PAGE_SIZE));
        // 获取当前页数据
        List<Blog> records = page.getRecords();
        // 查询用户
        records.forEach(blog -> {
            queryBlogUser(blog);
            isBlogLiked(blog);
        });
        return Result.ok(records);
    }

    /*
    * 查询单条博客
    * */
    @Override
    public Result queryBlogById(Long id) {
        Blog blog = getById(id);
        if (blog == null){
            return Result.fail("笔记不存在");
        }
        //查询blog有关的用户
        queryBlogUser(blog);
        //判断当前登录用户是否已经点赞
        isBlogLiked(blog);
        return Result.ok(blog);
    }

    private void isBlogLiked(Blog blog) {
        // 1.获取登录用户
        Long userId = UserHolder.getUser().getId();
        //2.判断当前用户是否已经点赞
        String key = "blog:liked:"+blog.getId();
        Double score = stringRedisTemplate.opsForZSet().score(key, userId.toString());
        blog.setIsLike(score != null);
    }

    /*
    * 修改点赞
    * */
    @Override
    public Result likeBlog(Long id) {
        // 1.获取登录用户
        Long userId = UserHolder.getUser().getId();
        //2.判断当前用户是否已经点赞
        String key = "blog:liked:"+id;
        Double score = stringRedisTemplate.opsForZSet().score(key, userId.toString());
        if (score == null){
            //3.如果未点赞，可以点赞
            //3.1 数据库点赞数 + 1
            boolean update = update().setSql("liked = liked +1 ").eq("id", id).update();
            //3.2 保存用户到Redis的Zset集合
            if (update){
                stringRedisTemplate.opsForZSet().add(key,userId.toString(),System.currentTimeMillis());
            }
        }else {
            //4.如果已点赞 取消点赞
            //4.1 数据库点赞数 -1
            boolean update = update().setSql(" liked = liked - 1 ").eq("id", id).update();
            if (update){
                //4.2 把用户从redis 的Zset集合移除
                stringRedisTemplate.opsForZSet().remove(key,userId.toString());
            }

        }
        return Result.ok();
    }

    @Override
    public Result queryBlogLikes(Long id) {
        String key = BLOG_LIKED_KEY + id;
        //1.查询top5 的点赞用户 zrange key 0 4
        Set<String> top5 = stringRedisTemplate.opsForZSet().range(key,0,4);
        if (top5 == null || top5.isEmpty()){
            return Result.ok(Collections.emptyList());
        }

        //2.解析出其中的用户Id
        List<Long> ids = top5.stream().map(Long::valueOf).collect(Collectors.toList());
        String idStr = StrUtil.join(",", ids);
        //3.根据用户id查询用户 WHERE id IN (5,1) ORDER BY FIELD(id,5,1)
        List<UserDTO> userDTOS = userService.query()
                .in("id",ids)
                .last("ORDER BY FIELD(id,"+idStr+")").list()
                .stream()
                .map(user -> BeanUtil.copyProperties(user, UserDTO.class))
                .collect(Collectors.toList());
        //返回
        return Result.ok(userDTOS);
    }

    @Override
    public Result saveBlog(Blog blog) {
        //1.获取登录用户
        UserDTO user = UserHolder.getUser();
        blog.setUserId(user.getId());
        //保存探店笔记
        boolean isSuccess = save(blog);
        if (!isSuccess){
            return Result.fail("新增笔记失败");
        }
        //查询笔记作者的所有粉丝
        List<Follow> follows = followServiceImpl.query().eq("follow_user_id", user.getId()).list();
        //推送笔记id给所有粉丝
        for (Follow follow: follows ){
            //获取所有粉丝id
            Long userId = follow.getUserId();
            //推送
            String key = FEED_KEY + userId;
            stringRedisTemplate.opsForZSet().add(key,blog.getId().toString(),System.currentTimeMillis());
        }
        //返回id
        return Result.ok(blog.getId());
    }

    @Override
    public Result queryBlogOfFollow(Long max, Integer offset) {
        //1.获取当前用户
        Long userId = UserHolder.getUser().getId();
        //2.查询收件箱 ZREVRANGEBYSCORE key Max Min LIMIT offset count
        String key = FEED_KEY + userId;
        Set<ZSetOperations.TypedTuple<String>> typedTuples = stringRedisTemplate.opsForZSet()
                .reverseRangeByScoreWithScores(key, 0, max, offset, 5);
        //3.非空判断
        if (typedTuples == null || typedTuples.isEmpty()){
            return Result.ok();
        }
        //4.解析数据 blogId 、minTime（时间戳）、offset
        List<Long> ids = new ArrayList<>(typedTuples.size());
        long minTime = 0;
        int os = 1;
        for (ZSetOperations.TypedTuple<String> tuple : typedTuples){
            //获取id
            ids.add(Long.valueOf(tuple.getValue()));
            //获取分数(时间戳)
            long time = tuple.getScore().longValue();
            if (time == minTime){
                os++;
            }
            else {
                minTime = time;
                os = 1;
            }
        }
        //4.根据id查询blog
        String idStr = StrUtil.join(",",ids);
        List<Blog> blogs = query().in("id", ids).last("ORDER BY FIELD(id," + idStr + ")").list();

        for (Blog blog : blogs){
            //查询blog 有关的用户
            queryBlogUser(blog);
            //查询blog是否被点赞
            isBlogLiked(blog);
        }
        //5.封装并返回
        ScrollResult r = new ScrollResult();
        r.setList(blogs);
        r.setOffset(os);
        r.setMinTime(minTime);

        return Result.ok(r);
    }

    /*
    * 查询blog有关的用户
    * */
    private void queryBlogUser(Blog blog){
        Long userId = blog.getUserId();
        User user = userService.getById(userId);
        blog.setName(user.getNickName());
        blog.setIcon(user.getIcon());
    }

}
