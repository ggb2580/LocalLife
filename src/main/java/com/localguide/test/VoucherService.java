package com.localguide.test;

import com.baomidou.mybatisplus.extension.service.IService;
import com.localguide.dto.Result;
import com.localguide.entity.VoucherOrder;

public interface VoucherService extends IService<VoucherOrder> {
    Result getVoucher(Long voucherId);

    Result createOrder(Long voucherId);
}
