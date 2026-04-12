package com.localguide.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.localguide.entity.SeckillVoucher;
import com.localguide.mapper.SeckillVoucherMapper;
import com.localguide.service.ISeckillVoucherService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 秒杀优惠券表，与优惠券是一对一关系 服务实现类
 * </p>
 *
 * @author ggb2580
 * @since 2026-01-02
 */
@Service
public class SeckillVoucherServiceImpl extends ServiceImpl<SeckillVoucherMapper, SeckillVoucher> implements ISeckillVoucherService {

}
