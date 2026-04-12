package com.localguide.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.localguide.dto.Result;
import com.localguide.entity.Follow;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ggb2580
 * @since 2026-01-08
 */
public interface IFollowService extends IService<Follow> {

    Result follow(Long followUserId, Boolean isFollow);

    Result isFollow(Long followUserId);
}
