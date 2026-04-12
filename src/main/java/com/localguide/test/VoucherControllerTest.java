package com.localguide.test;

import com.localguide.dto.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
//@RequestMapping("/voucher-order")
public class VoucherControllerTest {
    @Autowired
    private VoucherImpl voucher;
    @PostMapping("seckill/{id}")
    public ResponseEntity<Result> getVoucher(@PathVariable("id") Long voucherId){
        Result result = voucher.getVoucher(voucherId);
        if (!Result.ok().getSuccess()){
            return ResponseEntity.badRequest().body(result);
        }
        return ResponseEntity.ok(result);
    }
}
