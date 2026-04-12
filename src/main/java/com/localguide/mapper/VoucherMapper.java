package com.localguide.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.localguide.entity.Voucher;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ggb2580
 * @since 2026-01-08
 */
public interface VoucherMapper extends BaseMapper<Voucher> {

    List<Voucher> queryVoucherOfShop(@Param("shopId") Long shopId);
}
