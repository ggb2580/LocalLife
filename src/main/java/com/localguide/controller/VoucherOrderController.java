package com.localguide.controller;


import com.localguide.dto.Result;
import com.localguide.service.IVoucherOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ggb2580
 * @since 2026-01-08
 */
@RestController
@RequestMapping("/voucher-order")
public class VoucherOrderController {
    @Autowired
    private IVoucherOrderService voucherOrderService;

    /*
    * 秒杀下单
    * */
    @PostMapping("seckill/{id}")
    public ResponseEntity<Result> seckillVoucher(@PathVariable("id") Long voucherId) throws InterruptedException {
        Result result = voucherOrderService.seckillVoucher(voucherId);
        if (!result.getSuccess()){
            return ResponseEntity.badRequest().body(result);
        }
        return ResponseEntity.ok(result);
    }
}
