package com.localguide.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.localguide.dto.Result;
import com.localguide.entity.Shop;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ggb2580
 * @since 2026-01-08
 */
public interface IShopService extends IService<Shop> {

    Result getShopById(Long id);

    Result updateShop(Shop shop);
}
