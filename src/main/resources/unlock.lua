if redis.call('GET',KEY[1]) == ARG[1] then
    -- 一致 则删除
    return redis.call('DEL',KEY[1])
end
-- 不一致 直接返回
return 0