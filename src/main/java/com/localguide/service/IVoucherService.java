package com.localguide.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.localguide.dto.Result;
import com.localguide.entity.Voucher;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ggb2580
 * @since 2026-01-08
 */
public interface IVoucherService extends IService<Voucher> {

    Result queryVoucherOfShop(Long shopId);

    void addSeckillVoucher(Voucher voucher);
}
