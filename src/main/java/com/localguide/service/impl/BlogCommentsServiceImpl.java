package com.localguide.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.localguide.entity.BlogComments;
import com.localguide.mapper.BlogCommentsMapper;
import com.localguide.service.IBlogCommentsService;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ggb2580
 * @since 2026-01-08
 */
@Service
public class BlogCommentsServiceImpl extends ServiceImpl<BlogCommentsMapper, BlogComments> implements IBlogCommentsService {

}
