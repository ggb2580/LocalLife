local voucherId = ARGV[1]
local userId = ARGV[2]
local orderId = ARGV[3]

-- 库存key
local stockKey = 'seckill:stock:' .. voucherId
-- 订单key
local orderKey = 'seckill:order:' .. voucherId

-- 1. 获取库存，判断是否为nil（修复nil比较错误）
local stock = redis.call('get', stockKey)
if not stock or tonumber(stock) <= 0 then
    -- 库存不足
    return 1
end

-- 2. 判断用户是否已经下单
if redis.call('sismember', orderKey, userId) == 1 then
    -- 重复下单
    return 2
end

-- 3. 扣库存（正确语法：incrby key 步长）
redis.call('incrby', stockKey, -1)

-- 4. 记录用户下单
redis.call('sadd', orderKey, userId)

--发送消息到队列中 ，XADD stream.orders * k1 v1 k2 v2 ...
redis.call('xadd','stream.orders','*','userId',userId,'voucherId',voucherId,'id',orderId)
return 0