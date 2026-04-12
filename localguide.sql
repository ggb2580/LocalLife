/*
 Navicat Premium Dump SQL

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80040 (8.0.40)
 Source Host           : localhost:3306
 Source Schema         : localguide

 Target Server Type    : MySQL
 Target Server Version : 80040 (8.0.40)
 File Encoding         : 65001

 Date: 06/04/2026 18:14:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_blog
-- ----------------------------
DROP TABLE IF EXISTS `tb_blog`;
CREATE TABLE `tb_blog`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` bigint NOT NULL COMMENT '商户id',
  `user_id` bigint UNSIGNED NOT NULL COMMENT '用户id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `images` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '探店的照片，最多9张，多张以\",\"隔开',
  `content` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '探店的文字描述',
  `liked` int UNSIGNED NULL DEFAULT 0 COMMENT '点赞数量',
  `comments` int UNSIGNED NULL DEFAULT NULL COMMENT '评论数量',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tb_blog
-- ----------------------------
INSERT INTO `tb_blog` VALUES (4, 4, 2, '无尽浪漫的夜晚丨在万花丛中摇晃着红酒杯🍷品战斧牛排🥩', '/imgs/blogs/7/14/4771fefb-1a87-4252-816c-9f7ec41ffa4a.jpg,/imgs/blogs/4/10/2f07e3c9-ddce-482d-9ea7-c21450f8d7cd.jpg,/imgs/blogs/2/6/b0756279-65da-4f2d-b62a-33f74b06454a.jpg,/imgs/blogs/10/7/7e97f47d-eb49-4dc9-a583-95faa7aed287.jpg,/imgs/blogs/1/2/4a7b496b-2a08-4af7-aa95-df2c3bd0ef97.jpg,/imgs/blogs/14/3/52b290eb-8b5d-403b-8373-ba0bb856d18e.jpg', '生活就是一半烟火·一半诗意<br/>手执烟火谋生活·心怀诗意以谋爱·<br/>当然<br/>\r\n男朋友给不了的浪漫要学会自己给🍒<br/>\n无法重来的一生·尽量快乐.<br/><br/>🏰「小筑里·神秘浪漫花园餐厅」🏰<br/><br/>\n💯这是一家最最最美花园的西餐厅·到处都是花餐桌上是花前台是花  美好无处不在\n品一口葡萄酒，维亚红酒马瑟兰·微醺上头工作的疲惫消失无际·生如此多娇🍃<br/><br/>📍地址:延安路200号(家乐福面)<br/><br/>🚌交通:地铁①号线定安路B口出右转过下通道右转就到啦～<br/><br/>--------------🥣菜品详情🥣---------------<br/><br/>「战斧牛排]<br/>\n超大一块战斧牛排经过火焰的炙烤发出阵阵香，外焦里嫩让人垂涎欲滴，切开牛排的那一刻，牛排的汁水顺势流了出来，分熟的牛排肉质软，简直细嫩到犯规，一刻都等不了要放入嘴里咀嚼～<br/><br/>「奶油培根意面」<br/>太太太好吃了💯<br/>我真的无法形容它的美妙，意面混合奶油香菇的香味真的太太太香了，我真的舔盘了，一丁点美味都不想浪费‼️<br/><br/><br/>「香菜汁烤鲈鱼」<br/>这个酱是辣的 真的绝好吃‼️<br/>鲈鱼本身就很嫩没什么刺，烤过之后外皮酥酥的，鱼肉蘸上酱料根本停不下来啊啊啊啊<br/>能吃辣椒的小伙伴一定要尝尝<br/><br/>非常可 好吃子🍽\n<br/>--------------🍃个人感受🍃---------------<br/><br/>【👩🏻‍🍳服务】<br/>小姐姐特别耐心的给我们介绍彩票 <br/>推荐特色菜品，拍照需要帮忙也是尽心尽力配合，太爱他们了<br/><br/>【🍃环境】<br/>比较有格调的西餐厅 整个餐厅的布局可称得上的万花丛生 有种在人间仙境的感觉🌸<br/>集美食美酒与鲜花为一体的风格店铺 令人向往<br/>烟火皆是生活 人间皆是浪漫<br/>', 3, 104, '2021-12-28 19:50:01', '2026-04-05 18:49:36');
INSERT INTO `tb_blog` VALUES (5, 1, 2, '人均30💰杭州这家港式茶餐厅我疯狂打call‼️', '/imgs/blogs/4/7/863cc302-d150-420d-a596-b16e9232a1a6.jpg,/imgs/blogs/11/12/8b37d208-9414-4e78-b065-9199647bb3e3.jpg,/imgs/blogs/4/1/fa74a6d6-3026-4cb7-b0b6-35abb1e52d11.jpg,/imgs/blogs/9/12/ac2ce2fb-0605-4f14-82cc-c962b8c86688.jpg,/imgs/blogs/4/0/26a7cd7e-6320-432c-a0b4-1b7418f45ec7.jpg,/imgs/blogs/15/9/cea51d9b-ac15-49f6-b9f1-9cf81e9b9c85.jpg', '又吃到一家好吃的茶餐厅🍴环境是怀旧tvb港风📺边吃边拍照片📷几十种菜品均价都在20+💰可以是很平价了！<br>·<br>店名：九记冰厅(远洋店)<br>地址：杭州市丽水路远洋乐堤港负一楼（溜冰场旁边）<br>·<br>✔️黯然销魂饭（38💰）<br>这碗饭我吹爆！米饭上盖满了甜甜的叉烧 还有两颗溏心蛋🍳每一粒米饭都裹着浓郁的酱汁 光盘了<br>·<br>✔️铜锣湾漏奶华（28💰）<br>黄油吐司烤的脆脆的 上面洒满了可可粉🍫一刀切开 奶盖流心像瀑布一样流出来  满足<br>·<br>✔️神仙一口西多士士（16💰）<br>简简单单却超级好吃！西多士烤的很脆 黄油味浓郁 面包体超级柔软 上面淋了炼乳<br>·<br>✔️怀旧五柳炸蛋饭（28💰）<br>四个鸡蛋炸成蓬松的炸蛋！也太好吃了吧！还有大块鸡排 上淋了酸甜的酱汁 太合我胃口了！！<br>·<br>✔️烧味双拼例牌（66💰）<br>选了烧鹅➕叉烧 他家烧腊品质真的惊艳到我！据说是每日广州发货 到店现烧现卖的黑棕鹅 每口都是正宗的味道！肉质很嫩 皮超级超级酥脆！一口爆油！叉烧肉也一点都不柴 甜甜的很入味 搭配梅子酱很解腻 ！<br>·<br>✔️红烧脆皮乳鸽（18.8💰）<br>乳鸽很大只 这个价格也太划算了吧， 肉质很有嚼劲 脆皮很酥 越吃越香～<br>·<br>✔️大满足小吃拼盘（25💰）<br>翅尖➕咖喱鱼蛋➕蝴蝶虾➕盐酥鸡<br>zui喜欢里面的咖喱鱼！咖喱酱香甜浓郁！鱼蛋很q弹～<br>·<br>✔️港式熊仔丝袜奶茶（19💰）<br>小熊🐻造型的奶茶冰也太可爱了！颜值担当 很地道的丝袜奶茶 茶味特别浓郁～<br>·', 0, 0, '2021-12-28 20:57:49', '2026-04-05 18:05:32');
INSERT INTO `tb_blog` VALUES (6, 10, 1, '杭州周末好去处｜💰50就可以骑马啦🐎', '/imgs/blogs/blog1.jpg', '杭州周末好去处｜💰50就可以骑马啦🐎', 14, 0, '2022-01-11 16:05:47', '2026-04-05 18:09:09');
INSERT INTO `tb_blog` VALUES (7, 10, 1, '杭州周末好去处｜💰50就可以骑马啦🐎', '/imgs/blogs/blog1.jpg', '杭州周末好去处｜💰50就可以骑马啦🐎', 3, 0, '2022-01-11 16:05:47', '2026-04-05 18:05:20');
INSERT INTO `tb_blog` VALUES (23, 1, 3012, '好吃的批爆', '/imgs/blogs/9/2/953535e3-34f1-460f-acba-f223af1af466.png', '最近去了这个小吃店，太好了给大家安利一下！人均100不到，大家快去试试吧！', 5, NULL, '2026-04-05 16:22:22', '2026-04-05 18:44:57');
INSERT INTO `tb_blog` VALUES (24, 10, 3012, 'OSAKA', '/imgs/blogs/6/10/cd318036-03bd-4d9c-9167-d3187f6bfedd.jpg,/imgs/blogs/6/7/cc3aa0b4-274d-480a-b414-d8fb42682839.jpg,/imgs/blogs/11/7/13944edf-6ba5-4718-85a3-4b38cfe5e8a8.jpg', '在大阪暴走的一天，真的累并快乐着！！！\n🌟花费：周游券150r（携程提前买）+ 住宿104r（住在新今宫地铁站附近100多元穷鬼单人间）+ 吃饭120r\n🌟路线：四天王寺p2➡️大阪警察署p3➡️西之丸p4天守阁p5➡️海洋堂博物馆p6➡️天王寺动物园p8➡️通天阁p9-10➡️天保山摩天轮p11-12➡️道顿堀游船p14-17\n🌟交通：步行+地铁（周游券全包，JR不行哦）\n🌧️早上8:30 四天王寺\n天气不太好，拍了几张照片就溜了😭\n🏯10:30 大阪城公园\n谷町四丁目站下车，步行打卡大阪警察署，对面就是大阪城公园！路过西之丸庭院，冬天+下雨真的没啥好拍的\n🏰天守阁\n楼下打卡柯南同款机位，具体机位可以查小红书，之后直接扫码进天守阁不用排队～里面是个小博物馆，爬楼梯到顶楼拍拍风景就OK啦～\n🎪海洋堂博物馆\n就在天守阁附近，周游券可以免费扭蛋，里面超多手办，p7就是我扭到的，逛完已经12点了，附近随便吃了点东西去天王寺动物园\n🦁13:30 天王寺动物园\n原本以为时间很充裕，结果逛完动物园完美错过了圣玛丽亚号邮轮😭想去坐圣玛丽亚号游船就别逛动物园了，就是普通动物园！逛完动物园步行几分钟就到通天阁了\n🎢15:00 通天阁\n通天阁下面根据红色指示牌排队取号，这次只玩了玩了高空滑梯+高空漫步，全程1.5小时，排队的人很多！滑梯有视频记录，下来扫码下载就好啦～高空漫步需要先在后面小巷换装备（不能带电子设备）蹦极有点怕，只玩了高空漫步，图片p10，工作人员会给挂保险绳和一张卡，每个拍照点刷卡拍照，拍到满意为止，最后同样扫码下载照片😎\n📸17:00 温泉大世界图片p1\n路过打卡拍照就走啦～\n🎡18:20 天保山摩天轮\n普通厢不用排队，透明厢要等半小时，果断普通！俯瞰大阪港夜景绝了！！！\n🍤19:00 天妇罗\n摩天轮附近随便找了一家天妇罗店铺，75r味道还可以\n🚢20:30 道顿堀游船\n最后一站，高德搜道顿堀坐游船的地方，游船可以网上预约，也可以现场排队，冬季人少，没人排队，去了直接扫QR码兑换船票，乘坐八点半游船，全程约40分钟～结束后打卡格力高广告牌\n🏨21:30 回旅店\n第二天去京都\n总结：周游券真的超值，p18是我当天整个刷卡记录，也是榨干他的最后一丝价值\n#大阪一日游 #大阪周游券 #日本旅行 #大阪攻略 #一个人的旅行\n03-05', 1, NULL, '2026-04-06 16:15:22', '2026-04-06 16:18:07');
INSERT INTO `tb_blog` VALUES (25, 1, 3012, 'Kyoto', '/imgs/blogs/2/11/6c970017-5c5a-44eb-886a-4ae04247f017.jpg,/imgs/blogs/13/14/03cbef3a-5426-4238-bd2d-21163da3a7d7.jpg', 'Kyoto为什么不叫京东?\nTokyo＝东京\nKyoto＝？', 1, NULL, '2026-04-06 16:17:58', '2026-04-06 18:13:33');
INSERT INTO `tb_blog` VALUES (26, 2, 3012, '带薪摸鱼太香啦', '/imgs/blogs/0/5/9b014e6f-ee64-4865-bf08-bdf029db7497.png', '之前和同事一起深入讨论了一手摸鱼技巧，感觉现在的摸鱼技巧已经登峰造极了\n这不学到了立马我就过来发了，如果有更好的方法也欢迎在下面说出来\n	\n销售同事：蓝牙耳机一戴，手机、电脑、水杯一拿，找个没人的角落里头蹲着，然后就可以开始和“客户”商讨方案了，来人了就开始表演，没人就直接开摸\n	\n普通职员：选一种超大号水杯去公司，就选接水人最多（最好有排队）的时候去接水，接一次水十几分钟就过去了，来个几次一天就没了\n	\n剪辑/运营：把想看的视频调成画中画，然后开启剪映/pr等软件，把画中画拖到上方展示区，假装还在剪视频\n	\n人事/行政：不论多大的事，能离开工位找当事人绝不发私信，每天跑个几十趟，摸鱼的同时还把肥减了\n	\n再多来点不同岗位和行业的姐妹们分享一下情报呀！还能各取所需\n	\n#一起来摸鱼 #打工人日常 #上班摸鱼不如上班学习 #职场摸鱼人 #上班不摸鱼 #当代职场人 #打工人 #不想上班 #职场日常 #摸鱼', 0, NULL, '2026-04-06 16:22:51', '2026-04-06 16:22:51');
INSERT INTO `tb_blog` VALUES (27, 1, 3013, '总结：上班什么都不用做', '/imgs/blogs/8/0/5c944e93-e062-421b-ac7f-1fd077709936.png', '是不是这样的，宝子们  #达文西  #打工人  #打工人日常  #打工人精神状态  #摸鱼  #摸鱼从此有了正当的理由', 1, NULL, '2026-04-06 16:25:52', '2026-04-06 18:13:50');
INSERT INTO `tb_blog` VALUES (28, 7, 3013, '贼好吃的烧烤老店', '/imgs/blogs/14/7/1d965111-838c-429e-b90c-66ed1eb5c6fe.png,/imgs/blogs/15/0/25d520f1-c6aa-477b-8760-4c87d72d2f9b.png,/imgs/blogs/13/12/c2426cfb-23a7-47d7-8fd9-1c9948007925.png', '牛双筋 3.5一串，外焦里嫩一口爆汁\n铁签子烤的是过去的味道\n熟筋和牛肉串也好吃🥩\n就是店有点破，对环境有要求的就别考虑了\n他家说是四点营业，但怎么也得四点半才能烤上', 1, NULL, '2026-04-06 16:30:39', '2026-04-06 18:13:58');

-- ----------------------------
-- Table structure for tb_blog_comments
-- ----------------------------
DROP TABLE IF EXISTS `tb_blog_comments`;
CREATE TABLE `tb_blog_comments`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint UNSIGNED NOT NULL COMMENT '用户id',
  `blog_id` bigint UNSIGNED NOT NULL COMMENT '探店id',
  `parent_id` bigint UNSIGNED NOT NULL COMMENT '关联的1级评论id，如果是一级评论，则值为0',
  `answer_id` bigint UNSIGNED NOT NULL COMMENT '回复的评论id',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '回复的内容',
  `liked` int UNSIGNED NULL DEFAULT NULL COMMENT '点赞数',
  `status` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '状态，0：正常，1：被举报，2：禁止查看',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tb_blog_comments
-- ----------------------------

-- ----------------------------
-- Table structure for tb_follow
-- ----------------------------
DROP TABLE IF EXISTS `tb_follow`;
CREATE TABLE `tb_follow`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint UNSIGNED NOT NULL COMMENT '用户id',
  `follow_user_id` bigint UNSIGNED NOT NULL COMMENT '关联的用户id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tb_follow
-- ----------------------------

-- ----------------------------
-- Table structure for tb_seckill_voucher
-- ----------------------------
DROP TABLE IF EXISTS `tb_seckill_voucher`;
CREATE TABLE `tb_seckill_voucher`  (
  `voucher_id` bigint UNSIGNED NOT NULL COMMENT '关联的优惠券的id',
  `stock` int NOT NULL COMMENT '库存',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `begin_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生效时间',
  `end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '失效时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`voucher_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '秒杀优惠券表，与优惠券是一对一关系' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tb_seckill_voucher
-- ----------------------------
INSERT INTO `tb_seckill_voucher` VALUES (10, 100, '2026-03-30 20:37:54', '2026-03-30 20:37:54', '2026-03-30 20:37:54', '2026-03-30 20:37:54');
INSERT INTO `tb_seckill_voucher` VALUES (14, 99, '2026-03-31 19:52:50', '2026-03-31 19:52:30', '2026-06-01 21:45:30', '2026-04-02 18:31:06');
INSERT INTO `tb_seckill_voucher` VALUES (15, 100, '2026-04-02 20:31:03', '2026-03-31 19:52:30', '2026-06-01 21:45:30', '2026-04-02 20:31:03');
INSERT INTO `tb_seckill_voucher` VALUES (20, 0, '2026-04-04 16:07:31', '2026-03-31 19:52:30', '2026-06-01 21:45:30', '2026-04-04 18:26:19');

-- ----------------------------
-- Table structure for tb_shop
-- ----------------------------
DROP TABLE IF EXISTS `tb_shop`;
CREATE TABLE `tb_shop`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商铺名称',
  `type_id` bigint UNSIGNED NOT NULL COMMENT '商铺类型的id',
  `images` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商铺图片，多个图片以\',\'隔开',
  `area` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商圈，例如陆家嘴',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '地址',
  `x` double UNSIGNED NOT NULL COMMENT '经度',
  `y` double UNSIGNED NOT NULL COMMENT '维度',
  `avg_price` bigint UNSIGNED NULL DEFAULT NULL COMMENT '均价，取整数',
  `sold` int(10) UNSIGNED ZEROFILL NOT NULL COMMENT '销量',
  `comments` int(10) UNSIGNED ZEROFILL NOT NULL COMMENT '评论数量',
  `score` int(2) UNSIGNED ZEROFILL NOT NULL COMMENT '评分，1~5分，乘10保存，避免小数',
  `open_hours` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '营业时间，例如 10:00-22:00',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `foreign_key_type`(`type_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tb_shop
-- ----------------------------
INSERT INTO `tb_shop` VALUES (1, '103茶餐厅', 1, 'https://qcloud.dpfile.com/pc/jiclIsCKmOI2arxKN1Uf0Hx3PucIJH8q0QSz-Z8llzcN56-_QiKuOvyio1OOxsRtFoXqu0G3iT2T27qat3WhLVEuLYk00OmSS1IdNpm8K8sG4JN9RIm2mTKcbLtc2o2vfCF2ubeXzk49OsGrXt_KYDCngOyCwZK-s3fqawWswzk.jpg,https://qcloud.dpfile.com/pc/IOf6VX3qaBgFXFVgp75w-KKJmWZjFc8GXDU8g9bQC6YGCpAmG00QbfT4vCCBj7njuzFvxlbkWx5uwqY2qcjixFEuLYk00OmSS1IdNpm8K8sG4JN9RIm2mTKcbLtc2o2vmIU_8ZGOT1OjpJmLxG6urQ.jpg', '大关', '金华路锦昌文华苑29号', 120.149192, 30.316078, 80, 0000004215, 0000003035, 37, '10:00-22:00', '2021-12-22 18:10:39', '2026-03-15 17:13:05');
INSERT INTO `tb_shop` VALUES (2, '蔡馬洪涛烤肉·老北京铜锅涮羊肉', 1, 'https://p0.meituan.net/bbia/c1870d570e73accbc9fee90b48faca41195272.jpg,http://p0.meituan.net/mogu/397e40c28fc87715b3d5435710a9f88d706914.jpg,https://qcloud.dpfile.com/pc/MZTdRDqCZdbPDUO0Hk6lZENRKzpKRF7kavrkEI99OxqBZTzPfIxa5E33gBfGouhFuzFvxlbkWx5uwqY2qcjixFEuLYk00OmSS1IdNpm8K8sG4JN9RIm2mTKcbLtc2o2vmIU_8ZGOT1OjpJmLxG6urQ.jpg', '拱宸桥/上塘', '上塘路1035号（中国工商银行旁）', 120.151505, 30.333422, 85, 0000002160, 0000001460, 48, '11:30-03:00', '2021-12-22 19:00:13', '2026-03-14 16:28:23');
INSERT INTO `tb_shop` VALUES (3, '新白鹿餐厅(运河上街店)', 1, 'https://p0.meituan.net/biztone/694233_1619500156517.jpeg,https://img.meituan.net/msmerchant/876ca8983f7395556eda9ceb064e6bc51840883.png,https://img.meituan.net/msmerchant/86a76ed53c28eff709a36099aefe28b51554088.png', '运河上街', '台州路2号运河上街购物中心F5', 120.151954, 30.32497, 61, 0000012035, 0000008045, 47, '10:30-21:00', '2021-12-22 19:10:05', '2022-01-11 16:12:42');
INSERT INTO `tb_shop` VALUES (4, 'Mamala(杭州远洋乐堤港店)', 1, 'https://img.meituan.net/msmerchant/232f8fdf09050838bd33fb24e79f30f9606056.jpg,https://qcloud.dpfile.com/pc/rDe48Xe15nQOHCcEEkmKUp5wEKWbimt-HDeqYRWsYJseXNncvMiXbuED7x1tXqN4uzFvxlbkWx5uwqY2qcjixFEuLYk00OmSS1IdNpm8K8sG4JN9RIm2mTKcbLtc2o2vmIU_8ZGOT1OjpJmLxG6urQ.jpg', '拱宸桥/上塘', '丽水路66号远洋乐堤港商城2期1层B115号', 120.146659, 30.312742, 290, 0000013519, 0000009529, 49, '11:00-22:00', '2021-12-22 19:17:15', '2022-01-11 16:12:51');
INSERT INTO `tb_shop` VALUES (5, '海底捞火锅(水晶城购物中心店）', 1, 'https://img.meituan.net/msmerchant/054b5de0ba0b50c18a620cc37482129a45739.jpg,https://img.meituan.net/msmerchant/59b7eff9b60908d52bd4aea9ff356e6d145920.jpg,https://qcloud.dpfile.com/pc/Qe2PTEuvtJ5skpUXKKoW9OQ20qc7nIpHYEqJGBStJx0mpoyeBPQOJE4vOdYZwm9AuzFvxlbkWx5uwqY2qcjixFEuLYk00OmSS1IdNpm8K8sG4JN9RIm2mTKcbLtc2o2vmIU_8ZGOT1OjpJmLxG6urQ.jpg', '大关', '上塘路458号水晶城购物中心F6', 120.15778, 30.310633, 104, 0000004125, 0000002764, 49, '10:00-07:00', '2021-12-22 19:20:58', '2022-01-11 16:13:01');
INSERT INTO `tb_shop` VALUES (6, '幸福里老北京涮锅（丝联店）', 1, 'https://img.meituan.net/msmerchant/e71a2d0d693b3033c15522c43e03f09198239.jpg,https://img.meituan.net/msmerchant/9f8a966d60ffba00daf35458522273ca658239.jpg,https://img.meituan.net/msmerchant/ef9ca5ef6c05d381946fe4a9aa7d9808554502.jpg', '拱宸桥/上塘', '金华南路189号丝联166号', 120.148603, 30.318618, 130, 0000009531, 0000007324, 46, '11:00-13:50,17:00-20:50', '2021-12-22 19:24:53', '2022-01-11 16:13:09');
INSERT INTO `tb_shop` VALUES (7, '炉鱼(拱墅万达广场店)', 1, 'https://img.meituan.net/msmerchant/909434939a49b36f340523232924402166854.jpg,https://img.meituan.net/msmerchant/32fd2425f12e27db0160e837461c10303700032.jpg,https://img.meituan.net/msmerchant/f7022258ccb8dabef62a0514d3129562871160.jpg', '北部新城', '杭行路666号万达商业中心4幢2单元409室(铺位号4005)', 120.124691, 30.336819, 85, 0000002631, 0000001320, 47, '00:00-24:00', '2021-12-22 19:40:52', '2022-01-11 16:13:19');
INSERT INTO `tb_shop` VALUES (8, '浅草屋寿司（运河上街店）', 1, 'https://img.meituan.net/msmerchant/cf3dff697bf7f6e11f4b79c4e7d989e4591290.jpg,https://img.meituan.net/msmerchant/0b463f545355c8d8f021eb2987dcd0c8567811.jpg,https://img.meituan.net/msmerchant/c3c2516939efaf36c4ccc64b0e629fad587907.jpg', '运河上街', '拱墅区金华路80号运河上街B1', 120.150526, 30.325231, 88, 0000002406, 0000001206, 46, ' 11:00-21:30', '2021-12-22 19:51:06', '2022-01-11 16:13:25');
INSERT INTO `tb_shop` VALUES (9, '羊老三羊蝎子牛仔排北派炭火锅(运河上街店)', 1, 'https://p0.meituan.net/biztone/163160492_1624251899456.jpeg,https://img.meituan.net/msmerchant/e478eb16f7e31a7f8b29b5e3bab6de205500837.jpg,https://img.meituan.net/msmerchant/6173eb1d18b9d70ace7fdb3f2dd939662884857.jpg', '运河上街', '台州路2号运河上街购物中心F5', 120.150598, 30.325251, 101, 0000002763, 0000001363, 44, '11:00-21:30', '2021-12-22 19:53:59', '2022-01-11 16:13:34');
INSERT INTO `tb_shop` VALUES (10, '开乐迪KTV（运河上街店）', 2, 'https://p0.meituan.net/joymerchant/a575fd4adb0b9099c5c410058148b307-674435191.jpg,https://p0.meituan.net/merchantpic/68f11bf850e25e437c5f67decfd694ab2541634.jpg,https://p0.meituan.net/dpdeal/cb3a12225860ba2875e4ea26c6d14fcc197016.jpg', '运河上街', '台州路2号运河上街购物中心F4', 120.149093, 30.324666, 67, 0000026891, 0000000902, 37, '00:00-24:00', '2021-12-22 20:25:16', '2021-12-22 20:25:16');
INSERT INTO `tb_shop` VALUES (11, 'INLOVE KTV(水晶城店)', 2, 'https://p0.meituan.net/dpmerchantpic/53e74b200211d68988a4f02ae9912c6c1076826.jpg,https://qcloud.dpfile.com/pc/4iWtIvzLzwM2MGgyPu1PCDb4SWEaKqUeHm--YAt1EwR5tn8kypBcqNwHnjg96EvT_Gd2X_f-v9T8Yj4uLt25Gg.jpg,https://qcloud.dpfile.com/pc/WZsJWRI447x1VG2x48Ujgu7vwqksi_9WitdKI4j3jvIgX4MZOpGNaFtM93oSSizbGybIjx5eX6WNgCPvcASYAw.jpg', '水晶城', '上塘路458号水晶城购物中心6层', 120.15853, 30.310002, 75, 0000035977, 0000005684, 47, '11:30-06:00', '2021-12-22 20:29:02', '2021-12-22 20:39:00');
INSERT INTO `tb_shop` VALUES (12, '魅(杭州远洋乐堤港店)', 2, 'https://p0.meituan.net/dpmerchantpic/63833f6ba0393e2e8722420ef33f3d40466664.jpg,https://p0.meituan.net/dpmerchantpic/ae3c94cc92c529c4b1d7f68cebed33fa105810.png,', '远洋乐堤港', '丽水路58号远洋乐堤港F4', 120.14983, 30.31211, 88, 0000006444, 0000000235, 46, '10:00-02:00', '2021-12-22 20:34:34', '2021-12-22 20:34:34');
INSERT INTO `tb_shop` VALUES (13, '讴K拉量贩KTV(北城天地店)', 2, 'https://p1.meituan.net/merchantpic/598c83a8c0d06fe79ca01056e214d345875600.jpg,https://qcloud.dpfile.com/pc/HhvI0YyocYHRfGwJWqPQr34hRGRl4cWdvlNwn3dqghvi4WXlM2FY1te0-7pE3Wb9_Gd2X_f-v9T8Yj4uLt25Gg.jpg,https://qcloud.dpfile.com/pc/F5ZVzZaXFE27kvQzPnaL4V8O9QCpVw2nkzGrxZE8BqXgkfyTpNExfNG5CEPQX4pjGybIjx5eX6WNgCPvcASYAw.jpg', 'D32天阳购物中心', '湖州街567号北城天地5层', 120.130453, 30.327655, 58, 0000018997, 0000001857, 41, '12:00-02:00', '2021-12-22 20:38:54', '2021-12-22 20:40:04');
INSERT INTO `tb_shop` VALUES (14, '星聚会KTV(拱墅区万达店)', 2, 'https://p0.meituan.net/dpmerchantpic/f4cd6d8d4eb1959c3ea826aa05a552c01840451.jpg,https://p0.meituan.net/dpmerchantpic/2efc07aed856a8ab0fc75c86f4b9b0061655777.jpg,https://qcloud.dpfile.com/pc/zWfzzIorCohKT0bFwsfAlHuayWjI6DBEMPHHncmz36EEMU9f48PuD9VxLLDAjdoU_Gd2X_f-v9T8Yj4uLt25Gg.jpg', '北部新城', '杭行路666号万达广场C座1-2F', 120.128958, 30.337252, 60, 0000017771, 0000000685, 47, '10:00-22:00', '2021-12-22 20:48:54', '2021-12-22 20:48:54');

-- ----------------------------
-- Table structure for tb_shop_type
-- ----------------------------
DROP TABLE IF EXISTS `tb_shop_type`;
CREATE TABLE `tb_shop_type`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型名称',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `sort` int UNSIGNED NULL DEFAULT NULL COMMENT '顺序',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tb_shop_type
-- ----------------------------
INSERT INTO `tb_shop_type` VALUES (1, '美食', '/types/ms.png', 1, '2021-12-22 20:17:47', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (2, 'KTV', '/types/KTV.png', 2, '2021-12-22 20:18:27', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (3, '丽人·美发', '/types/lrmf.png', 3, '2021-12-22 20:18:48', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (4, '健身运动', '/types/jsyd.png', 10, '2021-12-22 20:19:04', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (5, '按摩·足疗', '/types/amzl.png', 5, '2021-12-22 20:19:27', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (6, '美容SPA', '/types/spa.png', 6, '2021-12-22 20:19:35', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (7, '亲子游乐', '/types/qzyl.png', 7, '2021-12-22 20:19:53', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (8, '酒吧', '/types/jiuba.png', 8, '2021-12-22 20:20:02', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (9, '轰趴馆', '/types/hpg.png', 9, '2021-12-22 20:20:08', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (10, '美睫·美甲', '/types/mjmj.png', 4, '2021-12-22 20:21:46', '2021-12-23 11:24:31');

-- ----------------------------
-- Table structure for tb_sign
-- ----------------------------
DROP TABLE IF EXISTS `tb_sign`;
CREATE TABLE `tb_sign`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint UNSIGNED NOT NULL COMMENT '用户id',
  `year` year NOT NULL COMMENT '签到的年',
  `month` tinyint NOT NULL COMMENT '签到的月',
  `date` date NOT NULL COMMENT '签到的日期',
  `is_backup` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '是否补签',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tb_sign
-- ----------------------------

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号码',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码，加密存储',
  `nick_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '昵称，默认是用户id',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '人物头像',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniqe_key_phone`(`phone` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3014 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (1, '13686869696', '', '小鱼同学', '/imgs/blogs/blog1.jpg', '2021-12-24 10:27:19', '2022-01-11 16:04:00');
INSERT INTO `tb_user` VALUES (2, '13838411438', '', '可可今天不吃肉', '/imgs/icons/kkjtbcr.jpg', '2021-12-24 15:14:39', '2021-12-28 19:58:04');
INSERT INTO `tb_user` VALUES (4, '13456789011', '', 'user_slxaxy2au9f3tanffaxr', '', '2022-01-07 12:07:53', '2022-01-07 12:07:53');
INSERT INTO `tb_user` VALUES (5, '13456789001', '', '可爱多', '/imgs/icons/user5-icon.png', '2022-01-07 16:11:33', '2022-03-11 09:09:20');
INSERT INTO `tb_user` VALUES (6, '13456762069', '', 'user_xn5wr3hpsv', '', '2022-02-07 17:54:10', '2022-02-07 17:54:10');
INSERT INTO `tb_user` VALUES (3012, '18881566740', '', 'user_7zt8gm2apx', '', '2026-04-04 18:33:00', '2026-04-04 18:33:00');
INSERT INTO `tb_user` VALUES (3013, '15862846423', '', 'user_ini5y2242m', '', '2026-04-06 16:24:49', '2026-04-06 16:24:49');

-- ----------------------------
-- Table structure for tb_user_info
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_info`;
CREATE TABLE `tb_user_info`  (
  `user_id` bigint UNSIGNED NOT NULL COMMENT '主键，用户id',
  `city` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '城市名称',
  `introduce` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个人介绍，不要超过128个字符',
  `fans` int UNSIGNED NULL DEFAULT 0 COMMENT '粉丝数量',
  `followee` int UNSIGNED NULL DEFAULT 0 COMMENT '关注的人的数量',
  `gender` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '性别，0：男，1：女',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `credits` int UNSIGNED NULL DEFAULT 0 COMMENT '积分',
  `level` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '会员级别，0~9级,0代表未开通会员',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tb_user_info
-- ----------------------------

-- ----------------------------
-- Table structure for tb_voucher
-- ----------------------------
DROP TABLE IF EXISTS `tb_voucher`;
CREATE TABLE `tb_voucher`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '商铺id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代金券标题',
  `sub_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '副标题',
  `rules` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '使用规则',
  `pay_value` bigint UNSIGNED NOT NULL COMMENT '支付金额，单位是分。例如200代表2元',
  `actual_value` bigint NOT NULL COMMENT '抵扣金额，单位是分。例如200代表2元',
  `type` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '0,普通券；1,秒杀券',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '1,上架; 2,下架; 3,过期',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tb_voucher
-- ----------------------------
INSERT INTO `tb_voucher` VALUES (1, 1, '50元代金券', '周一至周日均可使用', '全场通用\\n无需预约\\n可无限叠加\\不兑现、不找零\\n仅限堂食', 4750, 5000, 0, 1, '2022-01-04 09:42:39', '2022-01-04 09:43:31');
INSERT INTO `tb_voucher` VALUES (14, 1, '100元代金券', '周一至周五均可使用', '全场通用\\n无需预约\\n可无限叠加\\不兑现、不找零\\n仅限堂食', 8000, 10000, 1, 1, '2026-03-31 19:52:50', '2026-03-31 19:52:50');
INSERT INTO `tb_voucher` VALUES (15, 2, '100元代金券', '周一至周五均可使用', '全场通用\\n无需预约\\n可无限叠加\\不兑现、不找零\\n仅限堂食', 8000, 10000, 1, 1, '2026-04-02 20:31:03', '2026-04-02 20:31:03');
INSERT INTO `tb_voucher` VALUES (20, 1, '100元代金券', '周一至周五均可使用', '全场通用\\n无需预约\\n可无限叠加\\不兑现、不找零\\n仅限堂食', 8000, 10000, 1, 1, '2026-04-04 16:07:30', '2026-04-04 16:07:30');

-- ----------------------------
-- Table structure for tb_voucher_order
-- ----------------------------
DROP TABLE IF EXISTS `tb_voucher_order`;
CREATE TABLE `tb_voucher_order`  (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint UNSIGNED NOT NULL COMMENT '下单的用户id',
  `voucher_id` bigint UNSIGNED NOT NULL COMMENT '购买的代金券id',
  `pay_type` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '支付方式 1：余额支付；2：支付宝；3：微信',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '订单状态，1：未支付；2：已支付；3：已核销；4：已取消；5：退款中；6：已退款',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  `pay_time` timestamp NULL DEFAULT NULL COMMENT '支付时间',
  `use_time` timestamp NULL DEFAULT NULL COMMENT '核销时间',
  `refund_time` timestamp NULL DEFAULT NULL COMMENT '退款时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tb_voucher_order
-- ----------------------------
INSERT INTO `tb_voucher_order` VALUES (576951452317004005, 2012, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004006, 2013, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004007, 2014, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004008, 2015, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004009, 2016, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004010, 2017, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004011, 2018, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004012, 2020, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004013, 2019, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004014, 2021, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004015, 2022, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004016, 2023, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004017, 2025, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004018, 2024, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004019, 2026, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004020, 2029, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004021, 2028, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004022, 2027, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004023, 2030, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004024, 2032, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004025, 2033, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004026, 2034, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004027, 2036, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004028, 2037, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004029, 2040, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004030, 2035, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004031, 2043, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004032, 2038, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004033, 2042, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004034, 2031, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004035, 2041, 20, 1, 1, '2026-04-04 18:26:18', NULL, NULL, NULL, '2026-04-04 18:26:18');
INSERT INTO `tb_voucher_order` VALUES (576951452317004036, 2045, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004037, 2039, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004038, 2044, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004039, 2046, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004040, 2047, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004041, 2049, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004042, 2048, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004043, 2050, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004044, 2051, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004045, 2052, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004046, 2053, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004047, 2055, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004048, 2057, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004049, 2054, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004050, 2056, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004051, 2059, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004052, 2063, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004053, 2062, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004054, 2060, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004055, 2061, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004056, 2058, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004057, 2064, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004058, 2065, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004059, 2067, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004060, 2066, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004061, 2068, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004062, 2075, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004063, 2072, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004064, 2069, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004065, 2070, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004066, 2074, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004067, 2076, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004068, 2071, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004069, 2073, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004070, 2077, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004071, 2078, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004072, 2080, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004073, 2079, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004074, 2082, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004075, 2084, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004076, 2094, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004077, 2091, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004078, 2088, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004079, 2085, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004080, 2092, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004081, 2083, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004082, 2081, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004083, 2086, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004084, 2090, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004085, 2093, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004086, 2087, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004087, 2095, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004088, 2089, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004089, 2097, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004090, 2096, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004091, 2098, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004092, 2099, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004093, 2102, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004094, 2100, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004095, 2101, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004096, 2103, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004097, 2105, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004098, 2104, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004099, 2107, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004100, 2106, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004101, 2108, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004102, 2109, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004103, 2110, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004104, 2114, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004105, 2112, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004106, 2113, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004107, 2111, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951452317004108, 2115, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971405, 2116, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971406, 2117, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971407, 2119, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971408, 2118, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971409, 2120, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971410, 2121, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971411, 2122, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971412, 2123, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971413, 2124, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971414, 2125, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971415, 2126, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971416, 2127, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971417, 2128, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971418, 2129, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971419, 2130, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971420, 2131, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971421, 2132, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971422, 2133, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971423, 2134, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971424, 2135, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971425, 2137, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971426, 2136, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971427, 2138, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971428, 2139, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971429, 2140, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971430, 2141, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971431, 2142, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971432, 2143, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971433, 2144, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971434, 2146, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971435, 2145, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971436, 2147, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971437, 2148, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971438, 2149, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971439, 2150, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971440, 2151, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971441, 2152, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971442, 2154, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971443, 2156, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971444, 2153, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971445, 2155, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971446, 2157, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971447, 2158, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971448, 2159, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971449, 2160, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971450, 2161, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971451, 2162, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971452, 2163, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971453, 2164, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971454, 2165, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971455, 2166, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971456, 2167, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971457, 2168, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971458, 2169, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971459, 2170, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971460, 2171, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971461, 2172, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971462, 2173, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971463, 2174, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971464, 2176, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971465, 2177, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971466, 2175, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971467, 2178, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971468, 2179, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971469, 2181, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971470, 2182, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971471, 2180, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971472, 2183, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971473, 2184, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971474, 2185, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971475, 2187, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971476, 2186, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971477, 2188, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971478, 2189, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971479, 2190, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971480, 2191, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971481, 2192, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971482, 2193, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971483, 2194, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971484, 2195, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971485, 2196, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971486, 2198, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971487, 2199, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971488, 2197, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971489, 2200, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971490, 2201, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971491, 2202, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971492, 2203, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971493, 2205, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971494, 2204, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971495, 2206, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971496, 2207, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971497, 2208, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971498, 2211, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971499, 2209, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');
INSERT INTO `tb_voucher_order` VALUES (576951456611971500, 2210, 20, 1, 1, '2026-04-04 18:26:19', NULL, NULL, NULL, '2026-04-04 18:26:19');

SET FOREIGN_KEY_CHECKS = 1;
