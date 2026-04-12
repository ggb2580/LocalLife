package com.localguide.test;

import com.localguide.entity.Shop;
import com.localguide.service.IShopService;
import com.localguide.service.impl.ShopServiceImpl;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.geo.Point;
import org.springframework.data.redis.connection.RedisGeoCommands;
import org.springframework.data.redis.core.StringRedisTemplate;


import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@SpringBootTest
public class ShopTest {
    @Resource
    private ShopServiceImpl service;
    @Resource
    private StringRedisTemplate stringRedisTemplate;
    @Test
    public void test01(){
        for(int i=0;i<14;i++){
            service.saveShopToRedis(Long.parseLong(i+""),30L);
        }
    }

    /*
    * 导入店铺地理坐标
    * */
    @Test
    public void loadShopData(){
        //1.查询店铺信息
        List<Shop> list = service.list();
        //2.把店铺分组，按照typeId 分组，typeId 一致的放到一个集合
        Map<Long, List<Shop>> map = list.stream().collect(Collectors.groupingBy(Shop::getTypeId));
        //3.分批完成写入redis
        for(Map.Entry<Long,List<Shop>> entry:map.entrySet()){
            //3.1获取类型id
            Long typeId = entry.getKey();
            String key = "shop:geo:"+typeId;
            //3.2 获取同类型的店铺的集合
            List<Shop> value = entry.getValue();
            List<RedisGeoCommands.GeoLocation<String>> locations  = new ArrayList<>(value.size());
            //3.3 写入redis GEOADD key 经度 纬度 member
            for (Shop shop : value){
                locations.add(new RedisGeoCommands.GeoLocation<>(
                        shop.getId().toString(),
                        new Point(shop.getX(),shop.getY())
                ));
            }
            stringRedisTemplate.opsForGeo().add(key,locations);
        }
    }
}
