package com.localguide.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.localguide.dto.Result;
import com.localguide.entity.VoucherOrder;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ggb2580
 * @since 2026-01-08
 */
public interface IVoucherOrderService extends IService<VoucherOrder> {

    Result seckillVoucher(Long voucherId) throws InterruptedException;

    Result createVoucherOrder(Long voucherId);

    void createVoucherOrder(VoucherOrder voucherOrder);
}
