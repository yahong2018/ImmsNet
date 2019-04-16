/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : localhost:3306
 Source Schema         : Imms_Net

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 09/04/2019 20:45:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bom
-- ----------------------------
DROP TABLE IF EXISTS `bom`;
CREATE TABLE `bom` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bom_order_id` bigint(20) NOT NULL,
  `component_material_id` bigint(20) NOT NULL,
  `component_abstract_material_id` bigint(20) DEFAULT NULL,
  `qty_component` float(8,2) NOT NULL,
  `component_unit` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `is_main_fabric` bit(1) NOT NULL,
  `parent_bom_id` bigint(20) DEFAULT NULL,
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_bom_01` (`component_material_id`),
  KEY `idx_bom_02` (`component_abstract_material_id`),
  KEY `idx_bom_03` (`parent_bom_id`),
  KEY `idx_bom_04` (`bom_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of bom
-- ----------------------------
BEGIN;
INSERT INTO `bom` VALUES (1, 2, 158, NULL, 52.92, '米', b'1', NULL, 1, '2019-04-09 11:26:41', NULL, NULL, 0);
INSERT INTO `bom` VALUES (2, 2, 207, NULL, 40.00, '个', b'0', NULL, 1, '2019-04-09 11:26:41', NULL, NULL, 0);
INSERT INTO `bom` VALUES (3, 2, 201, NULL, 400.00, '个', b'0', NULL, 1, '2019-04-09 11:26:41', NULL, NULL, 0);
INSERT INTO `bom` VALUES (4, 2, 193, NULL, 40.00, '个', b'0', NULL, 1, '2019-04-09 11:26:41', NULL, NULL, 0);
INSERT INTO `bom` VALUES (5, 2, 194, NULL, 40.00, '个', b'0', NULL, 1, '2019-04-09 11:26:41', NULL, NULL, 0);
INSERT INTO `bom` VALUES (6, 2, 195, NULL, 40.00, '个', b'0', NULL, 1, '2019-04-09 11:26:41', NULL, NULL, 0);
INSERT INTO `bom` VALUES (7, 2, 196, NULL, 40.00, '个', b'0', NULL, 1, '2019-04-09 11:26:41', NULL, NULL, 0);
INSERT INTO `bom` VALUES (8, 2, 197, NULL, 40.00, '条', b'0', NULL, 1, '2019-04-09 11:26:41', NULL, NULL, 0);
INSERT INTO `bom` VALUES (9, 2, 198, NULL, 40.00, '个', b'0', NULL, 1, '2019-04-09 11:26:41', NULL, NULL, 0);
INSERT INTO `bom` VALUES (10, 2, 199, NULL, 40.00, '包', b'0', NULL, 1, '2019-04-09 11:26:41', NULL, NULL, 0);
INSERT INTO `bom` VALUES (11, 2, 200, NULL, 40.00, '张', b'0', NULL, 1, '2019-04-09 11:26:41', NULL, NULL, 0);
INSERT INTO `bom` VALUES (12, 2, 273, NULL, 9.83, '米', b'0', NULL, 1, '2019-04-09 11:26:41', NULL, NULL, 0);
INSERT INTO `bom` VALUES (13, 2, 239, NULL, 0.46, '米', b'0', NULL, 1, '2019-04-09 11:26:41', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for bom_order
-- ----------------------------
DROP TABLE IF EXISTS `bom_order`;
CREATE TABLE `bom_order` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(12) COLLATE utf8_bin NOT NULL,
  `order_status` int(11) NOT NULL,
  `bom_order_type` int(11) NOT NULL,
  `material_id` bigint(20) NOT NULL,
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_bom_order_01` (`order_no`),
  KEY `idx_bom_order_02` (`order_status`),
  KEY `idx_bom_order_03` (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of bom_order
-- ----------------------------
BEGIN;
INSERT INTO `bom_order` VALUES (1, 'BOM000000001', 0, 50, 16, 1, '2019-04-09 10:52:06', NULL, NULL, 0);
INSERT INTO `bom_order` VALUES (2, 'BOM000000002', 0, 50, 16, 1, '2019-04-09 10:53:44', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for code_seed
-- ----------------------------
DROP TABLE IF EXISTS `code_seed`;
CREATE TABLE `code_seed` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `seed_no` varchar(50) COLLATE utf8_bin NOT NULL,
  `seed_name` varchar(50) COLLATE utf8_bin NOT NULL,
  `initial_value` int(11) NOT NULL,
  `prefix` varchar(10) COLLATE utf8_bin NOT NULL,
  `postfix` varchar(10) COLLATE utf8_bin NOT NULL,
  `total_length` int(11) NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `idx_code_seed_0` (`seed_no`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of code_seed
-- ----------------------------
BEGIN;
INSERT INTO `code_seed` VALUES (1, 'Imms.Mes.MasterData.BomOrder', 'bom单号', 3, 'BOM', '', 12);
INSERT INTO `code_seed` VALUES (2, 'Imms.Mes.Stitch.ProductionOrder', '生产计划单号', 2, 'PO', '', 12);
INSERT INTO `code_seed` VALUES (3, 'piking_schedule_no', '领料计划单号', 1, '', '', 10);
INSERT INTO `code_seed` VALUES (4, 'piking_order_no', '领料单号', 1, '', '', 10);
INSERT INTO `code_seed` VALUES (5, 'cutting_order_no', '裁剪单号', 1, '', '', 10);
INSERT INTO `code_seed` VALUES (6, 'work_order_no', '作业单号', 1, '', '', 10);
INSERT INTO `code_seed` VALUES (7, 'Imms.Mes.Stitch.OperationRoutingOrder', '工艺路线单号', 2, 'ORO', '', 12);
COMMIT;

-- ----------------------------
-- Table structure for material
-- ----------------------------
DROP TABLE IF EXISTS `material`;
CREATE TABLE `material` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `material_no` varchar(20) COLLATE utf8_bin NOT NULL,
  `material_name` varchar(50) COLLATE utf8_bin NOT NULL,
  `material_type_id` bigint(20) NOT NULL,
  `unit` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `width` decimal(10,4) DEFAULT NULL,
  `weight` decimal(10,4) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `color` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `description` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_material_01` (`material_no`),
  KEY `idx_material_02` (`material_name`),
  KEY `idx_material_03` (`material_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=512 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of material
-- ----------------------------
BEGIN;
INSERT INTO `material` VALUES (1, 'SMCSCX001', '衬衫', 512, '', 0.0000, 0.0000, 1200.00, '30,144,255', '打底连衣裙', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (2, 'SMCSCX002', '梭织男衬衫', 512, '', 0.0000, 0.0000, 680.00, '248,248,255', '男装长袖衬衫，上下级领，工字折双层担干，门襟、袖衩装拉链', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (3, 'SWCSCX002', '梭织男衬衫', 512, '', 0.0000, 0.0000, 1000.00, '255,182,193', '梭织男衬衫', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (4, 'SWCSCX004', '小西装', 512, '', 0.0000, 0.0000, 2000.00, '65,105,225', '小西装', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (5, 'SWCSCX005', '梭织男衬衫', 512, '', 0.0000, 0.0000, 980.00, '255,250,250', '梭织男衬衫', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (6, 'SWCSCX001', '女长袖衬衫_1', 512, '', NULL, NULL, 0.02, 'BA', ' 陈文越客户女长袖衬衫_1', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (7, 'SWLYCX001', '女长袖连衣裙', 512, '', NULL, NULL, 0.02, 'BA', ' 陈文越客户女长袖连衣裙', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (8, 'ZWWTCX001', '女针织外套', 512, '', NULL, NULL, 0.02, 'BA', ' 陈文越客户女针织外套', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (9, 'S00001', '常规剪裁，搭配简约的中八领，演绎雅致臻品魅力透气吸湿，舒适柔软；光泽柔和，手感细腻；轻柔洗涤，温和晾', 512, '', NULL, NULL, 5180.00, '', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (10, 'FB185Z1002', '商品基准款团体定制款_11I', 512, '', NULL, NULL, 0.01, 'AA', ' 韩豪客户商品基准款 团体定制款_11I', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (11, 'FB185Z100211I', '商品基准款团体定制款_11I', 512, '', NULL, NULL, NULL, 'AA', '商品基准款团体定制款_11I', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (12, 'FB185Z1002OY5', '商品基准款团体定制款_OY5', 512, '', NULL, NULL, NULL, 'AA', '商品基准款团体定制款_OY5', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (13, 'SWCSCX006', '梭织女衬衫', 512, '', 0.0000, 0.0000, 980.00, '255,250,250', '女装半开胸衬衫，立领，门襟、领位夹\n叠活动双层页，内贴担干', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (14, 'SMCS001', '衬衫', 512, '件', 0.0000, 0.0000, 1000.00, '137,207,240', '男装衬衫长袖，上下级领，方介英，三尖袖叉，明筒，后幅工字折担干', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (15, 'SWCS002', '女衬衫', 512, '件', 0.0000, 0.0000, 1000.00, '137,207,240', '女装衬衫长袖，上下级领，方介英，三尖袖叉，明筒，前后幅腰省', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (16, 'SMCS001001', '衬衫', 512, '件', 0.0000, 0.0000, 1000.00, '137,207,240', '男装衬衫长袖，上下级领，方介英，三尖袖叉，明筒，后幅工字折担干', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (17, 'SWCS001', '春季时尚女衬衫', 512, '件', 0.0000, 0.0000, 1000.00, '65,105,225', '女装衬衫长袖，上下级领，方介英，三尖袖叉，明筒，前后幅腰省', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (18, 'SMKZ001', '男工装裤', 512, '件', NULL, NULL, 1000.00, '255,255,255', '智能制造宇航服工装裤，白拼黑，橡筋腰、脚口；拉链袋。', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (19, 'ZWTX001', '女T恤', 512, '件', NULL, NULL, 1000.00, '128,128,128', '圆领针织T恤衫，三线合缝，脚、袖口冚边。', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (20, 'ZMTX001', '男T恤', 512, '件', NULL, NULL, 1000.00, '128,128,128', '圆领针织T恤衫，三线合缝，脚、袖口冚边。', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (21, 'SWKZ001', '女工装裤', 512, '件', NULL, NULL, 1000.00, '255,255,255', '智能制造宇航服工装裤，白拼黑，橡筋腰、脚口；拉链袋。', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (22, 'SMWT001', '男工装外套', 512, '件', NULL, NULL, 1000.00, '255,255,255', '智能制造宇航服工装外套，白拼黑，橡筋袖口；拉链袋。', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (23, 'SWWT001', '女工装外套', 512, '件', NULL, NULL, 1000.00, '255,255,255', '智能制造宇航服工装外套，白拼黑，橡筋袖口；拉链袋。', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (24, 'SMCS002', '衬衫', 512, '件', NULL, NULL, 1000.00, '65,105,225', '男装衬衫长袖，上下级领，方介英，三尖袖叉，明筒，后幅工字折担干', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (25, '11001', '主面料', 513, '件', 1.4200, 1.2200, 0.00, '137,207,240', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (26, 'SMCSCX011', '领子', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (27, 'SMCSCX012', '介英', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (28, 'SMCSCX013', '门襟', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (29, 'SMCSCX014', '袖贴', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (30, 'SMCSCX015', '面料', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (31, 'SMCSCX111', '圆领', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (32, 'SMCSCX121', '新款介英', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (33, 'SMCSCX131', '新款门襟', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (34, 'SMCSCX141', '新款袖贴', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (35, 'SMCSCX021', '领子', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (36, 'SMCSCX022', '介英', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (37, 'SMCSCX023', '门襟', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (38, 'SMCSCX024', '袖贴', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (39, 'SMCSCX025', '面料', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (40, 'SMCSCX211', '圆领', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (41, 'SMCSCX221', '新款介英', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (42, 'SMCSCX231', '新款门襟', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (43, 'SMCSCX241', '新款袖贴', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (44, 'SWCSCX021', '领子', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (45, 'SWCSCX022', '介英', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (46, 'SWCSCX023', '门襟', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (47, 'SWCSCX024', '袖贴', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (48, 'SWCSCX025', '面料', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (49, 'SWCSCX211', '圆领', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (50, 'SWCSCX221', '新款介英', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (51, 'SWCSCX231', '新款门襟', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (52, 'SWCSCX241', '新款袖贴', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (53, 'SWCSCX041', '领子', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (54, 'SWCSCX042', '介英', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (55, 'SWCSCX043', '门襟', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (56, 'SWCSCX044', '袖贴', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (57, 'SWCSCX045', '面料', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (58, 'SWCSCX411', '圆领', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (59, 'SWCSCX421', '新款介英', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (60, 'SWCSCX431', '新款门襟', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (61, 'SWCSCX441', '新款袖贴', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (62, 'SWCSCX051', '领子', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (63, 'SWCSCX052', '介英', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (64, 'SWCSCX053', '门襟', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (65, 'SWCSCX054', '袖贴', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (66, 'SWCSCX055', '面料', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (67, 'SWCSCX511', '圆领', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (68, 'SWCSCX521', '新款介英', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (69, 'SWCSCX531', '新款门襟', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (70, 'SWCSCX541', '新款袖贴', 513, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (71, '11002', '面料B', 513, '件', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (72, '16001', '衬布', 513, '厘米', 148.0000, 0.0000, NULL, '248,248,255', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (73, '16002', '布衬B', 513, '件', 142.0000, 0.0000, 0.00, '255,255,255', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (74, 'SMCSCL', '领子', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (75, 'SMCSCU', '介英', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (76, 'SMCSFR', '前幅', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (77, 'SMCSBK', '后幅', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (78, 'SMCSSL', '袖子', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (79, 'SMCSAS', '组合', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (80, 'SWCSOH', '组合', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (81, 'SMCSCL001', '方领', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (82, 'SMCSCL002', '八字领', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (83, 'SMCSCL003', '尖领', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (84, 'SMCSCU001', '介英', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (85, 'SMCSFR001', '前幅', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (86, 'SMCSBK001', '后幅', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (87, 'SMCSSL001', '长袖', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (88, 'SMCSSL002', '短袖', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (89, 'SMCSAS001', '组合', 513, '件', 0.0000, 0.0000, 0.00, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (90, 'SWCSCL', '领子', 513, '件', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (91, 'SWCSCU', '介英', 513, '件', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (92, 'SWCSFR', '前幅', 513, '件', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (93, 'SWCSBK', '后幅', 513, '件', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (94, 'SWCSSL', '袖子', 513, '件', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (95, 'SWCSAS', '组合', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (96, 'SWCSCL001', '方领', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (97, 'SWCSCL002', '八字领', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (98, 'SWCSCL003', '尖领', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (99, 'SWCSCU001', '介英', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (100, 'SWCSFR001', '前幅', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (101, 'SWCSBK001', '后幅', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (102, 'SWCSSL001', '长袖', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (103, 'SWCSSL002', '短袖', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (104, 'SWCSAS001', '组合', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (105, 'SWCSCL004', '圆领', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (106, 'SWCSYDAS', '一段组合', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (107, 'SWCSEDAS', '二段组合', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (108, 'SWCSSDAS', '三段组合', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (109, 'SWCSCLAS', '领子组合', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (110, 'SWCSCUAS', '介英组合', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (111, 'SWCSEDAS001', '二段组合', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (112, 'SWCSYDAS001', '一段组合', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (113, 'SWCSSDAS001', '三段组合', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (114, 'SWCSCLAS001', '领子组合', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (115, 'SWCSCUAS001', '介英组合', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (116, 'ZWTXSL', '袖子', 513, '件', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (117, 'ZWTXSL001', '长袖', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (118, 'ZWTXSL002', '短袖', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (119, 'ZMTXSL', '袖子', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (120, 'ZMTXSL001', '长袖', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (121, 'ZMTXSL002', '短袖', 513, '件', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (122, 'WLLA001', 'W拉链A1', 513, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (123, 'WLLB001', 'W拉链B1前中', 513, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (124, 'WLLA002', 'W拉链A2', 513, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (125, 'WXJA001', 'W橡筋A腰头', 513, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (126, 'WXJB001', 'W橡筋B', 513, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (127, 'WSDA001', 'W绳带A', 513, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (128, 'WLLA004', 'W拉链A4', 513, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (129, 'WLLA005', 'W拉链A5', 513, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (130, 'WLLA006', 'W拉链A6', 513, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (131, 'WLWA001', 'W罗纹A', 513, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (132, 'WYLA001', 'W隐拉A1', 513, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (133, 'WZDA001', 'W织带A', 513, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (134, 'WDXTB01', 'W定型衬条B', 513, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (135, 'TDT001', 'W透明定型条', 513, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (136, 'WDXTA01', 'W定型衬条A', 513, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (137, '15001', '红色罗纹', 513, '米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (138, 'CX0002', '缝合线', 514, 'M', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (139, 'SWCS001001', '春季时尚女衬衫', 516, '件', 0.0000, 0.0000, 1000.00, '65,105,225', '女装衬衫长袖，上下级领，方介英，三尖袖叉，明筒，前后幅腰省', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (140, 'SWKZ001001', '女工装裤', 516, '件', NULL, NULL, 1000.00, '255,255,255', '智能制造宇航服工装裤，白拼黑，橡筋腰、脚口；拉链袋。', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (141, 'SMKZ001001', '男工装裤', 516, '件', NULL, NULL, 1000.00, '255,255,255', '智能制造宇航服工装裤，白拼黑，橡筋腰、脚口；拉链袋。', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (142, 'ZWTX001001', '女T恤', 516, '件', NULL, NULL, 1000.00, '128,128,128', '圆领针织T恤衫，三线合缝，脚、袖口冚边。', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (143, 'ZMTX001001', '男T恤', 516, '件', 0.0000, 0.0000, 1000.00, '0,128,0', '圆领针织T恤衫，三线合缝，脚、袖口冚边。', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (144, 'SMWT001001', '男工装外套', 516, '件', NULL, NULL, 1000.00, '255,255,255', '智能制造宇航服工装外套，白拼黑，橡筋袖口；拉链袋。', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (145, 'SWWT001001', '女工装外套', 516, '件', NULL, NULL, 1000.00, '255,255,255', '智能制造宇航服工装外套，白拼黑，橡筋袖口；拉链袋。', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (146, '1WOR17396', '女裤', 516, '件', NULL, NULL, 1000.00, '0,0,0', '电商灯笼脚口时装长裤。', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (147, 'SWLY001001', '女连衣裙', 516, '件', NULL, NULL, 1000.00, '255,255,255', '女连衣裙，后中暗拉链', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (148, '19EB2610', '女衬衫', 516, '件', NULL, NULL, 1000.00, '248,248,255', '女装衬衫长袖，上下级领，方介英，明筒', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (149, '19EB8067', '女连衣裙', 516, '件', NULL, NULL, 1000.00, '0,0,0', '女连衣裙', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (150, '19EB2604', '女上衣', 516, '件', NULL, NULL, 1000.00, '0,0,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (151, '19EB2044', '女T恤', 516, '件', NULL, NULL, 1000.00, '248,248,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (152, '19EB2065', '女T恤', 516, '件', NULL, NULL, 1000.00, '248,248,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (153, '19EB2611', '女衬衫', 516, '件', NULL, NULL, 1000.00, '248,248,255', '女装衬衫长袖，上下级领', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (154, '19EB9608', '半裙', 516, '件', NULL, NULL, 1000.00, '248,248,255', '半裙', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (155, '1WOR17065', '女T恤', 516, '件', NULL, NULL, 1000.00, '255,0,0', '圆领针织短款T恤衫，三线合缝，脚、袖口冚边。', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (156, '19EB1615', '女裤', 516, '件', NULL, NULL, 1000.00, '248,248,255', '印花女裤', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (157, 'W19SZCT010001', '柔性面料', 517, '件', 142.0000, 0.0000, NULL, '255,255,255', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (158, 'M18SZCT01001', '柔性面料', 517, '件', 142.0000, 0.0000, NULL, '137,207,240', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (159, 'M18SZSP01001', '白色面料', 517, '件', 142.0000, 0.0000, NULL, '255,255,255', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (160, 'P03', '朴', 517, '件', 142.0000, 1.0000, 0.00, '255,255,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (161, 'M18SZCT01002', '粉红面料', 517, '件', 142.0000, 0.0000, NULL, '255,192,203', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (162, 'M18SZCT070001', '蓝色格仔面料', 517, '件', 142.0000, 0.0000, NULL, '65,105,225', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (163, 'SMCSCX151', '柔性面料', 517, '', 0.0000, 0.0000, NULL, '30,144,255', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (164, 'M19ZZCT07001', '墨蓝面料', 517, '件', 158.0000, NULL, NULL, '65,105,225', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (165, 'M19ZZSP01001', '白色面料', 517, '件', 158.0000, NULL, NULL, '255,255,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (166, 'M19ZZCT04001', '粉红面料', 517, '件', 158.0000, NULL, NULL, '255,192,203', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (167, 'M19SZCT01001', '面料', 517, '件', 145.0000, NULL, NULL, '0,0,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (168, 'M19SZCT02001', '面料', 517, '件', 145.0000, NULL, NULL, '0,0,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (169, 'M19SZQT01001', '里料', 517, '件', 140.0000, NULL, NULL, '0,0,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (170, 'M19SZVR02001', '衬料', 517, '件', 140.0000, NULL, NULL, '0,0,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (171, 'M19ZZCT03001', '灰色面料', 517, '件', 158.0000, 0.0000, 0.00, '46,139,87', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (172, 'M19ZZSP05001', '橙黄面料', 517, '件', 158.0000, NULL, NULL, '255,69,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (173, 'M19ZZSP07001', '荧光绿面料', 517, '件', 158.0000, 0.0000, 0.00, '127,255,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (174, 'M19SZQT02001', '里料', 517, '件', 140.0000, NULL, NULL, '0,0,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (175, 'M19SZCT02002', '面料', 517, '件', 145.0000, NULL, NULL, '0,0,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (176, 'M19SZHF01001', '面料', 517, '件', 146.0000, NULL, NULL, '255,255,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (177, 'M19SZPE01001', '里料', 517, '件', 140.0000, NULL, NULL, '255,255,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (178, 'M19ZZHF02001', '面料', 517, '件', 176.0000, NULL, NULL, '0,0,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (179, 'M19ZZHF02002', '黑色针织面料', 517, '件', 176.0000, NULL, NULL, '0,0,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (180, 'M19XFPE02001', '黑色雪纺面料', 517, '件', 143.0000, NULL, NULL, '0,0,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (181, 'M19ZZHF01001', '白色针织面料', 517, '厘米', 170.0000, NULL, NULL, '248,248,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (182, 'M19SZCT01002', '白色梭织面料', 517, '厘米', 118.0000, NULL, NULL, '248,248,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (183, 'M19ZZCT06001', '绿色面料', 517, '厘米', 157.0000, NULL, NULL, '0,128,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (184, 'M19XFPE01001', '面料', 517, '厘米', 143.0000, NULL, NULL, '248,248,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (185, 'M19XFPE01002', '面料', 517, '厘米', 143.0000, NULL, NULL, '248,248,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (186, 'M19ZZHF04001', '红色面料', 517, '米', 170.0000, NULL, NULL, '255,0,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (187, 'M19XFSK01002', '印花面料', 517, '米', 143.0000, NULL, NULL, '248,248,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (188, 'M19LWHF04001', '红色罗纹', 517, '米', 120.0000, 0.0000, 0.00, '255,0,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (189, '2001', '朴条', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (190, 'SZ01', '细绳', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (191, 'DL01', '吊粒', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (192, 'MD001', '铆钉', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (193, 'ZM01', '主唛', 515, '', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (194, 'CM01', '码唛', 515, '', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (195, 'XM01', '洗水唛', 515, '', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (196, 'DP01', '吊牌', 515, '', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (197, 'DX01', '吊绳', 515, '', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (198, 'JD01', '胶袋', 515, '', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (199, 'GZJ01', '干燥剂', 515, '', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (200, 'FCZ01', '防潮纸', 515, '', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (201, 'NC01', '四眼纽扣', 515, '粒', 0.0000, 0.0000, 0.00, '137,207,240', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (202, '4001', '实样', 515, '件', 110.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (203, '4002', '实样', 515, '件', 110.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (204, '4003', '实样', 515, '件', 110.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (205, 'B001', '面料b', 515, '米', 1.4500, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (206, 'AX0001', '淡黄绿绿色配饰线', 515, 'M', 142.0000, 0.0000, 0.02, '127,255,0', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (207, 'AX0002', '雪白缝合线', 515, 'M', 142.0000, 0.0000, 0.00, '255,250,250', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (208, '11003', '面料C', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (209, '11004', '面料D', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (210, '11005', '面料F', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (211, '11006', '面料G', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (212, '11007', '面料H', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (213, '12002', '里料B', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (214, '12003', '里料C', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (215, '12004', '里料D', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (216, '12005', '里料F', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (217, '13001', '蕾丝A', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (218, '13002', '蕾丝B', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (219, '13004', '蕾丝C', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (220, '13005', '蕾丝D', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (221, '13006', '蕾丝F', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (222, '14001', '花边A', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (223, '14002', '花边B', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (224, '14003', '花边C', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (225, '14004', '花边D', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (226, '14005', '花边C', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (227, '14006', '花边F', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (228, '14007', '花边G', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (229, '16003', '布衬C', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (230, '17001', '纸朴A', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (231, '17002', '纸朴B', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (232, '17003', '纸朴C', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (233, '18001', '网衬A', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (234, '18002', '网衬B', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (235, '18003', '网衬C', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (236, '19001', '毛衬A', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (237, '19002', '毛衬B', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (238, '19003', '毛衬C', 515, '', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (239, '40101', '实样A', 515, '件', 110.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (240, '40201', '折烫样A', 515, '件', 110.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (241, '40301', '修剪样A', 515, '件', 110.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (242, '40401', '点位样A', 515, '件', 110.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (243, '40501', '扫粉样A', 515, '件', 110.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (244, '40601', '夹烫样A', 515, '件', 110.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (245, '40701', '模板样A', 515, '件', 110.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (246, '40801', '花稿样A', 515, '件', 110.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (247, 'F19LL5A01014', '白色金属拉链', 515, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (248, 'F19LT5A01001', '银白拉链头', 515, '个', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (249, 'F19LL3B01014', '白色塑料拉链', 515, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (250, 'F19LL5A01016', '白色金属拉链', 515, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (251, 'F19SDPE02055', '黑色橡筋', 515, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (252, 'F19SDPE09006', '黑白相间绳带', 515, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (253, 'F19SDPE02030', '黑色橡筋', 515, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (254, 'F19LL5A01015', '白色金属拉链', 515, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (255, 'F19LL5A01018', '白色金属拉链', 515, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (256, 'F19LL5A01023', '白色金属拉链', 515, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (257, 'F19ZZRW01001', '白间黑条罗纹', 515, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (258, 'F19HKWJ01001', '银色四合扣', 515, '个', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (259, 'F19JYWJ01001', '白色机眼', 515, '个', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (260, 'F19QTSJ02001', '黑色魔术贴', 515, '个', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (261, 'F19LLPC02001', 'W拉链G1', 515, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (262, 'F19ZDSD02001', 'W织带C', 515, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (263, 'F19LLPC01018', 'W隐拉A1', 515, '厘米', NULL, NULL, NULL, '248,248,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (264, 'F19ZDSD01005', 'W织带A', 515, '厘米', NULL, NULL, NULL, '248,248,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (265, 'F19CPVR01001', 'W定型衬条B', 515, '厘米', NULL, NULL, NULL, '248,248,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (266, 'F19ZDSD02015', 'W织带A', 515, '厘米', 0.0000, 0.0000, 0.00, '0,0,0', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (267, 'F19CPVR01003', 'W透明定型条', 515, '厘米', NULL, NULL, NULL, NULL, NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (268, 'F19CPVR01004', 'W定型衬条A', 515, '厘米', NULL, NULL, NULL, '248,248,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (269, 'F19SDPE01050', 'W橡筋A', 515, '厘米', NULL, NULL, NULL, '248,248,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (270, 'NK01', '四眼纽扣', 515, '粒', 0.0000, 0.0000, 0.00, '248,248,255', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (271, '12001', '里料A', 519, '件', 0.0000, 0.0000, NULL, '', '', 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (272, 'M19SZLN01001', '里布', 519, '厘米', 143.0000, NULL, NULL, '248,248,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (273, 'M19SZVR01001', '白色衬布', 520, '厘米', 148.0000, NULL, NULL, '255,255,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
INSERT INTO `material` VALUES (274, 'F19CPVR01002', '白色布衬', 520, '厘米', 148.0000, NULL, NULL, '248,248,255', NULL, 1, '2019-04-07 16:19:38', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for operation
-- ----------------------------
DROP TABLE IF EXISTS `operation`;
CREATE TABLE `operation` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `operation_no` varchar(20) COLLATE utf8_bin NOT NULL,
  `description` varchar(3000) COLLATE utf8_bin NOT NULL,
  `machine_type_id` bigint(20) NOT NULL,
  `standard_time` double(8,4) DEFAULT NULL,
  `standard_price` double(8,4) DEFAULT NULL,
  `section_type` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `section_name` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `is_outsource` bit(1) NOT NULL,
  `qa_procedure` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `requirement` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `required_level` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_operation_01` (`operation_no`),
  KEY `idx_operation_02` (`machine_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8191 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of operation
-- ----------------------------
BEGIN;
INSERT INTO `operation` VALUES (4096, 'OP0001', '裁剪', 1, 260.0000, 0.1200, 'CUTTING', '裁剪', b'0', '裁剪', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4097, 'OP0002', '缝车合肩', 3, 25.0000, 0.1200, 'STITCHING', '缝制', b'0', '缝车合肩', '2', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4098, 'OP0003', '压肩线', 5, 16.0000, 0.1200, 'STITCHING', '缝制', b'0', '压肩线', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4099, 'OP0004', '接圆领*1', 5, 23.0000, 0.1200, 'STITCHING', '缝制', b'0', '接圆领*1', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4100, 'OP0005', '走领散口一圈', 5, 18.0000, 0.1200, 'STITCHING', '缝制', b'0', '走领散口一圈', '3', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4101, 'OP0006', '缝车上领一圈', 3, 24.0000, 0.1200, 'STITCHING', '缝制', b'0', '缝车上领一圈', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4102, 'OP0007', '拉后领条', 5, 17.0000, 0.1200, 'STITCHING', '缝制', b'0', '拉后领条', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4103, 'OP0008', '包后领条', 5, 34.0000, 0.1200, 'STITCHING', '缝制', b'0', '包后领条', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4104, 'OP0009', '压前领线', 5, 45.0000, 0.1200, 'STITCHING', '缝制', b'0', '压前领线', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4105, 'OP0010', '封前领线*2', 5, 55.0000, 0.1200, 'STITCHING', '缝制', b'0', '封前领线*2', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4106, 'OP0011', '缝车上袖子', 3, 23.0000, 0.1200, 'STITCHING', '缝制', b'0', '缝车上袖子', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4107, 'OP0012', '压袖笼线', 5, 56.0000, 0.1200, 'STITCHING', '缝制', b'0', '压袖笼线', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4108, 'OP0013', '订洗水唛*2订衣上', 5, 24.0000, 0.1200, 'STITCHING', '缝制', b'0', '订洗水唛*2订衣上', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4109, 'OP0014', '缝车合身', 3, 78.0000, 0.1200, 'STITCHING', '缝制', b'0', '缝车合身', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4110, 'OP0015', '坎脚一圈', 4, 76.0000, 0.1200, 'STITCHING', '缝制', b'0', '坎脚一圈', '2', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4111, 'OP0016', '坎袖口*2', 4, 40.0000, 0.1200, 'STITCHING', '缝制', b'0', '坎袖口*2', '2', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4112, 'OP0017', '订主标暗线、连订尺码唛', 5, 80.0000, 0.1200, 'STITCHING', '缝制', b'0', '订主标暗线、连订尺码唛', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4113, 'OP0018', '大烫', 7, 25.0000, 0.1200, 'STITCHING', '缝制', b'0', '大烫', '2', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4114, 'OP0019', '尾查', 8, 65.0000, 0.1200, 'STITCHING', '后整', b'0', '尾查', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4115, 'OP0020', '生产包装', 9, 85.0000, 0.1200, 'STITCHING', 'PACK', b'0', '后整', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4116, 'OP0021', '中检', 6, 60.0000, 0.1200, 'STITCHING', '缝制', b'0', '中检', '2', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4117, 'OP0022', '上吊挂', 2, 60.0000, 60.0000, 'STITCHING', NULL, b'0', '上料台', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4118, 'OP0023', '印染', 10, 60.0000, 60.0000, 'PRINTING', '印染', b'0', '印染', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4119, 'MXGM010', '', 62, 13.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4120, 'MXGM011', '', 62, 39.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4121, 'MXGM012', '', 62, 39.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4122, 'MXGM013', '', 62, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4123, 'MXGM014', '', 62, 70.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4124, 'MXGM015', '', 137, 2.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4125, 'MXGM016', '', 62, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4126, 'MXGM017', '', 62, 47.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4127, 'MXGM018', '', 62, 60.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4128, 'MXGM019', '', 138, 105.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4129, 'HP001', '缝后中缝（直/70）*1', 156, 31.9800, 0.0760, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4130, 'LZ002', '运领沿（直10+弧5+直50+弧5+直10）1条*1', 156, 50.3700, 0.1196, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4131, 'LZ003', '修剪领止口*2', 15, 21.2200, 0.0477, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4132, 'LZ004', '封领（直/6）1条*2', 156, 25.6800, 0.0610, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4133, 'LZ005', '翻烫领*1', 160, 27.9100, 0.0977, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4134, 'LZ006', '', 152, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4135, 'MXGM001', '', 62, 0.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4136, 'MXGM002', '', 62, 0.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4137, 'MXGM003', '', 62, 0.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4138, 'MXGM004', '', 62, 0.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4139, 'MXGM005', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4140, 'MXGM006', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4141, 'MXGM007', '', 64, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4142, 'MXGM008', '', 64, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4143, 'MXGM009', '', 62, 13.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4144, 'MXGM020', '', 138, 111.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4145, 'MXGM021', '', 138, 47.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4146, 'MXGM022', '', 64, 11.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4147, 'MXGM023', '', 64, 22.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4148, 'MXGM024', '', 64, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4149, 'MXGM025', '', 64, 38.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4150, 'MXGM026', '', 64, 38.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4151, 'MXGM027', '', 64, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4152, 'MXGM028', '', 63, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4153, 'MXGM029', '', 63, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4154, 'MXGM030', '', 88, 60.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4155, 'MXGM031', '', 88, 82.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4156, 'MXGM032', '', 88, 82.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4157, 'MXGM033', '', 139, 22.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4158, 'MXGM034', '', 139, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4159, 'MXGM035', '', 139, 26.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4160, 'MXGM036', '', 139, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4161, 'MXGM037', '', 64, 7.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4162, 'MXGM038', '', 73, 7.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4163, 'MXGM039', '', 74, 48.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4164, 'MXGM040', '', 74, 38.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4165, 'MXGM041', '', 74, 61.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4166, 'MXGM042', '', 62, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4167, 'MXGM043', '', 137, 42.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4168, 'MXGM044', '', 137, 38.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4169, 'MXGM045', '', 137, 63.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4170, 'MXGM046', '', 137, 13.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4171, 'MXGM047', '', 64, 54.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4172, 'MXGM048', '', 64, 38.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4173, 'MXGM049', '', 64, 81.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4174, 'MXGM050', '', 64, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4175, 'MXGM051', '', 62, 23.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4176, 'MXGM052', '', 62, 17.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4177, 'MXGM053', '', 62, 29.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4178, 'MXGM054', '', 64, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4179, 'MXGM055', '', 62, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4180, 'MXGM056', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4181, 'MXGM057', '', 77, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4182, 'MXGM058', '', 62, 154.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4183, 'MXGM059', '', 62, 52.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4184, 'MXGM060', '', 62, 210.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4185, 'MXGM061', '', 65, 27.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4186, 'MXGM062', '', 65, 27.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4187, 'MXGM063', '', 65, 19.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4188, 'MXGM064', '', 65, 19.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4189, 'MXGM065', '', 65, 33.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4190, 'MXGM066', '', 65, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4191, 'MXGM067', '', 65, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4192, 'MXGM068', '', 65, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4193, 'MXGM069', '', 65, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4194, 'MXGM070', '', 65, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4195, 'MXGM071', '', 63, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4196, 'MXGM072', '', 138, 55.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4197, 'MXGM073', '', 62, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4198, 'MXGM074', '', 92, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4199, 'MXHS001', '', 138, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4200, 'MXHS002', '', 63, 42.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4201, 'MXHS003', '', 72, 60.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4202, 'MXHS004', '', 139, 17.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4203, 'MXHS005', '', 139, 17.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4204, 'MXHS006', '', 62, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4205, 'MXHS007', '', 62, 46.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4206, 'MXHS008', '', 109, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4207, 'MXHS009', '', 62, 28.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4208, 'MXHS010', '', 62, 28.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4209, 'MXHS011', '', 138, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4210, 'MXHS012', '', 138, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4211, 'MXHS013', '', 138, 80.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4212, 'MXHS014', '', 62, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4213, 'MXHS015', '', 64, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4214, 'MXHS016', '', 62, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4215, 'MXHS017', '', 62, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4216, 'MXHS018', '', 64, 9.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4217, 'MXHS019', '', 64, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4218, 'MXHS020', '', 64, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4219, 'MXHS021', '', 64, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4220, 'MXHS022', '', 64, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4221, 'MXHS023', '', 64, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4222, 'MXHS024', '', 138, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4223, 'MXHS025', '', 64, 120.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4224, 'MXHS026', '', 88, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4225, 'MXHS027', '', 64, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4226, 'MXHS028', '', 62, 13.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4227, 'MXHS029', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4228, 'MXHS030', '', 137, 7.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4229, 'MXHS031', '', 137, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4230, 'MXHS032', '', 64, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4231, 'MXHS033', '', 64, 16.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4232, 'MXHS034', '', 62, 36.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4233, 'MXHS035', '', 62, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4234, 'MXHS036', '', 62, 130.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4235, 'MXHS037', '', 62, 82.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4236, 'MXHS038', '', 62, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4237, 'MXHS039', '', 64, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4238, 'MXHS040', '', 64, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4239, 'MXHS041', '', 64, 22.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4240, 'MXHS042', '', 64, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4241, 'MXHS043', '', 62, 47.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4242, 'MXHS044', '', 139, 68.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4243, 'MXHS045', '', 139, 59.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4244, 'MXHS046', '', 139, 48.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4245, 'MXHZT001', '', 121, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4246, 'MXHZT002', '', 115, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4247, 'MXHZT003', '', 116, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4248, 'MXHZT004', '', 116, 42.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4249, 'MXHZT005', '', 117, 42.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4250, 'MXHZT006', '', 118, 42.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4251, 'MXHZT007', '', 119, 42.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4252, 'MXHZT008', '', 120, 42.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4253, 'MXHZT009', '', 122, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4254, 'MXHZT010', '', 139, 8.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4255, 'MXHZT011', '', 139, 14.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4256, 'MXHZT012', '', 139, 24.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4257, 'MXHZT013', '', 139, 27.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4258, 'MXHZT014', '', 139, 32.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4259, 'MXHZT015', '', 139, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4260, 'MXHZT016', '', 139, 8.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4261, 'MXHZT017', '', 135, 8.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4262, 'MXHZT018', '', 135, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4263, 'MXHZT019', '', 135, 27.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4264, 'MXHZT020', '', 135, 24.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4265, 'MXHZT021', '', 135, 32.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4266, 'MXHZT022', '', 135, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4267, 'MXHZT023', '', 135, 8.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4268, 'MXHZT024', '', 65, 6.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4269, 'MXHZT025', '', 65, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4270, 'MXHZT026', '', 65, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4271, 'MXHZT027', '', 65, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4272, 'MXHZT028', '', 65, 24.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4273, 'MXHZT029', '', 65, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4274, 'MXHZT030', '', 65, 6.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4275, 'MXHZT031', '', 137, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4276, 'MXHZT032', '', 137, 8.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4277, 'MXHZT033', '', 137, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4278, 'MXHZT034', '', 137, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4279, 'MXHZT035', '', 137, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4280, 'MXHZT036', '', 137, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4281, 'MXHZT037', '', 137, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4282, 'MXHZT038', '', 139, 6.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4283, 'MXHZT039', '', 139, 8.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4284, 'MXHZT040', '', 139, 11.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4285, 'MXHZT041', '', 139, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4286, 'MXHZT042', '', 139, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4287, 'MXHZT043', '', 139, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4288, 'MXHZT044', '', 139, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4289, 'MXHZT045', '', 139, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4290, 'MXHZT046', '', 133, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4291, 'MXHZT047', '', 133, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4292, 'MXHZT048', '', 133, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4293, 'MXHZT049', '', 133, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4294, 'MXHZT050', '', 133, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4295, 'MXHZT051', '', 133, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4296, 'MXHZT052', '', 133, 60.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4297, 'MXHZT053', '', 133, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4298, 'MXHZT054', '', 97, 6.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4299, 'MXHZT055', '', 97, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4300, 'MXHZT056', '', 97, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4301, 'MXHZT057', '', 97, 24.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4302, 'MXHZT058', '', 97, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4303, 'MXHZT059', '', 97, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4304, 'MXHZT060', '', 97, 48.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4305, 'MXHZT061', '', 64, 34.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4306, 'MXHZT062', '', 64, 42.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4307, 'MXHZT063', '', 64, 37.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4308, 'MXHZT064', '', 64, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4309, 'MXHZT065', '', 139, 47.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4310, 'MXLZ001', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4311, 'MXLZ002', '', 62, 22.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4312, 'MXLZ003', '', 138, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4313, 'MXLZ004', '', 138, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4314, 'MXLZ005', '', 138, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4315, 'MXLZ006', '', 62, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4316, 'MXLZ007', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4317, 'MXLZ008', '', 64, 22.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4318, 'MXLZ009', '', 62, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4319, 'MXLZ010', '', 62, 22.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4320, 'MXLZ011', '', 62, 13.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4321, 'MXLZ012', '', 77, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4322, 'MXLZ013', '', 62, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4323, 'MXLZ014', '', 137, 4.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4324, 'MXLZ015', '', 62, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4325, 'MXLZ016', '', 139, 9.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4326, 'MXLZ017', '', 62, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4327, 'MXLZ018', '', 64, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4328, 'MXLZ019', '', 137, 4.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4329, 'MXLZ020', '', 77, 34.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4330, 'MXLZ021', '', 64, 52.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4331, 'MXLZ022', '', 67, 8.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4332, 'MXLZ023', '', 139, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4333, 'MXLZ024', '', 139, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4334, 'MXLZ025', '', 62, 14.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4335, 'MXQHZ001', '', 144, 56.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4336, 'MXQHZ002', '', 144, 90.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4337, 'MXQHZ003', '', 144, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4338, 'MXQHZ004', '', 138, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4339, 'MXQHZ005', '', 64, 71.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4340, 'MXQHZ006', '', 64, 23.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4341, 'MXQHZ007', '', 64, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4342, 'MXQHZ008', '', 112, 24.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4343, 'MXQHZ009', '', 138, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4344, 'MXQHZ010', '', 62, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4345, 'MXQHZ011', '', 138, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4346, 'MXQHZ012', '', 62, 115.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4347, 'MXQHZ013', '', 64, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4348, 'MXQHZ014', '', 62, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4349, 'MXQHZ015', '', 64, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4350, 'MXQHZ016', '', 64, 55.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4351, 'MXQHZ017', '', 64, 55.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4352, 'MXQHZ018', '', 64, 90.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4353, 'MXQHZ019', '', 72, 22.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4354, 'MXQHZ020', '', 62, 28.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4355, 'MXQHZ021', '', 137, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4356, 'MXQHZ022', '', 64, 11.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4357, 'MXQHZ023', '', 62, 54.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4358, 'MXQHZ024', '', 62, 115.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4359, 'MXQHZ025', '', 62, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4360, 'MXQHZ026', '', 92, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4361, 'MXQHZ027', '', 92, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4362, 'MXQHZ028', '', 92, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4363, 'MXQHZ029', '', 92, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4364, 'MXQHZ030', '', 64, 53.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4365, 'MXQHZ031', '', 64, 58.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4366, 'MXQHZ032', '', 64, 65.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4367, 'MXQHZ033', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4368, 'MXQHZ034', '', 138, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4369, 'MXQHZ035', '', 64, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4370, 'MXQHZ036', '', 67, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4371, 'MXQHZ037', '', 67, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4372, 'MXQHZ038', '', 67, 43.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4373, 'MXQHZ039', '', 67, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4374, 'MXQHZ040', '', 67, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4375, 'MXQHZ041', '', 67, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4376, 'MXQHZ042', '', 67, 70.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4377, 'MXQHZ043', '', 67, 80.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4378, 'MXQHZ044', '', 67, 60.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4379, 'MXQHZ045', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4380, 'MXQHZ046', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4381, 'MXQHZ047', '', 113, 23.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4382, 'MXQHZ048', '', 72, 33.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4383, 'MXQHZ049', '', 67, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4384, 'MXQHZ050', '', 62, 22.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4385, 'MXQHZ051', '', 139, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4386, 'MXQHZ052', '', 64, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4387, 'MXQHZ053', '', 62, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4388, 'MXQHZ054', '', 64, 6.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4389, 'MXQHZ055', '', 139, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4390, 'MXQHZ056', '', 88, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4391, 'MXQHZ057', '', 65, 7.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4392, 'MXQHZ058', '', 137, 7.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4393, 'MXQHZ059', '', 139, 16.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4394, 'MXQHZ060', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4395, 'MXQHZ061', '', 93, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4396, 'MXQHZ062', '', 93, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4397, 'MXQHZ063', '', 93, 52.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4398, 'MXQHZ064', '', 93, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4399, 'MXQHZ065', '', 139, 26.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4400, 'MXQHZ066', '', 139, 26.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4401, 'MXQHZ067', '', 139, 75.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4402, 'MXQHZ068', '', 62, 70.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4403, 'MXQHZ069', '', 62, 70.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4404, 'MXQHZ070', '', 62, 120.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4405, 'MXQHZ071', '', 64, 68.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4406, 'MXQHZ072', '', 137, 14.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4407, 'MXQHZ073', '', 64, 90.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4408, 'MXQHZ074', '', 77, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4409, 'MXQHZ075', '', 137, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4410, 'MXQHZ076', '', 62, 80.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4411, 'MXQHZ077', '', 62, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4412, 'MXQHZ078', '', 67, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4413, 'MXQHZ079', '', 92, 28.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4414, 'MXQHZ080', '', 92, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4415, 'MXQHZ081', '', 139, 70.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4416, 'MXQS001', '', 138, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4417, 'MXQS002', '', 62, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4418, 'MXQS003', '', 137, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4419, 'MXQS004', '', 62, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4420, 'MXQS005', '', 74, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4421, 'MXQS006', '', 137, 31.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4422, 'MXQS007', '', 137, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4423, 'MXQS008', '', 137, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4424, 'MXQS009', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4425, 'MXQS010', '', 62, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4426, 'MXQS011', '', 64, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4427, 'MXQS012', '', 138, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4428, 'MXQS013', '', 138, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4429, 'MXQS014', '', 138, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4430, 'MXQS015', '', 138, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4431, 'MXQS016', '', 138, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4432, 'MXQS017', '', 63, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4433, 'MXQS018', '', 64, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4434, 'MXQS019', '', 62, 32.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4435, 'MXQS020', '', 62, 44.3000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4436, 'MXQS021', '', 137, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4437, 'MXQS022', '', 63, 65.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4438, 'MXQS023', '', 72, 75.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4439, 'MXQS024', '', 64, 68.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4440, 'MXQS025', '', 72, 85.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4441, 'MXQS026', '', 137, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4442, 'MXQS027', '', 62, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4443, 'MXQS028', '', 137, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4444, 'MXQS029', '', 64, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4445, 'MXQS030', '', 62, 65.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4446, 'MXQS031', '', 62, 68.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4447, 'MXQS032', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4448, 'MXQS033', '', 64, 42.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4449, 'MXQS034', '', 139, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4450, 'MXQS035', '', 64, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4451, 'MXQS036', '', 62, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4452, 'MXQS037', '', 62, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4453, 'MXQS038', '', 62, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4454, 'MXQS039', '', 63, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4455, 'MXQS040', '', 64, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4456, 'MXQS041', '', 67, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4457, 'MXQS042', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4458, 'MXQS043', '', 77, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4459, 'MXQS044', '', 92, 9.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4460, 'MXQS045', '', 62, 22.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4461, 'MXQS046', '', 139, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4462, 'MXQS047', '', 137, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4463, 'MXQS048', '', 62, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4464, 'MXQS049', '', 64, 6.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4465, 'MXQS050', '', 139, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4466, 'MXQS051', '', 73, 14.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4467, 'MXQS052', '', 65, 14.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4468, 'MXQS053', '', 139, 6.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4469, 'MXQS054', '', 139, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4470, 'MXQS055', '', 63, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4471, 'MXQS056', '', 139, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4472, 'MXQS057', '', 62, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4473, 'MXQS058', '', 62, 24.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4474, 'MXQS059', '', 137, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4475, 'MXQS060', '', 65, 14.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4476, 'MXQS061', '', 62, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4477, 'MXQS062', '', 137, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4478, 'MXQS063', '', 139, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4479, 'MXQS064', '', 62, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4480, 'MXQS065', '', 138, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4481, 'MXQS066', '', 62, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4482, 'MXQS067', '', 62, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4483, 'MXQS068', '', 64, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4484, 'MXQS069', '', 139, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4485, 'MXQS070', '', 139, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4486, 'MXQS071', '', 62, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4487, 'MXQS072', '', 74, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4488, 'MXQS073', '', 137, 16.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4489, 'MXQS074', '', 64, 16.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4490, 'MXQS075', '', 62, 17.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4491, 'MXQS076', '', 62, 13.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4492, 'MXQS077', '', 62, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4493, 'MXQS078', '', 137, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4494, 'MXQS079', '', 62, 8.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4495, 'MXQS080', '', 63, 8.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4496, 'MXQS081', '', 140, 11.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4497, 'MXQS082', '', 140, 3.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4498, 'MXQS083', '', 137, 4.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4499, 'MXQS084', '', 64, 8.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4500, 'MXQS085', '', 142, 8.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4501, 'MXQS086', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4502, 'MXQS087', '', 64, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4503, 'MXQS088', '', 137, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4504, 'MXQS089', '', 72, 14.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4505, 'MXQS090', '', 137, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4506, 'MXQS091', '', 64, 8.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4507, 'MXQS092', '', 62, 58.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4508, 'MXQS093', '', 64, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4509, 'MXQS094', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4510, 'MXQS095', '', 77, 46.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4511, 'MXQS096', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4512, 'MXQS097', '', 138, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4513, 'MXQS098', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4514, 'MXQS099', '', 63, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4515, 'MXQS100', '', 62, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4516, 'MXQS101', '', 92, 9.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4517, 'MXQS102', '', 64, 62.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4518, 'MXQS103', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4519, 'MXQS104', '', 137, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4520, 'MXQS105', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4521, 'MXQS106', '', 139, 124.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4522, 'MXQS107', '', 137, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4523, 'MXQS108', '', 62, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4524, 'MXQS109', '', 139, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4525, 'MXQS110', '', 139, 105.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4526, 'MXQS111', '', 139, 85.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4527, 'MXQS112', '', 64, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4528, 'MXQS113', '', 64, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4529, 'MXQS114', '', 72, 27.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4530, 'MXQS115', '', 62, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4531, 'MXQS116', '', 64, 22.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4532, 'MXQS117', '', 62, 95.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4533, 'MXQS118', '', 62, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4534, 'MXQS119', '', 62, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4535, 'MXQS120', '', 63, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4536, 'MXQS121', '', 64, 140.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4537, 'MXQS122', '', 67, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4538, 'MXQS123', '', 62, 80.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4539, 'MXQS124', '', 62, 19.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4540, 'MXQS125', '', 62, 214.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4541, 'MXQS126', '', 137, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4542, 'MXQS127', '', 64, 62.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4543, 'MXQS128', '', 139, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4544, 'MXQS129', '', 72, 109.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4545, 'MXQS130', '', 139, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4546, 'MXQS131', '', 62, 90.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4547, 'MXQS132', '', 139, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4548, 'MXQS133', '', 62, 42.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4549, 'MXQS134', '', 77, 158.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4550, 'MXQS135', '', 141, 44.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4551, 'MXQS136', '', 62, 60.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4552, 'MXQS137', '', 137, 8.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4553, 'MXQS138', '', 137, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4554, 'MXQS139', '', 137, 42.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4555, 'MXQS140', '', 72, 42.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4556, 'MXQS141', '', 62, 42.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4557, 'MXQS142', '', 64, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4558, 'MXQS143', '', 64, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4559, 'MXQS144', '', 64, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4560, 'MXQS145', '', 139, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4561, 'MXQS146', '', 139, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4562, 'MXQS147', '', 139, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4563, 'MXQS148', '', 64, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4564, 'MXQS149', '', 62, 90.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4565, 'MXQS150', '', 74, 38.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4566, 'MXQS151', '', 74, 42.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4567, 'MXQS152', '', 137, 31.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4568, 'MXQS153', '', 64, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4569, 'MXQS154', '', 139, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4570, 'MXQS155', '', 139, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4571, 'MXQS156', '', 62, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4572, 'MXQS157', '', 137, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4573, 'MXQS158', '', 64, 60.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4574, 'MXQS159', '', 62, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4575, 'MXQS160', '', 62, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4576, 'MXQS161', '', 62, 17.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4577, 'MXQS162', '', 62, 123.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4578, 'MXQS163', '', 65, 27.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4579, 'MXQS164', '', 65, 27.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4580, 'MXQS165', '', 138, 55.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4581, 'MXQS166', '', 62, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4582, 'MXQS167', '', 63, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4583, 'MXQS168', '', 77, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4584, 'MXQS169', '', 77, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4585, 'MXQS170', '', 77, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4586, 'MXQS171', '', 77, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4587, 'MXQS172', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4588, 'MXQS173', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4589, 'MXQS174', '', 77, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4590, 'MXQS175', '', 62, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4591, 'MXQS176', '', 77, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4592, 'MXQS177', '', 67, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4593, 'MXQS178', '', 77, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4594, 'MXQS179', '', 139, 8.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4595, 'MXQS180', '', 64, 11.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4596, 'MXQS181', '', 110, 8.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4597, 'MXQS182', '', 64, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4598, 'MXQS183', '', 67, 92.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4599, 'MXQS184', '', 64, 65.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4600, 'MXQS185', '', 92, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4601, 'MXQS186', '', 92, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4602, 'MXQS187', '', 64, 65.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4603, 'MXQS188', '', 92, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4604, 'MXQS189', '', 94, 68.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4605, 'MXQS190', '', 110, 31.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4606, 'MXQS191', '', 139, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4607, 'MXQS192', '', 139, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4608, 'MXQS193', '', 139, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4609, 'MXQS194', '', 139, 28.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4610, 'MXQS195', '', 139, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4611, 'MXQS196', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4612, 'MXQS197', '', 139, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4613, 'MXQSZ001', '', 67, 100.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4614, 'MXQSZ002', '', 67, 120.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4615, 'MXQSZ003', '', 67, 120.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4616, 'MXQSZ004', '', 67, 120.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4617, 'MXQSZ005', '', 62, 102.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4618, 'MXQSZ006', '', 62, 102.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '四星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4619, 'MXQSZ007', '', 137, 24.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4620, 'MXQSZ008', '', 143, 39.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4621, 'MXQSZ009', '', 64, 23.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4622, 'MXQSZ010', '', 64, 128.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4623, 'MXQSZ011', '', 64, 128.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4624, 'MXQSZ012', '', 67, 26.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4625, 'MXQSZ013', '', 139, 70.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4626, 'MXQSZ014', '', 111, 44.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4627, 'MXQSZ015', '', 67, 55.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4628, 'MXQSZ016', '', 92, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4629, 'MXQSZ017', '', 139, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4630, 'MXQSZ018', '', 139, 49.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4631, 'MXQSZ019', '', 62, 17.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4632, 'MXQSZ020', '', 62, 31.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4633, 'MXQSZ021', '', 62, 62.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4634, 'MXQSZ022', '', 64, 24.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4635, 'MXQSZ023', '', 64, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4636, 'MXQSZ024', '', 139, 65.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4637, 'MXQSZ025', '', 139, 65.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4638, 'MXQSZ026', '', 67, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4639, 'MXQSZ027', '', 138, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4640, 'MXQSZ028', '', 62, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4641, 'MXXZ001', '', 107, 17.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4642, 'MXXZ002', '', 139, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4643, 'MXXZ003', '', 62, 38.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4644, 'MXXZ004', '', 138, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4645, 'MXXZ005', '', 62, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4646, 'MXXZ006', '', 139, 6.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4647, 'MXXZ007', '', 62, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4648, 'MXXZ008', '', 62, 42.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4649, 'MXXZ009', '', 64, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4650, 'MXXZ010', '', 64, 38.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4651, 'MXXZ011', '', 62, 70.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4652, 'MXXZ012', '', 64, 16.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4653, 'MXXZ013', '', 62, 186.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4654, 'MXXZ014', '', 64, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4655, 'MXXZ015', '', 137, 22.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4656, 'MXXZ016', '', 62, 70.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4657, 'MXXZ017', '', 138, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4658, 'MXXZ018', '', 62, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4659, 'MXXZ019', '', 138, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4660, 'MXXZ020', '', 138, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4661, 'MXXZ021', '', 138, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4662, 'MXXZ022', '', 138, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4663, 'MXXZ023', '', 138, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4664, 'MXXZ024', '', 138, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4665, 'MXXZ025', '', 62, 28.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4666, 'MXXZ026', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4667, 'MXXZ027', '', 64, 49.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4668, 'MXXZ028', '', 64, 46.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4669, 'MXXZ029', '', 64, 49.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4670, 'MXXZ030', '', 62, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4671, 'MXXZ031', '', 139, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4672, 'MXXZ032', '', 64, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4673, 'MXXZ033', '', 62, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4674, 'MXXZ034', '', 139, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4675, 'MXXZ035', '', 139, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4676, 'MXXZ036', '', 73, 14.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4677, 'MXXZ037', '', 73, 28.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4678, 'MXXZ038', '', 65, 14.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4679, 'MXXZ039', '', 65, 28.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4680, 'MXXZ040', '', 137, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4681, 'MXXZ041', '', 137, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4682, 'MXXZ042', '', 62, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4683, 'MXXZ043', '', 138, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4684, 'MXXZ044', '', 137, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4685, 'MXXZ045', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4686, 'MXXZ046', '', 139, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4687, 'MXXZ047', '', 139, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4688, 'MXXZ048', '', 139, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4689, 'MXXZ049', '', 139, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4690, 'MXXZ050', '', 73, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4691, 'MXXZ051', '', 100, 17.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4692, 'MXXZ052', '', 100, 26.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4693, 'MXXZ053', '', 100, 34.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4694, 'MXXZ054', '', 73, 58.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4695, 'MXXZ055', '', 73, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4696, 'MXXZ056', '', 73, 48.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4697, 'MXXZ057', '', 65, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4698, 'MXXZ058', '', 65, 48.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4699, 'MXXZ059', '', 137, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4700, 'MXXZ060', '', 137, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4701, 'MXXZ061', '', 62, 24.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4702, 'MXXZ062', '', 64, 16.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4703, 'MXXZ063', '', 72, 24.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4704, 'MXXZ064', '', 62, 52.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4705, 'MXXZ065', '', 62, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4706, 'MXXZ066', '', 108, 51.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4707, 'MXXZ067', '', 64, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4708, 'MXXZ068', '', 137, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4709, 'MXXZ069', '', 137, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4710, 'MXXZ070', '', 137, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4711, 'MXXZ071', '', 137, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4712, 'MXXZ072', '', 66, 13.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4713, 'MXXZ073', '', 66, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4714, 'MXXZ074', '', 66, 38.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4715, 'MXXZ075', '', 66, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4716, 'MXXZ076', '', 62, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4717, 'MXXZ077', '', 64, 28.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4718, 'MXXZ078', '', 62, 68.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4719, 'MXXZ079', '', 62, 51.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4720, 'MXXZ080', '', 64, 23.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4721, 'MXXZ081', '', 139, 7.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4722, 'MXXZ082', '', 72, 24.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4723, 'MXXZ083', '', 62, 60.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4724, 'MXXZ084', '', 137, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4725, 'MXXZ085', '', 92, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4726, 'MXXZ086', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4727, 'MXXZ087', '', 64, 36.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4728, 'MXXZZ001', '', 96, 230.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '五星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4729, 'MXXZZ002', '', 137, 70.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4730, 'MXXZZ003', '', 64, 34.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4731, 'MXXZZ004', '', 138, 60.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4732, 'MXXZZ005', '', 138, 90.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4733, 'MXXZZ006', '', 137, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4734, 'MXXZZ007', '', 62, 37.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4735, 'MXXZZ008', '', 64, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4736, 'MXXZZ009', '', 64, 60.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4737, 'MXXZZ010', '', 62, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4738, 'MXXZZ011', '', 103, 90.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4739, 'MXXZZ012', '', 103, 115.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4740, 'MXXZZ013', '', 146, 60.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4741, 'MXXZZ014', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4742, 'MXXZZ015', '', 64, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4743, 'MXXZZ016', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4744, 'MXXZZ017', '', 72, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4745, 'MXXZZ018', '', 103, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4746, 'MXXZZ019', '', 103, 66.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4747, 'MXXZZ020', '', 103, 56.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4748, 'MXXZZ021', '', 62, 84.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4749, 'MXXZZ022', '', 95, 62.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4750, 'MXXZZ023', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4751, 'MXXZZ024', '', 72, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4752, 'MXXZZ025', '', 139, 63.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4753, 'MXXZZ026', '', 139, 220.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4754, 'MXXZZ027', '', 72, 130.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4755, 'MXXZZ028', '', 72, 145.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4756, 'MXXZZ029', '', 139, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4757, 'MXXZZ030', '', 72, 145.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4758, 'MXXZZ031', '', 72, 160.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4759, 'MXXZZ032', '', 139, 55.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4760, 'MXXZZ033', '', 72, 170.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4761, 'MXXZZ034', '', 72, 185.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4762, 'MXXZZ035', '', 139, 60.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4763, 'MXXZZ036', '', 137, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4764, 'MXXZZ037', '', 137, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4765, 'MXXZZ038', '', 137, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4766, 'MXXZZ039', '', 137, 60.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4767, 'MXXZZ040', '', 137, 75.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4768, 'MXXZZ041', '', 139, 350.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4769, 'MXXZZ042', '', 139, 400.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4770, 'MXXZZ043', '', 139, 350.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4771, 'MXXZZ044', '', 139, 100.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4772, 'MXXZZ045', '', 139, 90.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4773, 'MXXZZ046', '', 139, 75.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4774, 'MXXZZ047', '', 139, 14.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4775, 'MXXZZ048', '', 139, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4776, 'MXXZZ049', '', 139, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4777, 'MXXZZ050', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4778, 'MXXZZ051', '', 137, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4779, 'MXXZZ052', '', 138, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4780, 'MXXZZ053', '', 139, 60.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4781, 'QD001', '驳接领仔、分缝（弧/30）2条*2', 156, 76.5200, 0.2678, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4782, 'QD002', '车袋贴（直/20）1条*2', 156, 35.6800, 0.0847, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4783, 'QD003', '车袋支线（直/20）1条*2', 156, 44.1100, 0.1048, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4784, 'QD004', '落袋支线（直/20）1条*2', 156, 39.6300, 0.0991, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4785, 'QD005', '落袋贴（直/20）1条*2', 156, 30.6400, 0.0996, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4786, 'QD006', '（剪三角2次+翻袋支线、袋贴）*2', 161, 35.7400, 0.0893, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4787, 'QD007', '翻袋支线、袋贴*2', 161, 18.0000, 0.0405, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4788, 'QD008', '压袋口线（直/20）*2', 156, 35.6500, 0.0847, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4789, 'QD009', '封三角（直/2）*4', 156, 45.7100, 0.1086, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4790, 'QD010', '压袋口线三边（直1.2+直18+直1.2）1条*2', 156, 46.2900, 0.1099, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4791, 'QD011', '封袋布（弧70）1条*2', 156, 50.4000, 0.1197, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4792, 'WGHZ001', '', 139, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4793, 'WGHZ002', '', 66, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4794, 'WGHZ003', '', 139, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4795, 'WGHZ004', '', 66, 65.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4796, 'WGHZ005', '', 139, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4797, 'WGHZ006', '', 66, 75.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4798, 'WGHZ007', '', 139, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4799, 'WGHZ008', '', 66, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4800, 'WGHZ009', '', 139, 3.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4801, 'WGHZ010', '', 66, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4802, 'WGML001', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4803, 'WGML002', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4804, 'WGML003', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4805, 'WGML004', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4806, 'WGML005', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4807, 'WGML006', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4808, 'WGML007', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4809, 'WGML008', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4810, 'WGML009', '', 62, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4811, 'WGML010', '', 64, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4812, 'WGML011', '', 137, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4813, 'WGML012', '', 74, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4814, 'WGML013', '', 137, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4815, 'WGML014', '', 137, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4816, 'WGML015', '', 64, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4817, 'WGML016', '', 138, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4818, 'WGML017', '', 137, 3.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4819, 'WGML018', '', 62, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4820, 'WGML019', '', 62, 5.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4821, 'WGML020', '', 62, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4822, 'WGML021', '', 62, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4823, 'WGML022', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4824, 'WGML023', '', 62, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4825, 'WGML024', '', 65, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4826, 'WGML025', '', 92, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4827, 'WGML026', '', 77, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4828, 'WGML027', '', 137, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4829, 'WGML028', '', 62, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4830, 'WGML029', '', 64, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4831, 'WGML030', '', 62, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4832, 'WGML031', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4833, 'WGML032', '', 64, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4834, 'WGML033', '', 64, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4835, 'WGML034', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4836, 'WGML035', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4837, 'WGML036', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4838, 'WGML037', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4839, 'WGML038', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4840, 'WGML039', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4841, 'WGML040', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4842, 'WGML041', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4843, 'WGML042', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4844, 'WGML043', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4845, 'WGML044', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4846, 'WGML045', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4847, 'WGML046', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4848, 'WGML047', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4849, 'WGML048', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4850, 'WGML049', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4851, 'WGML050', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4852, 'WGML051', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4853, 'WGML052', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4854, 'WGML053', '', 64, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4855, 'WGML054', '', 62, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4856, 'WGML055', '', 62, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4857, 'WGML056', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4858, 'WGML057', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4859, 'WGML058', '', 62, 18.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4860, 'WGML059', '', 62, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4861, 'WGML060', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4862, 'WGML061', '', 64, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4863, 'WGML062', '', 64, 12.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4864, 'WGML063', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4865, 'WGML064', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4866, 'WGML065', '', 62, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4867, 'WGML066', '', 64, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4868, 'WGML067', '', 62, 25.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4869, 'WGML068', '', 62, 45.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4870, 'WGML069', '', 62, 35.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4871, 'WGML070', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4872, 'WGML071', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4873, 'WGML072', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4874, 'WGML073', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4875, 'WGML074', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4876, 'WGML075', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4877, 'WGML076', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4878, 'WGML077', '', 62, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4879, 'WGML078', '', 64, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4880, 'WGML079', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4881, 'WGML080', '', 64, 15.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4882, 'WGML081', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4883, 'WGML082', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4884, 'WGML083', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4885, 'WGML084', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4886, 'WGML085', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4887, 'WGML086', '', 64, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4888, 'WGML087', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4889, 'WGML088', '', 64, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4890, 'WGML089', '', 62, 90.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4891, 'WGML090', '', 62, 80.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4892, 'WGML091', '', 137, 10.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4893, 'WGML092', '', 64, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4894, 'WGML093', '', 62, 80.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4895, 'WGML094', '', 62, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4896, 'WGML095', '', 62, 50.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4897, 'WGML096', '', 138, 100.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4898, 'WGML097', '', 138, 30.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4899, 'WGML098', '', 138, 60.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '二星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4900, 'WGML099', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4901, 'WGML100', '', 62, 40.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4902, 'WGML101', '', 62, 20.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', '一星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4903, 'XFSZNXFQP003', '驳接领仔、分缝（弧/30）2条*2', 156, 76.5200, 0.2678, 'STITCHING', NULL, b'1', '驳接领仔、分缝（弧/30）2条*2驳接领仔、分缝（弧/30）2条*2驳接领仔、分缝（弧/30）2条*2驳接领仔、分缝（弧/30）2条*2驳接领仔、分缝（弧/30）2条*2驳接领仔、分缝（弧/30）2条*2', '驳接领仔、分缝（弧/30）2条*2驳接领仔、分缝（弧/30）2条*2驳接领仔、分缝（弧/30）2条*2驳接领仔、分缝（弧/30）2条*2驳接领仔、分缝（弧/30）2条*2驳接领仔、分缝（弧/30）2条*2', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4904, 'XFSZNXFQP004', '车袋贴（直/20）1条*2', 156, 35.6800, 0.0847, 'STITCHING', NULL, b'1', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4905, 'XFSZNXFQP005', '车袋支线（直/20）1条*2', 156, 44.1100, 0.1048, 'STITCHING', NULL, b'1', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4906, 'XFSZNXFQP006', '落袋支线（直/20）1条*2', 156, 39.6300, 0.0991, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4907, 'XFSZNXFQP007', '落袋贴（直/20）1条*2', 156, 30.6400, 0.0996, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4908, 'XFSZNXFQP008', '驳接领仔、分缝（弧/30）2条*2', 156, 76.5200, 0.2678, 'STITCHING', NULL, b'1', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4909, 'XFSZNXFQP009', '运领沿（直10+弧5+直50+弧5+直10）1条*1', 156, 50.3700, 0.1196, 'STITCHING', NULL, b'1', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4910, 'XFSZNXFQP010', '封领（直/6）1条*2', 156, 25.6800, 0.0610, 'STITCHING', NULL, b'1', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4911, 'XFSZNXFQP011', '驳接领仔、分缝（弧/30）2条*2', 156, 76.5200, 0.2678, 'STITCHING', NULL, b'1', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4912, 'XFSZNXFQP012', '车袋贴（直/20）1条*2', 156, 35.6800, 0.0847, 'STITCHING', NULL, b'1', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4913, 'XFSZNXFQP013', '车袋支线（直/20）1条*2', 156, 44.1100, 0.1048, 'STITCHING', NULL, b'1', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4914, 'XFSZNXFQP014', '落袋支线（直/20）1条*2', 156, 39.6300, 0.0991, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4915, 'XFSZNXFQP015', '落袋贴（直/20）1条*2', 156, 30.6400, 0.0996, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4916, 'XZ001', '缝袖侧缝（直/60）*2', 156, 45.5800, 0.1083, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4917, 'XZ002', '压袖侧缝（直/60）*2', 156, 41.3600, 0.0982, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4918, 'ZYSZBXDZ001', '折衣服', 15, 38.0200, 0.0950, 'STITCHING', NULL, b'0', '不可变形#line#不可露针#line#不可起皱#line#不可外露毛边#line#', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4919, 'ZYSZCYDZ001', '拉筒环口辑袋口3CM边线1个*1同时落衬条（直/15CM）1个*1(每扎15件)', 155, 11.6500, 0.0291, 'STITCHING', NULL, b'0', '平服,线迹均匀,宽窄一致,衬条均匀外露0.3CM', '袋布反面朝上袋口三折边放入拉筒车缝,同时吊落衬条,衬条均匀外露0.3CM,内折止口0.6CM,两端顺形剪齐衬条,完成后宽3CM', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4920, 'ZYSZCYDZ002', '袋布两侧落衬条1个*1(直/10CM)', 156, 10.9700, 0.0274, 'STITCHING', NULL, b'0', '平服,衬条不可外露', '衬条在下,袋布反面两侧袋口向下1CM距边0.1CM稀针(3针/CM)车0.5CM宽衬条,下端不车', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4921, 'ZYSZCYDZ003', '专机扣烫袋布1个*1（圆角,放拷贝纸,单头机）', 30, 9.7600, 0.0244, 'STITCHING', NULL, b'0', '止口一致,圆角圆顺,不可有烫痕', '扣烫之前需在正面垫一层拷贝纸,袋口平齐模具,再居中放袋布,温度适度', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4922, 'ZYSZCYHD001', '明钉后担干主标一周1个*1(5+1.5+5+1.5CM)', 156, 27.8000, 0.0903, 'STITCHING', NULL, b'0', '平服,不可歪斜,转角要直,线迹距边0.1CM均匀,唛两端内折止口不可外露,唛头方向不可错误', '先将后担干里按车台标记放好,再取唛从左边(穿计)依次距边0.1CM均匀车缝一周,首尾不可回针，首尾重线1CM即可,面线与唛颜色相同,底线与担干颜色相同,剪净线头', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4923, 'ZYSZCYHD002', '明钉后担干辅标一周1个*1(4.5+1+4.5+1CM)', 156, 26.3000, 0.0855, 'STITCHING', NULL, b'1', '平服,不可歪斜,转角要直,线迹距边0.1CM均匀,唛两端内折止口不可外露,唛头方向不可错误', '先将后担干里按车台标记放好,再取唛从左边(穿计)依次距边0.1CM均匀车缝一周,首尾不可回针，首尾重线1CM即可,面线与唛颜色相同,底线与担干颜色相同,剪净线头', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4924, 'ZYSZCYHD003', '扣烫后担干面肩位衬条2边*1(先烫衬条，再折烫止口)', 19, 22.8000, 0.0541, 'STITCHING', NULL, b'0', '平服,衬条牢固,内折止口一致,不可有烫痕', '衬条烫在后担干面肩位的反面,均匀距边0.1CM处,担干肩位止口均匀内折1CM,温度适度', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4925, 'ZYSZCYHP001', '打后片后背位活褶2个*1(直/3CM)', 156, 14.5000, 0.0362, 'STITCHING', NULL, b'0', '褶位正顺,两褶左右对称,褶倒向不可错误', '按刀口打活褶,褶倒向袖围,褶宽1.3CM,止口0.8CM即可', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4926, 'ZYSZCYHP002', '合后担干缝1条*1同时放衬条1条*1(直/50CM，三层)', 156, 27.8000, 0.0903, 'STITCHING', NULL, b'0', '出入口齐,止口一致,褶位正顺,两褶左右对称,打活褶线不可外露,主唛需与担干缝平行', '出入口齐,止口一致,担干里在下,后片在中间,担干面在上,三层均匀1CM止口同时车缝,按刀口对齐活褶位,衬条位于担干面距边0.1CM处', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4927, 'ZYSZCYHP003', '辑后担干缝明线1条*1(直/50CM)', 156, 15.9000, 0.0517, 'STITCHING', NULL, b'0', '平服,止口一致,褶位正顺,线迹均匀', '打开担干里,辑明线不车在担干里上,止口倒向担干,沿担干面均匀辑0.1CM明线', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4928, 'ZYSZCYHP004', '整烫后担干1片*1及修剪1片*1', 19, 11.7000, 0.0278, 'STITCHING', NULL, b'0', '平服,不可有烫痕', '摆平后片,后片里朝上,烫死后担里合缝位,温度适度，修剪肩缝多余的止口。', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4929, 'ZYSZCYHP005', '压烫后担干1片*1(两台压烫机同时交替操作)', 19, 10.2000, 0.0242, 'STITCHING', NULL, b'0', '平服,不可有烫痕,衬条牢固', '摆平后片,后片面朝上,压烫整个担干位,温度适度', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4930, 'ZYSZCYHP006', '缝后复司（直/50cm)1条*1', 156, 32.9900, 0.1072, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4931, 'ZYSZCYHP007', '整烫后复司1条*1', 19, 10.7700, 0.0256, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4932, 'ZYSZCYHP008', '画连修改后复司1件*1', 15, 19.4100, 0.0485, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4933, 'ZYSZCYHP009', '缝刀背缝（弯54+54cm)2条*1', 156, 46.3900, 0.1508, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4934, 'ZYSZCYHP010', '缝刀背缝三线锁边（弯/54+54cm)', 171, 27.0000, 0.0641, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4935, 'ZYSZCYLZ001', '车上领暗线1条*1(尖角,净色,直/9+47+9CM)', 156, 27.0000, 0.0641, 'STITCHING', NULL, b'0', '平服,出入口齐,转角要正顺,领尖左右对称', '出入口齐,领里在下,领面在上,沿领面上粘好的衬边均匀顺形车缝(领衬为实样)三方,首尾回针', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4936, 'ZYSZCYLZ002', '切上级领止口1条*1(尖角,直/9+47+9CM)', 167, 9.3700, 0.0234, 'STITCHING', NULL, b'0', '止口一致,保留0.6CM止口', '以运领线为准保留0.6CM止口,均匀顺形切去三方多余的止口', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4937, 'ZYSZCYLZ003', '打上级领刀口6个*1(15条领子一扎)', 15, 6.3600, 0.0151, 'STITCHING', NULL, b'0', '剪口不可太深或太浅,不可直打剪口,要斜打剪口,剪口距运领线0.2CM', '领上沿两边距领尖有弧度处等距斜打剪口3个*2,剪口距运领线0.2CM处即可', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4938, 'ZYSZCYLZ004', '专机修翻上级领2个*1连修剪领角2个*1(单头机)', 27, 9.8000, 0.0233, 'STITCHING', NULL, b'0', '不可爆口,领尖要尖,左右对称', '先将领尖套入翻领机切去领尖位多余的止口,再将领尖翻到正面,用力适度,完全将领尖翻出为止', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4939, 'ZYSZCYLZ005', '专机烫定上级领尖2个*1(双头机)', 19, 8.5800, 0.0204, 'STITCHING', NULL, b'0', '不可爆口,领尖要尖,左右对称,不可反止口,不可有烫痕', '先将领尖套入模具且调整平整,用力适度,再送入上方压烫定型,温度适度', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4940, 'ZYSZCYLZ006', '整烫上级领1条*1', 19, 14.0100, 0.0333, 'STITCHING', NULL, b'0', '平服,不可反止口,不可有烫痕', '先打开领子,在领反面烫倒(止口往任意一边倒)领上沿中间未压烫的部分,再到正面烫定领上沿中间未压烫的部分,温度适度', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4941, 'ZYSZCYLZ007', '辑上级领边线1条*1同时放领角片2个*1(尖角,直/9+47+9CM,已烫沿)', 156, 25.2200, 0.0883, 'STITCHING', NULL, b'0', '平服,止口一致,线迹均匀,不可反止口及夹止口,领角片要牢固且居中', '沿领三方辑0.6CM明线,两边领角处居中放领角片且车住领角片', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4942, 'ZYSZCYLZ008', '专机切上级领脚止口1条*1(对折领后切)', 34, 5.3900, 0.0128, 'STITCHING', NULL, b'0', '对折领后左右对称,与实样一致', '对折领沿领脚放入切领机内切去多余的止口', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4943, 'ZYSZCYLZ009', '走封上级领脚1条*1(直/36CM)', 156, 7.6100, 0.0190, 'STITCHING', NULL, b'0', '平服,上级领面稍大于领里,使其有自然反翘效果', '将领反面朝上,向上横向内折领子,沿领脚0.4CM止口稀针(2针/CM)走线封领脚', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4944, 'ZYSZCYLZ010', '折辑下级领面脚边线1条*1(直/47CM)', 156, 11.4200, 0.0371, 'STITCHING', NULL, b'0', '平服,止口一致,线迹均匀,两边对称', '反面在上,下级领面脚位向上折0.8CM止口沿衬边均匀顺形车缝0.6CM边线', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4945, 'ZYSZCYLZ011', '辑转下级领1条*1连落上级领1条*1(圆角,弯/4+直/40+弯/4CM,先固定下级领里,再辑转)', 156, 35.6000, 0.1335, 'STITCHING', NULL, b'0', '平服,止口一致,圆咀处圆顺,左右对称,固定上级领线不可外露', '先将上级领按刀口固定在下级领里上,再上级领面在上,下级领里脚位预留1CM止口,按刀口顺形1CM止口车缝,圆领咀处用纸板车缝,首尾回针', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4946, 'ZYSZCYLZ012', '切下级领上沿上口1条*1(直/40CM)', 167, 6.1200, 0.0153, 'STITCHING', NULL, b'0', '止口一致,保留0.6CM止口', '以运领线为准保留0.6CM止口,均匀顺形切去上沿多余的止口', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4947, 'ZYSZCYLZ013', '修翻连整烫下级领1条*1(15条领子一扎)', 19, 20.1200, 0.0478, 'STITCHING', NULL, b'0', '平服,圆咀圆顺,左右对称', '先修剪两边圆咀处多余的止口,保留0.3CM止口,再用模具翻领咀到正面,再烫定上沿止口,正反面都需要烫定', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4948, 'ZYSZCYLZ014', '辑下级领上沿明线2条*1(直/40CM)', 156, 23.1700, 0.0753, 'STITCHING', NULL, b'0', '平服,止口一致,线迹均匀,底不可落坑', '先距上级领两边0.5CM处均匀辑0.1CM明线,再辑0.6CM明线且首尾回针,需检查底线是否落坑,剪净线头', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4949, 'ZYSZCYLZ015', '切下级领里脚止口1条*1(直/42CM)', 167, 6.2000, 0.0155, 'STITCHING', NULL, b'0', '止口一致,保留0.6CM止口', '以下级领面脚位为准保留0.6CM止口,均匀顺形切去上沿多余的止口', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4950, 'ZYSZCYLZ016', '点下级领里脚位3点*1(点领机)', 36, 3.8500, 0.0091, 'STITCHING', NULL, b'0', '左右对称,刀口不可太深(0.3CM即可)', '对折领子对准点位机,分别打刀口两肩点2个及后中1个', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4951, 'ZYSZCYLZ017', '锁领尖眼2个*1(固定循环2.5秒)', 254, 10.7000, 0.0267, 'STITCHING', NULL, b'0', '平服,左右对称', '以车台上标领尖锁眼1个*2,锁眼长1.8CM', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4952, 'ZYSZCYLZ018', '车上领暗缝1条*1（尖角，直9+47+9cm)', 156, 35.7900, 0.1253, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4953, 'ZYSZCYLZ019', '车上领暗缝（尖角/9+47+9cm)1条*1', 165, 39.4700, 0.1381, 'STITCHING', NULL, b'0', '平服,出入口齐,转角要正顺,领尖左右对称', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4954, 'ZYSZCYLZ020', '', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4955, 'ZYSZCYLZ021', '车上领暗缝（圆角/50cm）1条*1', 156, 36.3000, 0.0862, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4956, 'ZYSZCYLZ022', '车上领暗缝（弧/9+47+9cm）1条*1', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '取上下领裁片对位，放置于压脚下，', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4957, 'ZYSZCYLZ023', '画上领净边（圆角）1条*1', 161, 10.3800, 0.0234, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4958, 'ZYSZCYLZ024', '翻领角（尖）2个*1', 27, 9.3500, 0.0304, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4959, 'ZYSZCYLZ025', '翻领角（尖）2个*1', 27, 6.8800, 0.0163, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4960, 'ZYSZCYLZ026', '烫领角定型尖2个*1', 59, 14.0100, 0.0333, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4961, 'ZYSZCYLZ027', '整烫上领尖1条*1', 19, 7.8600, 0.0196, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4962, 'ZYSZCYLZ028', '车上领装饰线（尖角，直/9+47+9cm)1条*1', 147, 13.5600, 0.0339, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4963, 'ZYSZCYLZ029', '翻领角(圆)2个*1', 27, 2.8700, 0.0068, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4964, 'ZYSZCYLZ030', '缝底领衬固定缝（直/48cm)1条*1', 156, 13.6300, 0.0324, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4965, 'ZYSZCYLZ031', '切底领面上口（直/50cm)1条*1', 167, 6.7200, 0.0160, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4966, 'ZYSZCYLZ032', '夹底领（直/5cm+42cm+5cm)1条*1', 156, 39.7300, 0.1391, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4967, 'ZYSZCYLZ033', '切底领里下口（直/50cm)1条*1', 167, 6.7200, 0.0160, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4968, 'ZYSZCYLZ034', '定缝上领下口（直/44cm)1条*1', 243, 8.8300, 0.0210, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4969, 'ZYSZCYLZ035', '重定角尖2个*1', 59, 9.1100, 0.0205, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4970, 'ZYSZCYLZ036', '切上领下口止口1条*1', 34, 8.9500, 0.0213, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4971, 'ZYSZCYLZ037', '缝上领下口吃势（直/40cm)1条*1', 289, 9.0300, 0.0226, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4972, 'ZYSZCYLZ038', '翻连整烫底领1条*1', 19, 12.3500, 0.0309, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4973, 'ZYSZCYLZ039', '点底领里位置3点*1', 36, 10.8100, 0.0270, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4974, 'ZYSZCYMT001', '缩烫商标1个*1(一次烫100个,压烫机)', 57, 2.4000, 0.0060, 'STITCHING', NULL, b'1', '不变形,不变色,不可有烫痕', '以压烫机面积计算适量摆入唛头的数量,摆放整齐,温度适度', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4975, 'ZYSZCYQP001', '双针锁连车拉筒落左门襟条1条*1（直/70CM，净色,自动摆放）', 156, 17.4600, 0.0567, 'STITCHING', NULL, b'0', '内折止口一致,顺直平服,线迹均匀', '先将门筒放入拉筒,再左前片正面朝上门襟下摆位开始,向上内折0.6CM止口放入拉筒车缝,完成后门筒宽3.5CM,双线距边0.6CM', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4976, 'ZYSZCYQP002', '拉筒环口辑右门里襟2.5CM明线1个*1（直/70CM）同时夹标1个*1（净色，自动摆放）', 156, 19.5400, 0.0635, 'STITCHING', NULL, b'0', '平服,线迹均匀,宽窄一致,洗唛不可放反且要正,不可车住洗唛上面的文字', '右前片反面朝上下摆位开始三折边放入拉筒车缝,内折止口1CM,完成后宽2.5CM,下摆向上9CM处夹洗唛,洗唛正面朝外', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4977, 'ZYSZCYQP003', '修前领窝1件*1(左右门襟,净色)', 15, 15.3100, 0.0383, 'STITCHING', NULL, b'0', '下摆位平齐,左门襟领窝斜修剪0.2CM略低于右门襟', '比齐左右前襟位,左前片在上，右前片在上,下摆位修剪平齐,前领窝位用纸板顺形修剪,左门襟领窝斜修剪0.2CM略低于右门襟', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4978, 'ZYSZCYQP004', '明上左前片贴袋1个*1(圆角/3+0.5+38+0.5+3CM,袋口两边三角形,净色)', 156, 47.0100, 0.1763, 'STITCHING', NULL, b'0', '平服,止口一致,均匀距边0.1CM,圆角圆顺,与门襟平行,线迹均匀', '先将左前片按车台标记放好,再取袋布距边0.1CM贴袋,袋口两边车三角形,三角形底边长0.5CM,斜边长以车至袋口明线为准,首尾回针,剪净线头', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4979, 'ZYSZCYQP005', '压烫左右门襟1件*1(三面压烫机，压烫4秒)', 57, 12.8700, 0.0306, 'STITCHING', NULL, b'0', '平服,不可有烫痕', '放平左右门襟至压烫机上,放置时左右门襟需完全错开,温度适度', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4980, 'ZYSZCYQP006', '锁左门襟平眼6个*1(两台全自动锁眼车交替操作)', 258, 9.5900, 0.0240, 'STITCHING', NULL, b'0', '平服,以门筒为准居中,眼与眼间距均匀', '左右门襟同时拿取放平至锁眼车上,需将右门襟完全错开,左门襟以前领处为准对准锁眼车,锁眼长1.8CM', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4981, 'ZYSZCYQP007', '钉右门襟扣7粒*1(全自动钉扣车，包括1粒备用扣)', 263, 17.3000, 0.0432, 'STITCHING', NULL, b'0', '扣的位置在以门襟边为准2CM处(以扣中心为准),扣与扣间距均匀,线微松且牢固,扣上扣后要平服', '左右门襟同时拿取放平至锁眼车上,需将左门襟完全错开,右门襟以前领处为准对准锁眼车,四眼扣,线成交叉形,针数为16针', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4982, 'ZYSZCYQP009', '缝门襟拉筒落门襟条/附带衬（直/72cm）1条*1', 222, 20.7100, 0.0673, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4983, 'ZYSZCYQP010', '缝里襟/附带衬(直/72cm)1条*1', 156, 17.2000, 0.0559, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4984, 'ZYSZCYQP011', '烫袋口三折（直/14cm）1个*1', 248, 3.6200, 0.0090, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4985, 'ZYSZCYQP012', '缝袋口三折（直/14cm）1个*1', 292, 4.5300, 0.0113, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4986, 'ZYSZCYQP013', '烫口袋三边/手工（直13+6+6+13）1个*1', 160, 9.5200, 0.0238, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4987, 'ZYSZCYQP014', '缝口袋（直13+6+6+13）1个*1', 156, 39.2800, 0.0982, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4988, 'ZYSZCYQP015', '改门、里襟领口+下摆/1件*1', 15, 38.2600, 0.0956, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4989, 'ZYSZCYQP016', '缝合腰缝及袖底缝/五线锁边(直40+40cm+)1条*2', 181, 36.9100, 0.0877, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4990, 'ZYSZCYQP017', '缝前刀背缝/三线锁边（弯55cm）1条*2', 172, 12.3900, 0.0294, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4991, 'ZYSZCYQP018', '缝腰缝/分割（直35cm）1件*2', 156, 17.4900, 0.0415, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4992, 'ZYSZCYXC001', '专机扣烫大袖衩1个*2(宝剑头)', 32, 13.0800, 0.0311, 'STITCHING', NULL, b'0', '平服,止口一致,尖位顺正,不可有烫痕', '从大袖衩宝剑头方向入拉筒烫,完成后宽2.5CM,尖位斜边长1.5CM,温度适度', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4993, 'ZYSZCYXC002', '整烫大袖衩1个*1连打刀口1个*2(宝剑头,每次拿15个,专机烫后)', 19, 7.8000, 0.0185, 'STITCHING', NULL, b'1', '平服,剪口不可爆口,不可有烫痕', '先将大袖衩下层下端转角处打剪口1个*2,再整烫袖衩,温度适度', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4994, 'ZYSZCYXC003', '落大袖衩衬条1条*2(直/15CM)', 156, 14.4000, 0.0360, 'STITCHING', NULL, b'0', '平服,衬条不可外露', '打开袖衩,袖衩上层止口距边0.1CM稀针(2针/CM)车0.5CM宽衬条,尖位不车', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4995, 'ZYSZCYXC004', '锁大袖衩眼1个*2(固定循环2秒)', 255, 9.4000, 0.0235, 'STITCHING', NULL, b'0', '平服,以大袖衩为准居中且平行', '以车台上标记大袖衩锁眼1个*2,锁眼长1.8CM', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4996, 'ZYSZCYXC005', '专机扣烫大小袖衩1个*2(宝剑头)', 32, 11.7000, 0.0278, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4997, 'ZYSZCYXO001', '折辑袖英面边线1条*2(直/28CM)', 156, 17.6000, 0.0572, 'STITCHING', NULL, b'0', '平服,止口一致,线迹均匀', '反面在上,袖英面向上折1.2CM止口沿衬边均匀车缝1CM边线', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4998, 'ZYSZCYXO002', '刀车辑转袖英1个*2(圆角,直/4+弯/3+直/21+弯3+直4CM)', 166, 43.7000, 0.1529, 'STITCHING', NULL, b'0', '袖英里在上,袖英面在上,用高低层次的纸板运袖英,袖英里两边向上折1CM止口包紧袖英面', '袖英里在上,袖英面在上,用高低层次的纸板运袖英,袖英里两边向上折1CM止口包紧袖英面', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (4999, 'ZYSZCYXO003', '修袖英圆角2个*2', 15, 6.9000, 0.0164, 'STITCHING', NULL, b'0', '圆角处保留0.3CM止口', '修剪两边圆角处多余的止口,保留0.3CM止口', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5000, 'ZYSZCYXO004', '翻袖英1个*2连定型1个*2(圆角,双头机)', 29, 17.3000, 0.0411, 'STITCHING', NULL, b'0', '平服,圆角圆顺,不可爆口,左右对称,不可有烫痕', '先手工将袖英翻到正面,再将袖英套入翻袖英机模具且调整平整,再送入上方压烫定型,温度适度', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5001, 'ZYSZCYXO005', '辑袖英边线1条*2(圆角,直/4+弯/3+直/21+弯3+直4CM)', 156, 26.8000, 0.0871, 'STITCHING', NULL, b'0', '平服,止口一致,线迹均匀,不可反止口及夹止口,圆角圆顺,接线位不可有空位', '以折辑袖英面线为准沿袖三方辑0.6CM明线,首尾回针,剪净线头', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5002, 'ZYSZCYXO006', '锁袖英眼1个*2(单头机,固定循环时间1.5秒)', 255, 10.6000, 0.0265, 'STITCHING', NULL, b'0', '平服,以折辑袖英线与辑袖英边线之间为准居中且平行,锁眼位于大袖衩一边,不可搞错', '以车台上标记袖英(靠近大袖衩一边)锁眼1个*2,锁眼长1.8CM', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5003, 'ZYSZCYXO007', '钉袖英扣1粒*2(手动钉扣车,固定循环时间1秒)', 261, 14.1000, 0.0352, 'STITCHING', NULL, b'1', '以小袖衩宽度为准扣要居中,线微松且牢固,扣上扣后要平服', '以大袖衩锁眼为准,在小袖衩中间钉四眼扣1粒*2,线成交叉形,针数为16针', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5004, 'ZYSZCYXO008', '缝袖头固定缝（直/28cm)1条*2', 156, 16.0600, 0.0381, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5005, 'ZYSZCYXO009', '缝袖头暗缝（方角，直/7cm+26cm+7cm)1条*2', 165, 46.0400, 0.1611, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5006, 'ZYSZCYXO010', '翻袖头1个*2（方角）', 15, 11.2200, 0.0280, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5007, 'ZYSZCYXO011', '烫袖头1个*2（方角）', 19, 17.5300, 0.0416, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5008, 'ZYSZCYXO012', '缝袖头装饰线（方角，直/7cm+26cm+7cm)1个*2', 156, 34.7900, 0.0870, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5009, 'ZYSZCYXZ001', '拉筒拉小袖衩滚条1条*1同时放衬条1条*2(直/15CM)', 156, 21.5000, 0.0699, 'STITCHING', NULL, b'0', '平服,线迹均匀,内包止口一致,小袖衩宽窄一致,衩底转角位不可爆口', '先将小袖衩均匀穿入拉筒,再在袖子衩位靠后袖位一边拉袖衩,中间夹衬条,衩底预留小袖衩长度为1CM,完成后宽1.2CM', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5010, 'ZYSZCYXZ002', '上大袖衩连封三角1个*2(宝剑头,单线,直/2+直/2.5+直/1.5+直/1.5+直/18CM,净色)', 156, 81.9000, 0.3071, 'STITCHING', NULL, b'0', '平服,左右对称,转角顺正,底不可落坑,线迹均匀,衩底反面不可爆口,宝剑头处止口不可外露', '先在衩底反面封三角,首尾回针,再0.1CM明线夹上大袖叉,宝剑头位需用纸板车缝,袖口处不回针,宝剑头处需回针,剪净线头', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5011, 'ZYSZCYXZ003', '走袖口线1条*2同时打活褶1个*2(直/15CM)', 156, 18.5000, 0.0462, 'STITCHING', NULL, b'0', '止口一致,褶位正顺,两褶左右对称,褶倒向不可错误', '袖口距边0.8CM止口稀针(2针/CM)均匀走固定线(用于夹上袖英夹入的止口标准),同时靠大袖衩一边按刀口打活褶1个*2,褶位倒向大袖衩', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5012, 'ZYSZCYXZ004', '压烫大小袖衩1个*2(两台压烫机同时交替操作)', 57, 6.6000, 0.0157, 'STITCHING', NULL, b'0', '平服,不可有烫痕,衬条牢固', '放平左右袖衩位至压烫机上,放置时左右需完全错开,温度适度', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5013, 'ZYSZCYXZ005', '钉小袖衩扣1粒*2(手动钉扣车,固定循环时间1秒)', 261, 15.6000, 0.0390, 'STITCHING', NULL, b'0', '以小袖衩宽度为准扣要居中,线微松且牢固,扣上扣后要平服', '以大袖衩锁眼为准,在小袖衩中间钉四眼扣1粒*2,线成交叉形,针数为16针', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5014, 'ZYSZCYXZ006', '缝大小袖衩连点袖衩1个*2(宝剑头,直/5.0+直/3.0+直/1.5+直/1.5+直/15CM，直/2.4+15cm,净色)', 155, 119.6100, 0.3887, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5015, 'ZYSZCYZH001', '拉筒合肩缝2条*1及封后领窝1点*1(直/18CM#line#)', 149, 40.9900, 0.1435, 'STITCHING', NULL, b'0', '平服,止口一致,底不可落坑,线迹均匀', '出入口齐,后片在左边且担干面在上内折1CM止口放入拉筒,担干里在下内折1CM止口放入拉筒,前片在右边且夹在中间1CM止口,再三层一起合肩缝0.1CM明线,首尾回针', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5016, 'ZYSZCYZH002', '上领1条*1及封左门襟1点*1(弯/46CM)', 156, 33.9000, 0.1271, 'STITCHING', NULL, b'0', '平服,止口一致,领围圆顺,左右对称', '出入口齐,大身领围在下、正面朝上,领子在上、反面朝上,分别对齐肩位、后中位刀口均匀车缝0.8CM止口,首尾回针', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5017, 'ZYSZCYZH003', '上领后辑明线1条*1(圆头,直/2+弧/4+直/46+弧/4+直/2CM)', 156, 42.1000, 0.1579, 'STITCHING', NULL, b'0', '平服,止口一致,领围圆顺,左右对称', '下级正面在上,从领咀接线处起针(重线2CM),包紧领咀处止口,上领止口倒向内均匀车缝0.1CM明线,剪净线头', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5018, 'ZYSZCYZH004', '上袖2个*1同时放衬条2条*1(弯/57CM)', 202, 41.2000, 0.1545, 'STITCHING', NULL, b'0', '平服,包止口均匀,止口一致,上袖圆顺,左右对称', '出入口齐,袖子在下、正面朝上放入拉筒,大身袖围在上、反面朝上左手依次收拢大身袖围放入拉筒,再袖山1.2CM止口包大身袖围均匀车缝,中间夹衬条,对准肩位刀口', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5019, 'ZYSZCYZH005', '辑袖围明线2条*1(弯/57CM)', 156, 36.7000, 0.1284, 'STITCHING', NULL, b'0', '平服,止口一致,线迹均匀,底不可落坑', '止口倒向大身,正面均匀辑0.8CM明线', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5020, 'ZYSZCYZH006', '压烫袖围2个*1(两台压烫机同时交替操作)', 57, 18.3000, 0.0435, 'STITCHING', NULL, b'0', '平服,不可有烫痕,衬条牢固', '正面朝上顺形摆放至压烫机上,温度适度', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5021, 'ZYSZCYZH007', '埋夹车合侧缝2条*1及袖底缝2条*1同时夹衬条2条*1(洗唛不折,侧缝直/44CM+袖底缝直/46CM,净色)', 206, 57.2000, 0.2145, 'STITCHING', NULL, b'0', '平服,止口一致,包缝爆满,不可露毛边,线迹均匀,底不可落坑，十字缝要对准,不可错位', '正面朝上,后片包前片,后片在上向下内折0.8CM止口放入拉筒,前片在下向上内折0.8CM止口放入拉筒,再均匀车缝0.6CM+0.1CM双明线,对准袖底十字缝,中间夹衬条', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5022, 'ZYSZCYZH008', '压烫侧缝及袖底缝2条*1(两台压烫机同时交替操作)', 57, 16.1000, 0.0402, 'STITCHING', NULL, b'0', '平服,不可有烫痕,衬条牢固', '正面朝上顺形摆放至压烫机上,温度适度', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5023, 'ZYSZCYZH009', '夹上袖英2个*1同时打活褶2个*1连点位2点*1(直/26CM)', 156, 76.8000, 0.2880, 'STITCHING', NULL, b'0', '平服,止口一致,线迹均匀,底不可落坑,左右对称,大小衩不可有高低,不可露咀', '大袖在左边,袖英在右边,先比齐大袖衩修齐多余的止口,再袖衩位塞入袖英内包紧放入拉筒,再按袖口走线均匀车缝0.1CM明线,同时按刀口打活褶1个*2,褶位倒向大袖衩,首尾回针,剪净线头', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5024, 'ZYSZCYZH010', '拉筒环口辑下摆1件*1连修剪(燕尾形,宽0.3CM,弯/132CM)', 156, 61.6000, 0.2156, 'STITCHING', NULL, b'0', '线迹均匀,下摆圆顺,不可扭曲,不可露毛边,左右门襟不可有高低且要平,不可歪斜', '先比齐左右门襟修齐下脚处及侧缝处多余的止口,再从左门襟下脚处起针手工三折边车缝过门襟位,再放入拉筒均匀三折边车缝0.3CM明线,两侧缝处取下拉筒手工三折边车缝,首尾回针,剪净线头', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5025, 'ZYSZCYZH011', '钉领尖扣2粒*1(手动钉扣车,固定循环时间1秒)', 261, 13.9000, 0.0347, 'STITCHING', NULL, b'1', '线微松且牢固,扣上扣后要平服自然', '以车台标记为准,在左右前片领尖扣位钉四眼扣1粒*2,线成交叉形,针数为16针', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5026, 'ZYSZCYZH012', '绱领1条*1(弯/46cm)', 156, 28.8400, 0.1081, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5027, 'ZYSZCYZH013', '辑下领连压上口0.1明线1条*1(圆头,直/2+弧/4+直/46+弧/4+直/2CM)', 156, 44.8200, 0.1681, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5028, 'ZYSZCYZH014', '拉筒缝合肩缝(直18cm)1条*2', 156, 31.6500, 0.1108, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5029, 'ZYSZCYZH015', '绱袖同时放胶条（弯/55cm）1条*2', 202, 44.2500, 0.1659, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5030, 'ZYSZCYZH016', '缉袖笼明线（弯55cm）1条*2', 156, 36.6100, 0.1281, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5031, 'ZYSZCYZH017', '压烫袖笼1条*2', 57, 15.6700, 0.0509, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5032, 'ZYSZCYZH018', '缝合侧缝及袖底缝1条*2（侧缝直/44cm+袖底缝直/46cm)', 206, 56.7200, 0.2127, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5033, 'ZYSZCYZH019', '绱袖头同时打活褶2个（直/26cm)1件*2', 156, 30.6800, 0.1150, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5034, 'ZYSZCYZH020', '', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5035, 'ZYSZCYZH021', '缝下摆（圆摆，宽0.5cm，弯/125cm)1件*1', 156, 50.2100, 0.1757, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5036, 'ZYSZCYZH022', '整件锁眼（眼长1.8，共11个眼）1件*1', 254, 46.3900, 0.1624, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5037, 'ZYSZCYZH023', '整件钉扣(共12粒，半自动钉扣车,固定循环时间1秒)1件*1', 262, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5038, 'ZYSZCYZH024', '合腰袖缝（直80）1条*2', 172, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5039, 'ZYSZJPLZ019', '驳接领仔、分缝（弧/30）2条*2', 156, 76.5200, 0.2678, 'STITCHING', NULL, b'1', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5040, 'ZYSZJPLZ020', '车袋支线（直/20）1条*2', 156, 44.1100, 0.1048, 'STITCHING', NULL, b'1', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5041, 'ZYSZJPLZ021', '落袋贴（直/20）1条*2', 156, 30.6400, 0.0996, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5042, 'ZYSZJPQP023', '运领沿（直10+弧5+直50+弧5+直10）1条*1', 156, 50.3700, 0.1196, 'STITCHING', NULL, b'1', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5043, 'ZYSZJPQP024', '封领（直/6）1条*2', 156, 25.6800, 0.0610, 'STITCHING', NULL, b'1', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5044, 'ZYSZJPQP025', '翻烫领*1', 160, 27.9100, 0.0977, 'STITCHING', NULL, b'1', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5045, 'ZYSZJYDF001', '合挡风贴面里贴布（直/60CM）2条*1', 156, 40.4000, 0.1313, 'STITCHING', NULL, b'0', '裁片平服，线迹均匀顺直；', '面层在下，头尾回针，出入口对齐，', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5046, 'ZYSZJYDF002', '烫定挡风贴面里贴布2条*1', 19, 25.3000, 0.0632, 'STITCHING', NULL, b'0', '裁片对齐，平服，不起拱。', '反折到面层，烫平服。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5047, 'ZYSZJYDF003', '压挡风贴面里贴布明线（直/60CM）2条*1', 156, 31.2000, 0.1014, 'STITCHING', NULL, b'0', '压线均匀顺直，明线宽窄止口一致。', '面层朝下，保持0.6止口顺直。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5048, 'ZYSZJYDF004', '运挡风贴（直/80CM）2条*1', 156, 29.7000, 0.0965, 'STITCHING', NULL, b'0', '裁片平服，线迹均匀顺直；', '走定面里层，首尾回针。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5049, 'ZYSZJYDF005', '刀车切修挡风贴（直/80CM）2条*1', 167, 20.6000, 0.0515, 'STITCHING', NULL, b'0', '整条宽窄一致，止口均匀。', '面层朝下，切到头。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5050, 'ZYSZJYDF006', '烫定挡风贴*2', 19, 15.4000, 0.0385, 'STITCHING', NULL, b'0', '裁片顺直，不起拱。', '先蒸汽烫，不平服地方压烫。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5051, 'ZYSZJYDF007', '压挡风贴上下止口明线（直（3+10+27CM）2段*1', 156, 24.3000, 0.0851, 'STITCHING', NULL, b'0', '止口宽窄均匀顺直，能与中间明线接上线。', '首尾回针，压上下一段。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5052, 'ZYSZJYDF008', '切修挡风贴宽度（直/80CM）1条*1', 167, 11.5000, 0.0287, 'STITCHING', NULL, b'0', '整条宽窄一致，止口均匀，上下层对齐。', '切除多余止口，双层，上下对齐。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5053, 'ZYSZJYDF009', '钉挡风贴魔术贴（2.5+3+2.5+3CM）1个*1', 156, 24.6000, 0.0799, 'STITCHING', NULL, b'0', '位置准确，平服，四角匀称。', '四方明贴，首尾回针。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5054, 'ZYSZJYDF010', '点挡风贴平眼位及固定位8个*1', 15, 18.5000, 0.0462, 'STITCHING', NULL, b'0', '位置准确，点位力度适中不褪色。', '裁片在下，样板准确对齐。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5055, 'ZYSZJYDF011', '固定挡风贴面里3点*1', 156, 18.1000, 0.0588, 'STITCHING', NULL, b'0', '位置准确，宽度适中。', '上下对齐，回针固定。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5056, 'ZYSZJYDF012', '上挡风贴拉链（直/72CM)*1', 156, 36.1000, 0.1263, 'STITCHING', NULL, b'0', '裁片平服，线迹均匀顺直；', '挡风贴在下，尾部拉链头需折。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5057, 'ZYSZJYDG001', '模板运前上袋盖（直/4+14+4CM）2个*1', 156, 43.7000, 0.1420, 'STITCHING', NULL, b'0', '袋盖平服，线迹均匀顺直；', '袋盖与模板净样线对齐，沿槽勾袋盖，头尾回针。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5058, 'ZYSZJYDG004', '模板运前下袋盖（直/6+18+6CM）2个*1', 156, 45.4000, 0.1475, 'STITCHING', NULL, b'1', '袋盖平服，线迹均匀顺直；', '袋盖与模板净样线对齐，沿槽勾袋盖，头尾回针。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5059, 'ZYSZJYDG005', '模板运袖袋盖（直/4+12+4CM）1个*1', 156, 21.5000, 0.0699, 'STITCHING', NULL, b'1', '袋盖平服，线迹均匀顺直；', '袋盖与模板净样线对齐，沿槽勾袋盖，头尾回针。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5060, 'ZYSZJYDG006', '烫定袋盖连翻角*5', 19, 75.5000, 0.1887, 'STITCHING', NULL, b'0', '袋盖面里平服，尖角匀称。', '翻袋盖，挑脚，裁片正面在上，烫平袋盖。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5061, 'ZYSZJYDG007', '单针缉前上袋盖宽明线（直/3.5+13+3.5CM）2条*1', 156, 44.5000, 0.1446, 'STITCHING', NULL, b'0', '裁片平服，线迹均匀顺直；', '袋盖正面在上，转角压线，保持线距宽度一致。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5062, 'ZYSZJYDG009', '单针缉前下袋盖宽明线（直/5.5+17+5.5CM）2条*1', 156, 44.9000, 0.1459, 'STITCHING', NULL, b'1', '裁片平服，线迹均匀顺直；', '袋盖正面在上，转角压线，保持线距宽度一致。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5063, 'ZYSZJYDG010', '单针缉前袖盖宽明线（直/3.5+11+3.5CM）1条*1', 156, 43.5000, 0.1414, 'STITCHING', NULL, b'1', '裁片平服，线迹均匀顺直；', '袋盖正面在上，转角压线，保持线距宽度一致。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5064, 'ZYSZJYDG011', '走定前上袋盖实样（直/13.5CM)2条*1', 156, 14.9000, 0.0484, 'STITCHING', NULL, b'0', '袋盖平服，宽度一致。', '走定面里层袋盖，保持宽度一致。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5065, 'ZYSZJYDG012', '走定前下袋盖实样（直/18CM)2条*1', 156, 14.7000, 0.0478, 'STITCHING', NULL, b'1', '袋盖平服，宽度一致。', '走定面里层袋盖，保持宽度一致。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5066, 'ZYSZJYDG013', '走定袖袋盖实样（直/12CM)1条*1', 156, 7.2000, 0.0234, 'STITCHING', NULL, b'1', '袋盖平服，宽度一致。', '走定面里层袋盖，保持宽度一致。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5067, 'ZYSZJYDZ001', '环口压前上袖贴袋口明线连落垫布（直/13CM）3条*1', 156, 43.4000, 0.1410, 'STITCHING', NULL, b'0', '卷边止口宽度一致，平服，不起纽。', '卷1.4CM袋口边，落纽扣垫布。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5068, 'ZYSZJYDZ002', '扣烫前上袖贴袋3个*1', 19, 46.4000, 0.1508, 'STITCHING', NULL, b'0', '裁片平服，折烫的止口均匀；', '用拷贝纸包住贴袋，再用贴袋模板包烫贴袋三边。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5069, 'ZYSZJYHP001', '合后中缝（直/92CM）1条*1', 156, 28.7000, 0.0933, 'STITCHING', NULL, b'0', '线迹顺直，裁片平服。', '反面拼缝，较长，裁片需抚平。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5070, 'ZYSZJYHP002', '压后中缝明线（直/92CM）1条*1', 156, 25.8000, 0.0838, 'STITCHING', NULL, b'0', '明线宽窄一致，顺直、无跳针、跳线线迹。', '正面压明线，衣身较长。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5071, 'ZYSZJYHP003', '扣烫后下摆*2', 19, 18.1000, 0.0588, 'STITCHING', NULL, b'1', '裁片平服，折烫的止口均匀；', '折合落样扣烫，烫平缝份；', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5072, 'ZYSZJYHP004', '画腰通道线（直/68CM）2条*1', 15, 23.3000, 0.0582, 'STITCHING', NULL, b'0', '线迹位置准确，不易褪色。', '裁片放下，落样画线。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5073, 'ZYSZJYLB002', '点里前袋及织带位7个*1', 15, 20.6000, 0.0515, 'STITCHING', NULL, b'1', '点位位置精准，且不易掉色。', '落样点位，注意裁片平服。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5074, 'ZYSZJYLB003', '环口压里贴袋口明线（直/15CM）1条*1', 156, 15.0000, 0.0487, 'STITCHING', NULL, b'0', '袋口明线宽窄须一致，线迹直顺。', '环口压袋口明线，首尾回针。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5075, 'ZYSZJYLB004', '扣烫里贴袋1个*1', 19, 15.5000, 0.0504, 'STITCHING', NULL, b'1', '裁片平服，折烫的止口均匀；', '用拷贝纸包住贴袋，再用贴袋模板包烫贴袋三边。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5076, 'ZYSZJYLB005', '明上里前贴袋（直/13+2+11+2+13CM）*1连落扣袢连压线（直/1.5CM）*1', 156, 56.0000, 0.1960, 'STITCHING', NULL, b'0', '线迹顺直，袋口平服，直角方正。', '按点位印明贴袋口连落织带，首尾回针。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5077, 'ZYSZJYLB006', '合里肩缝（直/16CM）1条*2', 156, 27.6000, 0.0897, 'STITCHING', NULL, b'0', '裁片平服，线迹均匀顺直；', '里布肩缝正面相对，出入口对齐，沿边1CM缝合；', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5078, 'ZYSZJYLB008', '合里袖侧缝（直/61CM）1条*2', 156, 41.8000, 0.1358, 'STITCHING', NULL, b'0', '线迹顺直，裁片平服。', '里布正面相对，首尾回针。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5079, 'ZYSZJYLB009', '上里平袖（弧/68CM）同时落里布条*2', 156, 68.5000, 0.2397, 'STITCHING', NULL, b'0', '弧度圆顺，里布平服。', '上弧度摊开袖，里布正面相对。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5080, 'ZYSZJYLB010', '剪洗水唛', 15, 3.0000, 0.0075, 'STITCHING', NULL, b'0', '无歪斜，沿虚线。', '手工剪量，对准虚线剪断。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5081, 'ZYSZJYLB011', '合里袖底缝及摆缝（直/112CM）同时夹洗水唛', 156, 71.9000, 0.2337, 'STITCHING', NULL, b'0', '线迹顺直，裁片平服。', '里布正面对折合缝，首尾回针，注意对位。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5082, 'ZYSZJYLB012', '烫里布整件', 19, 52.9000, 0.1322, 'STITCHING', NULL, b'0', '要求里布平服，不起纽。', '中烫工艺，烫平服。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5083, 'ZYSZJYLB013', '折压襟贴（弧/36+2+152+2+36CM）1条*1', 156, 95.9000, 0.3356, 'STITCHING', NULL, b'0', '明线宽窄需一致，线迹顺直，无跳针断线线迹。', '转角首尾回针，落及压明线。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5084, 'ZYSZJYLB015', '合里袖侧缝及袖底缝(直/54+62CM）2条*2', 156, 95.7000, 0.3110, 'STITCHING', NULL, b'0', '线迹顺直，裁片平服。', '对折拼缝，拼成圆筒袖。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5085, 'ZYSZJYLB016', '三线锁里袖侧缝及袖底缝（直/54+62CM）2条*2', 172, 49.8000, 0.1245, 'STITCHING', NULL, b'0', '线迹止口顺直，与平车线宽窄均匀。', '锁边及切除多余止口', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5086, 'ZYSZJYLB017', '合肩缝（直/18CM)1条*2及摆缝（直/42CM）1条*2', 156, 70.0000, 0.2275, 'STITCHING', NULL, b'0', '裁片平服，线迹均匀顺直；', '里布肩缝正面相对，出入口对齐，沿边1CM缝合；', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5087, 'ZYSZJYLB018', '三线锁肩缝(直/18CM）及摆缝（直/42CM）', 173, 35.0000, 0.0875, 'STITCHING', NULL, b'0', '线迹止口顺直，与平车线宽窄均匀。', '锁边及切除多余止口', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5088, 'ZYSZJYLB019', '上里圆袖（弧/65CM）1条*2', 156, 125.0000, 0.4375, 'STITCHING', NULL, b'0', '容位均匀，左右对称，袖山圆顺；', '圆筒上袖，翻袖子穿到大身内转圆筒，首尾回针。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5089, 'ZYSZJYLB020', '三线锁里圆袖（弧/65CM）1条*2', 172, 40.1000, 0.1002, 'STITCHING', NULL, b'0', '线迹止口顺直，与平车线宽窄均匀。', '锁边及切除多余止口', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5090, 'ZYSZJYLB021', '拉筒拉袖口（直/40CM）1条*2', 155, 41.0000, 0.1435, 'STITCHING', NULL, b'0', '止口均匀，不跳线，滚袖口饱满；', '滚圆筒袖口，拼接口拉出留一段。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5091, 'ZYSZJYLB022', '拼接袖口捆条*2连修剪', 156, 32.5000, 0.1137, 'STITCHING', NULL, b'0', '线迹接正，捆条平服，不纽。', '拼连包袖口捆条，接线。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5092, 'ZYSZJYLB023', '拉筒拉前襟下摆一周（弧/284CM）1条*1', 156, 107.4000, 0.3759, 'STITCHING', NULL, b'0', '止口均匀，不跳线，滚条饱满；', '滚大身捆条，下摆处拉出捆条，留一段拼接。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5093, 'ZYSZJYLB025', '拼接下摆捆条*1连修剪', 156, 17.2000, 0.0602, 'STITCHING', NULL, b'1', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5094, 'ZYSZJYLB026', '上内胆拉链（弧/154CM）*1', 156, 74.0000, 0.2590, 'STITCHING', NULL, b'0', '线迹顺直，无跳针跳线线迹，裁片平服，止口均匀。', '上套内胆拉链，拉链尾折止口，首尾回针。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5095, 'ZYSZJYLZ002', '扣烫翻领下沿', 19, 24.0000, 0.0600, 'STITCHING', NULL, b'0', '下沿止口需烫定，止口匀称。', '取样板扣烫，烫止口。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5096, 'ZYSZJYLZ003', '模板运翻领（直/10+64+10CM)1条*1', 156, 29.0000, 0.0942, 'STITCHING', NULL, b'1', '领角圆顺，止口均匀；', '模板打开，领与模板净样线对齐，裁片平服，沿槽位，勾翻领净样，头尾回针断线；', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5097, 'ZYSZJYLZ004', '切修翻领三边（直/10+64+10CM）1条*1', 167, 16.2000, 0.0405, 'STITCHING', NULL, b'0', '留0.2CM缝份，缝份均匀；', '距勾领线0.2CM修多余缝份；', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5098, 'ZYSZJYLZ005', '烫定翻领连翻角连画下沿线（直/62CM）', 19, 25.4000, 0.0635, 'STITCHING', NULL, b'0', '留0.2CM缝份，缝份均匀，翻后角位圆顺，止口不外吐；', '翻圆角位，烫定翻领止口，连画下沿线。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5099, 'ZYSZJYLZ006', '压翻领三边宽明线（直/9+63+9CM）3边*1', 156, 27.6000, 0.0897, 'STITCHING', NULL, b'0', '裁片平服，线迹均匀顺直；', '领面在上，距边0.6CM压边线；', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5100, 'ZYSZJYLZ007', '运领条两端（直/2+2CM）连翻角连压线（直/2+39+2CM）1条*1', 156, 34.0000, 0.1105, 'STITCHING', NULL, b'0', '裁片平服，线迹均匀顺直，两角匀称；', '平车固定两头，翻领条，压三边0.1止口线。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5101, 'ZYSZJYLZ008', '落领条拉链（直/35M）连打拉链刀口3个*1', 156, 22.7000, 0.0794, 'STITCHING', NULL, b'0', '裁片平服，线迹均匀顺直；', '领条在下端，拉链顺直贴上。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5102, 'ZYSZJYLZ009', '落领拉链条（直/39）1条*1', 156, 17.0000, 0.0595, 'STITCHING', NULL, b'0', '两端对称，线迹顺直，裁片平服。', '落在领子里层，首尾回针。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5103, 'ZYSZJYLZ010', '运毛领里翻领（直/64CM）1条*1', 156, 21.0000, 0.0682, 'STITCHING', NULL, b'0', '裁片平服，线迹顺直。', '面层面里在下，里布在上，合面里。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5104, 'ZYSZJYLZ011', '烫定毛领里翻领1条*1连翻', 156, 13.3000, 0.0332, 'STITCHING', NULL, b'0', '裁片对齐，平服，不起拱。', '反折到面层，烫平服。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5105, 'ZYSZJYLZ012', '压毛领里翻领明线（63CM）1条*1', 156, 18.9000, 0.0614, 'STITCHING', NULL, b'0', '裁片平服，线迹均匀顺直；', '里布在上，距边0.6CM压边线；', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5106, 'ZYSZJYLZ013', '点毛领里翻领平眼位5个*1', 15, 16.4000, 0.0410, 'STITCHING', NULL, b'0', '位置准确，点位力度适中不褪色。', '裁片在下，样板准确对齐。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5107, 'ZYSZJYLZ014', '走定毛领里翻领与下领里（直/8+8CM）2条*1', 155, 17.2000, 0.0559, 'STITCHING', NULL, b'0', '裁片对齐、平服。', '上下层走定两头。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5108, 'ZYSZJYLZ015', '画毛领里布（直/25+10+67+10+25）连点扣袢位5个*1', 15, 30.4000, 0.0760, 'STITCHING', NULL, b'0', '位置对准，画痕准确不褪色。', '落洋画实样线一周，同时点扣袢位。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5109, 'ZYSZJYLZ016', '运毛领（直/25+10+67+10+25CM）留口同时放扣袢4个*1', 156, 61.8000, 0.2008, 'STITCHING', NULL, b'0', '根据画线位走，角度圆顺，留封口位。', '毛领里布在下，合一周，同时落扣袢，留口。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5110, 'ZYSZJYLZ017', '翻毛领*1', 15, 22.3000, 0.0557, 'STITCHING', NULL, b'0', '角度圆顺，整体平服。', '从留口翻出，抹平。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5111, 'ZYSZJYLZ018', '封毛领口（直/10CM）连落织带*1', 156, 22.9000, 0.0801, 'STITCHING', NULL, b'0', '0.1止口均匀，裁片平服。', '明封，合连压线，首尾回针。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5112, 'ZYSZJYLZ019', '刷毛领', 15, 21.1000, 0.0527, 'STITCHING', NULL, b'0', '整体平服，无断毛。', '手工工艺，刷平服。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5113, 'ZYSZJYMJ001', '点襟贴平眼位1个*2', 15, 20.8000, 0.0520, 'STITCHING', NULL, b'0', '位置准确，点位迹不易褪色。', '落样点位', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5114, 'ZYSZJYMJ002', '拼接面里襟贴及后领贴（直/6CM)2条*2', 156, 39.4000, 0.1280, 'STITCHING', NULL, b'0', '线迹顺直，无跳针跳线线迹。', '面里反面拼接，裁片较长。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5115, 'ZYSZJYMJ003', '合襟贴及后领贴里布（弧/156CM）1条*1', 156, 61.2000, 0.2142, 'STITCHING', NULL, b'0', '线迹顺直，领贴弧度圆顺，裁片平服，无跳针跳线线迹。', '正面在下，里布在上，首尾回针，裁片较长注意平服。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5116, 'ZYSZJYMJ004', '压襟贴及后领边线（直/156CM）1条*1', 156, 47.5000, 0.1662, 'STITCHING', NULL, b'0', '明线宽窄一致，弧度圆顺，线迹顺直。', '明压边线，首尾回针。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5117, 'ZYSZJYMJ005', '上襟贴拉链（弧/156CM）1条*1', 156, 70.9000, 0.2659, 'STITCHING', NULL, b'1', '线迹顺直，弧度圆顺，首尾回针，拉链下口宽度须一致。', '门襟贴在下，首尾回针。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5118, 'ZYSZJYMZ001', '点帽气眼位2个*1', 15, 21.9000, 0.0547, 'STITCHING', NULL, b'0', '位置准确，点位痕迹不易褪色。', '裁片在下，落洋点位', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5119, 'ZYSZJYMZ002', '合帽侧缝（弧/50CM）2条*1', 156, 42.1000, 0.1368, 'STITCHING', NULL, b'0', '弧度圆顺，线迹顺直。', '反面弧度拼缝，首尾回针。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5120, 'ZYSZJYMZ003', '压帽侧明线（弧/50CM）2条*1', 156, 36.1000, 0.1263, 'STITCHING', NULL, b'0', '线迹顺直，宽窄一致，弧度圆顺。', '正面压弧度明线，首尾回针。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5121, 'ZYSZJYMZ004', '落帽口拉链（直/37CM）1条*1', 156, 22.5000, 0.0788, 'STITCHING', NULL, b'0', '线迹顺直，拉链两端宽度一致.', '帽子正面在下，拉链前端折止口，首尾回针。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5122, 'ZYSZJYMZ005', '穿帽绳连穿帽卡头', 15, 37.9000, 0.0947, 'STITCHING', NULL, b'0', '打结牢固，两端长度基本一致。', '手工工艺，穿过2个气眼后打结。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5123, 'ZYSZJYMZ011', '合里帽侧（弧/50CM）2条*1同时落里布条*2', 156, 46.1000, 0.1498, 'STITCHING', NULL, b'1', '线迹顺直，弧度圆顺。', '棉质面料弧度拼缝，需落布条。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5124, 'ZYSZJYMZ012', '画帽贴（弧/44+13）1条*2', 15, 35.5000, 0.0887, 'STITCHING', NULL, b'0', '画迹准确，不易褪色。', '画线工艺，弧度，裁片在下，落样画线。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5125, 'ZYSZJYMZ013', '拼接帽贴（直/7CM）1条*1', 156, 12.1000, 0.0393, 'STITCHING', NULL, b'0', '线迹顺直，裁片平服对齐。', '正面对齐，反面拼缝，无需回针。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5126, 'ZYSZJYMZ015', '落帽沿贴（弧/84CM）1条*1连缉明线', 156, 50.2000, 0.1757, 'STITCHING', NULL, b'1', '线迹顺直，裁片平服，止口宽窄一致。', '合连压，首尾回针。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5127, 'ZYSZJYMZ016', '运帽子面里（弧/20+12+84+12+20CM）连固定里布条*2', 156, 74.6000, 0.2611, 'STITCHING', NULL, b'0', '面里对齐、平服，弧度圆顺。', '帽子面里拼缝，有弧度，拼缝后连固定布条。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5128, 'ZYSZJYMZ017', '修翻帽子', 15, 28.2000, 0.0705, 'STITCHING', NULL, b'0', '裁片平服，面里对齐。', '手工工艺，从反面翻到正面。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5129, 'ZYSZJYMZ018', '烫定帽沿一周', 19, 34.0000, 0.1105, 'STITCHING', NULL, b'0', '裁片平服，止口对齐顺直。', '沿帽沿边对齐烫平。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5130, 'ZYSZJYMZ019', '压帽沿一周边线（弧/75+12+84+12CM）及宽线（直/74+11+90+11CM）同时封口', 156, 123.2000, 0.4620, 'STITCHING', NULL, b'0', '止口宽度一致，裁片平服，线迹顺直，弧度圆顺。', '压明线，有弧度，首尾回针，拉链一段需封口。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5131, 'ZYSZJYMZ020', '落帽嘴魔术贴（直/7+7+7+7CM）1个*2', 156, 61.0000, 0.1982, 'STITCHING', NULL, b'0', '魔术贴线迹顺直，角度方正。', '明贴四方魔术贴，首尾回针。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5132, 'ZYSZJYQP001', '扣烫前下摆*2', 19, 32.4000, 0.1053, 'STITCHING', NULL, b'0', '扣烫止口一致，止口平服，不起拱。', '落样折烫，扣烫正面。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5133, 'ZYSZJYQP002', '点前袋位*8连画腰通道线（直/34CM)2条*2连魔术贴位*5', 15, 61.8000, 0.1545, 'STITCHING', NULL, b'0', '点位位置准确，力度适中不易褪色。', '裁片在下，落样点位及画线。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5134, 'ZYSZJYQP003', '明上前贴袋（直/14+14+14CM）*2连落袋盖连压线直（直/14CM）2条*2', 156, 131.5000, 0.4602, 'STITCHING', NULL, b'0', '线迹顺直，袋口平服，直角方正。', '按点位印明贴袋口连落袋盖，首尾回针。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5135, 'ZYSZJYQP004', '钉左前上袋魔术贴*1', 156, 46.7000, 0.1518, 'STITCHING', NULL, b'0', '角度方正，居中，线迹顺直，整体平服。', '明贴魔术贴，首尾回针。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5136, 'ZYSZJYQP005', '模版落袋唇及袋盖（直/14CM）2条*2', 156, 65.5000, 0.2292, 'STITCHING', NULL, b'0', '袋盖袋唇平服，线迹均匀顺直；', '袋盖与模板净样线对齐，沿槽勾袋盖袋唇，头尾回针。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5137, 'ZYSZJYQP006', '剪开袋口*2', 15, 44.1000, 0.1103, 'STITCHING', NULL, b'0', '剪开袋口长度符合尺寸标准。', '手工工艺，从反面剪开袋口。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5138, 'ZYSZJYQP007', '压袋口下端明线(直/14CM）连翻连封三角*2', 156, 49.2000, 0.1722, 'STITCHING', NULL, b'0', '明线宽窄一致，线迹顺直，袋子平服。', '翻开口袋压明显，以及固定袋口两端，首尾回针。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5139, 'ZYSZJYQP008', '合袋贴（直/14CM）2条*2及袋布连运袋布三边（直/20+14+20CM）1个*2', 156, 111.5000, 0.3624, 'STITCHING', NULL, b'0', '袋布弧度圆顺，平服，袋贴线迹顺直。', '合袋贴袋布，反面车缝，需回针。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5140, 'ZYSZJYQP009', '压袋口3边明线（直/2+14+2CM）1条*2同时走定袋布上口', 156, 51.0000, 0.1785, 'STITCHING', NULL, b'0', '线迹宽窄一致，转角方正，线迹顺直，裁片平服。', '正面压袋口明线，首尾回针。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5141, 'ZYSZJYQT001', '缩烫前中内胆帽子拉链4条*1', 19, 31.1000, 0.0777, 'STITCHING', NULL, b'0', '保持拉链顺直。', '蒸汽缩烫，不顺直部位压烫。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5142, 'ZYSZJYQT002', '剪量帽子腰隧道棉绳连烫两端2个*2', 15, 27.7000, 0.0692, 'STITCHING', NULL, b'0', '长度与s实际尺寸一致，烫后两端无其他毛须。', '桌子上定位棉绳长度，剪断后烧两头', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5143, 'ZYSZJYQT003', '穿帽子腰隧道棉绳一端卡锁1个*2', 15, 51.4000, 0.1285, 'STITCHING', NULL, b'0', '打结长度一致，牢固。', '手工工艺，穿卡锁并打结。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5144, 'ZYSZJYQT004', '剪量下摆帽面前片魔术贴*5', 15, 30.8000, 0.0770, 'STITCHING', NULL, b'0', '魔术贴宽窄一致，无歪斜。', '桌面定规长度，比对剪下。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5145, 'ZYSZJYQT005', '单针拉筒拉领子扣袢', 156, 6.8000, 0.0221, 'STITCHING', NULL, b'0', '捆条不跳线，线迹宽窄基本一致。', '平车拉筒拉捆条。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5146, 'ZYSZJYQT006', '剪量后领里布扣袢及后领挂耳*7', 156, 21.6000, 0.0540, 'STITCHING', NULL, b'0', '长短一致，无跳线扣袢。', '桌面定规，按长度剪量。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5147, 'ZYSZJYQT007', '固定后领扣袢(直/1CM）6个*1', 156, 37.8000, 0.1229, 'STITCHING', NULL, b'0', '固定宽窄位置一致，牢固。', '对折固定，回针。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5148, 'ZYSZJYQT008', '模板运肩章及袖袢（直/13+3+3+13CM）4个*1', 156, 108.7000, 0.3533, 'STITCHING', NULL, b'1', '肩章袖袢平服，线迹均匀顺直；', '肩章袖袢与模板净样线对齐，沿槽勾肩章袖袢，头尾回针。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5149, 'ZYSZJYQT009', '烫定肩章及袖袢连翻*4', 19, 55.6000, 0.1390, 'STITCHING', NULL, b'1', '肩章袖袢面里平服，尖角匀称。', '翻肩章袖袢，挑脚，裁片正面在上，烫平肩章袖袢。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5150, 'ZYSZJYQT010', '单针缉肩章及袖章宽明线（直/13+3+3+13CM）4条*1', 156, 93.7000, 0.3045, 'STITCHING', NULL, b'1', '裁片平服，线迹均匀顺直，明线宽窄一致。', '肩章袖袢正面在上，转角压线，保持线距宽度一致。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5151, 'ZYSZJYQT011', '画肩章及袖袢宽度线（直/5CM）4条*1', 15, 23.1000, 0.0577, 'STITCHING', NULL, b'0', '裁片平服，线迹清晰；', '桌面定规，按照尺寸画。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5152, 'ZYSZJYXZ001', '扣烫袖口*2', 19, 30.5000, 0.0991, 'STITCHING', NULL, b'1', '裁片平服，折烫的止口均匀；', '折合落样扣烫，烫平缝份；', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5153, 'ZYSZJYXZ002', '点袖袋位6点*1', 15, 19.4000, 0.0485, 'STITCHING', NULL, b'0', '点位位置精准，点位迹不易脱落。', '裁片在下，落样点位。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5154, 'ZYSZJYXZ003', '合袖侧缝（直/60CM）1条*2同时夹袖袢', 156, 53.4000, 0.1735, 'STITCHING', NULL, b'0', '线迹顺直，裁片平服，袖袢与袖口平行。', '正面对折，反面拼缝，连夹袖袢。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5155, 'ZYSZJYXZ004', '压袖侧缝（直/60CM）1条*2', 156, 37.9000, 0.1232, 'STITCHING', NULL, b'0', '明线宽窄一致，线迹顺直。', '正面明压，过袖袢。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5156, 'ZYSZJYXZ005', '明上袖贴袋（直/13+12+13CM)*1连落袋盖(直/13CM）连压线', 156, 59.4000, 0.2079, 'STITCHING', NULL, b'0', '明线宽窄一致，线迹顺直，角度方正。', '明贴袖袋口及袖袋盖，转角，首尾回针。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5157, 'ZYSZJYZH001', '合肩缝（直/20CM）1条*2', 156, 38.4000, 0.1248, 'STITCHING', NULL, b'0', '裁片平服，线迹均匀顺直；', '裁片正面相对，出入口对齐，头尾回针，沿边1CM缝合。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5158, 'ZYSZJYZH002', '压肩缝明线（直/20CM）1条*2', 156, 24.4000, 0.0793, 'STITCHING', NULL, b'0', '裁片平服，线迹均匀顺直，明线宽窄一致；', '正面压线，止口导向正确。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5159, 'ZYSZJYZH003', '上平袖（弧/72CM）1条*2连落肩章', 156, 86.9000, 0.3259, 'STITCHING', NULL, b'0', '容位均匀，左右对称，袖山圆顺；', '裁片正面在下，反面上袖，剪口对齐。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5160, 'ZYSZJYZH004', '压袖笼明线(弧/72CM）1条*2', 156, 63.6000, 0.2226, 'STITCHING', NULL, b'0', '明线线迹顺直宽窄一致，弧度圆顺。', '正面压袖笼线，止口倒向一致正确，袖盯落肩章。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5161, 'ZYSZJYZH005', '合袖底缝及摆缝(直/108CM）1条*2', 156, 103.5000, 0.3364, 'STITCHING', NULL, b'0', '裁片平服，线迹均匀顺直；', '裁片正面相对，出入口对齐，头尾回针，沿边1CM缝合；', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5162, 'ZYSZJYZH006', '压袖底缝及摆缝明线（直/108CM）1条*2', 156, 85.2000, 0.2769, 'STITCHING', NULL, b'0', '明线线迹顺直宽窄一致，裁片平服不起纽。', '正面压线，止口倒向一致正确。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5163, 'ZYSZJYZH007', '双针压腰通道明线(直/118CM）同时落里布条', 163, 68.6000, 0.2401, 'STITCHING', NULL, b'0', '左右对称，双针明线无跳针跳线线迹。', '平双针落里布条连压线，首尾回针连折止口。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5164, 'ZYSZJYZH008', '上前中挡风贴及拉链（直/80+70CM）1条*2', 156, 88.4000, 0.3315, 'STITCHING', NULL, b'0', '容位均匀，线迹顺直，裁片平服。', '左边上挡风贴（拉链已上），右边上拉链，首尾回针，右侧拉链折止口。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5165, 'ZYSZJYZH009', '合前中前中挡风贴及拉链面里（直/80CM）1条*2', 155, 93.6000, 0.3510, 'STITCHING', NULL, b'0', '容位均匀，线迹顺直，裁片平服。', '套面里，正面在下，首尾回针。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5166, 'ZYSZJYZH010', '固定袖笼里布条*2', 156, 20.5000, 0.0666, 'STITCHING', NULL, b'0', '位置准确，左右布条长度基本一致。', '回针固定', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5167, 'ZYSZJYZH011', '翻衣服连穿棉绳连穿一端卡头连打结', 15, 87.7000, 0.2192, 'STITCHING', NULL, b'0', '裁片平服，棉绳左右对称。', '手工工艺，从下脚套出。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5168, 'ZYSZJYZH012', '压前襟明线（直/80CM）1条*2', 156, 73.6000, 0.2760, 'STITCHING', NULL, b'0', '明线顺直，止口宽窄一致，无跳针跳线线迹。', '正面压双层明线，右侧转角，首尾回针。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5169, 'ZYSZJYZH013', '走定领窝面里（弧/58CM）1条*1', 156, 37.5000, 0.1219, 'STITCHING', NULL, b'0', '大身平服，上下齐位,弧度圆顺。', '正面在下，上下对齐，走定面里。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5170, 'ZYSZJYZH014', '上领（直/58CM）*1', 156, 54.1000, 0.2029, 'STITCHING', NULL, b'0', '领裁片平服，领围圆顺；', '裁片正面在上，面里领窝已固定，领与领窝正面相对，出入口对齐，沿边1CM缝合。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5171, 'ZYSZJYZH015', '折压领下沿止口（弧/50CM）1条*1', 156, 69.9000, 0.2621, 'STITCHING', NULL, b'0', '领裁片平服，领围圆顺；', '压领落坑线，首尾回针。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5172, 'ZYSZJYZH016', '卷下摆（直/140CM）1条*1及袖口（直/40CM）1条*2', 155, 194.2000, 0.7282, 'STITCHING', NULL, b'0', '裁片平服，线迹均匀顺直，止口宽窄一致；', '压下摆袖口宽明线同时走定里布，首尾回针。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5173, 'ZYSZJYZH017', '钉右前下摆魔术贴（直/2+3+2+3CM）1个*1', 156, 24.5000, 0.0796, 'STITCHING', NULL, b'0', '裁片平服，角度位置方正。', '订四方，首尾回针。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5174, 'ZYSZJYZH018', '点前襟及领子连肩章及袖口连袋口扣位（25个）', 156, 72.7000, 0.1817, 'STITCHING', NULL, b'0', '位置准确，清晰可见，不易褪色。', '手工落样点位。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5175, 'ZYSZJYZH019', '手工钉领围钮扣*5', 15, 164.6000, 0.4115, 'STITCHING', NULL, b'0', '订扣位置准确，牢固。', '手工订扣', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5176, 'ZYSZJYZH020', '扣毛领*5', 15, 29.4000, 0.0735, 'STITCHING', NULL, b'0', '裁片平服。', '手工工艺，扣扣子。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5177, 'ZYSZJYZH021', '配内胆拉上拉链', 15, 26.2000, 0.0655, 'STITCHING', NULL, b'0', '裁片平服，拉链位置对齐。', '手工工艺，拉拉链，穿袖子。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5178, 'ZYSZJYZH022', '配帽子', 15, 17.1000, 0.0428, 'STITCHING', NULL, b'0', '帽子平服，位置对正。', '手工工艺，拉帽子拉链。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5179, 'ZYSZJYZJ001', '打挡风贴套结*2', 251, 14.8000, 0.0370, 'STITCHING', NULL, b'0', '位置准确，线迹顺直。', '专机打枣', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5180, 'ZYSZJYZJ002', '打前袋口套结*8', 251, 40.4000, 0.1010, 'STITCHING', NULL, b'0', '位置准确，线迹顺直。', '半成品打枣。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5181, 'ZYSZJYZJ003', '钉帽口气眼*2', 263, 15.3000, 0.0383, 'STITCHING', NULL, b'0', '位置准确，气眼牢固。', '半成品专机工艺。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5182, 'ZYSZJYZJ004', '专机锁挡风贴平眼*5', 257, 35.0000, 0.0875, 'STITCHING', NULL, b'0', '眼位方正，不歪斜，眼位无毛线；', '半成品锁眼，对齐点位，锁眼，剪干净毛线；', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5183, 'ZYSZJYZJ005', '专机锁襟贴平眼*2', 257, 18.5000, 0.0462, 'STITCHING', NULL, b'0', '眼位方正，不歪斜，眼位无毛线；', '半成品锁眼，对齐点位，锁眼，剪干净毛线；', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5184, 'ZYSZJYZJ006', '专机锁袋盖平眼*5', 257, 40.5000, 0.1013, 'STITCHING', NULL, b'0', '眼位方正，不歪斜，眼位无毛线；', '半成品锁眼，对齐点位，锁眼，剪干净毛线；', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5185, 'ZYSZJYZJ007', '专机锁肩章平眼*2', 257, 16.2000, 0.0405, 'STITCHING', NULL, b'1', '眼位方正，不歪斜，眼位无毛线；', '半成品锁眼，对齐点位，锁眼，剪干净毛线；', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5186, 'ZYSZJYZJ008', '专机锁翻领平眼*5', 257, 35.0000, 0.0875, 'STITCHING', NULL, b'1', '眼位方正，不歪斜，眼位无毛线；', '半成品锁眼，对齐点位，锁眼，剪干净毛线；', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5187, 'ZYSZJYZJ009', '专机钉袋口钮扣*6', 263, 53.4000, 0.1335, 'STITCHING', NULL, b'0', '位置准确，牢固。', '半成品订扣，对齐点位。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5188, 'ZYSZJYZJ012', '专机钉翻领钮扣*5', 263, 39.9000, 0.0997, 'STITCHING', NULL, b'1', '位置准确，牢固。', '半成品订扣，对齐点位。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5189, 'ZYSZJYZJ013', '专机钉肩章袖袢钮扣*4', 263, 35.6000, 0.0890, 'STITCHING', NULL, b'1', '位置准确，牢固。', '半成品订扣，对齐点位。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5190, 'ZYSZJYZJ014', '专机钉前襟钮扣*5', 263, 45.1000, 0.1127, 'STITCHING', NULL, b'1', '位置准确，牢固，无线毛。', '成品订扣，对准点位印。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5191, 'ZYSZKZHP001', '拔裆2条*1', 57, 12.5600, 0.0298, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5192, 'ZYSZKZHP002', '锁后裤片（直/104+79+39四线放1.2斜条）1条*2', 177, 54.8000, 0.1301, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5193, 'ZYSZKZHP003', '缝后单省（直/8cm）1*2', 156, 29.1200, 0.0692, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5194, 'ZYSZKZHP004', '量后片规格1*2', 15, 14.6400, 0.0329, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5195, 'ZYSZKZHP005', '烫后单省1*2', 160, 7.7800, 0.0194, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5196, 'ZYSZKZHP006', '开后袋1*2', 265, 41.0700, 0.0975, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5197, 'ZYSZKZHP007', '剪后袋口三角，翻烫袋牙线1*2', 160, 35.8300, 0.0896, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5198, 'ZYSZKZHP008', '暗封三角（直/2）2*2、缝下袋嵌布（直/20）1*2、钉后袋眼位（直/3）1*2', 156, 66.7700, 0.1669, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5199, 'ZYSZKZHP009', '缝后袋垫布（直/20）1*2', 156, 21.3900, 0.0508, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5200, 'ZYSZKZHP010', '缝上嵌袋布（直/20）1*2', 156, 26.2800, 0.0624, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5201, 'ZYSZKZHP011', '钉后袋套结1*2', 251, 20.9200, 0.0497, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5202, 'ZYSZKZHP012', '嵌布两端封口', 156, 20.9000, 0.0496, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5203, 'ZYSZKZHP013', '包缝后袋布（直30+20+30）1*2', 156, 79.6300, 0.1891, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5204, 'ZYSZKZHP014', '1', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5205, 'ZYSZKZHP015', '缝下袋嵌布（直/20）1*2', 156, 8.1100, 0.0193, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5206, 'ZYSZKZQP001', '缝前单省（直/10cm）1*2', 156, 33.4480, 0.0836, 'STITCHING', NULL, b'0', '前褶/省位左右对称、大小一致、缉线顺直、平服', '根据前裤片的省位刀口缝合前省，先把裤片省位刀口对折，门、里襟方向高出0.1cm', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5207, 'ZYSZKZQP002', '量前片规格1*2', 15, 14.5600, 0.0364, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5208, 'ZYSZKZQP003', '锁前袋垫布（直/6cm）1条*2', 171, 11.9200, 0.0298, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5209, 'ZYSZKZQP004', '锁前袋口垫布（直/6cm）1条*2', 171, 11.9200, 0.0298, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5210, 'ZYSZKZQP005', '锁里襟（直/20cm）1*2', 171, 13.6500, 0.0341, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5211, 'ZYSZKZQP006', '缝前袋垫布明线（直/30cm）1条*2', 156, 25.1100, 0.0596, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5212, 'ZYSZKZQP007', '绱前袋布（直18cm）1条*2', 156, 23.9100, 0.0568, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5213, 'ZYSZKZQP008', '烫前袋止口连打刀口1条*2', 19, 27.2900, 0.0682, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5214, 'ZYSZKZQP009', '压前袋口垫布连袋口0.6明线（直/21cm/直18cm）1条*2', 156, 34.9500, 0.0830, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5215, 'ZYSZKZQP010', '钉前袋口套结2个*2', 251, 20.6800, 0.0491, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5216, 'ZYSZKZQP011', '定缝袋口、褶位（直/5+12cm）连画袋口垫布位1条*2', 156, 66.2400, 0.1490, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5217, 'ZYSZKZQP012', '缝合前袋布（弯/28cm）1条*2', 180, 21.3200, 0.0746, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5218, 'ZYSZKZQP013', '切前裤里1条*2', 287, 12.4100, 0.0310, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5219, 'ZYSZKZQP014', '附前裤里（直/5+14+20cm）1条*2', 243, 38.0000, 0.0902, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5220, 'ZYSZKZQP015', '锁前裤片（直/115+25+86四线放1.2斜条）1条*2', 177, 56.9000, 0.1991, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5221, 'ZYSZKZQP016', '绱门襟连绱门襟拉链（直/20+20+18+18cm）1条*1', 156, 36.7100, 0.0918, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5222, 'ZYSZKZQP017', '绱门襟连绱门襟拉链（直/20+20+18+18cm）1条*1', 156, 36.3200, 0.0908, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5223, 'ZYSZKZQP018', '缝合里襟（弯/21cm）1条*1', 156, 12.8100, 0.0304, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5224, 'ZYSZKZQP019', '整烫里襟1条*1', 19, 14.4200, 0.0360, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5225, 'ZYSZKZQP020', '绱里襟拉链（直/20cm）1条*1', 156, 11.2700, 0.0268, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5226, 'ZYSZKZYT001', '合缝裤腰（直/55cm）1条*2', 156, 30.9600, 0.0735, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5227, 'ZYSZKZYT002', '合缝宝剑头（直/10+4+4+10cm）1条*1', 156, 22.5400, 0.0535, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5228, 'ZYSZKZYT003', '钉商标（直/2+2cm）1条*1', 156, 15.8200, 0.0395, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5229, 'ZYSZKZYT004', '钉洗水唛（直/7cm）1条*1', 156, 9.2600, 0.0208, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5230, 'ZYSZKZZH001', '缝合内/外侧缝（弯110+86cm）1条*2', 201, 116.4200, 0.4075, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5231, 'ZYSZKZZH002', '绱里襟（直/20cm）1条*1', 156, 14.1400, 0.0336, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5232, 'ZYSZKZZH003', '缝前裆缝（弯/10cm）1条*1', 156, 16.7300, 0.0397, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5233, 'ZYSZKZZH004', '压里襟明线（直/19cm)1条*1', 156, 11.5100, 0.0273, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5234, 'ZYSZKZZH005', '缝裤袢（直/60cm）及剪裤袢1条*6个', 290, 16.7100, 0.0418, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5235, 'ZYSZKZZH006', '绱裤腰/放裤袢（直/5+55+55cm）1条*1连打剪口2个*1', 156, 115.2100, 0.4032, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5236, 'ZYSZKZZH007', '钉裤钩1条*1付', 273, 24.0400, 0.0571, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5237, 'ZYSZKZZH008', '门襟包边（弯/25cm）1条*1', 169, 12.8600, 0.0305, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5238, 'ZYSZKZZH009', '接缝宝剑头及里襟腰头（直/7+8+1+8cm）1条*1*修剪宝剑头与里襟', 156, 41.0900, 0.0976, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5239, 'ZYSZKZZH010', '翻宝剑头及里襟腰头1条*1', 15, 17.6200, 0.0440, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5240, 'ZYSZKZZH011', '烫宝剑头及里襟腰头连倒烫腰头缝1条*1', 19, 40.1300, 0.0953, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5241, 'ZYSZKZZH012', '定缝后袋布（直/18cm）1条*2', 156, 13.8500, 0.0312, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5242, 'ZYSZKZZH013', '车里襟里布封口（直/20cm）1条*1', 156, 19.5500, 0.0464, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5243, 'ZYSZKZZH014', '钉缝裤袢（暗线/2道）1条*6个', 290, 47.8300, 0.1554, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5244, 'ZYSZKZZH015', '车宝剑头封口（直/3.3cm）1条*1', 156, 12.3500, 0.0293, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5245, 'ZYSZKZZH016', '压门襟装饰线（直/15cm+弯6cm）1条*1', 156, 25.6300, 0.0609, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5246, 'ZYSZKZZH017', '缝合后裆缝（弧/45cm）1条*1', 202, 33.1700, 0.1161, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5247, 'ZYSZKZZH018', '分烫后裆缝及后腰中缝1条*1', 19, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5248, 'ZYSZKZZH019', '缝垫裆布（直/6cm+6cm）1条*1', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5249, 'ZYSZKZZH020', '翻垫裆布1条*1', 15, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5250, 'ZYSZKZZH021', '烫垫裆布1条*1', 19, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5251, 'ZYSZKZZH022', '折缝后腰里缝（直/5cm）1条*1', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5252, 'ZYSZKZZH023', '绱及定点垫布（直/2cm）1条*1+三处定点', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5253, 'ZYSZKZZH024', '门里襟定点（直/1cm）1条*1', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5254, 'ZYSZKZZH025', '钉缝裤袢（明线1道）1条*6', 290, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5255, 'ZYSZKZZH026', '缲缝腰里衬（直/55cm+55cm)1条', 237, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5256, 'ZYSZKZZH027', '点缝腰里1条*10', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5257, 'ZYSZNFDC001', '走定2标(直/3CM)*1(折叠1标)', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'1', '平顺,不歪斜.', '标与标对齐,距边0.5CM进行车缝,首尾回针.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5258, 'ZYSZNFDG004', '刀车切修袋盖(方角/26CM)1个*2', 167, 21.4000, 0.0535, 'STITCHING', NULL, b'1', '平顺,止口均匀.#line#', '以领车缝线为准保留0.6CM止口,均匀顺形切去三方多余的止口.#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5259, 'ZYSZNFDG005', '刀车落样走定袋盖实样线(直/16CM)1条*2#line#', 166, 17.7000, 0.0398, 'STITCHING', NULL, b'1', '平服，不反翘.', '摆平袋盖,车台定位走袋盖实样线.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5260, 'ZYSZNFDG006', '模板缉转袋盖(方角/26CM)1个*2', 156, 50.6000, 0.1644, 'STITCHING', NULL, b'1', '平服，线迹均匀，宽窄一至.', '取模版打开后,先取领里与模版配对,然后取面领以正面对正面的方式放置里领上与之配对,出入口齐,关上模版,将模版对准压脚槽后,沿槽进行车缝.#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5261, 'ZYSZNFDG007', '烫定袋盖(方角/26CM）1个*2连翻袋盖', 19, 43.2000, 0.1080, 'STITCHING', NULL, b'1', '角位对称、止口无外露.#line#', '首先将袋盖翻至正面，然后沿止口边沿定型，温度适度.#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5262, 'ZYSZNFGM001', '收前里胸省连腰省（直/10+26cm)1条*2', 156, 34.1100, 0.1109, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5263, 'ZYSZNFGM002', '拼缝挂面（弯/60cm)1条*2', 156, 38.5400, 0.1349, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5264, 'ZYSZNFGM003', '整烫挂面拼缝连胸腰省1条*2', 19, 14.5800, 0.0474, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5265, 'ZYSZNFGM004', '缝合里插袋布1*2', 156, 24.3800, 0.0853, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5266, 'ZYSZNFGM005', '烫里插袋口1个*1', 19, 6.3200, 0.0205, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5267, 'ZYSZNFGM006', '打里袋口套结2*1', 251, 14.1900, 0.0461, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5268, 'ZYSZNFGM007', '挂面贡针（弯/60cm）1条*2', 234, 33.8500, 0.1185, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5269, 'ZYSZNFHP001', '合后中缝(直/62CM)1条*1', 156, 26.3500, 0.0626, 'STITCHING', NULL, b'1', '平服，线迹均匀，宽窄一致.#line#', '出入口齐，大片在下，小片在上，正面与正面上下对齐留1CM止口开始车缝，头尾回针.#line#', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5270, 'ZYSZNFHP002', '烫后刀背缝（弧/50CM）2条*1', 19, 17.6500, 0.0397, 'STITCHING', NULL, b'1', '平服,不可要有烫痕.', '摆平后片,拔开止口,取烫斗对准开始烫形.摆平袖窿及后领窝，取衬条与之配对，边缘平齐.摆平后下摆,取纸板与后下摆配对,开始折烫形，温度适度.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5271, 'ZYSZNFHP003', '归拔后片*2#line#', 59, 16.4400, 0.0370, 'STITCHING', NULL, b'1', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5272, 'ZYSZNFHP004', '合后刀背缝(弧/50CM)2条*1', 156, 46.6800, 0.1634, 'STITCHING', NULL, b'1', '平服，线迹均匀，宽窄一致.#line#', '出入口齐，大片在下，小片在上，正面与正面上下对齐留1CM止口开始车缝，头尾回针.#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5273, 'ZYSZNFHP005', '烫后中缝(直/62CM)1条*1', 19, 14.2500, 0.0321, 'STITCHING', NULL, b'1', '平服,不可要有烫痕.', '摆平后片,拔开止口,取烫斗对准开始烫形.摆平袖窿及后领窝，取衬条与之配对，边缘平齐.摆平后下摆,取纸板与后下摆配对,开始折烫形，温度适度.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5274, 'ZYSZNFHP006', '合后里中缝(转角/60+4CM)1条*1', 156, 23.6900, 0.0563, 'STITCHING', NULL, b'1', '平服，线迹均匀，宽窄一致.#line#', '出入口齐，大片在下，小片在上，正面与正面上下对齐留1CM止口开始车缝，头尾回针.#line#', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5275, 'ZYSZNFHP007', '烫后里中缝(直/62CM)1条*1', 19, 9.9600, 0.0224, 'STITCHING', NULL, b'1', '平服,不可要有烫痕.', '摆平后片,拔开止口,取烫斗对准开始烫形.摆平袖窿及后领窝，取衬条与之配对，边缘平齐.摆平后下摆,取纸板与后下摆配对,开始折烫形，温度适度.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5276, 'ZYSZNFHP008', '拉后领口牵带（弧/20CM）1条*1', 156, 13.8800, 0.0312, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5277, 'ZYSZNFHP009', '拉后袖窿牵带（弧/22CM）1条*2', 156, 34.8900, 0.0785, 'STITCHING', NULL, b'1', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5278, 'ZYSZNFHP010', '修剪后背里刀缝（90CM）2条*1', 15, 37.0300, 0.0879, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5279, 'ZYSZNFHP011', '烫后里刀背缝（弧/50CM）2条*1', 19, 12.4700, 0.0281, 'STITCHING', NULL, b'1', '刀缝熨烫平顺，无拉开现象。', '后背里反面朝上，领圈朝左，平放于烫台上，抚顺刀缝，进行吸风将刀缝向后片倒烫平整', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5280, 'ZYSZNFHP012', '合后里刀背缝(弧/50CM)2条*1', 156, 40.2800, 0.1410, 'STITCHING', NULL, b'1', '平服，线迹均匀，宽窄一致.#line#', '出入口齐，大片在下，小片在上，正面与正面上下对齐留1CM止口开始车缝，头尾回针.#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5281, 'ZYSZNFHP013', '修剪后背里（50CM）2条*2', 15, 29.0700, 0.0690, 'STITCHING', NULL, b'1', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5282, 'ZYSZNFHP014', '拔袖*2', 59, 15.3900, 0.0539, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5283, 'ZYSZNFHP016', '归拔后片*2（18秒）#line#', 59, 16.4400, 0.0370, 'STITCHING', NULL, b'1', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5284, 'TXML001', '上吊挂', 2, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5285, 'TXDG001', '上吊挂', 2, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5286, 'TXML002', '', 62, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', '三星', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5287, 'ZYSZNFKD002', '开大袋1*2', 265, 42.0500, 0.1472, 'STITCHING', NULL, b'0', '1：开袋缝制平顺、起、止处回针密密缝，袋盖宽度一致。#line#2：条格面料与前身丝对准。', '缝制操作：#line#    1：在开袋前，先将袋位画好（根据口袋定位板）。#line#    2：袋盖规格根据工艺单。#line#    3：开袋前按照规格调好尺寸；前开袋机上的光标对准袋位A、B，袋口前端与大身丝#line#       绺对直 ，抚平衣片，压住压脚，放入嵌线、袋盖，送入开袋机进行开袋。#line#    4：对条对格时，前端袋口C、D 点与前身片的上、下、左、右丝绺对准。#line#       注：袋位以袋口宽为中（如图三）。#line#    #line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5288, 'ZYSZNFLB001', '合里袖侧缝及袖底缝（直/50+45CM)1条*2(左袖留口）', 156, 75.6000, 0.2457, 'STITCHING', NULL, b'1', '平服，线迹均匀，宽窄一致.', '出入口齐,取大袖正面向上，取小袖以正面对正面的方式与大袖配对后放入压脚下，头尾回针，止口1CM.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5289, 'ZYSZNFLB002', '烫倒里袖侧缝及袖底缝(56+45CM)2条*2', 19, 24.0000, 0.0600, 'STITCHING', NULL, b'1', '平服,不可有烫痕.', '取里袖后将袖缝整理平服，然后取烫斗进行熨烫，温度适度', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5290, 'ZYSZNFLB004', '烫倒里布大身9条缝(前腰省:25CM、后中：52CM、后侧缝40、小肩12CM、摆缝45CM)', 19, 36.4000, 0.0819, 'STITCHING', NULL, b'1', '平服,不可有烫痕.', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5291, 'ZYSZNFLB005', '落样点里前腰省5点*2(两头尖)', 15, 29.4000, 0.0735, 'STITCHING', NULL, b'1', '点位与纸板一致，无偏移现象.#line#', '摆平里前片,反面朝上,然后取纸板与其配对，边沿与纸板对齐，按纸板点位.#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5292, 'ZYSZNFLB006', '落样收里前腰省(直/26CM)1条*1(两头尖)', 156, 34.5000, 0.0819, 'STITCHING', NULL, b'1', '平服,省尖不可有酒窝.', '摆平里布,折叠省位及调整止口,反面朝上.', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5293, 'ZYSZNFLB007', '合里后中(直/52CM)1条*1及后侧缝(弯/40CM)2条*1', 156, 56.1000, 0.1332, 'STITCHING', NULL, b'1', '平服，线迹均匀，宽窄一致#line#', '出入口齐，大片在下，小片在上，正面与正面上下对齐留1CM止口开始车缝，首尾回针#line#', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5294, 'ZYSZNFLB008', '合里布肩摆缝（直/12+45CM）4条*1同时落洗标', 156, 65.2000, 0.2119, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5295, 'ZYSZNFLB009', '合襟贴面里（弧/60CM）1条*2', 156, 63.2000, 0.2054, 'STITCHING', NULL, b'1', '', '双手取里前片，然后取襟贴与其配对，出入口齐，首尾回针，按1CM止口进行车缝。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5296, 'ZYSZNFLB011', '上里圆袖（弧/54CM）2只*1同时落里布条4个*1', 156, 120.8000, 0.4228, 'STITCHING', NULL, b'1', '线迹一致，衣身及袖子均无打折现象，止口一致#line#', '取衣身调整至袖笼位后，再双手取袖子直接配对，首尾不回针，结束重针，车缝过程中需注意肩缝的刀口位，止口保持1CM进行车缝；#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5297, 'ZYSZNFLZ001', '拼接底领(直/10CM)1条*1', 156, 10.5600, 0.0264, 'STITCHING', NULL, b'1', '平服,线迹均匀,宽窄一致.', '出入口对齐,正面与正面相对,沿止口车缝,头尾回针.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5298, 'ZYSZNFLZ002', '烫开底领拼接（直/10CM)1条*1#line#', 19, 6.0700, 0.0152, 'STITCHING', NULL, b'1', '平服,不可有烫痕.', '摆平底领,拔开止口,温度适度.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5299, 'ZYSZNFLZ003', '模板运返领(方角/4+40+4CM)1条*1', 156, 28.4200, 0.0924, 'STITCHING', NULL, b'1', '平服,线迹均匀，宽窄一致.', '取模板打开后,先取领里与模版配对,然后领面以正面对正面的方式放置领里上与之配对,出入口齐,关上模版,将模版对准压脚槽后,沿槽进行车缝.#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5300, 'ZYSZNFLZ004', '刀车切修领大小止口(方角/4+40+4CM）1条*1连手工修剪领角2个*1', 167, 17.0000, 0.0425, 'STITCHING', NULL, b'1', '止口一致,领面保留0.6-0.7CM止口,领底保留0.3-0.4CM止口.#line#', '将缝份打开,以领线为准领面留0.6-0.7cm,领底留0.3-0.4cm,均匀顺形切去三方多余的止口.#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5301, 'ZYSZNFLZ005', '缉领暗线(弯/30CM)1条*1', 156, 15.9100, 0.0378, 'STITCHING', NULL, b'1', '平服，线迹均匀,止口一止.', '打开领子,抚平领子,正面在上，沿边距缉0.1暗线,首尾回针.#line#', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5302, 'ZYSZNFLZ006', '烫定领子(方角/5+40+4CM)1条*1', 19, 23.9300, 0.0778, 'STITCHING', NULL, b'1', '平服,不可反止口,不可有烫痕.#line#', '摆平领子,领面朝上,调整握取止口开始烫形,温度适度.#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5303, 'ZYSZNFLZ007', '刀车切修领下缘(弯/40CM)1条*1', 167, 8.4700, 0.0212, 'STITCHING', NULL, b'1', '无偏移现象，纹路顺直.', '摆平领子,留上领止口外,其余止口修剪掉.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5304, 'ZYSZNFLZ008', '落样点上领位3点*1', 15, 12.2900, 0.0277, 'STITCHING', NULL, b'1', '对位准确,不可有移位.#line##line#', '摆平领子,取纸板与领子配对开始点位.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5305, 'ZYSZNFLZ009', '画领面及领脚（85+65CM）', 15, 10.1800, 0.0229, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5306, 'ZYSZNFMD001', '#line##line##line#缝制操作：#line#    1：根据袋盖的规格选择相应的模具，#line#    2：将里布的正面朝上、前头A端的直纱对准模具E端丝绺摆平。(如图一）#line#    3：将袋盖的面料反面朝上，前头B端对准模具E端丝绺摆平，盖下模具，然后缝合。#line#    4：缝合后在袋盖前端布边剪一刀口作为袋盖的前端标记。（如图二）#line#  袋盖的对条对格#line#    1：先在前身片上距胸省1.5cm画出袋盖前端位置（如图三C）。#line#    2：根据前身片上的定位，在袋盖面布上确定前端摆放位置模具上  D。#line#注：特殊款式按工艺要求操作。#line#       #line#    #line##line##line##line#缝制操作：#line#    1：根据袋盖的规格选择相应的模具，#line#    2：将里布的正面朝上、前头A端的直纱对准模具E端丝绺摆平。(如图一）#line#    3：将袋盖的面料反面朝上，前头B端对准模具E端丝绺摆平，盖下模具，然后缝合。#line#', 166, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5307, 'ZYSZNFMD003', '剪袋口三角1*2', 161, 30.5400, 0.0993, 'STITCHING', NULL, b'0', '1：开口剪平顺，三角准确到位，袋角无破出现象。', '#line#缝制操作：#line#    1：两线取中剪开，距袋角约1.0cm处剪三角，刀口距起、止线头  约0.1cm 。（如图）    #line#    #line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5308, 'ZYSZNFQP002', '归拔前片及侧片*2#line#2的、', 19, 65.8000, 0.1480, 'STITCHING', NULL, b'1', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5309, 'ZYSZNFQP003', '合前公主缝(弯/60CM)1条*2连打剪口6个*2#line#', 156, 74.2000, 0.1762, 'STITCHING', NULL, b'1', '平服，线迹顺直，宽窄一致.#line#', '出入口齐，前大片在下，前小片在上，正面与正面上下对齐留1CM止口开始车缝，头尾回针.#line#', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5310, 'ZYSZNFQP004', '烫开前公主缝(弯60/cm)1条*2连烫袖窿衬条(弯/26CM)1条*2连落样扣烫前下摆(直/30CM)1条*2', 19, 57.8000, 0.1445, 'STITCHING', NULL, b'1', '平复,不可有烫痕.', '摆平前片,拔开前公主缝止口,取烫斗对准开始烫形.摆平袖窿，取衬条与之配对，边缘平齐.摆平前下摆,取纸板与前下摆配对,开始折烫形，温度适度.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5311, 'ZYSZNFQP005', '落样点前片双唇袋位4点*2', 15, 30.1000, 0.0752, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5312, 'ZYSZNFQP006', '模板落双袋唇(直/15CM)2条*2同时落袋布及袋盖', 156, 75.4000, 0.2450, 'STITCHING', NULL, b'1', '线迹均匀顺直，袋唇或袋布不歪斜；', '打开模板和夹层，双手取大身与模板尺码线对齐，关上夹层，双手取袋唇和袋布与压脚配对，关上模板，沿槽缉转，头尾回针，头尾剪线；', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5313, 'ZYSZNFQP007', '折烫双袋唇(直/14CM)1条*2#line#', 19, 11.0000, 0.0275, 'STITCHING', NULL, b'1', '平服,不可有烫痕.', '折叠摆平双袋唇,取烫斗烫形,温度适度.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5314, 'ZYSZNFQP008', '剪开袋口（直/18CM）1条*2连封三角(直/2CM)*2', 156, 93.3000, 0.3265, 'STITCHING', NULL, b'1', '三角位无毛口或未剪到位现象。#line#', '取前片后，将袋口中间对折剪开，然后依次剪开一端，并剪开三角，然后调整至另一端在依次剪开中间，然后剪开三角；四个角位保留一根纱#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5315, 'ZYSZNFQP009', '烫前袋口衬(直/18CM)1条*2#line#', 19, 19.3000, 0.0434, 'STITCHING', NULL, b'1', '不起泡,不起皱.', '摆平前片,在开袋位反面烫衬.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5316, 'ZYSZNFQP010', '烫平前袋口(直/14CM)1条*2#line#', 19, 13.6000, 0.0306, 'STITCHING', NULL, b'1', '平服,不可有烫痕.', '摆平前片袋口位开始烫形.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5317, 'ZYSZNFQP011', '缉转袋布（方角/45CM）1条*2同时落里布条1条*2', 156, 55.3000, 0.1797, 'STITCHING', NULL, b'1', '线迹均匀，止口一致', '取前片后正面向上摆放，翻起前片抚平袋布后放入压脚下，首尾回针，中间车缝止口为1CM,缝至袋布下端处同时放里布条。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5318, 'ZYSZNFQP013', '模板缉转门襟(上下方角/65CM)1条*2', 156, 68.3000, 0.2220, 'STITCHING', NULL, b'1', '平服,角位圆顺,止口一止.', '取模版打开后，先取门襟贴与模版配对，然后取驳头面以正面对正面的方式放置门襟贴上与之配对，再取前片正面与驳头配对,出入口齐，关上模版，将模版对准压脚槽后，沿槽进行车缝.#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5319, 'ZYSZNFQP014', '刀车切修门襟（上下方角/5+50+10CM）1条*2', 167, 28.0000, 0.0700, 'STITCHING', NULL, b'1', '止口均匀', '以门筒暗线为准保留0.6CM止口,均匀顺形切去三方多余的止口#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5320, 'ZYSZNFQP015', '烫定门襟（上下方角/5+50+10CM）1条*1连翻', 19, 61.1000, 0.1986, 'STITCHING', NULL, b'1', '平服,不可反止口,不可有烫痕.#line#', '摆平前襟，正面朝上，烫定门襟止口,温度适度#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5321, 'ZYSZNFQP016', '缉门襟暗线(直/12+20CM)1条*2', 156, 41.1000, 0.0976, 'STITCHING', NULL, b'1', '平服，线迹均匀,宽窄一致.', '打开前襟,抚平驳头及前中,正面在上，沿边距缉0.1暗线,首尾回针.#line#', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5322, 'ZYSZNFQP017', '烫前襟衬(上下方角/65CM)1条*2及驳头衬(直/25CM)1条*2#line#', 19, 36.6000, 0.0823, 'STITCHING', NULL, b'1', '不起泡,不起皱.', '摆平前片,在开袋位反面烫衬.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5323, 'ZYSZNFXZ002', '落样扣烫大小袖衩及袖口*2', 19, 62.5000, 0.2031, 'STITCHING', NULL, b'1', '后贴袋裁片平服，角位方正，', '裁片反面在上，净纸板对齐贴袋上端，折叠毛缝，扣烫后贴袋；', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5324, 'ZYSZNFXZ003', '缉转大小袖衩连修剪连翻(直/4+4CM)*2（三角叉 大袖三角，小袖直接打底）', 156, 85.4000, 0.2775, 'STITCHING', NULL, b'1', '平服,左右叉位高低一致.', '摆平袖子,分别取袖叉折叠进行车缝,首尾回针.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5325, 'ZYSZNFXZ004', '合袖侧缝(直/50CM)1条*2连留衩', 156, 46.0000, 0.1495, 'STITCHING', NULL, b'1', '平服,线迹顺直,宽窄一致.#line#', '出入口齐,大袖片在下,小袖片在上,正面与正面上下对齐留1CM止口开始车缝,首尾回针.#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5326, 'ZYSZNFXZ005', '烫开袖侧缝(直/50CM)1条*2', 19, 24.2000, 0.0605, 'STITCHING', NULL, b'1', '平复,不可有烫痕.', '摆平袖,拔开袖侧缝止口,取烫斗对准开始烫形,温度适度.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5327, 'ZYSZNFXZ006', '合袖底缝(直/50CM)1条*2', 156, 48.2000, 0.1566, 'STITCHING', NULL, b'1', '平服,线迹均匀,宽窄一致.#line#', '出入口齐，同时取袖口两端正面与正面上下对齐留1CM止口开始车缝，头尾回针.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5328, 'ZYSZNFXZ007', '烫开袖底缝(直/50CM)1条*2', 19, 24.6000, 0.0615, 'STITCHING', NULL, b'1', '止口平复，无烫痕.', '取袖子后，双手由两端同时打开袖口及袖笼口，然后将袖子整理平顺后，拨开缝份，依次烫开，温度适度', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5329, 'ZYSZNFXZ008', '走缩袖山（弧/15CM）1条*2', 156, 18.5000, 0.0601, 'STITCHING', NULL, b'1', '缩褶均匀', '取袖子将袖山刀口位对准压脚下，首尾无需回针，按0.5CM止口走缩', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5330, 'ZYSZNFXZ009', '烫平袖山(弧/15CM)1条*2#line#', 19, 16.8000, 0.0378, 'STITCHING', NULL, b'1', '熨烫均匀、平滑、使袖山圆顺饱满、无烫痕.', '将缩缝后的袖山头放在铁凳上，摆平袖山，开始烫形，温度适度.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5331, 'ZYSZNFXZ010', '归拔大袖片*2#line#', 19, 17.3000, 0.0432, 'STITCHING', NULL, b'1', '平服,无烫痕.', '摆平大袖片,依弧度进行拔烫,温度适度.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5332, 'ZYSZNFXZ011', '合袖口面里(直/30CM)1条*2', 156, 70.3000, 0.2285, 'STITCHING', NULL, b'1', '纹路顺直，止口一致.', '将袖面与袖里正面相对套合在一起,对齐袖口,袖面和袖里缝后,合袖口一周.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5333, 'ZYSZNFXZ012', '手工撬袖口(直/30CM)1条*2', 15, 120.7000, 0.3017, 'STITCHING', NULL, b'1', '平服,手缝均匀,不起吊.', '摆平袖口,依面里松份进行手工缝.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5334, 'ZYSZNFXZ013', '烫平袖口面里(直/30CM)1条*2#line#', 19, 16.4000, 0.0369, 'STITCHING', NULL, b'1', '平服,不可有烫痕.', '摆平前片袋口位开始烫形.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5335, 'ZYSZNFXZ014', '手工修剪袖山面里(弯/15CM）1条*2', 15, 19.8000, 0.0495, 'STITCHING', NULL, b'1', '纹路顺直.', '取袖子摆平车台,摆平袖山面里,修剪余缝份.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5336, 'ZYSZNFZH001', '合肩缝及摆缝（直/14+50CM）4条*1', 156, 73.1600, 0.2378, 'STITCHING', NULL, b'1', '平服，线迹顺直，宽窄一致.', '出入口齐,将后片正面朝上摆放，取前片正面与后片正面相对车缝，首尾回针.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5337, 'ZYSZNFZH002', '烫开肩缝及摆缝（直/14+50CM）4条*1', 19, 23.1000, 0.0577, 'STITCHING', NULL, b'1', '平服,无烫痕.', '摆平衣身，将缝份分缝烫开，温度适度.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5338, 'ZYSZNFZH003', '上领连修剪领脚缝份(弯/7+35+7CM)2条*1(连续性转角）', 156, 180.8000, 0.6328, 'STITCHING', NULL, b'1', '平服,止口一致,领围圆顺,左右对称.', '出入口齐,大身领围在下、正面朝上,领子在上、反面朝上,分别对齐肩位、后中位刀口均匀车缝0.8CM止口,首尾回针.', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5339, 'ZYSZNFZH005', '烫开领穴(弯/8+40+8CM)2条*2#line#', 19, 44.7000, 0.1006, 'STITCHING', NULL, b'1', '平服,不可有烫痕.', '摆平大身,拔开领两端及领围止口烫形,温度适度.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5340, 'ZYSZNFZH006', '上圆袖（弧/50CM）2只*1', 156, 123.8000, 0.4642, 'STITCHING', NULL, b'1', '线迹一致，容位均匀，衣身及袖子均无打折现象，止口一致.#line#', '取衣身调整至袖笼处，再双手取袖子直接配对，首尾不回针，结束重针，车缝过程中需注意肩缝的刀口位，止口保持1CM进行车缝，上下放平车缝，肩缝居中5公分平行车缝，5公分以外的左右部位衣身稍带紧，防止吃势，袖子边沿则向前推进.', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5341, 'ZYSZNFZH007', '烫袖围(弯/50CM)2条*1  #line#', 19, 33.0000, 0.0742, 'STITCHING', NULL, b'1', '平服,不可有烫痕.', '正面朝上顺形摆放至压烫机上,温度适度.#line#', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5342, 'ZYSZNFZH008', '落袖围棉条(弯/30CM)2条*1', 156, 61.2000, 0.1454, 'STITCHING', NULL, b'1', '平服,不可起皱.', '摆平衣身,将棉条上的标记与肩缝对齐,使前后位置准确,棉条边与袖围边对齐,首尾回针.', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5343, 'ZYSZNFZH009', '烫平棉条(弯/30CM)2条*1  #line#', 19, 32.7000, 0.0736, 'STITCHING', NULL, b'1', '平服,不可有烫痕.', '正面朝上顺形摆放至压烫机上,温度适度.#line#', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5344, 'ZYSZNFZH010', '手工落垫肩(弯/30CM)2个*1', 15, 125.2000, 0.3130, 'STITCHING', NULL, b'1', '平服,左右一致,不起皱.', '摆平衣身,抚平袖窿,取垫肩与袖窿配对,松紧适度,进行手缝.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5345, 'ZYSZNFZH013', '合下摆面里（直/90CM）*1连固定下摆缝位7点连固定小肩里布条2点*1', 156, 131.3000, 0.4595, 'STITCHING', NULL, b'1', '下摆止口一致，松紧适应，面里下摆无错位现象.', '摆平衣身,取里布正面与面布正面相对，出入口齐，每个起针及结束后都需回针，沿止口1CM车缝.', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5346, 'ZYSZNFZH016', '封袖口（直/15CM）*1翻袖', 156, 19.9000, 0.0647, 'STITCHING', NULL, b'1', '上下止口一致，线迹一致.', '取衣身后找到袖口位，将止口调整好后放入压脚下，首尾回针，止口0.15CM，剪线.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5347, 'ZYSZNFZH017', '翻衣服*1', 15, 44.5000, 0.1112, 'STITCHING', NULL, b'1', '', '取衣身找到袖口打开后，手移位下摆角位开始向外翻出，左袖翻至反面方面封袖口', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5348, 'ZYSZNFZH018', '合领3端(弯/3+28+3CM)1条*1', 156, 64.1000, 0.2243, 'STITCHING', NULL, b'1', '面里平复，止口一致，肩缝及后中无错误现象。', '取衣身找到领口处，将两边的止口外层对齐后放入压脚下，首尾回针，沿上领线内0.15进行车缝，需对肩缝及后领中', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5349, 'ZYSZNFZJ001', '落样点前襟风眼位4点*1', 15, 15.9000, 0.0397, 'STITCHING', NULL, b'1', '门里襟无高低，点位清晰，不歪斜.', '前襟正面平服在上，调整门里襟对齐，取纸板比齐门襟，点门襟风眼位.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5350, 'ZYSZNFZJ003', '打门襟风眼套结2个*1', 260, 20.0000, 0.0650, 'STITCHING', NULL, b'1', '', '正面在上，移致压脚,踩动机器.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5351, 'ZYSZNFZJ004', '专机锁前襟凤眼2个*1', 260, 20.0000, 0.0500, 'STITCHING', NULL, b'1', '线迹良好', '取挡风贴将凤眼位精准对准机器开始锁眼，开始打第二个时则剪第一个的线头。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5352, 'ZYSZNFZJ006', '落样点前襟扣位2点*1', 15, 12.8000, 0.0320, 'STITCHING', NULL, b'1', '点位与实样一致，无偏移现象.', '取衣身将点位处抚平后，取纸板配对，按纸板进行点位，结束后摆放纸板.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5353, 'ZYSZNFZJ007', '专机钉前襟钮扣2个*1', 261, 11.3000, 0.0367, 'STITCHING', NULL, b'1', '线迹牢固，线迹不可超过0.1CM.', '前中平服，对点号位移进压脚下，踩动机器自动循环并断线，剪线.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5354, 'ZYSZNFZJ008', '专机绕脚2个*1', 252, 8.7000, 0.0283, 'STITCHING', NULL, b'1', '线迹牢固.', '前中平服，取扣对点号位移进压脚下，踩动机器自动循环并断线，剪线.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5355, 'ZYSZNKDZ001', '三线锁袋贴(直/4+22CM)1条*2', 171, 20.8000, 0.0520, 'STITCHING', NULL, b'1', '线迹均匀.', '袋贴正面在上，头尾不断线.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5356, 'ZYSZNKDZ003', '落垫布与袋布(直/20CM)1条*2(1片袋布)#line#', 156, 25.2000, 0.0819, 'STITCHING', NULL, b'1', '平服，止口一致.', '出入口对齐，将袋布反面朝上，取垫袋布正面与袋布配对，沿止口车缝.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5357, 'ZYSZNKDZ004', '烫平连烫定垫袋布(直/20CM)1条*2#line#', 19, 26.2000, 0.0589, 'STITCHING', NULL, b'1', '平服,不可有烫痕.', '摆平垫袋布烫形，将垫袋布折叠，沿边缘烫形.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5358, 'ZYSZNKDZ006', '走定垫袋布(直/20CM)1条*2（垫袋布已落在袋布上)', 156, 20.3000, 0.0660, 'STITCHING', NULL, b'1', '线迹均匀，止口一致.', '出入口对齐，将袋布反面朝上，取垫袋布正面与袋布配对，沿止口车缝.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5359, 'ZYSZNKDZ007', '缉转袋布连修剪连包光绕袋(弯/25CM)1条*2', 156, 71.0000, 0.2307, 'STITCHING', NULL, b'1', '线迹均匀，止口一致.', '将袋布折叠反面与反面对齐，沿止口车缝.修剪缝份后翻转袋布,捏平止口,开始车缝.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5360, 'ZYSZNKDZ008', '烫平袋布(弯/25CM)1条*2#line#', 19, 13.6000, 0.0306, 'STITCHING', NULL, b'1', '平服,不可有烫痕.', '摆平袋布烫形', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5361, 'ZYSZNKHP001', '三线锁后片(100+26+90+25CM)1条*2', 171, 64.9000, 0.1622, 'STITCHING', NULL, b'1', '平服，线迹均匀.', '前片正面在上，头尾不断线.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5362, 'ZYSZNKHP002', '落样点后省位12点*2', 15, 31.7000, 0.0792, 'STITCHING', NULL, b'1', '点划线迹清晰', '后片正面在上，取纸板比齐后片，点划后省，', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5363, 'ZYSZNKHP003', '落样缉后片省位(直/14CM)2个*2连手工打结2个*2', 156, 53.3000, 0.1732, 'STITCHING', NULL, b'1', '省长和省大要符合规格，省尖缉直、缉尖.', '由省根缉至省尖，省尖处留线头4CM,手工打结后剪短.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5364, 'ZYSZNKHP004', '烫平连倒后省(直/14CM)2个*2', 19, 19.9000, 0.0497, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5365, 'ZYSZNKHP005', '归拔后侧缝(直/100CM)1条*2及下档缝(直90CM)1条*2', 19, 74.0000, 0.1850, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5366, 'ZYSZNKHP006', '烫后烫迹线(直/100CM)1条*2#line#', 19, 20.2000, 0.0454, 'STITCHING', NULL, b'1', '平服,不可有烫痕.', '对折摆平单嵌线,取烫斗烫形,温度适度.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5367, 'ZYSZNKHP007', '落样点后侧袋位2点*2#line#', 15, 23.7000, 0.0533, 'STITCHING', NULL, b'1', '对位准确,不可有移位.', '摆平后片,纸板与后片布边对齐,进行点位.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5368, 'ZYSZNKKE001', '拼接裤袢*1', 156, 16.2000, 0.0405, 'STITCHING', NULL, b'1', '裁片搭接无歪斜，不爆口.', '裤袢搭接，放压脚下车缝固定，头尾回针.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5369, 'ZYSZNKKE002', '拉裤袢(直/60CM)1条*1', 187, 21.0000, 0.0525, 'STITCHING', NULL, b'1', '线迹均匀顺直.', '裁片正面在上穿过拉筒，伸手上前拉出一段，直接车缝，头尾剪断.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5370, 'ZYSZNKKE003', '手工剪量裤耳*6(车台定位)', 15, 18.6000, 0.0465, 'STITCHING', NULL, b'1', '长短一致，线迹完好，无接缝.', '裤耳比起车台定位，剪断,', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5371, 'ZYSZNKQP001', '三线锁前片(100+22+90+20CM)1条*2', 171, 63.8000, 0.1595, 'STITCHING', NULL, b'1', '平服，线迹均匀.', '前片正面在上，头尾不断线.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5372, 'ZYSZNKQP002', '缉前活褶(直/10CM)2个*2', 156, 26.0000, 0.0650, 'STITCHING', NULL, b'1', '左右活褶大小一至.', '将前片活褶对准剪口位折叠车缝，首尾不回针.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5373, 'ZYSZNKQP003', '归拔前侧缝(直/100CM)1条*2及下档缝(直90CM)1条*2', 19, 74.0000, 0.1850, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5374, 'ZYSZNKQP004', '烫前烫迹线(直/100CM)1条*2#line#', 19, 20.2000, 0.0454, 'STITCHING', NULL, b'1', '平服,不可有烫痕.', '对折摆平单嵌线,取烫斗烫形,温度适度.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5375, 'ZYSZNKQP005', '落样点前侧袋位2点*2#line#', 15, 23.7000, 0.0533, 'STITCHING', NULL, b'1', '对位准确,不可有移位.', '摆平前片,纸板与前片布边对齐,进行点位.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5376, 'ZYSZNKQP006', '三线锁前门襟(弧/15CM)1条*1及里襟(直/5+15CM)1条*1', 171, 19.0000, 0.0475, 'STITCHING', NULL, b'1', '线迹均匀，', '单牌正面在上，头尾不断线，成串剪线；#line#折叠双牌，头尾不断线，成串剪线；', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5377, 'ZYSZNKQP007', '上前中拉链双线(直/20CM)*1连合前档缝一段(弯/8CM)*1连落样压J形明线(弯/20CM)1条*1连固定1点', 156, 50.7000, 0.1648, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5378, 'ZYSZNKQP008', '单针落里襟拉链(直/15CM)1条*1', 156, 15.3000, 0.0497, 'STITCHING', NULL, b'1', '线迹均匀顺直.', '拉链反面与里襟正面锁边线对齐，头尾回针断线.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5379, 'ZYSZNKQP009', '落样缉门襟J形明线(弧/16CM)1条*1', 156, 20.6000, 0.0489, 'STITCHING', NULL, b'0', '线迹均匀，弧度圆顺.', '将里襟折向右前片，车缝门襟明线.#line#', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5380, 'ZYSZNKQP010', '合裤门襟贴(直/20CM)1条*1', 156, 15.0000, 0.0487, 'STITCHING', NULL, b'1', '平服，线迹均匀顺直.', '出入口对齐，前片在下，门襟贴在上，沿止口车缝.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5381, 'ZYSZNKQP011', '烫定前门襟(直/20CM)1条*1', 19, 8.6000, 0.0279, 'STITCHING', NULL, b'1', '平服,不可反止口,不可有烫痕.#line#', '摆平腰带,腰带面朝上,开始烫定止口,温度适度.#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5382, 'ZYSZNKQP013', '双针落门襟贴拉链(直/16CM)1条*1', 156, 14.7000, 0.0478, 'STITCHING', NULL, b'1', '线迹均匀顺直.', '将门襟贴与拉链正面相对，拉链边缘与门襟贴前口留0.5CM,另一边缉2道线.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5383, 'ZYSZNKYT001', '落样划腰头面里两端(直/6CM)2条*6连点腰头面位10点*1', 15, 86.8000, 0.2170, 'STITCHING', NULL, b'1', '线迹顺直.', '摆平腰头面里，取纸板与腰头面里边对齐，开始划号.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5384, 'ZYSZNKYT002', '拼接腰头面里(直/6CM)2条*2连修剪末端1个*2', 156, 48.8000, 0.1586, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5385, 'ZYSZNKYT003', '烫开腰头面里拼接(直/6CM)2条*2', 19, 20.7000, 0.0518, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5386, 'ZYSZNKYT004', '合腰头上沿(弯/90CM)1条*1', 156, 53.6000, 0.1273, 'STITCHING', NULL, b'1', '平服，线迹顺直，宽窄一致.#line#', '出入口齐，正面与正面上下对齐留1CM止口开始车缝，首尾回针.#line#', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5387, 'ZYSZNKYT005', '刀车切修腰头上沿缝份(弯/90CM)1条*1', 167, 15.3000, 0.0383, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5388, 'ZYSZNKYT006', '缉腰头上沿暗线(弯/80CM)1条*1', 156, 30.5000, 0.0724, 'STITCHING', NULL, b'1', '平服，线迹均匀,止口一止.', '打开腰头,抚平腰头,正面在上，沿边距缉0.1暗线,首尾回针.#line#', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5389, 'ZYSZNKYT007', '烫定腰头上沿(弯/90CM)1条*1', 19, 35.3000, 0.0882, 'STITCHING', NULL, b'1', '平服，不可有烫痕.', '摆平腰头，沿腰头边沿烫形,温度适度.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5390, 'ZYSZNKYT008', '明钉腰头主标2边同时钉尺码标1个*1(车台定位)', 156, 24.9000, 0.0809, 'STITCHING', NULL, b'1', '标方正，止口外露均匀，线头不超过0.1CM.', '腰面在上，尺码标在右侧，钉标同时钉尺码标.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5391, 'ZYSZNKYT009', '落样扣烫腰头面上下缘(弯/90+100CM）1条*1及腰头里下缘(弯/90CM)1条*2', 19, 38.4000, 0.0960, 'STITCHING', NULL, b'1', '平服,止口一致,不可有烫痕.#line#', '取腰头面里，反面向上摆放，取纸板与其配对，反折止口取烫斗进行熨烫，温度适度。#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5392, 'ZYSZNKZH001', '合侧缝(直/78+6CM)2条*1连留直插袋位连修剪缝份2个*1', 156, 89.0000, 0.3115, 'STITCHING', NULL, b'1', '平服,线迹顺直,宽窄一致.#line#', '出入口对齐,后片在下,前片在上,左片从脚口开始向侧缝袋下封缉线,右片从侧缝袋下封口开始向脚口缉线,缉线止口0.8CM.', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5393, 'ZYSZNKZH002', '烫开侧缝(84CM)2条*1连烫平袋口位*1', 19, 21.2000, 0.0530, 'STITCHING', NULL, b'1', '止口平复，无烫痕', '摆平裤身，将拼合的裁片打开，反面朝上，拨开止口，将衣缝逐渐向前分开,温度适度.#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5394, 'ZYSZNKZH003', '落直插袋袋布(直/20CM)2条*1连合另一边袋口(直/20CM)2条*1', 156, 69.5000, 0.2259, 'STITCHING', NULL, b'1', '平服，线迹均匀，宽窄一致.', '出入口对齐，将袋布袋口与前裤片侧缝袋口净线对齐，沿前裤片袋口拷边线车缝,首尾回针.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5395, 'ZYSZNKZH004', '烫平直插袋口(直/20CM)2条*1#line#', 19, 10.2000, 0.0229, 'STITCHING', NULL, b'1', '平服,不可有烫痕.', '摆平前片袋口位开始烫形.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5396, 'ZYSZNKZH005', '缉直插袋口1/4明线(1+20CM)2条*1', 156, 34.8000, 0.1131, 'STITCHING', NULL, b'1', '平服，线迹均匀，宽窄一致.', '摆平袋口,正面朝上，沿止口缉1/4明线.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5397, 'ZYSZNKZH006', '合下裆缝(直/80CM)2条*1', 156, 63.3000, 0.2215, 'STITCHING', NULL, b'1', '平服，线迹均匀，宽窄一致.', '出入口对齐，左右前后片正面相对，反面朝上，沿边止口1CM车缝,头尾回针.', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5398, 'ZYSZNKZH007', '烫开下档缝(直/80CM)2条*1', 19, 19.4000, 0.0485, 'STITCHING', NULL, b'1', '止口平复，无烫痕', '摆平裤身，将拼合的裁片打开，反面朝上，拨开止口，将衣缝逐渐向前分开,温度适度.#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5399, 'ZYSZNKZH008', '单针锁链车合前后裆缝(弧/40CM)1条*1', 201, 26.1000, 0.0848, 'STITCHING', NULL, b'1', '平服,线迹均匀,宽窄一致.', '出入口对齐，正面相对，沿边1CM缝,头尾回针.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5400, 'ZYSZNKZH009', '烫开前后档缝（直/40CM）1条*1', 19, 10.5000, 0.0262, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5401, 'ZYSZNKZH010', '钉腰围裤袢6个*1', 156, 47.1000, 0.1531, 'STITCHING', NULL, b'1', '裤耳毛缝不外落，不歪斜，线头不超过0.1CM.', '裁片和裤耳正面相对，放压脚下回针固定，缝份0.4CM,头尾剪线.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5402, 'ZYSZNKZH011', '上腰头(弧/100CM)1条*1连缉转两端(直/4CM)2个*2连修剪连翻#line#', 156, 126.9000, 0.4759, 'STITCHING', NULL, b'1', '平服,线迹均匀,宽窄一致.', '出入口对齐,将腰里的刀眼对准裤片腰节对应位置,腰里在上,裤片在下,沿止口车缝,头尾回针.', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5403, 'ZYSZNKZH012', '上腰头后包光缉暗线(弧/100CM)1条*1', 156, 166.5000, 0.5828, 'STITCHING', NULL, b'0', '平服,线迹均匀,宽窄一致.', '摆平腰头,正面朝上,沿腰缝缉暗线.', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5404, 'ZYSZNKZH013', '固定裤袢下端及明固定上端*6', 156, 56.1000, 0.1823, 'STITCHING', NULL, b'1', '裤耳毛缝不外落，不歪斜，线头不超过0.1CM.', '摆平裤身,裤耳与裤身对齐,折叠上端裤耳,回针固定.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5405, 'ZYSZNKZJ001', '落样点腰头风眼位2点*1', 15, 13.0000, 0.0325, 'STITCHING', NULL, b'1', '腰头无高低，点位清晰，不歪斜.', '腰头正面平服在上，调整对齐，取纸板比齐腰头，点风眼位.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5406, 'ZYSZNKZJ002', '专机锁腰头凤眼1个*1(3CM)', 260, 12.5000, 0.0312, 'STITCHING', NULL, b'1', '线迹良好', '车台定位，取腰头将平眼位精准对准机器开始锁眼.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5407, 'ZYSZNKZJ003', '打风眼套结1个*1', 260, 11.6000, 0.0377, 'STITCHING', NULL, b'1', '无歪斜错位现象', '正面在上，移致压脚,踩动机器.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5408, 'ZYSZNKZJ004', '点腰头扣位1点*1', 15, 8.4000, 0.0210, 'STITCHING', NULL, b'1', '无偏移现象.', '取腰头风眼一边与另一边对齐,开始点位.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5409, 'ZYSZNKZJ005', '专机钉腰头钮扣*1', 261, 8.7000, 0.0283, 'STITCHING', NULL, b'1', '线迹牢固，线迹不可超过0.1CM.', '前中平服，对点号位移进压脚下，踩动机器自动循环并断线，剪线.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5410, 'ZYSZNKZJ006', '专机挑裤脚(直/50CM)2条*1', 228, 57.8000, 0.1878, 'STITCHING', NULL, b'1', '线迹牢固，线迹不可超过0.1CM.', '取腰带对点号位移进压脚下，踩动机器自动循环并断线，剪线.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5411, 'ZYSZNKZJ007', '专机绕脚*1', 252, 6.9000, 0.0224, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5412, 'ZYSZNXFGM001', '暗线一道，缝位1.0，倒缝，胸部活褶各一个，褶向上倒', 152, 85.6200, 0.2783, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5413, 'ZYSZSTBJ001', '剪魔术贴1*4', 276, 0.9000, 0.0023, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5414, 'ZYSZSTBJ002', '剪手套松紧1*4', 15, 9.2000, 0.0230, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5415, 'ZYSZSTBJ003', '剪吊带袢1*2', 15, 3.1000, 0.0077, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5416, 'ZYSZSTBJ004', '剪背带1*1', 15, 8.7000, 0.0217, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5417, 'ZYSZSTKG001', '落样运射击孔盖(方角/9+11+9CM)1条*2', 156, 43.1000, 0.1508, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5418, 'ZYSZSTKG002', '修翻射击孔1片*2', 15, 54.2000, 0.1761, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5419, 'ZYSZSTKG003', '压射击孔盖边线(方角/9+11+9CM)1条*2连落魔术贴钩(直/11)1*2', 156, 66.9000, 0.2174, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5420, 'ZYSZSTKG004', '划射击孔盖实样线(直/10CM)1条*2', 15, 12.5000, 0.0312, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5421, 'ZYSZSTLB001', '漏划手掌及手背里绗棉印直33+弯7+直33+直15+直35+弯7+直33+弯7)1*4', 15, 22.6000, 0.0565, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5422, 'ZYSZSTLB002', '漏划拇指里绗棉印1*2', 15, 11.3000, 0.0282, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5423, 'ZYSZSTLB003', '绗手掌及手背棉连走定边线1*4', 156, 204.2000, 0.6636, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5424, 'ZYSZSTLB004', '绗拇指棉(直12+弯5+弯5+直12+弯11+弯11)1片*2', 156, 56.2000, 0.1826, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5425, 'ZYSZSTLB005', '切修手背或手掌棉(弯/75CM)1*4', 167, 53.4000, 0.1335, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5426, 'ZYSZSTLB006', '切修拇指棉(弯/75CM)1*2', 167, 26.7000, 0.0667, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5427, 'ZYSZSTLB007', '上里拇指连翻(圈/21CM)1条*2', 156, 89.0000, 0.3115, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5428, 'ZYSZSTLB008', '合里拇指(弯/18CM)1条*2', 156, 31.6000, 0.1027, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5429, 'ZYSZSTMZ002', '翻面拇指1*2', 15, 11.1000, 0.0277, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5430, 'ZYSZSTMZ003', '合面拇指(弯/18CM)1条*2', 156, 29.2000, 0.0949, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5431, 'ZYSZSTMZ004', '烫面拇指1个*2', 19, 13.4000, 0.0335, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5432, 'ZYSZSTSZ001', '落样点手掌及手背松紧位4点*4', 15, 2.5000, 0.0062, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5433, 'ZYSZSTSZ002', '烫手掌及手背套口1条*4', 19, 32.3000, 0.1050, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5434, 'ZYSZSTSZ003', '单针明落松紧(直/19CM)1条*4', 156, 70.9000, 0.2304, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5435, 'ZYSZSTSZ004', '双针压面松紧带明线(直/19CM)1条*4', 162, 46.0000, 0.1495, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5436, 'ZYSZSTSZ005', '剪手套松紧1*4', 15, 9.2000, 0.0230, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5437, 'ZYSZSTSZ006', '上面拇指(圈/21CM)1条*2', 156, 77.6000, 0.2716, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5438, 'ZYSZSTSZ007', '落样划射击孔位3条*2（1长和2宽）', 15, 13.0000, 0.0325, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5439, 'ZYSZSTTP001', '落样运调节袢(圆角/11.5+弯8+11.5CM)1条*2', 156, 39.0000, 0.1365, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5440, 'ZYSZSTTP002', '修翻调节袢1个*2', 15, 46.7000, 0.1518, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5441, 'ZYSZSTTP003', '压调节袢边线(圆角/直12.5+弯6+直12.5CM)1*2', 156, 34.5000, 0.1121, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5442, 'ZYSZSTTP004', '明落调节袢魔术贴钩(圆角/直11.5+弯8+直11.5CM)1片*2', 156, 54.2000, 0.1761, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5443, 'ZYSZSTZH001', '运射击孔(方/4+0.6+4+0.6CM)1条*2', 156, 48.6000, 0.1701, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5444, 'ZYSZSTZH002', '剪开连翻射击孔1个*2', 15, 20.8000, 0.0780, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5445, 'ZYSZSTZH003', '压射击孔明线(方角/4+1+4+1CM)1条*2连落魔术贴绒(方角/9+2.5+9+2.5CM)1条*2', 156, 112.3000, 0.3930, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5446, 'ZYSZSTZH004', '固定射击孔盖(直/11CM)1条*2', 156, 24.5000, 0.0796, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5447, 'ZYSZSTZH005', '固定调节袢(直/2.5CM)1条*1', 156, 21.5000, 0.0537, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5448, 'ZYSZSTZH006', '合面手掌及手背(弯/75CM)1条*2', 156, 91.0000, 0.3185, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5449, 'ZYSZSTZH007', '合里手掌及手背(弯/75CM)1条*2', 156, 104.7000, 0.3664, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5450, 'ZYSZSTZH008', '剪号型带1条*2', 15, 5.4000, 0.0135, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5451, 'ZYSZSTZH009', '翻手套1个*2', 15, 25.9000, 0.0842, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5452, 'ZYSZSTZH010', '卷手套口(圈/44CM)1条*2', 156, 147.5000, 0.5162, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5453, 'ZYSZSTZH011', '成品清理（扫毛，擦污迹）2*1', 15, 62.6000, 0.1565, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5454, 'ZYSZSTZH012', '系背带2个*1', 15, 29.6000, 0.0740, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5455, 'ZYSZSTZJ001', '冲里拇指洞1*1', 24, 9.6000, 0.0312, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5456, 'ZYSZXFDG001', '模板辑转袋盖1个*2(圆角,26CM)', 156, 37.5700, 0.1315, 'STITCHING', NULL, b'1', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5457, 'ZYSZXFDG002', '切袋盖止口三边1个*2(圆角,26CM)', 167, 8.0000, 0.0200, 'STITCHING', NULL, b'1', '止口一致,保留0.6CM止口', '保留0.6CM止口,均匀顺形切去多余的止口', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5458, 'ZYSZXFDG003', '烫定袋盖(圆角/26CM）1个*2连翻袋盖1个*2(圆角,用铁板烫)', 19, 43.6500, 0.1091, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5459, 'ZYSZXFDG004', '袋盖辑珠边线1条*1(圆角,26CM)', 225, 37.8200, 0.1229, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5460, 'ZYSZXFDG005', '袋盖粘双面胶1个*2(16CM)', 19, 18.3000, 0.0457, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5461, 'ZYSZXFDG006', '刀车落样走定袋盖实样线(直/16CM)1条*2#line#', 166, 17.6900, 0.0398, 'STITCHING', NULL, b'1', '平服，不反翘.', '摆平袋盖,车台定位走袋盖实样线.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5462, 'ZYSZXFDG007', '缝合袋盖1*2', 166, 32.4500, 0.1136, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5463, 'ZYSZXFDG008', '', 152, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5464, 'ZYSZXFDK001', '人字车袖窿棉多层走线1条*2(直/42CM,牙宽1.8CM)', 147, 55.9100, 0.1398, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5465, 'ZYSZXFDK002', '人字车大身衬收省1条*2(一端,直/10CM,牙宽1.8CM)', 147, 19.5000, 0.0487, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5466, 'ZYSZXFDK003', '人字车胸衬双层走线(直/12CM,牙宽1.8CM)', 147, 21.8000, 0.0545, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5467, 'ZYSZXFDK004', '人字车胸衬收省1条*2(两端,直/26CM,牙宽1.8CM)', 147, 40.9000, 0.1022, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5468, 'ZYSZXFDK006', '人字车胸衬三层走线(直/136CM,牙宽1.8CM)', 147, 82.8000, 0.2070, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5469, 'ZYSZXFDK007', '胸衬定型1块*2(定型11秒)', 59, 12.4000, 0.0310, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5470, 'ZYSZXFDZ001', '折烫手巾袋唇成型1个*1连剪量硬衬1条*1', 19, 68.2300, 0.1706, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5471, 'ZYSZXFDZ002', '折烫袋三角布1块*1', 19, 15.3500, 0.0384, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5472, 'ZYSZXFDZ003', '手巾袋画线1条*1(直/15CM)', 15, 6.6000, 0.0165, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5473, 'ZYSZXFDZ004', '折落袋垫布5块*1(直/20CM)', 156, 68.9500, 0.2241, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5474, 'ZYSZXFDZ005', '手巾袋唇辑珠边线1条*1(直/12CM)', 225, 13.2000, 0.0429, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5475, 'ZYSZXFDZ006', '锁袋三角布眼1个*1(固定循环2.5秒)', 254, 6.9900, 0.0175, 'STITCHING', NULL, b'1', '平服,左右对称', '以车台上标领尖锁眼1个*2,锁眼长1.8CM', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5476, 'ZYSZXFDZ008', '开大袋1*2', 265, 47.0100, 0.1645, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5477, 'ZYSZXFDZ009', '剪袋口三角1*2', 15, 27.1200, 0.0881, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5478, 'ZYSZXFDZ010', '翻烫袋牙线1*2', 19, 19.1100, 0.0621, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5479, 'ZYSZXFDZ011', '缝袋垫布1*2', 156, 22.3400, 0.0726, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5480, 'ZYSZXFDZ012', '修剪袋牙连接缝上、下袋布1*2', 156, 44.3800, 0.1553, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5481, 'ZYSZXFDZ013', '定缝袋口连缝合袋布1*2', 156, 67.0800, 0.2348, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5482, 'ZYSZXFDZ014', '整烫袋布1*2', 19, 22.2700, 0.0724, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5483, 'ZYSZXFDZ015', '缝合袋盖1*2', 166, 34.1400, 0.1195, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5484, 'ZYSZXFDZ016', '修剪袋盖圆角1*2', 15, 9.6200, 0.0216, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5485, 'ZYSZXFDZ017', '翻烫袋盖1*2', 19, 34.9900, 0.1137, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5486, 'ZYSZXFDZ018', '袋盖贡针', 225, 50.9600, 0.1784, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5487, 'ZYSZXFDZ019', '整烫袋盖1*2', 19, 8.6700, 0.0282, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5488, 'ZYSZXFGM001', '拼缝大挂面（弧/60cm+40cm）1条*2', 156, 98.5900, 0.3204, 'STITCHING', NULL, b'0', '', '将挂面与里布对号后,挂面正面朝上,前里正面置于挂面之上（与挂面正正相对）,顺布边缝线一道，缝位宽1.0cm；前里刀眼与挂面刀眼对齐，前里胸部褶宽按刀眼。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5489, 'ZYSZXFGM002', '整烫大挂面拼缝2条*2', 19, 36.7700, 0.0919, 'STITCHING', NULL, b'0', '', '将拼缝好的挂面正面朝上，挂面朝向操作者铺放在烫台板上，抚平进行熨烫，顺缝边将拼缝单边倒向里布', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5490, 'ZYSZXFGM003', '', 19, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5491, 'ZYSZXFGM004', '折烫三角袋盖1个*1', 19, 8.3400, 0.0198, 'STITCHING', NULL, b'0', '', '将三角袋盖里布反面朝上，先对半折烫，再取中将两角对折，成三角形状。', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5492, 'ZYSZXFGM005', '锁三角袋盖眼1个*1', 164, 7.2000, 0.0171, 'STITCHING', NULL, b'0', '', ' 1：将折烫好的三角，对准三角中心线；距尖点1.0cm处锁眼一道。2：并将锁眼线头修剪干净。', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5493, 'ZYSZXFGM006', '开里袋1个*2', 265, 28.6400, 0.0931, 'STITCHING', NULL, b'0', '', '1：开里袋位：将开袋机光标中间垫上开袋无胶衬，再把挂面平铺在开袋机上，并将开袋位放置无胶衬上，开袋机上的光标对准袋位线及前端的定位线；将无胶衬放入袋牙线中送入开袋机开袋；#line#注：开右袋时放入三角袋盖， 并居中口袋（三角袋盖宽：3.5～3.8cm）', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5494, 'ZYSZXFGM007', '开烟袋1个*1', 265, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5495, 'ZYSZXFGM008', '', 259, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5496, 'ZYSZXFGM009', '开烟袋1个*1', 265, 13.2400, 0.0430, 'STITCHING', NULL, b'0', '', '开里袋位：将开袋机光标中间垫上开袋无胶衬，再把挂面平铺在开袋机上，并将开袋位放置无胶衬上，开袋机上的光标对准袋位线及前端的定位线；将无胶衬放入袋牙线中送入开袋机开袋；', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5497, 'ZYSZXFGM010', '大挂面贡针（弧/60cm+40cm）2条*2', 286, 55.9000, 0.1397, 'STITCHING', NULL, b'0', '', '将整烫好的挂面反面朝上，顺挂面拼缝线边0.1cm，贡针一道', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5498, 'ZYSZXFGM011', '画里袋位1个*2，画烟袋位1个*1', 61, 21.1000, 0.0501, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5499, 'ZYSZXFGM012', '剪里袋三角2个*2', 161, 21.3600, 0.0694, 'STITCHING', NULL, b'0', '', '两线取中剪开，距袋角约1.0cm处剪三角，刀口距起、止线头约0.1cm，剪口不超出线头外', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5500, 'ZYSZXFGM013', '剪烟袋三角2个*1', 161, 10.4200, 0.0339, 'STITCHING', NULL, b'0', '', '两线取中剪开，距袋角约1.0cm处剪三角，刀口距起、止线头约0.1cm，剪口不超出线头外', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5501, 'ZYSZXFGM014', '剪里袋三角2个*2', 161, 20.3600, 0.0662, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5502, 'ZYSZXFGM015', '翻烟袋牙线2个*1', 161, 5.1700, 0.0116, 'STITCHING', NULL, b'0', '', '将支线翻至反面', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5503, 'ZYSZXFGM016', '翻里袋牙线2个*2', 161, 10.3400, 0.0233, 'STITCHING', NULL, b'1', '', '将支线及三角翻至反面', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5504, 'ZYSZXFGM017', '烫里袋牙线1个*2', 19, 21.1400, 0.0502, 'STITCHING', NULL, b'0', '', '正面抚平袋牙线及袋牙角，进行熨烫平整。', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5505, 'ZYSZXFGM018', '烫烟袋牙线1个*1', 19, 10.5700, 0.0238, 'STITCHING', NULL, b'0', '', '正面抚平袋牙线及袋牙角，进行熨烫平整。', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5506, 'ZYSZXFGM019', '缝里袋垫布（直/19cm）1片*2', 156, 21.0500, 0.0474, 'STITCHING', NULL, b'0', '', '将里袋垫布放置在里袋上袋布上反反相对），两层上端、侧边对齐，里袋垫布下端扣压缝一道，压线宽0.1cm，折边宽1.0cm', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5507, 'ZYSZXFGM020', '缝烟袋垫布（直/13cm）1片*1', 156, 9.2800, 0.0209, 'STITCHING', NULL, b'1', '', '将里袋垫布放置在里袋上袋布上反反相对），两层上端、侧边对齐，里袋垫布下端扣压缝一道，压线宽0.1cm，折边宽1.0cm', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5508, 'ZYSZXFGM021', '修剪袋牙线连接缝里袋下袋布（直/19cm）1片*2', 152, 59.3300, 0.1335, 'STITCHING', NULL, b'0', '', '1：修剪袋牙线#line#（1）：先修剪上袋牙线；距开袋线1.0cm宽修剪。#line#（2）：修剪袋牙两端距缝开线A点2.0cm处剪断。#line#（3）：里层袋牙两端距缝开线A点1.0cm处修剪袋牙线里层一层。#line#2：接缝上、下袋布#line#将下袋布与袋牙下开线缝合（缝位：1.0cm），向下单边倒缝。', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5509, 'ZYSZXFGM022', '接缝里袋上袋布（直/19cm）1片*2', 152, 16.1200, 0.0363, 'STITCHING', NULL, b'0', '', '接缝上袋布（里布缝在袋布上）与袋牙上开线缝合；注意上袋布高出袋牙上端0.5cm，并按原开线处0.1cm缉线一道。', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5510, 'ZYSZXFGM023', '缝合里袋布（直/20cm+16cm+18cm）1个*2', 152, 27.8600, 0.0662, 'STITCHING', NULL, b'0', '', '距袋口0.5处顺袋布缝线一圈#line#', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5511, 'ZYSZXFGM024', '缝里袋两端三角封口2个*2', 152, 11.7100, 0.0263, 'STITCHING', NULL, b'0', '', '并拢袋牙线，先封袋牙三角（回针二道固定）', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5512, 'ZYSZXFGM025', '修剪袋牙线连接缝烟袋下袋布（直/13cm）1片*1', 152, 25.4800, 0.0573, 'STITCHING', NULL, b'1', '', '1：修剪袋牙线#line#（1）：先修剪上袋牙线；距开袋线1.0cm宽修剪。#line#（2）：修剪袋牙两端距缝开线A点2.0cm处剪断。#line#（3）：里层袋牙两端距缝开线A点1.0cm处修剪袋牙线里层一层。#line#2：接缝上、下袋布#line#将下袋布与袋牙下开线缝合（缝位：1.0cm），向下单边倒缝。', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5513, 'ZYSZXFGM026', '接缝烟袋上袋布（直/13cm）1片*1', 152, 8.0500, 0.0181, 'STITCHING', NULL, b'1', '', '接缝上袋布（里布缝在袋布上）与袋牙上开线缝合；注意上袋布高出袋牙上端0.5cm，并按原开线处0.1cm缉线一道。', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5514, 'ZYSZXFGM027', '接缝里袋上袋布（直/19cm）1片*2', 152, 16.1200, 0.0363, 'STITCHING', NULL, b'1', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5515, 'ZYSZXFGM028', '缝合烟袋布（直/13cm+11cm+13cm）1个*1', 152, 11.9900, 0.0285, 'STITCHING', NULL, b'1', '', '距袋口0.5处顺袋布缝线一圈#line#', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5516, 'ZYSZXFGM029', '缝烟袋两端三角封口2个*1', 152, 4.9900, 0.0112, 'STITCHING', NULL, b'1', '', '并拢袋牙线，先封袋牙三角（回针二道固定）', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5517, 'ZYSZXFGM030', '里袋套结2个*2', 251, 20.7600, 0.0493, 'STITCHING', NULL, b'0', '', '将袋牙中间对准套结机中间进行套结，结长平齐上、下袋牙。', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5518, 'ZYSZXFGM031', '烟袋套结2个*1', 251, 10.4300, 0.0248, 'STITCHING', NULL, b'1', '', '将袋牙中间对准套结机中间进行套结，结长平齐上、下袋牙。', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5519, 'ZYSZXFGM032', '缝定商标（直6cm+4cm+6cm+4cm）1个*1', 147, 43.0200, 0.1076, 'STITCHING', NULL, b'0', '', '左挂面刀口向内移1.5cm，顺挂面丝绺摆平， 顺商标边缘打三角针（宽0.2cm）一圈，再将起止针线头用手工针拉至反面打结。三角针针距：3cm/11-12针', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5520, 'ZYSZXFGM033', '缲缝里袋布（直/17cm+17cm）2边*2', 237, 34.1100, 0.0767, 'STITCHING', NULL, b'0', '', '将里袋布上层抚平，挂面摆正放入缲边机顺下层袋布边平行缲边两道（宽1.0cm)(缲边袋布时视面料的厚薄度来调节缲边的深浅及针距密度)', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5521, 'ZYSZXFHP001', '链式车合后中缝（直/68cm）1片*2拉后袖笼牵条（弯/25cm）1片*2', 200, 60.8500, 0.2130, 'STITCHING', NULL, b'1', '1、背缝左右按划线粉切线，上下端位刀口对齐，切线顺直流畅。#line#2、背缝左右衣片无松紧，受力均匀一致无起吊现象。#line#', '上下层背缝叠拢，弧度一致送入压脚内，由领圈开始往下切，回针同轨，切线一定按画粉线平缝到底。#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5522, 'ZYSZXFHP002', '烫开后中缝（直/68cm）1片*1连扣烫底边（直/32cm）1片*1', 19, 24.1900, 0.0605, 'STITCHING', NULL, b'1', '1、背缝顺直分烫无座势，底摆一致，平直折烫进4cm。#line#2、操作中充分利用推、归、拔，在袖笼背中部、肩部等处进行归拢，左右两片对称一致。#line#', '1、两层后背叠拢一致，摆缝朝人平放。#line#①按弧线朝内捏起一个量，熨斗顺这弧度伸烫一把，后袖笼带吃量，归拢到位，熨斗顺丝绺方面往下烫，腰节推出，腰节下丝绺烫顺直。#line#②后背丝绺往内归直到位，顺丝绺方向熨烫中心腰节推出，余下顺直往下烫。#line#2、后背平推背缝分烫开，顺直到底腰节处可伸烫一把。#line#①背肩胛骨处丝绺往下弧呈弓形状，熨斗两侧对称弧形熨烫肩缝处圆顺归拢，两层容量归拢一致；#line#②后领圈不变形，领圈下0.1cm-0.2cm平粘1cm有线无纺衬，两端肩缝进1cm。                                ③背上部有活动容量约1.5cm，容量移动后背平服。#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5523, 'ZYSZXFHP003', '烫后刀背缝（弧/50CM）2条*1', 19, 17.6500, 0.0397, 'STITCHING', NULL, b'1', '平服,不可要有烫痕.', '摆平后片,拔开止口,取烫斗对准开始烫形.摆平袖窿及后领窝，取衬条与之配对，边缘平齐.摆平后下摆,取纸板与后下摆配对,开始折烫形，温度适度.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5524, 'ZYSZXFHP004', '归拔后片*2#line#', 59, 16.4400, 0.0370, 'STITCHING', NULL, b'1', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5525, 'ZYSZXFHP006', '合后中缝(直/80CM)1条*1（53秒）', 156, 32.0200, 0.0760, 'STITCHING', NULL, b'1', '平服，线迹均匀，宽窄一致.#line#', '出入口齐，大片在下，小片在上，正面与正面上下对齐留1CM止口开始车缝，头尾回针.#line#', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5526, 'ZYSZXFHP007', '合后里中缝(转角/80+3CM)1条*1（23秒）', 156, 25.7100, 0.0611, 'STITCHING', NULL, b'1', '平服，线迹均匀，宽窄一致.#line#', '出入口齐，大片在下，小片在上，正面与正面上下对齐留1CM止口开始车缝，头尾回针.#line#', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5527, 'ZYSZXFHP008', '烫后中缝(直/80CM)1条*1（12秒）', 19, 11.3400, 0.0255, 'STITCHING', NULL, b'1', '平服,不可要有烫痕.', '摆平后片,拔开止口,取烫斗对准开始烫形.摆平袖窿及后领窝，取衬条与之配对，边缘平齐.摆平后下摆,取纸板与后下摆配对,开始折烫形，温度适度.', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5528, 'ZYSZXFHP009', '烫后衩夹里及夹里中缝/3条*1（40秒）', 19, 29.8400, 0.0671, 'STITCHING', NULL, b'1', '夹里熨烫平整', '将开衩两边里布向内倒烫平整，多余的量往中缝折烫平整，中缝上段根据领口刀眼顺直平烫。（如图：红色线为里布）', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5529, 'ZYSZXFHP010', '画后开衩牵带位（直25CM/双开衩）1条*2（17秒）', 15, 15.3100, 0.0344, 'STITCHING', NULL, b'0', '画线顺直，位置准确。', '距开衩上端折角处A点向内1.5cm；下端对下摆刀口B点画一道线。', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5530, 'ZYSZXFHP011', '拉后袖窿牵带（直/16CM+弧20CM）1条*1（43秒）', 156, 50.5900, 0.1138, 'STITCHING', NULL, b'1', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5531, 'ZYSZXFHP012', '缝后开衩牵带（双开衩）（直/25CM）2条*1', 156, 15.5500, 0.0350, 'STITCHING', NULL, b'1', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5532, 'ZYSZXFHP013', '烫后中缝(直/62CM)1条*1（35秒）', 19, 17.8200, 0.0401, 'STITCHING', NULL, b'1', '后衩和底边折烫平整、顺直，无宽窄、无拉开现象。', ' 1：将后衩两边折角处各向内1.5cm处折烫，顺烫至下摆开    衩刀口。（如图一）#line# 2：再将底边按折边  的刀口进行折烫。', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5533, 'ZYSZXFHP014', '缝后背夹里中缝（下段）（直2+35CM）1条*1（47秒）', 156, 19.9200, 0.0473, 'STITCHING', NULL, b'1', '缉线顺直；里布平服、无吃势。', '将后里翻至反面，从开衩折角处至下摆，顺烫迹线将中缝下段缉线一道。', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5534, 'ZYSZXFHP015', '缝后开衩牵带（双开衩）（直/25CM）2条*1（46秒）', 156, 34.9300, 0.0786, 'STITCHING', NULL, b'1', '牵带缉线顺直、吃势准确到位', '将1.5cm宽的直牵带距后衩画线0.1cm缉线一道（①～②点）； 距下摆折边约6.0cm牵带略拉紧0.2cm', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5535, 'ZYSZXFHP016', '缝及翻后衩角（双开衩）2条*1（54秒）', 156, 28.1000, 0.0632, 'STITCHING', NULL, b'0', '衩角平服，无起吊、无反翘现象。', '1：将折烫好的开衩角摆平，叠角处用剪刀打个小刀口做      记号，（如图一）#line#2：将衩角翻至反面对折，对齐小刀口缉线一道；再修剪   1.0cm 的余量，（如图二）#line#3：将衩角分缝翻至正面，用镊子将衩角调正。              （如图三、四）', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5536, 'ZYSZXFHP017', '烫后衩角（双开衩）2条*1（16秒）', 19, 8.1000, 0.0182, 'STITCHING', NULL, b'0', '后背反面朝上，领口朝操作者，摆平在烫台上进行吸风；然后对衩角进行熨烫。', '衩角平服，无起吊、无反翘现象。', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5537, 'ZYSZXFHP018', '缝后衩夹里（双开衩）（直/25cm)2条*1（23秒）', 156, 50.0700, 0.1189, 'STITCHING', NULL, b'0', '1：缝位准确，缉线平顺，无吃势。#line#2：下摆里布高低一致，左右对称。', '将面布开衩上的刀口及里布衩上的刀口对齐，顺开衩边平缝一道，缝至距下摆1.5cm 处回针，缝位：1.0cm。（如图：红色线）', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5538, 'ZYSZXFHP019', '修剪后背夹里（双开衩）（59秒）', 15, 40.6500, 0.1016, 'STITCHING', NULL, b'0', '里布修剪准确。', '将熨烫好的后片平铺在台板上摆平，先由右边袖笼①点高出1.0cm；顺修至肩袖点②宽1.0cm，②高出肩袖点1.5cm平修至领肩点③(距领肩点1.0cm），接着在后领圈④处，面布领肩点距里布领肩点相距0.3cm，再顺修剪至⑤处，后中里布高出0.8cm，左边的修剪同右边操作。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5539, 'ZYSZXFHZ001', '成品驳头定型2个*1', 59, 31.9000, 0.0797, 'STITCHING', NULL, b'1', '1、驳头丝绺顺直、无凹凸现象，驳头宽度根据翻折线翻折对应驳头点，领面丝绺横平竖直理直，串口线竖直不弯曲，领嘴大小一致。#line#', '1、驳头放置模具对应点，摊平驳头领以及领面，驳头上端保持笔直，注意定型时不能拉#line#坏领子，合模启动自动程序定型，模具离合后踩住吸风冷却3秒钟进行保型，定好后驳头止口顺直、不弯曲、自然向里窝服，两边形状一致。#line##line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5540, 'ZYSZXFHZ002', '成品后侧片定型*1', 59, 43.2000, 0.1080, 'STITCHING', NULL, b'1', '1、后背分割线挺拔流畅，不起吊，后肩部造型饱满，不起裂，后背活动量自然，后背腰节处无起吊现象，下摆圆顺自然无凹凸现象。#line#', '1、后片根据模具形状摆正位置，后袖窿与模具想吻合，以不压住袖子为宜，背中缝要顺直，底边折边顺直，后背侧缝腰节处稍向背中缝推进0．15cm，后背侧缝从袖笼方往下10cm之内稍归拢0。2cm，摆放自然，无折缝，里布背中缝按烫痕摆放顺直，两边同样操作。#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5541, 'ZYSZXFHZ003', '成品立领定型1*1', 59, 23.4000, 0.0585, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5542, 'ZYSZXFHZ004', '成品肩袖定型2只*1', 59, 25.9000, 0.0647, 'STITCHING', NULL, b'1', ' 肩部造型饱满，肩缝线条顺畅不往后甩，前后片丝绺横平竖直多余量做归拢，袖山饱满圆顺无凹凸起空现象，袖面丝绺横平竖直，袖口里布无打折现象#line#', ' 将袖子套入袖型模具上，另一边袖子与前片挂在模具挂钩上，找准肩缝位置，以模具光线点为准对牢肩缝，袖山边距与模具边距相吻合踩吸风固定住，如图所示把余量放置作归拢，抹平肩缝使肩缝弧度自然不往后甩，踩一下模具压脚板，上模具压住大身模具固定住，按撑袖功能键把袖子撑开，袖子丝路理直，再按启动键机器自动操作压肩与喷袖程序，两肩袖同样操作。#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5543, 'ZYSZXFHZ005', '成品立领定型1*1连驳头定型1*1', 59, 27.3000, 0.0682, 'STITCHING', NULL, b'1', '驳头宽窄一致，领面丝绺顺直，两边翻折线翻折到位，驳头翻折至扣眼处向上1.5cm开始，驳头领子服帖，不起空现象。#line#', '衣服穿于立体模具上，两边高低一致摊放，里领围服帖于模具，领翻折线翻折到位，翻折至扣眼处向上1.5cm即可，驳领外围余量固定住作归拢，理顺驳头领面丝绺吸风固定，合模后完成压机自动程序操作。#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5544, 'ZYSZXFHZ006', '成品前片定型2片*1', 59, 42.6000, 0.1065, 'STITCHING', NULL, b'1', '1、省道弧度自然向前弯曲0.2cm，肩部造型饱满，无起裂、起空、无多余量，门襟往里呈窝势，止口顺直无凹凸、门襟外翻现象，条、格料袋盖与大身条格必须对牢，面袋嵌线顺直，前身袖窿处丝绺横平竖直不弯曲。#line#', '1、将衣服前后片分左右放在对应的模具上，前片根据胸高点摆正位置，前袖窿边距与模具边距相吻合，以不压住袖子为宜，前片袖窿处与挂面直纱处丝绺一定要横平竖直，多余量如图所示做归拢，胸省稍向外推出0．2cm，门襟止口直纱不能有凹凸现象，底边折边顺直，摆放自然，无折缝，两边同样操作。                   #line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5545, 'ZYSZXFHZ007', '成品袖外缝定型2个*1', 59, 38.5000, 0.0962, 'STITCHING', NULL, b'1', '袖缝顺直挺拔，袖面丝绺顺直，无多余量，袖面不出现缝份印迹袖扣不压坏，袖口里布作势无起扭打折，袖口不呈现喇叭口现象。#line#', '大袖缝正面朝上，放置于模具中心线上，踩下吸风，理直大袖缝缝位及袖面丝绺，多余量如图所示作归拢，袖扣摆正，如是叠扣以不压住扣子为准，袖缝倾斜放于模具上，，踩上模压脚板进行压烫，模具离合后踩住吹风压脚，左手按住袖口处，右手在袖面来回抹平袖面，吹风2秒后再取出袖子，两袖同样操作。#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5546, 'ZYSZXFHZ008', '点门襟扣位印2个*1', 15, 18.9000, 0.0473, 'STITCHING', NULL, b'1', '1、门襟眼为2.3cm，锁眼线迹清晰，无毛漏、无跳针断线、开刀处无毛须现象。#line#2、眼尾套结无偏离无脱线，扣眼平整，无歪斜等现象。#line#3、第一眼位距边1.5cm，第二眼位距边1.3cm，第三眼位距边1.1cm。#line#4、插花眼为1.8cm圆头假眼，不开刀。#line#', '1、左衣片挂面朝上，在翻驳处下1cm点眼位，眼位间距根据样板点位，距门襟边1.5cm，按照前身的横向纱向为标准。 #line#2、衣服反面朝上送入压脚内按锁眼机程序操作。#line#3、插花眼衣服正面朝上送入压脚内按锁眼机程序操作。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5547, 'ZYSZXFHZ009', '画扣眼位印4点*1', 15, 18.7000, 0.0467, 'STITCHING', NULL, b'1', '1、门襟眼为2.3cm，锁眼线迹清晰，无毛漏、无跳针断线、开刀处无毛须现象。#line#2、眼尾套结无偏离无脱线，扣眼平整，无歪斜等现象。#line#3、第一眼位距边1.5cm，第二眼位距边1.3cm，第三眼位距边1.1cm。#line#4、插花眼为1.8cm圆头假眼，不开刀。', '1、左衣片挂面朝上，在翻驳处下1cm点眼位，眼位间距根据样板点位，距门襟边1.5cm，按照前身的横向纱向为标准。 #line#2、衣服反面朝上送入压脚内按锁眼机程序操作。#line#3、插花眼衣服正面朝上送入压脚内按锁眼机程序操作。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5548, 'ZYSZXFHZ010', '专机钉面扣2粒*1及钉里扣1粒*1', 262, 36.0000, 0.0900, 'STITCHING', NULL, b'1', '1、钉扣线路均匀，每孔线支一致，无断线、少线现象，绕脚高度一致，线结头不能露在外面，扣子点印与扣眼相对称，不能偏离，扣子定好后扣起扣子保持平整，不起扭现象。', '1、两门襟正面相叠，由驳头开始比对至扣眼处点扣印，里口袋根据三角扣眼点印位置。将门襟扣印放入机器光线夹板上，放入扣子至机器模型架上，驱动操作程序进行机器自动操作，完成后剪干净线头线尾，检查各孔线支是否一直，缠脚高度是否合格，里扣及门襟扣都采用“=”形状钉扣，里扣同样操作。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5549, 'ZYSZXFHZ011', '手工挂吊牌1个*1连挂袖卡1*1', 15, 8.6000, 0.0215, 'STITCHING', NULL, b'1', '无折痕，无裂痕', '吊牌和洗唛核对后挂于左前片第一粒扣眼处，袖卡挂于右袖第一粒扣上。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5550, 'ZYSZXFHZ013', '整件拆线1片*1', 15, 320.4000, 0.8010, 'STITCHING', NULL, b'1', '1、线头线尾清理干净，', '1、取走衣身上的线钉', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5551, 'ZYSZXFHZ014', '袖窿定型2个*1', 59, 53.9000, 0.1347, 'STITCHING', NULL, b'1', ' 袖窿不变形，袖圈里布无起皱褶，袖型、棉条饱满，袖面无皱印，丝绺保持顺直，棉条以撑起袖面为主，棉条不起空打褶现象。#line#', ' 翻转衣片袖窿分3段操作，先将下方袖窿套入模具凹槽内，袖窿上半部分按照袖窿的弧度摆放平，踩住吸风抹平里布，踩上压模压脚不松开，再松开吸风让模具喷压袖圈3秒钟之后松开压模压脚再踩住吸风，冷却2秒钟后，再放袖圈第二、三段前小侧片及后袖窿进行压烫，定好型后翻转至正面检查定型情况，保证袖子与棉条饱满无皱褶现象，两袖圈同样操作。#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5552, 'ZYSZXFHZ015', '修烫整件里布*1', 20, 62.0000, 0.1550, 'STITCHING', NULL, b'1', '里布平服、整洁、无水印、不煞黄、不渗胶，无局部隆起，背叉顺直，背部平服，里布无折痕、整洁。', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5553, 'ZYSZXFHZ016', '修烫整件前片*1', 20, 49.8000, 0.1245, 'STITCHING', NULL, b'1', '前片门襟方止口直纱不能内凹，底边折边顺直，摆放自然，无折缝。', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5554, 'ZYSZXFHZ017', '修烫整件1件*1', 20, 47.4000, 0.1540, 'STITCHING', NULL, b'1', '熨烫部位平服、整洁、无水印、光亮、不煞黄、不渗胶，外光整洁，胸部饱满，无局部隆起，匀称，腋下清楚干净，无臃肿，不起链，吸腰自然，袖山头圆顺，前圆后登，袖子不夹不翻，自然服帖，无起纽现象，背叉顺直，背部平服，领子窝服。驳头挺括，左右对称，止口平薄，下摆轮廓圆顺，布翻布吊，面里无折痕，外观整洁。', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5555, 'ZYSZXFHZ018', '门襟珠边线打结*2', 15, 42.2000, 0.1055, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5556, 'ZYSZXFHZ019', '手工装备用扣2粒*1连手工穿吊牌3个*1', 15, 9.9000, 0.0248, 'STITCHING', NULL, b'1', '要求吊牌顺序不能放错。', '备用扣袋装2颗扣子，穿吊牌按主吊牌、备用扣、付吊牌的顺序穿', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5557, 'ZYSZXFHZ021', '修烫驳头及袖子*1', 20, 44.9000, 0.1122, 'STITCHING', NULL, b'1', '驳头止口顺直、不弯曲、自然向里窝服，两边形状一样，#line#袖山头圆顺，前圆后登，袖子不夹不翻', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5558, 'ZYSZXFLB001', '合里袖底缝(直/45CM)1条*2及袖侧(直/56CM)1条*2', 156, 71.9000, 0.2337, 'STITCHING', NULL, b'1', '平服,线迹顺直,宽窄一致.#line##line#', '出入口齐,取袖折叠,距边止口保持1CM开始车缝,首尾回针.', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5559, 'ZYSZXFLB002', '烫倒里袖底缝(直/45CM)1条*2及袖侧缝(直/56CM)1条*2', 19, 22.7000, 0.0539, 'STITCHING', NULL, b'1', '平服,不可有烫痕.', '将里袖套入烫杆内并抚平里袖,取烫斗开始烫形,温度适度.', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5560, 'ZYSZXFLB003', '翻内袋*2连上洗水唛（直/7cm）1条*1连上扣眼三角（直/9cm）1条*1#line#', 155, 27.7000, 0.0900, 'STITCHING', NULL, b'1', '要求洗水唛合小三角都居中不偏斜，袋角转正。', '洗水唛居左里袋，小三角居右里袋。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5561, 'ZYSZXFLB004', '合内袋袋布（直/17cm）1条*2连封三角连封袋口（方角/1+15+1）1条*2连运袋布（方角/17+15+17cm）1条*2#line#', 156, 101.5000, 0.3806, 'STITCHING', NULL, b'1', '1、袋垫下口平直压0.1cm止口，上口与袋布平齐。#line##line#2、洗水唛居左里袋，小三角居右里袋，位置居中不偏斜#line#。#line#3、里袋袋角切圆顺，卡袋袋角切方正，袋布缝位一致1.5cm（挂面—侧里袋缝位为2cm）。#line#', '1、里袋两嵌线理成宽窄一致，小三角对折线朝上放入，两嵌线内居中，上嵌线下口对准小三角缝位线（小三角中心线净高5cm），上嵌线缝位上抛线三角定位。#line##line#2、拼下袋布与嵌线缝位平齐切线，拼上袋布缝位距嵌线上口1.5cm，上口切线居中略呈弧线。#line##line#3、袋口两端小三角回针封固，袋角方正无起皱，上下层袋布缝合按要求（没有运袋布的说明）#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5562, 'ZYSZXFLB005', '平车定商标（方角/4+7+4+7cm）*1', 156, 39.6000, 0.1287, 'STITCHING', NULL, b'1', '1、左右里袋上口居中订商标，距下嵌线2cm#line#.#line#2、四周回针清晰，无毛漏，起皱，缝位进出一致。#line##line##line#', '1、左里袋下口订商标（含中文）右口袋上口订副商标（含英文）。                                               2、里布正面平摊，上下层平服，商标放置不偏斜，两端平直折烫进0.5cm，起落针三角针迹拼接上，商标服于里布上无起皱拉急现象。                                                                                        #line#3、各商标同样操作。                                                                                                                            #line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5563, 'ZYSZXFLB006', '烫里袋三角1个*2#line#', 19, 13.2000, 0.0330, 'STITCHING', NULL, b'1', '1、小三角为等腰三角形，对折线居三角中心，中心高5cm（净）。#line#2、三角距尖1cm打直眼一只，眼长2cm。', '1、方块里布先直对折烫平，再由两边往内折成对称小三角，近住中心线吸风熨烫。#line#2、两三角掀开，三角居中垂直锁眼，眼位不偏斜。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5564, 'ZYSZXFLB007', '烫平及烫开内袋布连烫平袋唇1片*2#line#', 19, 37.7000, 0.0942, 'STITCHING', NULL, b'1', '要求袋布烫平服。', '内嵌线合成一条直线，嵌线宽0.5cm，宽窄上下一致，袋布前口分开熨烫。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5565, 'ZYSZXFLB008', '专机撬里口袋边（直/15cm）1条*2', 220, 25.7000, 0.0899, 'STITCHING', NULL, b'1', '1、撬线顺直，松紧适宜，面不透线。#line##line#2、根据面料厚薄适当调节针迹。#line#', '1、挂面一侧的里袋布（2.0cm）与里布一同理平服不歪斜，挂面拉平直。#line##line#2、送入压脚内撬住袋布边（下层）与挂面，平直往前送。#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5566, 'ZYSZXFLB009', '专机套内口袋弧形结2个*2', 251, 31.1000, 0.1011, 'STITCHING', NULL, b'1', ' 1、嵌线两侧套结垂直封固，与嵌线高度一致，光洁里布不抽丝。#line# 2、面底线松紧一致。#line#', '1、两嵌线合成一直线，不豁口，衣片与袋布理平服，送入压脚内，嵌线中心线对牢压脚上的中缝，开动机器。#line#2、同样操作打套结，不遗漏一个。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5567, 'ZYSZXFLB010', '里口袋画印（直/15+2cm）1片*2', 15, 25.8000, 0.0645, 'STITCHING', NULL, b'1', '里口袋的横向位置为延过挂面1.5cm，与挂面直线平行，与上里布和本布拼接缝平行', '里袋按版画好袋位，一般情况下对准剪口画印', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5568, 'ZYSZXFLB011', '烫倒里后中缝（方角/38+3+36cm）1条*1', 19, 16.9000, 0.0422, 'STITCHING', NULL, b'1', '1、顺直、无折痕，领握中缝平边', '1、将里布放置烫台面，翻开抚平。#line#2、整烫好后对折放好。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5569, 'ZYSZXFLB012', '合里后中缝（方角/38+3+36cm）1条*1', 156, 35.4000, 0.1239, 'STITCHING', NULL, b'1', '1准直、无打折。', '1、合后中缝对齐剪口位，车线顺直，缝份1cm。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5570, 'ZYSZXFLB013', '平车合里挂面（直/69cm）1条*2同时收前胸省褶1个*2连合前侧里缝（直/50cm）1条*2', 156, 111.9000, 0.3916, 'STITCHING', NULL, b'1', '1、缝位一致1cm各刀口必须对称。#line#2、里布胸部位裥重叠2cm（按刀口），里布上半部斜丝略吃量，挂面第二只刀口到第三只刀口里布约吃0.3cm，第三只刀口到第四只刀口里布约吃0.2cm。', '1、里布放于下层，挂面居上第一只刀口对牢，从刀口上1cm左右开始缝制，里布折裥刀口与挂面第二只刀口对准，里布略松往下缝制。#line#2、缝制到第四只刀口下一针左右打回针，下摆里布应比面布长出1cm左右。#line#3、拼好后里布整体有一些松量，但无起皱，左右两片挂面对称操作。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5571, 'ZYSZXFLB014', '烫倒里挂及里前侧缝2条*2连烫垫袋位衬*2', 19, 43.7000, 0.1092, 'STITCHING', NULL, b'1', '1、缝位朝侧缝倒烫，顺直烫煞无座势。#line#2、里袋胸围108以下（含）宽13cm，其余规格均为14cm。#line#3、里袋定位线距袖窿下4cm-5cm，伸进挂面1.5cm，卡袋定位样板与底摆平齐，袋口距挂面2cm，宽10cm。#line#', '1、挂面丝绺放平直，里布缝位理直朝后倒放平，吸风正面熨烫。#line#2、取定样板按要求平放于里布上，定位线必须清晰精确，两里袋高低进出一致。#line#3、卡袋只定于左片，不遗留。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5572, 'ZYSZXFLB015', '专机链式针珠边挂面（直/60cm）1条*2', 234, 41.6000, 0.1456, 'STITCHING', NULL, b'1', '1、珠点大小一致，缝份距边0.15cm。#line##line#2、保持面里料平整，无抽丝、起皱等现象。#line#', '1、取衣片反面送入压脚内，以肩缝为起点，距拼缝挂面线旁0.15cm为#line##line#2、距挂面下摆6.0cm处米面里料分开至珠里料。#line##line#3、左右对称操作。#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5573, 'ZYSZXFLB016', '专机开里袋1条*2', 265, 31.0000, 0.0775, 'STITCHING', NULL, b'1', '1、胸围108以下（含）宽13cm，其余规格为14cm，卡袋一致10cm。#line#2、嵌线宽一致均为0.5cm，两嵌线平服不起皱，平直不重叠合成一致。', '1、里布正面朝上平摊放入开袋机内，光线对准袋定位线居中放上嵌线及纸衬，放下压脚后开动机器。#line#2、嵌线丝绺平直不拧向，宽窄一致，两里袋高低进出一致尺寸正确。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5574, 'ZYSZXFLB017', '烫倒里袖缝（直/63+48cm）1片*2', 19, 34.7000, 0.0867, 'STITCHING', NULL, b'1', '1、里袖内外缝烫平顺，无起泡', '1、将里袖放置摇臂上，调整抚平里袖，烫到缝份。#line#2、调整至另一边缝份，抚平，烫到缝份。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5575, 'ZYSZXFLB018', '平车合里袖外缝（直/58cm）同时放固定条连合里袖内缝（直/6+24cm）1条*2', 236, 74.3000, 0.2415, 'STITCHING', NULL, b'1', '1、袖里缝位1cm。#line##line#2、小袖缝距袖笼6cm左右留一个口长10-15cm。#line#', '1、上下层袖里正面相叠放平服，袖笼处比齐开始切线，缝位均位一致，切线顺直，右手捏住两层袖里以防袖里滑动。#line##line#2、小袖缝留口按要求，其余平缝到底。#line##line#3、左右两袖对称操作一致。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5576, 'ZYSZXFLB019', '专机锁里袋小三角扣眼1个*1#line#', 259, 21.4000, 0.0535, 'STITCHING', NULL, b'1', '扣眼不能倾斜', '先看扣眼版点印，然后锁眼，看反面锁。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5577, 'ZYSZXFLB020', '剪开里口袋1个*2', 15, 39.2000, 0.0980, 'STITCHING', NULL, b'1', '打剪口不能剪过线，以翻过去平整为宜。', '开袋刀口开中间。打剪口不能剪过线，以翻过去平整为宜。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5578, 'ZYSZXFLZ001', '落样画领面一周(直/4+直/36+直/4+弧/42)1条*1', 15, 16.3900, 0.0410, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5579, 'ZYSZXFLZ002', '落样画领里(绒布)翻折线(弧/30)1条*1', 15, 11.2200, 0.0280, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5580, 'ZYSZXFLZ003', '领里(绒布)落牵条1条*1(弧/30CM)', 156, 30.0800, 0.0978, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5581, 'ZYSZXFLZ004', '人字车搭接领沿(弧/45CM)1条*1同时落三角块2个*1连修剪(牙宽0.3CM)', 147, 63.3900, 0.2219, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5582, 'ZYSZXFLZ005', '辑转领两端(直/7CM)2条*1连修剪连翻领', 156, 61.7900, 0.2163, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5583, 'ZYSZXFLZ006', '合领条(直/32CM)1条*1连辑明线(直/32CM)1条*1', 156, 47.6100, 0.1666, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5584, 'ZYSZXFLZ007', '烫开领条缝1条*1连归烫领子成型1条*1', 19, 80.3400, 0.2008, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5585, 'ZYSZXFLZ008', '画领(弧/42CM)1条*1连修剪成形领1条*1(画领脚及修剪)', 15, 25.3300, 0.0633, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5586, 'ZYSZXFLZ009', '烫开下领缝连烫定上领三边连2次折烫下领1片*1', 19, 49.1500, 0.1229, 'STITCHING', NULL, b'1', '1、外领圈眼皮均匀为烫出一致0.15cm-0.2cm两侧弧度对称，自然圆顺。#line#2、领绒下领包呈不虚空，领子熨烫归拔到位。', '1、领绒翻折下烫眼皮，两侧领型对称圆弧熨烫。#line#2、领底绒按领脚往上翻折弧度圆顺，领绒（毛）距外领圈0.7cm如图，在两颈侧点处粘合1cm有线无纺衬，粘合时牵带略绷紧，后领圈不粘住，上下领缝位分缝平烫开，缝位按弧度烫圆顺。#line#3、下领按领弧线将领绒包足不虚空，后领圈处上领面包过面0.8cm两端约包进1.2-1.5cm，后领处领面稍绷紧熨烫，两颈侧点处按弧度熨烫略归拢。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5587, 'ZYSZXFLZ010', '花针机固定里领（直/3.5+34+3.5cm）1条*1', 235, 21.0000, 0.0787, 'STITCHING', NULL, b'1', '1、扣三角针缝位重叠一致，各刀口对准，领角至第一只刀口平缝，第一只刀口至第二只刀口领面约吃，0.25cm第       二只刀口至中心领面需拉开0.15cm缝制。#line#2、三角针针迹清晰，弧度自然圆顺，两领角翘势一致。', '1、领面与领底绒正面朝上，领面领圈1cm缝位放入领底绒与布衬之间进出一致。#line#2、领角处领底绒比领角（净）划线放置出0.5cm左右与领衬对牢，开始缝制，上领刀口领衬上的刀口对牢一致缝制吃量按要求。#line#3、左右两侧对称操作，所吃容量一致。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5588, 'ZYSZXFLZ011', '拼缝领脚（弧/28cm）1条*1', 152, 16.7900, 0.0399, 'STITCHING', NULL, b'0', '', '将领脚放在领面上，两层刀口对齐；顺下领边缝线一道，缝位宽0.5cm。', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5589, 'ZYSZXFLZ012', '缝领底腰牵带（弧/26cm）1条*1', 152, 18.4400, 0.0438, 'STITCHING', NULL, b'0', '', '将领底呢反面朝上，牵带顺领底呢定脚线下边顺缝一道，缝线距定脚线0.15cm，起、止针线处牵带距领串口留空约2.0cm。吃势位置见图，吃量各0.6cm，中间段平缝。', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5590, 'ZYSZXFLZ013', '画领串口（直/10cm）2条*1连修剪领串口2条*1', 15, 37.8200, 0.0945, 'STITCHING', NULL, b'1', '   领串口线划线平直清晰。#line#', '   领子反面平放，掀开串口处领绒，覆上领角样板，外型处与领型符合，根据领角样板平直，画领串口线。#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5591, 'ZYSZXFLZ014', '缝领底角垫布（弧/3cm+3cm）2边*1', 147, 22.9100, 0.0544, 'STITCHING', NULL, b'0', '', '将领角垫布置于领呢下；两边各距领呢边0.6cm,距领呢串口0.5cm处将垫布向下折，顺领底呢边缘缝三角针（宽0.3cm）至领刀眼位置。', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5592, 'ZYSZXFLZ015', '平车固定面里领（直/34cm）1条*1', 147, 24.0800, 0.0843, 'STITCHING', NULL, b'1', '里面各剪口对准，两边对称。', '里领居上面，和平面领划印处对齐缝合，吃量为0.3cm.', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5593, 'ZYSZXFLZ016', '剪领两端缝位2*1连翻领连挑角（两端尖角）2个*1', 15, 21.0000, 0.0525, 'STITCHING', NULL, b'1', '1、领角切线顺直，领面吃0.3cm（薄），0.4cm（厚），两领角呈自然窝势。#line#2、两领角圆顺对称，左右对称弧度一致。', '1、翻转领绒，领绒与领面正面相叠，按划粉线割领角，领串口处起针绒进0.3-0.4cm处。#line#2、缝制时领面居下层领角处均匀往内送量（如图）。#line#3、两领角切圆顺，割角缝位平直修至0.3cm，领角处可再削簿。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5594, 'ZYSZXFLZ017', '平车合上下面领（弧/40cm）同时对剪口5个', 156, 28.8400, 0.1009, 'STITCHING', NULL, b'1', '1、缝位一致0.6cm领角弧度切线。#line##line#2、外口第一只刀口平缝，第一只刀口至中心刀口，领面需拉开0.3cm左右的量对上刀口缝制。#line#', '1、领面居上按领角弧度上下层放平服送入压脚内，按领脚线弧度缝制不变形。#line#2、起落回针固定，缝制时各刀口一定要对准。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5595, 'ZYSZXFLZ018', '画面领三边（方角弧形/4+40+4cm）连点剪口位5点*1', 15, 26.4800, 0.0662, 'STITCHING', NULL, b'1', '1、上下领丝绺处顺直，划线及剪口清晰，上领两角（净）放1.3cm，外领圈放1cm，领脚处修净，下领四周修净。#line#2、后领面与背缝条，格必须对齐，两领角进出一致。', '1、领面正面朝上放平覆上领样，领中心线对准直丝绺，按住领样不松动，在领样四周按划粉不遗漏一只刀口，下领同样操作。#line#2、开剪上面领按要求三周放量，开剪顺直，无缺口。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5596, 'ZYSZXFLZ019', '领绒三边压线（直/4+38+4cm）1条*1连带牵条（直/30cm）1条*1', 156, 41.4900, 0.1452, 'STITCHING', NULL, b'1', '1、以领衬为基础，在领底绒上口三周平缝切线1.3cm切线宽窄一致。#line#2、翻折线两颈窝点拉量均匀一致，弯势自然服帖。', '1、领底绒反面朝上送入压脚内，由领角开始切线，按外领圈的弧度切线，到领角处弯转切角清晰。#line#2、0.4cm牵带比平翻折线画印按图位置吃量，均匀吃进0.5cm。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5597, 'ZYSZXFLZ020', '按版画领绒定位线（弧/40cm）1条*1连点反面位4点*1连点正面剪口位8点*1', 15, 35.3900, 0.0885, 'STITCHING', NULL, b'1', '要求点印两边对称。', '根据各款式相对应的版画印，依版上剪口处点印。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5598, 'ZYSZXFLZ021', '成型领定位（直/20cm）1条*1', 233, 9.1000, 0.0296, 'STITCHING', NULL, b'1', '要求形状与人体形状吻合，完成后能达到翘肩的效果。', '先将直领处胸衬与衣身缝合定位，前直领口归0.2cm，再从肩缝处打一圆圈线进行定位。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5599, 'ZYSZXFLZ022', '平车封面里领（直/3.5cm）两端*1', 156, 29.6500, 0.1038, 'STITCHING', NULL, b'1', '1、缝位一致0.6cm领角弧度切线。#line#2、外口第一只刀口平缝，第一只刀口至中心刀口，领面需拉开0.3cm左右的量对上刀口缝制。', '1、领面居上按领角弧度上下层放平服送入压脚内，按领脚线弧度缝制不变形。#line#2、起落回针固定，缝制时各刀口一定要对准。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5600, 'ZYSZXFLZ023', '合缝领角（弧/3cm+3cm）2边*1', 152, 23.3400, 0.0583, 'STITCHING', NULL, b'0', '', '将领底呢正面置于领面之上，领底呢领口距领面边1.0cm处开始缝制，顺领底呢三角边缝制一道（起针倒针一道)；在领角处两边吃势约0.2-0.3cm，领底呢刀口及领面刀口对齐。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5601, 'ZYSZXFLZ024', '修领角2边*1', 15, 10.8200, 0.0257, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5602, 'ZYSZXFLZ025', '缝合领面（弧/28cm）1条*1', 147, 21.5000, 0.0537, 'STITCHING', NULL, b'0', '', '将领面与领底呢分开，上领边两层叠在一起缝制，领底呢盖住领面的画迹线（或0.6的缝位），并且上下两层刀眼对齐，然后顺  画迹线边（或0.6缝位）缝三角针（宽0.3cm）一道；三角针打在领底呢边沿上。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5603, 'ZYSZXFLZ026', '翻领角2边*1', 15, 8.9900, 0.0225, 'STITCHING', NULL, b'0', '', '将领角翻至正面', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5604, 'ZYSZXFLZ027', '整烫领子1条*1', 19, 37.9800, 0.1234, 'STITCHING', NULL, b'0', '', '1：将领面翻至反面，劈缝烫开领脚合缝，使领脚摆放成弧形状。2：翻至领面，用领子烫板插进领角进行熨烫，使尖角烫尖、圆角烫圆。3  ：将领止口烫顺(止口为0.15cm)。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5605, 'ZYSZXFLZ028', '定缝领止口（弧/34cm）1条*1', 243, 9.9600, 0.0224, 'STITCHING', NULL, b'0', '', '距领串口1.5cm处开始定缝；顺上领边1.0cm定线一道。', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5606, 'ZYSZXFLZ029', '缝钉领标（直/0.8cm+0.8cm）2边*1', 152, 13.2200, 0.0314, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5607, 'ZYSZXFQHZZ001', '缝双侧缝（转角/32+4cm）2*1', 247, 65.1800, 0.2118, 'STITCHING', NULL, b'0', '', '将前小片面放置于后背之上，在开衩边留空止口1.0cm处开始缝制，垫进三角垫布，由A点平顺缝制，至转折角处B点三角垫布放松量A～B点0.2cm～0.3cm；再平顺至刀口，刀口至C点后身片吃势0.3cm。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5608, 'ZYSZXFQHZZ002', '画串口线（直/9cm)2*1', 15, 13.5200, 0.0473, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5609, 'ZYSZXFQHZZ003', '绱领（直/9cm+4cm)2*1', 156, 49.0600, 0.1717, 'STITCHING', NULL, b'1', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5610, 'ZYSZXFQHZZ004', '倒烫2*1', 20, 53.2500, 0.1331, 'STITCHING', NULL, b'0', '', '将缝制好的侧缝平放在烫台上，先把侧缝劈缝烫开至开衩折角，再单边往后身片倒烫；再翻至正面将开衩抚平，小片与开衩叠量约6.0cm～7.0cm，顺烫开衩边', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5611, 'ZYSZXFQHZZ005', '打串口两端刀眼2*1', 15, 17.2600, 0.0431, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5612, 'ZYSZXFQHZZ006', '分烫串口线2*1', 19, 18.3000, 0.0457, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5613, 'ZYSZXFQHZZ007', '粘贴领里串口*1', 19, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5614, 'ZYSZXFQHZZ008', '缝前衩（直/21+8cm）2*1#line#', 152, 66.1700, 0.1654, 'STITCHING', NULL, b'0', '', '先将小片里布开衩A点与面布刀口对齐，从面下摆对折开始缝制，里布略带紧缝制  至里布刀口A处，A处打刀口深0.9cm，合缝止口1.0cm；成品后小衩边里布坐势0.1cm，铺平里布平整无多余松量，里布下摆与面下摆边相距1.5cm。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5615, 'ZYSZXFQHZZ009', '缝领里（直/7.6+24.6+7.6cm)*1', 147, 38.7900, 0.1261, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5616, 'ZYSZXFQHZZ010', '缝夹里肩缝(弯/18.0cm+18.0cm)', 155, 35.4000, 0.1150, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5617, 'ZYSZXFQHZZ011', '缝后领脚夹里（弯/18cm）', 156, 22.8000, 0.0741, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5618, 'ZYSZXFQHZZ012', '修剪串口2*1', 161, 9.4300, 0.0236, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5619, 'ZYSZXFQHZZ013', '定缝驳面、后领脚（弯/50+50cm）2*1', 243, 29.5200, 0.0959, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5620, 'ZYSZXFQHZZ014', '缲缝驳面、后领内缝（弯20+5+20cm）*1', 237, 24.2300, 0.0787, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5621, 'ZYSZXFQHZZ015', '下摆缲边、缲边打结（直/30+40+30cm）*1', 237, 56.6400, 0.1841, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5622, 'ZYSZXFQHZZ016', '前衩止口线（直/23cm）2*1', 152, 33.7000, 0.0800, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5623, 'ZYSZXFQHZZ017', '烫前衩2*1', 19, 24.9400, 0.0592, 'STITCHING', NULL, b'0', '', '将缝制好的前衩平放在烫台上，再把前衩里布烫平，面坐势为0.1cm（里布平整无多余松量）', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5624, 'ZYSZXFQHZZ018', '缝双里侧缝（弧/35cm）2*1', 152, 81.9800, 0.2664, 'STITCHING', NULL, b'0', '', '从刀口A点缝位1.0cm顺缝至B点缝位1.5cm，距B点腋下10cm处后身片吃势为0.3cm～0.4cm。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5625, 'ZYSZXFQHZZ019', '缲缝下摆面贴边（25+29+25cm）3*1', 237, 26.8200, 0.0671, 'STITCHING', NULL, b'0', '', '距挂面缝边2.0cm处缲缝下摆贴边，缲线边距布边0.5cm。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5626, 'ZYSZXFQHZZ020', '烫双侧里缝2*1', 19, 20.4900, 0.0512, 'STITCHING', NULL, b'0', '', '把里布平铺烫台上，将里布侧缝缝头往后身片倒烫', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5627, 'ZYSZXFQHZZ021', '折烫下摆夹里3*1', 19, 40.5700, 0.1014, 'STITCHING', NULL, b'0', '', '将前里下摆折烫顺直；下摆面、里相距1.5cm。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5628, 'ZYSZXFQHZZ022', '定缝下摆夹里（22+17+22cm）3*1', 243, 30.5900, 0.0765, 'STITCHING', NULL, b'0', '', '将里布下摆边与面下摆相距1.5cm摆平，然后距里布下摆边1.5cm在里上定线一道', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5629, 'ZYSZXFQHZZ023', '缝合肩缝（弯/18+18cm）2*1', 155, 41.1500, 0.1337, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5630, 'ZYSZXFQHZZ024', '分烫、压烫肩缝2*1', 19, 18.9900, 0.0617, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5631, 'ZYSZXFQHZZ025', '捋肩2*1', 243, 31.4800, 0.1023, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5632, 'ZYSZXFQP001', '平车开手巾袋连剪开袋口连压暗线连封袋口连合袋布连运袋布1个*1', 156, 114.7600, 0.4303, 'STITCHING', NULL, b'1', '1、手巾袋净宽2.7cm，深14cm（净）居左省道上口中心，丝绺与大身一致。#line#2、袋口两端宽窄一致，起翘2.5cm。#line#3、手巾袋丝绺与大身一致，两侧袋盖封切顺直，袋口缝0.5cm，切线牢固不毛出，不漏针，封口处无凹势弯曲。#line#4、手工暗封袋口面不透针，松紧适宜。#line#5、手巾袋布，缝位一致1.5cm切线顺直，两层袋布斜度一致，服帖到位。', '1、衣片平面平铺，手巾袋按定位点找直丝绺，里袋盖瓣开，按手巾衬切外袋盖的第一道线，切线顺直不上坑下坑，起落回针固定。#line#2、袋垫正面朝上塞入外袋盖缝位蚋，袋垫上切第二道线与第一道线平行距0.7-0.8cm两端起落针以手巾袋翻折上，能掩盖往第二道线为准则。#line#3、反面顺直开剪手巾袋口，袋角修剪三角到位不毛出。#line#4、手巾袋按要求理正，服于衣片上送入压脚内切线，起落手回针，封线不上坑下坑，袋口转角切线清晰不毛出。#line#5、衣片翻到反面，左手抵住手巾袋，手工针迹放大撬四针左右，手巾袋正面无痕迹。#line#6、手巾袋下嵌线与袋布相拼，距第一道线0.2cm平直切线，两层袋布重叠一致圆顺切角。#line##line##line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5633, 'ZYSZXFQP002', '手工翻袋盖连按样板烫袋盖(两端圆角/28cm)1个*2', 19, 34.9500, 0.0874, 'STITCHING', NULL, b'1', '1、袋盖面里紧形成窝势，袋盖不反翘，前侧丝绺直，条格进出一致。#line#2、大袋盖三周里外一致均为0.1cm-0.15cm，里布不反吐。', '1、袋盖三周缝位修小尤其是圆角处，袋盖翻面套入模版，两袋角圆顺，三周里外匀环均匀烫出。#line#2、取出模版，袋盖往底边翻折吸风定型。#line#3、左右两袋盖对称操作。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5634, 'ZYSZXFQP003', '驳边机驳手巾袋（直/2.5cm)两端*1', 232, 40.7000, 0.1323, 'STITCHING', NULL, b'1', '1、手巾袋丝绺与大身一致，两侧袋盖封切顺直，袋口缝0.5cm，切线牢固不毛出，不漏针，封口处无凹势弯曲。#line#2、手工暗封袋口面不透针，松紧适宜。', '1、手巾袋按要求理正，服于衣片上送入压脚内切线，起落手回针，封线不上坑下坑，袋口转角切线清晰不毛出。#line#2、衣片翻到反面，左手抵住手巾袋，手工针迹放大撬四针左右，手巾袋正面无痕迹。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5635, 'ZYSZXFQP0038', '收腰省（直/15CM）1条*2', 156, 32.7700, 0.1065, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5636, 'ZYSZXFQP004', '撬边机撬驳头牵衬（直/40+40CM）2条*2及撬面口袋布（直/10CM）1条*2', 237, 34.0800, 0.1193, 'STITCHING', NULL, b'1', '1、胸衬牵带两侧及前侧袋布边撬线。#line#2、根据面料厚薄适当调节撬线深浅，面不透针，松紧适宜。', '1、衣片反而朝上，胸衬牵带送入压脚内，撬时略带紧牵带，一片往前送外侧与机纺衬撬住，内侧与胸衬撬住。#line#2、袋布放平服，不左右歪斜，前侧袋布缝位与衣片撬线固定。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5637, 'ZYSZXFQP005', '撬手巾袋袋口（直/10cm)*1', 237, 13.5300, 0.0474, 'STITCHING', NULL, b'1', '1、手巾袋丝绺与大身一致，两侧袋盖封切顺直，袋口缝0.5cm，切线牢固不毛出，不漏针，封口处无凹势弯曲。#line#2、手工暗封袋口面不透针，松紧适宜。', '1、手巾袋按要求理正，服于衣片上送入压脚内切线，起落手回针，封线不上坑下坑，袋口转角切线清晰不毛出。#line#2、衣片翻到反面，左手抵住手巾袋，手工针迹放大撬四针左右，手巾袋正面无痕迹。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5638, 'ZYSZXFQP006', '手工修剪胸衬（弯/28cm+直/19cm）1条*2', 15, 35.3600, 0.0884, 'STITCHING', NULL, b'1', '1、颈侧点处胸衬伸出0.5cm，外肩端点高出2.0cm，袖窿上端胸衬伸出0.8cm-1.0cm，袖窿第二只刀口上2cm伸出0.5cm，腋下伸出0.3cm。#line##line#2、胸衬修剪圆顺无毛出。#line#', '1、衣片正面平铺，下层胸衬放平服，按要求修剪胸衬，修剪精确，胸衬与面布袖窿一致化剪二只刀口。#line#2、掀开衣片及第一层黑炭衬，修剪马尾衬。马尾衬圆顺修进2cm左右。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5639, 'ZYSZXFQP007', '烫驳头衬（直/30cm)1条*2连画归量（直/2cm）1*2', 19, 43.9100, 0.1098, 'STITCHING', NULL, b'1', '要求驳头翻折自然，溶位均匀。', '胸衬粘2cm宽牵条带，驳头吃量0.8cm-1cm。容量均匀到位（吃量根据翻驳线长短，面料厚薄调节）#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5640, 'ZYSZXFQP008', '专机珠手巾袋边0.15cm（直/12cm）1条*1', 234, 11.1000, 0.0388, 'STITCHING', NULL, b'1', '线迹均匀、直顺、松紧适宜、止口不反吐', '将手巾袋正面朝上，成串缝制，缝完后成串剪线', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5641, 'ZYSZXFQP009', '专机袋盖珠边0.15cm（两端圆角/28cm）1个*2', 234, 36.0100, 0.1260, 'STITCHING', NULL, b'1', '线迹均匀、中间直顺、两角圆顺。', '将袋盖正面朝上，成串缝制，缝完后成串剪线', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5642, 'ZYSZXFQP010', '专机定型前片*2同时垫肩衬1*2', 59, 42.4100, 0.1060, 'STITCHING', NULL, b'1', '1、胸部平挺饱满，胸位不偏移袋盖不反翘。#line#2、衣片止口顺直，省道略往止口圆弧推弯0.2cm-0.3cm袖笼领圈弧度保持不变形。', '1、衣片覆上模具相吻合，肩缝至袖笼下第一只刀口放置于模具冲肩弧状上，各部位丝绺铺直吸风。#line#2、胸省圆顺弧度推弯，但余量不往止口外拉，轻轻拍平于止口内，前侧止口丝绺顺直。#line#3、驳头处略归拢量由下往上提，领圈不变动，翻驳线处衣片容量放平。#line#4、腋下横丝往上提，直丝往内推进，保持袖笼丝绺横平竖直。#line#5、腰节下丝绺放平，手巾袋，大袋盖垫衬，压机打一下蒸汽。#line#6、抬摸后背消除袋盖遗留印迹。衣片取下放平。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5643, 'ZYSZXFQP011', '敷胸衬（直/30+10+30+20+30cm+弯/20cm）1片*2', 233, 69.1000, 0.2246, 'STITCHING', NULL, b'1', '1、胸衬与面布规格相符，胸部平挺饱满无余量，丝绺顺直。#line#2、胸衬付2cm宽直料牵带吃量均匀到位（吃量根据翻驳线长短，面料厚薄调节）驳头翻折自然。', '1、胸衬与翻驳线比齐，伸出颈侧点0.5cm先在反面在翻驳线上扎线固定胸衬①。#line#2、翻回正面，胸部丝绺理直，扎线由上往下订（省道延长线上）②。#line#3、袖笼与胸衬放平服，袖笼丝绺横平竖直，弧形定第③道线上，余量往止口推出，平扎第④道线。#line#4、前衣片捏起往袖笼折转，余量推出腋下横丝略往上提，袖笼扎线固定⑤。#line#5、衣片往前止口折转量推出抚平，折除①线定⑥线。#line#6、按翻驳线覆上牵带，领圈开始上往下付先平扎8-9cm横向扎两针定位纵向牵带开始拉紧吃量约0.6cm与胸围线平行吃量较多，剩余牵带平缝。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5644, 'ZYSZXFQP012', '收前胸省同时落垫布（直/20cm）1条*2连打剪口1个*2', 156, 67.0600, 0.2347, 'STITCHING', NULL, b'1', '1、收胸省切线顺直，腰节下缝位0.5cm，腰节至省尖收尖。#line#2、两胸省长短对称进出一致，条料对条格料对格省尖不出现尖窝或省面松紧现象。#line#3、垫布左右两侧对称，平服。#line#4、针距14-15针/3cm,切线顺松紧适宜，无跳针，断线现象。', '1、衣片正面平放，按胸省剖开线翻折（袖笼）衣片，衣片反面朝上根据剖开线两层衣片比齐，省尖垫入本色布，垫出省尖1cm比剖开点袋位上0.5cm-0.8cm左右。#line#2、切线由省尖往下切，留线1cm于垫布上，按划线收省，省尖一定收尖，上下层面料受力一致#line#3、右片由袋位往上收省，其余对称操作。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5645, 'ZYSZXFQP013', '自动运模机运袋盖（两端圆角/28cm）1个*2', 274, 28.7300, 0.0934, 'STITCHING', NULL, b'1', '要求左右两袋盖对称，走线顺直，袋盖三周修剪，留缝位0.5cm。', '按规格选好模板，里布放下面，反面朝下，面布放上面，反面朝上。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5646, 'ZYSZXFQP014', '平车合前侧缝（弧/55cm）1条*2（中间断开）', 156, 53.7900, 0.1883, 'STITCHING', NULL, b'1', '1、拼小侧片缝位一致1cm各刀口对准无偏差。#line#2、袖笼至腋下10cm内大身约有0.2cm吃量。#line#3、切线松紧适宜，无跳针、断线现象。#line#4、3cm/14针#line#', '1、左片拼小片从袖笼往下缝制，小片居上袖笼圆顺比齐，大身略往上送量均匀吃进，余下平缝到底。 #line#2、右片拼小侧片由底摆往上缝制（底摆平齐），其余对称操作。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5647, 'ZYSZXFQP015', '走定肩缝（直/18cm）1条*2连拉前片袖笼牵条（弯/40cm）1条*2', 156, 70.0600, 0.2277, 'STITCHING', NULL, b'1', '1、肩部丝绺保持原型，平拉0.6cm宽的45度斜料。#line#2、前袖窿第一只刀口上，用1.5cm直料牵带，余下用0.4的扁带拉袖窿，斜丝绺部位吃量较大，直丝处平缝为主，吃量均匀到位，具体吃量根据面料厚薄调节，两袖对称一致。', '1、衣片反面朝上，斜料牵带平方于肩缝上放入压脚内，居中切线平缝到两端。#line#2、前袖窿从肩缝到第一只刀口止牵条均匀吃进0.2-0.3cm，0.4cm扁带叠上1.0cm继续缝制，#line##line#如图所示：#line#（1）以平缝为主；（2）牵条略带紧吃0.2cm；（3）腋下平缝过渡；（4）牵带带紧0.3cm左右', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5648, 'ZYSZXFQP016', '烫开前胸省及前侧缝（直/20+55cm）1片*2连烫串口牵条（直/50cm）1条*2连烫袋口衬布（直/25cm）1片*2', 19, 57.9000, 0.1447, 'STITCHING', NULL, b'1', '1、两胸省分缝压烫，缝位线丝绺顺直，省尖部出现尖窝或省面松紧现象。#line#2、袋口合并无重叠无豁开，25g无纺衬粘合固定。#line#3、侧缝缝位分烫顺直，无坐势。#line#4、侧片袋位粘25g无纺衬，粘合牢固不脱落。', '1、衣片反面朝上平放，与省尖平齐处开剪垫布，省尖下的两层垫布朝袖窿倒烫，省剖开点处化剪一刀口，省尖缝位朝前止口倒烫，余下胸省缝位分缝烫开，熨斗将其烫煞，用力到位，省烫顺直，垫布修小，两层垫布修成阶梯形，两侧对称操作。#line#2、袋口丝绺理直合并拢，吸风，居中放上无纺衬，留出侧缝缝位熨斗压烫牢固。#line#3、衣片反面朝上放置，侧缝用熨斗压烫开，缝线烫顺直。#line#4、袖窿弧线圆不下坠，底摆平齐。#line#5、在大身袋口衬的延长线上粘合侧片的袋口无纺衬，无纺衬不与侧缝缝位重叠，熨斗压烫定位。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5649, 'ZYSZXFQP017', '00', 245, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5650, 'ZYSZXFQP018', '翻面袋唇连封三角连合垫布（直/20cm）2条*2连运袋布（方角/20+20+20cm)1条*2连封袋口（直/15cm）1条*2', 156, 172.3000, 0.6461, 'STITCHING', NULL, b'1', '1、袋垫下口平直压0.1cm止口，上口与袋布平齐。#line##line#2、洗水唛居左里袋，小三角居右里袋，位置居中不偏斜。#line##line#3、里袋袋角切圆顺，卡袋袋角切方正，袋布缝位一致1.5cm（挂面—侧里袋缝位为2cm）。#line#', '1、里袋两嵌线理成宽窄一致，小三角对折线朝上放入，两嵌线内居中，上嵌线下口对准小三角缝位线（小三角中心线净高5cm），上嵌线缝位上抛线三角定位。#line##line#2、拼下袋布与嵌线缝位平齐切线，拼上袋布缝位距嵌线上口1.5cm，上口切线居中略呈弧线。#line##line#3、袋口两端小三角回针封固，袋角方正无起皱，上下层袋布缝合按要求#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5651, 'ZYSZXFQP019', '折压垫袋布（直/20cm）1条*2#line#', 156, 25.7000, 0.0835, 'STITCHING', NULL, b'1', '垫袋布线顺直、平服。', '先将袋布车好，再将垫袋布缝合车平整', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5652, 'ZYSZXFQP020', '专机开双唇袋同时放袋盖（直/18cm)1个*2', 265, 33.0200, 0.1156, 'STITCHING', NULL, b'1', '1、男装袋盖宽5cm，前侧出胸省2cm，两袋盖对称宽窄进出一致，袋角无反翘。#line#2、袋口嵌钱宽一致均为0.5cm与袋盖平服，袋盖丝绺与大身一致。', '1、衣片正面平摊光线对准袋位线，前侧光线出胸省1.5cm踩左脚吸风，踩右脚两下，大压脚放下，在袋位线上依次放入嵌线及纸衬位置居中，踩右脚一下，小压脚放下左侧放入袋盖（开大袋只放右边压脚，分清左右袋盖）。#line#2、踩一下右脚进行自动缝制，并由收料架自动放好。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5653, 'ZYSZXFQP021', '按样画面袋位印（直/5+12cm)1片*2', 15, 23.0700, 0.0577, 'STITCHING', NULL, b'1', '画粉以隐形画粉为宜，不能留粉印在外', '按版前端直纱对准面袋布直纱画样，留缝位后多余的修剪#line#面口袋规格为：88-92的15.2cm,96-104的位15.5cm，108-112的为15.8cm.', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5654, 'ZYSZXFQP022', '剪开双唇袋（直/15cm）两端*2', 15, 50.5500, 0.1264, 'STITCHING', NULL, b'1', '要求车线顺直，两层袋布斜度一致，袋口封口不重叠，不豁口。', '袋口两端打三角剪口距缝线0.1cm,(不能剪开线）垫袋布上口与袋布平齐，下口折光，压线0.1cm，大袋布缝位1.5cm。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5655, 'ZYSZXFQP023', '按样画手巾袋印（直/11cm）1条*1连打两端剪口2个*1', 15, 16.1700, 0.0404, 'STITCHING', NULL, b'1', '画粉以隐形画粉为宜，不能留粉印在外', '按版前端直纱对准手巾袋布直纱画样，留缝位后多余的修剪', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5656, 'ZYSZXFQP024', '前片压机定型1片*2', 59, 29.1600, 0.0729, 'STITCHING', NULL, b'1', '1、胸部平挺饱满，胸位不偏移袋盖不反翘。#line#2、衣片止口顺直，省道略往止口圆弧推弯0.2cm-0.3cm袖笼领圈弧度保持不变形。', '1、衣片覆上模具相吻合，肩缝至袖笼下第一只刀口放置于模具冲肩弧状上，各部位丝绺铺直吸风。#line#2、胸省圆顺弧度推弯，但余量不往止口外拉，轻轻拍平于止口内，前侧止口丝绺顺直。#line#3、驳头处略归拢量由下往上提，领圈不变动，翻驳线处衣片容量放平。#line#4、腋下横丝往上提，直丝往内推进，保持袖笼丝绺横平竖直。#line#5、腰节下丝绺放平，手巾袋，大袋盖垫衬，压机打一下蒸汽。#line#6、抬摸后背消除袋盖遗留印迹。衣片取下放平。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5657, 'ZYSZXFQP025', '专机合挂面（直/7+7+弧/33cm）1条*2', 233, 43.9000, 0.1536, 'STITCHING', NULL, b'1', '1、驳头1/2上丝绺必须直，挂面横竖均匀吃进0.3cm-0.4cm左右，条对条，格对格两驳头必须进出一致。#line#2、前止口顺直，驳角及下摆圆角自往呈窝势，挂面与面布笃线松紧适宜', '1、挂面在下与衣片一同铺开，领圈处挂面伸进2cm左右，驳头处挂面横竖场伸出0.3cm-0.4cm，前止口平齐，捏住两层不松动先定翻驳线。#line#2、翻转衣片止口比齐，未扣住挂面推上0.4cm左右的量，由驳口往下打圆角开始转变处圆角挂面往两侧略撑开呈窝势笃进。底摆处挂面提0.1cm左右。#line#3、驳口处开始挂面推进与面布平齐笃线，驳头中间段挂面纵向略绷紧吃量较为集中于驳角（如图），余量起皱方向与翻驳线呈直角。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5658, 'ZYSZXFQP026', '平车合挂面（弯/83cm）1条*2', 156, 109.3100, 0.3826, 'STITCHING', NULL, b'1', '1、缝位一致1cm各刀口必须对称。#line##line#2、里布胸部位裥重叠2cm（按刀口），里布上半部斜丝略吃量，挂面第二只刀口到第三只刀口里布约吃0.3cm，第三只刀口到第四只刀口里布约吃0.2cm。#line##line#', '1、里布放于下层，挂面居上第一只刀口对牢，从刀口上1cm左右开始缝制，里布折裥刀口与挂面第二只刀口对准，里布略松往下缝制。#line#2、缝制到第四只刀口下一针左右打回针，下摆里布应比面布长出1cm左右。#line#3、拼好后里布整体有一些松量，但无起皱，左右两片挂面对称操作。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5659, 'ZYSZXFQP027', '手工拆挂面线连打剪口1片*2。视频100秒3件', 15, 43.6300, 0.1091, 'STITCHING', NULL, b'1', '不能猛拉线迹，不能拉出纱头，保证衣身完整。', '将挂面辅助线拆除。视频100秒3件', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5660, 'ZYSZXFQP028', '专机挂面定位1*2', 233, 47.4000, 0.1659, 'STITCHING', NULL, b'1', '1、驳头丝绺横平竖直，翻折容量适宜。#line#2、挂面中间段容量适宜均匀吃进约0.5cm。', '挂面朝上平铺，里层袋布都放平整，先定：#line#（1）、由下往上订，丝绺横平竖直放正，余量往上赶，锁定住里袋口下10cm左右内，余量摆放均匀。#line#（2）、串口线下抛线防止驳头容量往上跑，此处丝绺保持横平竖直，领串口不起眼窝。#line#（3）、顺翻驳线定位，使驳头容量不往外跑。#line#（4）、笃挂面由上往下定，横丝放平挂面有量均匀吃进，里袋口布内缩稍往外拉一把放平后继续打挂面，拼缝接线顺直。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5661, 'ZYSZXFQP029', '专机撬挂面下端及内口袋布（直/12+12cm）2条*2', 220, 51.3500, 0.1669, 'STITCHING', NULL, b'1', '1、挂面平直，表面平整。#line#2、撬线松紧根据面料厚薄调节，面不透线。', '1、衣片放平整，驳头挂面丝绺理顺直不歪斜，里布掀开，撬住里袋布边及挂面缝位。#line#2、撬线能连则连，不能连单独撬边。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5662, 'ZYSZXFQP030', '专机上垫肩2个*1', 233, 26.7000, 0.0868, 'STITCHING', NULL, b'1', '   打垫肩符合人体肩部弧度位置正确不偏斜，扎针均匀。 #line#', '1、垫肩放入胸棉与黑炭衬之间，底层里布掀开，肩端点垫肩伸出0.8-1cm（与胸衬差不多平行）垫肩口的洞对准，前袖笼肩缝（毛）下0.3-0.5cm垫肩尾端中心对准肩缝毛边。#line#2、掀开面布手托住后垫肩凸起，先扎垫肩处围线后均匀打三角针冲肩，三角下口张开以2-3分/针为基础，尖角不宜过长。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5663, 'ZYSZXFQP031', '专机挂面定型1片*2#line#', 59, 47.6000, 0.1190, 'STITCHING', NULL, b'1', '定型后驳头自然服帖，归襟不掉不豁，自然下垂挺直。', '将衣片分左右对应模具摆对，将驳头摆放平整。前端直纱处不能内凹，纱向顺直，挂面上端与衣身横开领，充分吻合，溶位固定在里口袋两侧各10cm处均匀溶位，口袋位置左右完全一致。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5664, 'ZYSZXFQP032', '烫开挂面止口（弯/80cm）1条*2', 19, 30.9500, 0.0774, 'STITCHING', NULL, b'1', '1、驳角刀口修剪到位两驳头大小一致，驳角，圆摆缝位修小。#line#2、止口缝位分烫烫开，烫顺直无座势。', '1、对准驳角缝线的端点，剪刀口略呈斜线，不剪断缝线，缝位平修至0.3cm。#line#2、止口缝位朝上套入模具内，止口不拉长，熨烫驳头时熨斗侧重压烫，衣片缝位，熨烫到止口时熨斗侧重压烫挂面缝位，缝位烫开平服到位。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5665, 'ZYSZXFQP033', '烫定挂面连翻角连折烫底边1片*2', 19, 118.9800, 0.2975, 'STITCHING', NULL, b'1', '止口充分烫平烫死，驳头上端10cm处要求直纱笔直，两片长短、形状一致，驳头、下圆角窝服自然， 转折点翻转自然。', '先将驳角、圆下摆翻圆顺，翻驳点以上止口往前片座势0.1cm，翻驳头以下止口往挂面座势0.1cm，驳角处稍圆角。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5666, 'ZYSZXFQP034', '手工修剪里前片（18+30+48+20cm）1片*2连打袖笼剪口2个*1', 15, 84.6800, 0.2117, 'STITCHING', NULL, b'1', '侧缝里布与面布侧缝（毛）一致，修顺直无毛出', '1、前衣片面里层放平服，掀平面布小侧片，前侧里布按面布侧缝（含1cm）缝位修剪。#line#2、左右两片对称操作。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5667, 'ZYSZXFQP035', '烫平手巾袋1片*1及面袋1片*2', 19, 43.7500, 0.1094, 'STITCHING', NULL, b'1', '1、手巾袋角度清晰，宽窄一致， 2.7cm，烫出里外均0.1-0.2cm。#line#2、胸围104-108：9.5cm； 胸围110-118:10cm；胸围120-124:10.5cm；胸围126以上：11cm；胸围136以上：12cm。', '1、看清手巾袋丝绺，平粘树脂衬缝位内折，吸风烫顺直，袋角烫出角度转角上开剪刀口，便于平服。#line#2、手巾袋不烫歪斜（里）面布扣下，手巾袋（有树脂衬一层）掩盖住内层袋盖烫出里外均不反吐。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5668, 'ZYSZXFQP036', '画手巾底印连折烫手巾袋印连打剪口连折烫手巾袋两端', 19, 50.7400, 0.1268, 'STITCHING', NULL, b'1', '1、手巾袋角度清晰，宽窄一致， 2.7cm，烫出里外均0.1-0.2cm。#line#2、胸围104-108：9.5cm； 胸围110-118:10cm；胸围120-124:10.5cm；胸围126以上：11cm；胸围136以上：12cm。#line#', '1、看清手巾袋丝绺，平粘树脂衬缝位内折，吸风烫顺直，袋角烫出角度转角上开剪刀口，便于平服。#line#2、手巾袋不烫歪斜（里）面布扣下，手巾袋（有树脂衬一层）掩盖住内层袋盖烫出里外均不反吐。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5669, 'ZYSZXFQP037', '刀车修挂面止口（弧/85CM）1片*2', 167, 43.5400, 0.1415, 'STITCHING', NULL, b'1', '翻驳点以下应大身缝位：修剪后大身缝位留0.3cm，挂面缝位留0.6cm；#line#翻驳头点以上修挂面缝位：修后大身缝位留0.6cm,挂面缝位0.3cm，#line#驳角及圆摆两片一齐修，缝位留0.25cm.', '翻驳头以下应大身缝位，翻驳头以上修挂面缝位，驳角及圆摆处两片一齐修。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5670, 'ZYSZXFQP038', '烫前腋下小片（直线/40cm）1条*2', 19, 13.6100, 0.0323, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5671, 'ZYSZXFQP039', '000', 158, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5672, 'ZYSZXFQP040', '收腰省（直/15CM）1条*2', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5673, 'ZYSZXFQP041', '缝前袖笼牵带（弯/45cm)1条*2', 156, 20.8700, 0.0678, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5674, 'ZYSZXFQP046', '00', 150, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5675, 'ZYSZXFQP047', '缝胸省1*2', 156, 42.8000, 0.1498, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5676, 'ZYSZXFQP048', '', 19, 20.8900, 0.0679, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5677, 'ZYSZXFQP049', '缝腋下小片(弧/56cm）1*2', 156, 51.5600, 0.1805, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5678, 'ZYSZXFQP050', '前肩缉线连拉袖窿牵带（弯/17+41cm)1*2', 156, 68.0600, 0.2212, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5679, 'ZYSZXFQP051', '分烫胸省连烫腋下缝连烫袋口衬1*2', 19, 28.1000, 0.0913, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5680, 'ZYSZXFQP052', '前身归拔1*2', 19, 40.7300, 0.1426, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5681, 'ZYSZXFQP053', '画驳口翻折线（直/26cm）1*2', 15, 17.9800, 0.0584, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5682, 'ZYSZXFQP054', '附胸衬连拉驳口牵带1*2', 243, 82.4400, 0.2885, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5683, 'ZYSZXFQP055', '烫前片驳口牵带1*2', 19, 26.4000, 0.0858, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5684, 'ZYSZXFQP056', '缲缝袋布、驳口牵带1*2', 237, 54.6400, 0.1776, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5685, 'ZYSZXFQP057', '前身片定型*2', 59, 47.7400, 0.1552, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5686, 'ZYSZXFQP058', '修剪胸衬*1', 161, 35.7900, 0.1163, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5687, 'ZYSZXFQP059', '修剪驳头串口1*2', 161, 27.4000, 0.0890, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5688, 'ZYSZXFQP060', '画驳头止口线1*2', 161, 19.5300, 0.0635, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5689, 'ZYSZXFQP061', '做眼位标记*1', 15, 7.3200, 0.0238, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5690, 'ZYSZXFQP07', '合缝前腋下小片（直/40cm）1条*2', 156, 39.3200, 0.1376, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5691, 'ZYSZXFQPZZ001', '附挂面*2', 243, 59.2700, 0.2223, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5692, 'ZYSZXFQPZZ002', '缝挂面连拉牵带*2', 155, 106.4000, 0.3990, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5693, 'ZYSZXFQPZZ003', '拆连修前门止口线*2', 167, 86.1200, 0.2799, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5694, 'ZYSZXFQPZZ004', '分烫止口缝*2', 19, 13.6100, 0.0442, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5695, 'ZYSZXFQPZZ005', '翻连烫前门止口连下摆贴边*2', 19, 90.3800, 0.3163, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5696, 'ZYSZXFQPZZ006', '定缝前门止口*2', 243, 26.6300, 0.0865, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5697, 'ZYSZXFQPZZ007', '定缝挂面、绱垫肩1*2', 243, 33.8200, 0.1184, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5698, 'ZYSZXFQPZZ008', '缲缝挂面内缝、袋布1*2', 237, 39.3000, 0.1375, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5699, 'ZYSZXFQPZZ009', '修剪前里腋下缝1*2', 15, 46.9300, 0.1643, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5700, 'ZYSZXFQPZZ010', '缝夹里小片(直56/cm+8cm)1*2', 156, 90.6100, 0.3171, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5701, 'ZYSZXFQPZZ011', '烫前身夹里1*2#line#', 19, 21.9500, 0.0768, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5702, 'ZYSZXFQPZZ012', '修剪前身夹里1*2', 61, 67.1400, 0.2350, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5703, 'ZYSZXFQPZZ013', '缝双侧缝（面）(弯60/cm）1*2', 156, 84.6500, 0.2963, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5704, 'ZYSZXFSJD001', '冲手巾袋面布连衬*1', 288, 22.9900, 0.0747, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5705, 'ZYSZXFSJD002', '烫手巾袋衬连编号连压衬*1', 156, 7.9100, 0.0257, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5706, 'ZYSZXFSJD003', '折缝手巾袋*1', 156, 32.7000, 0.1063, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5707, 'ZYSZXFSJD004', '烫手巾袋*1', 19, 5.7500, 0.0187, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5708, 'ZYSZXFSJD005', '缝开手巾袋*1', 156, 45.9800, 0.1609, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5709, 'ZYSZXFSJD006', '分烫手巾袋*1', 19, 19.0700, 0.0620, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5710, 'ZYSZXFSJD007', '定缝手巾袋*1', 156, 20.6200, 0.0670, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5711, 'ZYSZXFSJD008', '手巾袋套结*1', 147, 31.1100, 0.1011, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5712, 'ZYSZXFSJD009', '接缝连缝合手巾袋袋布*1', 156, 37.6300, 0.1223, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5713, 'ZYSZXFSJD010', '缲缝手巾袋口*1', 237, 9.4800, 0.0332, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5714, 'ZYSZXFSXZZ001', '绱袖（弯/54CM）2边*1', 204, 197.5400, 0.7408, 'STITCHING', NULL, b'0', '1：绱袖缝位顺直；吃势均匀、准确到位、刀口对齐；#line#2：成品袖子圆顺、服贴、不起吊，前后对称；', '缝制操作：#line#    1.把袖子与前身袖窿的正面相对，前袖的弧度与前袖窿的弧度相吻合，并且袖子刀  口与袖窿刀口对齐，再进行顺边缝合，缝位：0.8cm 。（吃势见图一）#line#    2.另一个绱袖侧反方向缝制，以外袖缝处开始缝制。（如图一、图二）', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5715, 'ZYSZXFSXZZ002', '烫袖笼吃势  2边*1', 19, 35.9200, 0.0808, 'STITCHING', NULL, b'0', '吃势熨烫平服，无拉开、无变形。', '将袖窿平顺放在  烫模上按袖窿弧度摆放熨烫吃势，由内向外把绱袖的吃势烫匀、烫平。', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5716, 'ZYSZXFSXZZ003', '打袖山两端刀眼  2边*1', 15, 11.0200, 0.0248, 'STITCHING', NULL, b'0', '刀口准确、到位，前后刀眼对称', ' 1：（男装）：将前后身袖笼  距肩缝6.0cm处各打一个离绱袖线0.1cm的刀口。#line# 2：（女装）：将前后身袖笼  距肩缝5.0cm处各打一个离绱袖线0.1cm的刀口', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5717, 'ZYSZXFSXZZ004', '缝袖山垫布（弯/16CM）2边*1', 156, 37.0100, 0.0833, 'STITCHING', NULL, b'0', '', '缝制操作：#line#  1：袖山垫布规格：男装：16.0cmX3.0cm；#line#                  女装：14.0cmX3.0cm。（如图一）#line#  2：将袖山垫布平放在袖山刀眼间，两端垫布向刀眼外伸长约：2.0cm，从前袖窿垫布处开始来回针，垫布略带紧缝至后袖窿垫布处来回针；缉线距绱袖线0.1cm。（如图二）', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5718, 'ZYSZXFSXZZ005', '绱弹袖棉（弯/22CM）2边*1', 156, 75.2200, 0.1786, 'STITCHING', NULL, b'0', '缝位宽窄一致，中点对齐，缉线顺直，弹袖棉紧贴面袖，左右对称。', '1：根据衣身的规格来选择相应的弹袖棉。#line#    2-1：绱弹袖棉方法一：将弹袖棉放在袖笼上，弹袖棉与袖笼齐平，弹袖棉的中点对准衣身的肩缝，弹袖棉的前端对准前袖笼， 顺弹袖  棉线迹缝合衣身；缝线距绱袖线0.1cm。（如图一）#line#    2-2：绱弹袖棉方法二：将弹袖棉放在袖笼下，弹袖棉与袖笼齐平，弹袖棉的中点对准衣身的肩缝；弹袖棉的前端对准前袖笼；距绱袖线0.1缝合弹袖棉；（如图二）', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5719, 'ZYSZXFSXZZ006', '分烫袖山缝(弯/11CM）2边*1', 19, 32.1500, 0.0764, 'STITCHING', NULL, b'0', '1：袖山平服、圆顺、无拉开现象。', ' 1：将袖山头顺套在烫模边缘上，把袖山垫布和袖子劈缝烫开（袖山两端刀眼之间）', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5720, 'ZYSZXFSXZZ007', '捋胸、捋肩 （弯/44CM） 2边*1', 243, 54.8100, 0.1302, 'STITCHING', NULL, b'0', '袖窿圆顺，前胸平服', '缝制操作：#line#    1：将袖山垫布定线在棉条上；（如图一）#line#    2：将前身袖窿腋下段的胸衬固定在袖窿上，袖窿衬刀口对齐前身刀口；（如图二）#line#    3：用手托着衣身的肩缝点，并将袖山棉肩中点对齐肩缝点，抚平胸衬，握住袖山缝翻至正面，将肩缝放进临缝机，顺肩缝由内向外定线一道。（如图三）#line#    4：再将前胸向外捋平，由袖窿下往上固定一道至肩缝，定线紧靠袖窿。#line#    5：接着将后袖窿向上提约0.4cm的量，由外袖缝处开始定线至肩缝点，定线紧靠袖窿。（如图四、五、六）#line#    6：再将袖山垫布线拆掉，翻至正面检验衣身定线是否平服、袖窿是否圆顺。（如图七）', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5721, 'ZYSZXFSXZZ008', '缝切垫肩（弯/19）2边*1', 291, 55.0400, 0.1238, 'STITCHING', NULL, b'0', '1：缝线准确到位，线迹松紧适宜；#line#2：切缝圆顺，无棱角。', '缝制操作：#line#    1：将绱好的弹袖棉放在切垫肩机上缝切，从腋下处开始平顺缝切至后袖棉条，（另一个袖子顺序侧反方向缝制），缝线距绱棉条线0.1cm，切缝宽约1.0cm；垫肩厚处线迹调为松线缝制。（如图一、图二）', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5722, 'ZYSZXFSXZZ009', '定缝袖笼夹里、修剪袖笼夹里（弯/54CM）2边*1', 243, 56.0900, 0.1262, 'STITCHING', NULL, b'0', '里布定线平服、圆顺；各部位松紧适宜。', '缝制操作：#line#     1：将里肩缝与面肩缝对准，前、后身袖  窿缝要对齐，从肩缝处开始顺边定线一圈；腋下缝处里布按烫迹做个折（腋下省），腋下至后背缝段里布略松、至下摆里布松量约为0.5cm，定线宽约为0.7cm。（如图）#line#     2：将多余的袖窿里布修剪圆顺。（如图）', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5723, 'ZYSZXFSXZZ010', '绱里袖（下）（弯/25CM） 2边*1', 156, 86.7900, 0.2061, 'STITCHING', NULL, b'0', '里布松量适宜，不能有拉扭现象。', '缝制操作：#line#    1：把袖里翻出反面，将袖里内缝与袖面的内缝对齐，从前里折位处开始平顺缝至后袖里外缝处，并且袖面缝与袖里缝要对齐，缝位：0.7cm。（另一个袖子侧反方向缝制）（如图一）#line#    2：再将袖里翻至正面比对袖山里布的量是否适宜。（如图二）', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5724, 'ZYSZXFSXZZ011', '缲缝袖山夹里（弯/23CM）2边*1', 237, 41.6300, 0.0989, 'STITCHING', NULL, b'0', '1：缲边缝位平顺，吃势均匀。#line#2：袖山里布圆顺、里布无打折现象。', '缝制操作：#line#    1：从袖里内缝缺口处翻至袖山，将里袖山的上段放平；从前袖里合缝处重叠 1.0cm处缲缝袖山夹里；缲边缝位0.8cm；另一个袖则相反缲缝。（如图）', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5725, 'ZYSZXFSXZZ012', '袖里内缝封口（直/15）2边*1', 156, 20.4100, 0.0485, 'STITCHING', NULL, b'0', '缉线平顺、封口无漏洞', '缝制操作：#line#    1：将袖里内缝的缺口用平缝机封口，起止针来回定线一道，定线宽0.1cm。（如图）', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5726, 'ZYSZXFSXZZ013', '领脚贡针（弯/35CM）1*1', 234, 18.2400, 0.0433, 'STITCHING', NULL, b'0', '线迹顺直，领面无斜扭现象', '缝制操作：#line#      1：将领子平放在珠边机上，从领子的右边开始珠边至左边，珠边线距领脚缝0.15cm。（如图）', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5727, 'ZYSZXFXZ001', '烫开袖内缝连折烫袖口1片*2', 19, 47.6400, 0.1191, 'STITCHING', NULL, b'1', '1、缝位分缝烫开圆顺流畅，归拔到位无座势。#line#2、内袖缝无凹凸点出现，大袖叉平直内折3.5cm。', '1、缝位朝上按小袖片势道自然放置，由袖口往上分烫缝位，在中间两端刀口间伸烫一把往上烫中间段的大修片外围略归拢（如图）。#line#2、小袖片端往袖笼倒烫使丝绺往内撇进，小袖片袖笼上多出余量归拢。#line#3、袖口折边按刀口平直折烫进宽窄一致，大小袖片复合，小袖片居上烫除皱迹，内袖缝处大袖一致撇进2cm左右，弧度圆顺，大袖叉与大袖片缝位平直折烫进。#line#4、两袖左右对称操作。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5728, 'ZYSZXFXZ002', '固定袖衩角连合袖衩边及合袖外缝（直/7+46cm）1条*2连打袖衩剪口1个*2', 156, 89.8500, 0.3145, 'STITCHING', NULL, b'1', '#line#1、大小袖叉重叠3.2cm定位，大袖片居上。#line##line#2、合外袖缝位均匀1cm切线顺直。#line#', '1、大小袖叉缝位叠拢一致，袖口处大小袖口有里外匀，袖口正面抛线定位，外袖缝按袖片外形圆顺切线，缝至袖叉下1cm开始转折切线，到袖口折边上划刀口止，回针固定（如图）。#line#2、上下层袖片松紧适宜，左右两袖对称操作。#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5729, 'ZYSZXFXZ003', '平车定面里袖袖外缝固定条（直/3cm）1条*2连翻袖', 156, 34.2800, 0.1114, 'STITCHING', NULL, b'1', '1、大小袖叉重叠3.2cm定位，大袖片居上。#line#2、合外袖缝位均匀1cm切线顺直。', '1、大小袖叉缝位叠拢一致，袖口处大小袖口有里外匀，袖口正面抛线定位，外袖缝按袖片外形圆顺切线，缝至袖叉下1cm开始转折切线，到袖口折边上划刀口止，回针固定（如图）。#line#2、上下层袖片松紧适宜，左右两袖对称操作。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5730, 'ZYSZXFXZ004', '平车合袖口面里（直/30cm）1条*2', 156, 94.7600, 0.3317, 'STITCHING', NULL, b'1', '1、袖口处袖里与袖口折边比齐进出一致。#line#2、缝位均匀为1.5cm，面不透线松紧适宜。#line##line#', '、1、袖里反面朝外，套进转袖口机内，袖片跟着套进，袖里口与袖口折边套齐，上下层平服松紧适宜。#line##line#2、左手按住袖片，右手按住袖里缝位不滑动，一同随机往前旋转缝位一致，袖里缝位一致，袖里缝位朝大袖片倒。#line##line#3、清晰略松，可根据面料厚薄调节。#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5731, 'ZYSZXFXZ005', '烫开袖外缝（直/50cm）1条*2', 19, 29.5800, 0.0739, 'STITCHING', NULL, b'1', '1、外袖缝分缝烫开，烫圆顺流畅无座缝现象。#line##line#2、内袖缝压烫定型。#line#', '1、两袖分别套进配套的模具内，摆放符合模具外型。#line##line#2、外袖缝朝上，吸风将袖衩位朝大袖倒烫，缝位分缝烫开，袖窿处将小袖往袖窿内拔进，大袖片袖肘处略归拢，其余部分丝绺理平直压机下。#line##line#3、内袖缝朝上，平放到位中间段拉伸一把吸风，合模。#line##line#4、两缝位压烫煞，袖衩平服无反翘。#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5732, 'ZYSZXFXZ006', '运大袖衩角（直/5cm）1条*2', 156, 34.1800, 0.1196, 'STITCHING', NULL, b'1', '要求衩角方正，不起翘，止口均匀。', '两袖角按印划印再车线，小衩角缝位0.5cm。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5733, 'ZYSZXFXZ007', '折烫大袖口边及袖衩1条*2', 19, 27.3900, 0.0685, 'STITCHING', NULL, b'1', '1、 两袖衩角方正不反翘，袖口平服。#line##line#2、 割角线顺直无座势烫煞，小衩角里外不反吐。#line#', '1、将大袖衩缝位平缝捏平，顺势把衩角翻出，小袖角翻出自然里外匀，折边平服于袖片上不起空或拉紧。#line#2、袖片反面朝上平放烫台上，烫平两袖角不虚空，袖口平直无凹凸现象。#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5734, 'ZYSZXFXZ008', '专机撬袖口（直/20cm）1条*2', 237, 33.5200, 0.1173, 'STITCHING', NULL, b'1', ' 袖口贴边与面子上的无纺衬定位，松紧适宜根据面料厚薄适当调节撬线，表面无痕迹。', '1、袖片反面朝上，袖口折边平服送入压脚内，贴边下1cm内对压脚撬边，缝时袖口平直不歪扭。#line#2、左右两袖对称操作。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5735, 'ZYSZXFXZ009', '专机定型左右面袖内缝及袖口边及袖衩角1片*2', 59, 25.6500, 0.0641, 'STITCHING', NULL, b'1', '1、缝位分缝烫开圆顺流畅，归拔到位无座势。#line#2、内袖缝无凹凸点出现，大袖叉平直内折3.5cm。', '1、缝位朝上按小袖片势道自然放置，由袖口往上分烫缝位，在中间两端刀口间伸烫一把往上烫中间段的大修片外围略归拢（如图）。#line#2、小袖片端往袖笼倒烫使丝绺往内撇进，小袖片袖笼上多出余量归拢。#line#3、袖口折边按刀口平直折烫进宽窄一致，大小袖片复合，小袖片居上烫除皱迹，内袖缝处大袖一致撇进2cm左右，弧度圆顺，大袖叉与大袖片缝位平直折烫进。#line#4、两袖左右对称操作。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5736, 'ZYSZXFXZ010', '平车合袖内侧缝（直/48CM）1条*2', 156, 47.5300, 0.1545, 'STITCHING', NULL, b'1', '   缝位1.0cm切线按内袖缝弧度。', '1、大小袖片按内缝弧度正面叠拢，小袖片居上袖笼处比齐送入压脚内。#line#2、平缝至袖笼下第一只刀口，大袖片处容量均匀吃进至袖笼下第二只刀口止，剩余平缝袖口刀口对准。#line#3、两袖容量一致，左右两袖对称操作。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5737, 'ZYSZXFXZ011', '专机钉袖扣4粒*2', 263, 38.4500, 0.0961, 'STITCHING', NULL, b'1', '1、袖纽与眼位相对应，进出1cm。#line##line#2、线、纽扣面色色泽一致，纽扣并排整齐，无重叠。#line#', '1、袖里从袖口拉出，袖片套入订扣机内，袖叉正面朝上理平服。#line##line#2、纽扣正面朝上塞入订扣机内，对准眼位踩机车。#line##line#3、左右两袖扣对称进出一致，同样操作。#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5738, 'ZYSZXFXZ012', '专机拨大袖2片', 53, 22.6900, 0.0567, 'STITCHING', NULL, b'1', '   袖片丝绺平直，两袖片拔出容量均匀一致。#line#', '1、两大袖片正面相叠放置于模具上，内袖缝中间两刀口放置于凹凸槽上。#line#2、面料送往内侧放，面料紧往外侧放，适度调节拔大袖容量。#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5739, 'ZYSZXFXZ013', '专机锁袖衩眼4个*2', 275, 33.9300, 0.1103, 'STITCHING', NULL, b'1', '1、袖眼长2cm袖叉平行进1cm前眼距袖口（净）4cm。袖眼间距1.5cm。#line#2、眼位并排整齐，无凹凸现象，锁眼线与面料一致，平服不抽紧。', '1、大袖片反面朝上，袖叉袖口折边摊平送入压脚内，位置对准确，开动机器按要求锁眼。#line#2、眼位锁好后核对两袖眼对称进出一致。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5740, 'ZYSZXFXZ014', '运小袖衩（直/5cm）1片*2', 156, 30.5300, 0.0992, 'STITCHING', NULL, b'1', '要求小衩角缝位0.5cm。衩角方正，不起翘。', '两袖角按印划印再车线', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5741, 'ZYSZXFXZ015', '缝袖内缝（直/46cm)1条*2', 156, 67.5900, 0.2197, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5742, 'ZYSZXFXZ016', '分烫袖内缝连折衩角连贴边（直/46+38+12cm)1条*2', 19, 42.4400, 0.1485, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5743, 'ZYSZXFXZ017', '锁假眼连剪假眼线1*2', 260, 39.0100, 0.1268, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5744, 'ZYSZXFXZ018', '缝连翻袖衩角1*2', 156, 50.9300, 0.1655, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5745, 'ZYSZXFXZ019', '烫袖衩角1*2', 19, 18.1800, 0.0591, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5746, 'ZYSZXFXZ020', '定缝袖衩连缝袖外缝（直/48+3+10cm)1*2', 156, 87.3000, 0.3056, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5747, 'ZYSZXFXZ021', '分连压烫内、外袖缝1*2', 57, 62.6000, 0.2191, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5748, 'ZYSZXFXZ022', '袖口钉扣4粒*2', 261, 75.5700, 0.2645, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5749, 'ZYSZXFXZ023', '缝袖里内连外缝(直/14+14+62cm)1*2', 156, 79.8400, 0.2794, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5750, 'ZYSZXFXZ024', '倒烫袖里内连外缝1*2', 19, 29.8000, 0.0968, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5751, 'ZYSZXFXZ025', '缝袖口夹里（弯/38cm)1*2', 156, 64.6500, 0.2263, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5752, 'ZYSZXFXZ026', '翻袖子连缲缝袖口贴边1*2', 237, 22.9000, 0.0801, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5753, 'ZYSZXFXZ027', '固定袖里外缝连翻袖1*2', 156, 27.4400, 0.0892, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5754, 'ZYSZXFXZ028', '整烫袖子连袖口夹里1*2', 19, 31.9900, 0.1040, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5755, 'ZYSZXFXZ029', '', 152, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5756, 'ZYSZXFXZ030', '拔袖*2', 59, 13.9700, 0.0314, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5757, 'ZYSZXFXZ031', '拔袖*2', 19, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5758, 'ZYSZXFXZ032', '缝袖内缝（直/48cm）1*2', 156, 17.3700, 0.0608, 'STITCHING', NULL, b'0', '', '缝制操作：#line#    1：将小袖片放置于大袖片上，由下往上缝制，另一个侧相反方向操作；小袖片的刀#line#    2. 眼对齐于大袖片的刀眼大  袖片的拔开量均匀吃势，两片合缝止口：0.8cm。#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5759, 'ZYSZXFXZZZ001', '绱袖（弯55/cm)1边*2', 204, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5760, 'ZYSZXFZH001', '平机上里袖下端(弧/24cm)2条*1 连封里袖内缝（直/15cm）2条*1', 156, 86.2000, 0.3017, 'STITCHING', NULL, b'1', ' 1、封袖里留口平直切线0.1cm，两端回针固定。#line# 2、左右两袖对称操作。', '两层内袖缝（里），缝位捏齐送入压脚内切线，左右两袖对称操作无遗漏。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5761, 'ZYSZXFZH002', '专机上里袖上端（弧/44cm）2条*1', 240, 59.2000, 0.2072, 'STITCHING', NULL, b'1', '1、 切上袖缝线0.1-0.2cm内，切线圆#line##line#2、 袖里丝绺顺直，不起裂，起#line##line#3、 袖山中心对准肩缝，袖山弧形圆#line##line#4、 袖山与袖面各缝制对牢。#line##line#', '#line#1、翻转袖里，正面相叠缝制，缝位线按袖笼弧形切，前袖笼里略带松缝制，腋下平缝过渡，后袖笼略松，吃势均匀不起皱。#line##line#2、前袖笼里布缝制棉条上5-6cm，后袖笼缝至大袖缝处止。#line##line#3、上袖山从里留口掏出袖山里布正面相叠，与原袖里缝线拼接到#line##line#4、肩缝两侧平缝过渡，其余袖里容量均匀吃进。#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5762, 'ZYSZXFZH003', '专机搂肩2个*1', 233, 45.8000, 0.1603, 'STITCHING', NULL, b'1', '1、肩部丝绺都捋平挺，领圈弧度保持不变形。#line#2、扎线松紧适宜，不宜过松或过紧。', '1、略往外推一点量，前后肩缝两侧横丝捋平直（1）斜丝归拢（后肩缝起的浪花）扎线平缝定位，掀开衣片，将肩缝与垫肩，胸衬平缝定位5-6cm。#line#2、前肩部丝绺略往内抚进，(2)领圈扎线线迹细密越接近颈侧上扎线越紧，边做时边将丝绺挑横平竖直。#line#3、领圈处多余出的胸衬与领圈一起修平齐。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5763, 'ZYSZXFZH004', '专机搂胸2边*1', 238, 79.3000, 0.2775, 'STITCHING', NULL, b'1', '1、胸部平挺饱满，无多余容量，肩头挺括，袖笼圆顺。#line##line#2、前胸，肩面丝绺平直，扎线松紧适宜。#line#', '1、弹袖棉逢位分缝压开，胸衬放平，胸衬下手捏住，不松动翻回正面与面布一同放平，里布不切#line##line#2、胸部丝绺捋平，余量往袖笼侧推，腋下横丝往上提，保证胸部丝绺横平竖直，袖笼处衣片丝绺不呈现喇叭口。#line##line#3、由腋下侧缝处，衣袖笼弧度向前袖笼扎线，扎线时保持胸部丝绺不歪斜，扎线过肩1-2cm止。#line##line#4、前袖笼胸衬没订住处，在定肩面的缝位内笃几针固定住。#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5764, 'ZYSZXFZH005', '专机上棉条（弧/40cm）2条*1', 239, 40.3000, 0.1410, 'STITCHING', NULL, b'1', '1、切线圆顺与袖缝并齐切线内，按袖笼弧度。#line#2、棉条吃势均匀饱满，各部位层势均匀袖棉与袖面相符服帖，不起空，两袖对称一致。', '1、袖笼朝下，弹袖棉居下层（贴住袖片）。前袖笼弹袖衬比第二只刀口下1cm左右。#line#2、前袖笼棉条开始平缝切住二层牵带，靠近袖山略放松量缝制进，袖山棉条拉紧不吃势，肩棉处棉条平放面布略绷紧缝制切住一层牵带后袖笼上半段弹袖棉吃量较多均匀吃进，弹袖棉尾端与摆缝拼接上，吃量过渡均匀（如图）。#line#3、左右两袖上弹袖棉对称操作。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5765, 'ZYSZXFZH006', '上领两端串口（直/9cm）2条*1', 156, 66.6000, 0.2331, 'STITCHING', NULL, b'1', '要求缝线顺直，领角窝服。', '将挂面根据大身横领止口画好上领线，再缝合串口线，缝好后，修薄止口打好剪口，领下归势0.2cm', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5766, 'ZYSZXFZH007', '专机珠边衣身0.15cm(弧/200cm)1条*1', 225, 161.1000, 0.6041, 'STITCHING', NULL, b'1', '1、珠点大小一致均匀，缝份距边0.15cm。#line#2、止口保持平整，线迹无抽紧、无跳针、无漏针等现象。', '1、取成衣反面前片与小片出开始起针至翻驳点，翻驳点以上正面朝上开始作业直到另一片门襟驳头处，向反方向开始操作。#line#2、领圈珠点从串口处开始作业，缝份为0.15cm。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5767, 'ZYSZXFZH008', '平车合后侧缝（直/52CM）2*1连合下摆面里（直/92cm）1条*1（对位5个）#line#', 156, 131.2000, 0.4592, 'STITCHING', NULL, b'1', '#line#   下摆接口顺直，面里各缝位对准无偏离，活动量均匀。', '1、衣服反转反面朝上，挂面与下底边接口处开始起针，里布摆放位置倾斜小片与后片连接处，里布后片与面部后片底边比齐平缝。#line#2、里布缝位与面部缝位对准无偏离。#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5768, 'ZYSZXFZH009', '专机上面袖（弧/61cm）2条*1', 241, 97.6000, 0.3660, 'STITCHING', NULL, b'1', '1、上袖缝位一致0.8cm弧形圆顺。#line##line#2、各刀口对准，吃势准确，均匀自然。#line##line#3、袖子饱满平整，服帖，左右对称。#line#4、袖子层势分明，不搁不吊，袖山圆顺平服，袖片盖住大袋1/2+1cm为基准。#line#5、起始不回针，起始缝线搭合1-2cm。#line#', '1、翻转衣片袖笼反面朝外，袖子套入与衣片袖笼正相叠，右袖从前袖笼小弯在小袖上缝制，弧度，刀口对准，上下层丝绺摆直#line#，从小袖缝起针，袖片与衣袖笼弧度一致，不甩进甩出缝制。#line#2、具体各刀口之间的吃量按（如图所示）。#line##line#3、小袖缝与侧缝的距离两袖进出一致，袖片丝绺摆放顺直，摆放容量的手势左右两袖用力一致。#line#4、左袖由肩缝下后袖笼第一只刀口对准起针往前缝制，其余对称操作。#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5769, 'ZYSZXFZH010', '链式车合摆缝（直/55cm）2条*1', 200, 51.9000, 0.1816, 'STITCHING', NULL, b'1', '1、拼缝位一致1cm各刀口对准无偏差。#line##line#2、线辑松紧适宜，无跳针、断线现象。#line##line#', '1、前后两层衣片摆缝比齐，由袖笼处开始切线，袖笼下10cm内后背均匀吃进0.2cm的量，前片在上略带紧中，后片摆缝略往上送量，量吃进后平缝到底，底摆平齐。#line#2、另一侧由底摆往上缝制，左右两侧吃量一致。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5770, 'ZYSZXFZH011', '钉领标两端*1连剪线头4个', 156, 27.0000, 0.0878, 'STITCHING', NULL, b'1', '  吊标居中后领中心，两侧顺直直封切0.1cm，针距7-8针/1cm。', '   吊标放置与上下领拼缝呈平行，两端平直折进0.5cm，放平压止口来回缉3道线，吊标平服于下领上。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5771, 'ZYSZXFZH012', '烫面布摆缝及折下摆定型（直/92cm）1片*1', 19, 41.8000, 0.1045, 'STITCHING', NULL, b'1', '1、平叉摆缝分缝烫开无座势，烫顺直流畅，袖笼烫圆顺。#line#2、开叉摆缝缝位往后倒烫。#line#3、底折边平直折烫进4cm。', '1、衣片反而平摊于烫台上，侧片按势道摆放，后袖笼按袖笼弧度圆弧放置，吸风。#line#2、平叉摆缝分缝烫开，中间段用熨斗可伸烫一把，开叉摆缝倒烫按势道平烫即可。#line#3、底折边往上折烫，宽窄一致，底摆平直无扭曲。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5772, 'ZYSZXFZH013', '合面肩缝（直/17cm）2条*1连走定牵条', 156, 66.6000, 0.2331, 'STITCHING', NULL, b'1', '1、缝位一致1cm按肩缝圆顺切，后肩约吃进1cm。#line#2、左右两肩对称。', '1、后肩缝放于下层，上下层平放好送入压脚内，外肩约吃量0.2cm左右，吃量均匀过渡慢慢增多，内肩缝吃0.8cm左右，但靠近颈侧点外2cm内不吃量平缝过渡要适宜，前片平放切不可拉长。#line#2、左右两肩对称操作。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5773, 'ZYSZXFZH014', '烫开面肩缝定型1片*1', 19, 28.2000, 0.0705, 'STITCHING', NULL, b'1', '1、按肩缝弧度分烫开，弧度流畅无座势，容量摆放均匀到位。#line#2、左右两肩容量摆放必须对称一致。', '1、衣片反面翻出，肩缝按弧度平放入横具内分缝烫开。#line#2、内侧后肩容量较多处作归拢丝绺不歪扭，前后肩部的丝绺都归直，领圈弧度不变。#line#3、外侧肩缝端点不往后甩，略往前弧，再熨斗烫煞。#line#4、左右两端对称操作。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5774, 'ZYSZXFZH015', '烫里摆缝（直/53cm）2条*1', 19, 25.3000, 0.0632, 'STITCHING', NULL, b'1', '   里摆缝朝后倒烫，缝位线烫顺直，无座势。', '衣片里布正面朝上平摊于烫台上，里摆缝一绷朝后倒吸风，正面熨烫煞缝位，左右两侧对称操作。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5775, 'ZYSZXFZH016', '烫倒串口连双面胶(弯/8cm)2条*1', 19, 55.7000, 0.1392, 'STITCHING', NULL, b'1', '串口线顺直，领角窝服，豁口处平整、不毛边。', '串口分烫，在领里绒面将领角烫平整、窝服，然后用双面胶将领里绒与前片串口粘牢。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5776, 'ZYSZXFZH017', '手工定袖窿位2只*1', 15, 73.3000, 0.1832, 'STITCHING', NULL, b'1', '要求针距3cm2针，定位线不少于8针。', '翻转袖笼底部包紧往袖内1cm处用手缝扎线固定。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5777, 'ZYSZXFZH018', '烫面袖圈（弧/61cm）2个*1', 59, 37.7000, 0.0942, 'STITCHING', NULL, b'1', '1、袖子缝位平服，无起裥，袖片与衣片相服帖。#line#2、袖笼圆顺，袖片，衣片丝绺横平竖直。', '1、拿取上好袖的衣片，捏住袖笼缝位，袖片反面朝上按袖笼弧度在烫凳上熨烫缝位。#line#2、袖缝烫平煞，分成6段熨烫（如图），腋下烫进2个缝位，其余均烫进一个缝位。#line#3、衣片袖笼处的丝绺归直，切不可呈现喇叭口。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5778, 'ZYSZXFZH019', '专机珠下领缝（直/28cm）1条*1', 234, 38.7000, 0.1258, 'STITCHING', NULL, b'1', '1、珠点大小一致均匀，缝份距边0.15cm。#line##line#2、线迹无抽紧、无跳针、无漏针等现象。#line#', '1、领圈珠点从串口处开始作业，缝份为0.15cm', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5779, 'ZYSZXFZH020', '合里肩缝（直/18cm)2条*1连领里缝(弧/38）1条*1', 156, 82.1000, 0.3079, 'STITCHING', NULL, b'1', '1、合里肩缝位1cm吃势0.6-0.8cm，切线顺直。#line#2、合里领圈缝位1cm，刀口为准，里布与面布服贴松紧适宜。', '1、合里肩缝内层正面叠拢，前片上后片下，内侧里肩吃量较多过渡均匀，左右两肩对称一致，里外肩缝对牢。#line#2、从袖笼翻出里领圈与下领正面相叠 ，里布朝上从挂面与里布拼接处开始缝制，里布略放松紧肩缝刀口两侧进出一致，面里基本对牢，拼合后领圈里布略绷紧缝制，在缝位上划小刀口，便于服帖。#line#3、左右两侧拼合里肩，领圈对称操作。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5780, 'ZYSZXFZH021', '摘领圈（弧线/76cm）1条*1 ', 233, 23.9000, 0.0777, 'STITCHING', NULL, b'1', '要求领子、挂面丝质顺直。', '领面平服里外有容量，挂面平服不虚空，两者往内稍微呈窝势，不反翘。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5781, 'ZYSZXFZH022', '专机定袖窿里布2只*1', 238, 28.8000, 0.1008, 'STITCHING', NULL, b'1', '注意衣片和袖圈纱向走势，不能拉坏袖形，保证袖子饱满无褶皱现象。', '翻开袖笼分几部分，按照模具形状，放好袖圈，定好形后翻转至正面检查袖圈定形情况', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5782, 'ZYSZXFZH023', '撬领圈(直/15cm）2条*1', 237, 26.2000, 0.0851, 'STITCHING', NULL, b'1', '1、领圈缝位与衣片撬住松紧适宜，表面无痕迹。#line#2、根据面料厚薄调节针迹，不跳漏针。', '1、挂面放平整不歪斜，缝位朝下倒，套入袖笼内由胸衬处开始往下撬线与挂面撬线拼接上。#line#2、另一侧对称操作。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5783, 'ZYSZXFZH024', '下摆定位5条*1', 156, 38.1000, 0.1238, 'STITCHING', NULL, b'1', '折边与衣片定位平服，松紧适宜。', '底摆各十字缝对齐，定位线1cm。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5784, 'ZYSZXFZH025', '三角针扣转领绒（方角/4+38+4）1条*1', 235, 34.6000, 0.1211, 'STITCHING', NULL, b'1', ' 三角针针迹清晰缝位一致，扣转弧度圆顺，领串口处领绒不毛出。', '1、领绒朝上平放，底层里布及下领掀开不扣住，由领串口起针按手工扎线平缝，领底绒与领面相服帖。#line#2、领口与驳口连接处用手工撬针，领面无痕迹，针迹拼接上，领嘴无毛漏。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5785, 'ZYSZXFZH026', '专机锁门襟扣眼3个*1', 260, 33.1000, 0.1076, 'STITCHING', NULL, b'1', '1、门襟眼为2.3cm，锁眼线迹清晰，无毛漏、无跳针断线、开刀处无毛须现象。#line##line#2、眼尾套结无偏离无脱线，扣眼平整，无歪斜等现象。#line##line#3、第一眼位距边1.5cm，第二眼位距边1.3cm，第三眼位距边1.1cm。#line##line#4、插花眼为1.8cm圆头假眼，不开刀。#line##line#', '1、左衣片挂面朝上，在翻驳处下1cm点眼位，眼位间距根据样板点位，距门襟边1.5cm，按照前身的横向纱向为标#line##line#2、衣服反面朝上送入压脚内按锁眼机程序操作。#line##line#3、插花眼衣服正面朝上送入压脚内按锁眼机程序操作。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5786, 'ZYSZXKHP001', '锁后裤片（方角/110+23+83cm 1片*2', 171, 53.4900, 0.1872, 'STITCHING', NULL, b'1', '线路松紧适宜，针距10针/3cm，宽度0.5cm，不锁切，不空圈', '春夏面料三线方向由上至下（秋冬面料不提三线）,并检查裁片是否完整，无疵点。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5787, 'ZYSZXKHP002', '收后裤片省（直/8cm)2个*2', 156, 36.4000, 0.1274, 'STITCHING', NULL, b'1', '后省顺直收尖。                                  #line#', '按裤片腰头剪口对折缉后省长8cm，顺省尖收尾留线1cm。#line##line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5788, 'ZYSZXKHP003', '包后裆缝（弧38cm）1片*2', 155, 25.3000, 0.0822, 'STITCHING', NULL, b'1', '无布须、起扭或包边带缝份外吐，带紧或拉伸的现象，后裆弧线顺其自然。包边带平服、自然，两片接头不超过2cm。', '后裆包边缝份0.6cm。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5789, 'ZYSZXKHP004', '烫后省1片*2及烫后包缝1片*2', 19, 24.3000, 0.0790, 'STITCHING', NULL, b'1', '后省平服顺直，后裆包边带平服。#line##line#', '后省倒向裆缝，外缝臀围处略归。#line##line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5790, 'ZYSZXKHP005', '后省烫衬1片*2', 19, 20.3000, 0.0660, 'STITCHING', NULL, b'1', '后省顺直，裤片平服，粘衬牢固，位置准确。#line#', '衬以省尖为中心放置平服，粘衬牢固。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5791, 'ZYSZXKHP007', '按样划后口袋印（直/1cm）1片*2', 15, 22.3000, 0.0557, 'STITCHING', NULL, b'1', '规格相符，位置准确。#line#', '按后口袋划印板与裤片上端平齐中点对准省尖，在剪口处划印。#line#', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5792, 'ZYSZXKHP009', '专机开后口袋1个*2', 265, 30.7000, 0.1074, 'STITCHING', NULL, b'1', '袋布、裤片、袋巾位置准确，袋巾长短、宽窄一致，后袋长度准确，嵌线宽窄一致。#line#', '按划印双嵌线开袋，袋巾上下分别为0.5cm宽。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5793, 'ZYSZXKHP010', '后片剪袋巾及打剪口1片*2', 15, 41.0000, 0.1435, 'STITCHING', NULL, b'1', '剪口端正，深度恰当，不毛边。', '离袋口两端1cm处斜打剪口距缉线顶点一根纱。#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5794, 'ZYSZXKHP011', '翻烫后袋巾1片*2', 19, 32.8000, 0.1148, 'STITCHING', NULL, b'1', '嵌巾0.5cm宽窄一致，袋角方正无毛须。', '袋巾翻转，嵌巾0.5cm宽窄一致，整烫平服。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5795, 'ZYSZXKHP012', '车后袋扣眼位（直/1.5cm）1片*2', 156, 14.3000, 0.0465, 'STITCHING', NULL, b'1', '位置准确，辑线在三线正中。#line#', '扣眼位与省尖方向一致，与袋巾垂直，平袋巾下0.6cm处缉线1.5cm。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5796, 'ZYSZXKHP013', '车袋巾压线（直/15cm）1片*2', 156, 16.5000, 0.0536, 'STITCHING', NULL, b'1', '车线与袋口平行。#line#', '将后袋巾定位在口袋布上，沿三线正中缉线。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5797, 'ZYSZXKHP014', '贴后袋巾定位（方角/5+14+5cm）1片*2', 156, 45.0000, 0.1688, 'STITCHING', NULL, b'1', '袋角垂直，不露须，嵌巾平服。#line#', '沿袋巾缉线固定封好袋口，定位线缉至垫袋布缉线处。#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5798, 'ZYSZXKHP015', '车后袋垫袋布（直/15cm）1片*2', 156, 20.9000, 0.0679, 'STITCHING', NULL, b'1', '车线与袋布平行，垫袋布居中。#line#', '垫袋布三线边置于距袋布上方12.8cm与袋口平行居中缉线。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5799, 'ZYSZXKHP016', '钉主唛（方角/2.5+6.5+2.5+6.5cm）1个*1', 155, 24.6000, 0.0799, 'STITCHING', NULL, b'1', '主唛方向、位置正确。', '主唛位于左后袋布正中，底部距定位线1cm,四周缉线0.15cm。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5800, 'ZYSZXKHP017', '后袋后省定位（直/20cm）1片*2', 156, 18.1000, 0.0588, 'STITCHING', NULL, b'1', '后省与口袋垂直。#line#', '省与口袋垂直平服，在腰口0.5cm处缉线定位。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5801, 'ZYSZXKHP019', '专机车切后袋布（直/17+17cm）1条*2', 165, 45.0000, 0.1463, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5802, 'ZYSZXKHP020', '手工翻后袋布1个*2连压袋布明线（方角17+7+17cm）1个*2', 156, 58.3000, 0.1895, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5803, 'ZYSZXKHZ001', '后裆缝定型1条*1#line#', 59, 12.0000, 0.0300, 'STITCHING', NULL, b'1', '后裆分缝平服、圆顺。#line#', '将裤片前后裆缝平放在定型机上，反面向上定型，后裆定至门襟下端。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5804, 'ZYSZXKHZ002', '内外缝定型（直85+100cm）1条*2#line#', 59, 57.9000, 0.1447, 'STITCHING', NULL, b'1', '内外缝批开、平服。#line#', '裤身外缝平放在定型机上，前袋下方袋口处至以下10cm位置略归，转向内缝定型后翻转，缝份批开，定型平服。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5805, 'ZYSZXKHZ003', '前袋定型2片*1连后袋定型2片*1连腰头定型1条*1#line#', 59, 47.3000, 0.1655, 'STITCHING', NULL, b'1', '外缝顺直，袋口平服无褶皱，后袋不吊口，前后袋、腰头定型是否平服。', '所烫部位分别平放在定型机上定型5秒，冷却3秒。腰头前面定至门里襟搭门，后面定至后裆串带位，腰口处略归。#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5806, 'ZYSZXKHZ004', '裤腿定型2片*1#line#', 59, 54.5000, 0.1907, 'STITCHING', NULL, b'1', '脚口平整，裤腿平服，左右裤腿长度一致。#line#', '内外缝对准，脚口平整，裤腿定型平服。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5807, 'ZYSZXKHZ005', '整烫成品', 20, 89.1000, 0.3341, 'STITCHING', NULL, b'1', '各部位整烫平服，服贴，挺缝线顺直，不起泡不起吊，无水印、亮光。', '腰头、前褶位、门里襟、前后袋、前裆缝在摇臂上烫平服，把裤腿熨烫平服，各部位服贴。#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5808, 'ZYSZXKHZ006', '装备用扣连穿吊牌1个*1#line#', 15, 12.9000, 0.0322, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5809, 'ZYSZXKHZ007', '挂吊牌1*1#line#', 15, 5.1000, 0.0127, 'STITCHING', NULL, b'1', '吊牌规格与腰卡一致。#line#', '吊牌和腰卡核对后挂于右后腰外缝处的裤袢上。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5810, 'ZYSZXKHZ008', '成品包装', 15, 19.1000, 0.0477, 'STITCHING', NULL, b'1', '折叠方向是否正确、平服。#line#', '取下裤夹，三折加垫版纸折叠平服，打包。', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5811, 'ZYSZXKMJ001', '按样板做护扣式里襟（弯/20cm）1条*1', 156, 34.7000, 0.1214, 'STITCHING', NULL, b'1', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5812, 'ZYSZXKMJ002', '翻烫护扣式里襟及里襟尾1条*1', 19, 17.8000, 0.0578, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5813, 'ZYSZXKQP001', '裤片锁三线锁（方角/91+22+26+85cm）1片*2#line#', 171, 56.1000, 0.1963, 'STITCHING', NULL, b'1', '线路松紧适宜，针距10针/3cm，宽度0.5cm，不锁切，不空圈', '春夏面料三线方向由上至下（秋冬面料不提三线）,并检查裁片是否完整，无疵点。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5814, 'ZYSZXKQP002', '锁前袋垫布（弯/26cm）1片*2连锁前袋巾(弯/23cm)1片*2连后袋巾（直/15cm）连后袋垫（直/15cm）连里襟（直/17cm）', 171, 41.1000, 0.1336, 'STITCHING', NULL, b'1', '不锁切，不空圈。', '三线松紧适宜，针距10针/3cm，宽度0.5cm，并检查数量是否准确，附件是否无疵点。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5815, 'ZYSZXKQP003', '车前袋垫袋布（弯/26cm）1片*2', 156, 26.0000, 0.0845, 'STITCHING', NULL, b'1', '前垫袋布、手机袋位置准确。                                 #line#', '垫袋布距口袋布边1cm，下端转角距口袋布边4.5cm车出三线，手机袋口明线宽0.5cm，三周内折缝份1cm，缉线0.1cm在右袋布上，距袋底边4cm。#line##line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5816, 'ZYSZXKQP004', '单针环口压手机袋口宽明线（直/10cm)1片*1', 156, 11.0000, 0.0357, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5817, 'ZYSZXKQP005', '上手机袋（方角8+8+8cm)1片*1', 156, 29.9000, 0.0972, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5818, 'ZYSZXKQP006', '包门襟边（直/14+弧/8cm）1片*1', 155, 8.7000, 0.0283, 'STITCHING', NULL, b'1', '无布须、起扭或包边带缝份外吐，带紧或拉伸的现象，包边带平服、自然，两片接头不超过2cm。                                  #line#', '门襟、后裆包边缝份0.6cm。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5819, 'ZYSZXKQP007', '上门襟（直/17cm）1个*1及压明线（直/17cm）1个*1', 156, 22.0000, 0.0770, 'STITCHING', NULL, b'1', '门襟位置准确，规格与裁片相符。                                #line#', '门襟包边下边与裤片剪口相平，缝份为0.8cm，翻转缉明线0.1cm。#line##line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5820, 'ZYSZXKQP008', '按板前片出巾（直/17）1片*2', 156, 41.9000, 0.1571, 'STITCHING', NULL, b'1', '前袋巾长度、压线左右对称，剪口深度适宜。                         #line#', '前袋巾、裤片、袋布缝合0.8cm，前袋内、袋巾上缉线宽0.1cm，外缉明线0.6cm，左右对称，将袋巾与袋布缝合，沿袋巾三线正中缉线一道。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5821, 'ZYSZXKQP009', '定前袋口位（上直/2cm+下直/1.5cm）1片*2', 156, 35.4000, 0.1150, 'STITCHING', NULL, b'1', '三角大小左右对称，前袋巾左右长短一致。#line#', '按三角定位板，上端缉线与口袋巾明线重叠长2cm，下端袋角处缉线1.5cm倒针，袋巾不容位。#line##line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5822, 'ZYSZXKQP010', '前口袋上方定位(直/15cm)1条*2', 156, 26.9000, 0.0874, 'STITCHING', NULL, b'1', '前片左右规格与前腰尺寸一样。袋布平服。', '按前片定位板定位，在距腰口0.5cm 处缉定位线一道，左右两片三角位对称。#line##line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5823, 'ZYSZXKQP011', '车前袋巾线（直/23cm）1条*2', 156, 24.4000, 0.0793, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5824, 'ZYSZXKQP012', '手工修剪前袋布1个*2连运袋布（方角/15+8cm）1个*2连翻袋布1个*2连压线（方角/15+8cm）', 156, 79.7000, 0.2590, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5825, 'ZYSZXKQP013', '烫前折1条*1', 19, 16.1000, 0.0523, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5826, 'ZYSZXKQP014', '平车收前双褶（方角/3+2cm)1条*1', 156, 55.9000, 0.1956, 'STITCHING', NULL, b'1', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5827, 'ZYSZXKYT001', '折烫腰头（直/84cm）1片*2', 19, 24.5000, 0.0796, 'STITCHING', NULL, b'1', '经纱顺直，左右宽窄一致，条格对称。', '将腰头缝份按硬衬折烫。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5828, 'ZYSZXKYT002', '腰头划印（直0.8cm）9个*1', 15, 20.8000, 0.0676, 'STITCHING', NULL, b'1', '腰头规格与串带定位版相符。#line#', '按串带定位板准确无误地划出腰头大小，串带、洗水唛位置。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5829, 'ZYSZXKYT003', '车串带（直/57cm）,6个*1', 199, 12.8000, 0.0416, 'STITCHING', NULL, b'1', '#line#', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5830, 'ZYSZXKYT004', '专机钉串带6个*1（第六个固定上方）', 272, 50.4000, 0.1638, 'STITCHING', NULL, b'1', '方向正确，串带左右对称。', '串带成品长4.7cm，按划印上下固定，串带上端缉线距腰头上0.3cm宽，折叠部位为0.5cm，铜牌位于右侧第一个串带上。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5831, 'ZYSZXKYT005', '烫平自制腰里（直/100cm)1条*1#line##line#一次烫100米', 19, 4.7000, 0.0117, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5832, 'ZYSZXKYT006', '平机车腰里(直/48cm）2条*1', 156, 41.0000, 0.1332, 'STITCHING', NULL, b'1', '位置准确，容量适宜，腰里松紧适宜。#line#', '腰里距腰头上边0.3cm(正负0.1)，门襟处并进2cm，里襟处出1.5cm，缉明线0.15cm宽。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5833, 'ZYSZXKYT007', '手工穿铜牌1个*1连平车固定串带（直1cm）1个*1', 156, 12.2000, 0.0396, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5834, 'ZYSZXKYT008', '手工剪洗水唛（1个*1）                    一次大约剪100个', 15, 2.1000, 0.0052, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5835, 'ZYSZXKYT009', '上洗水唛（直/6cm）1个*1                  一扎六条', 156, 10.1000, 0.0328, 'STITCHING', NULL, b'1', '洗水唛规格与腰头规格一致。#line#', '按洗水唛上分割线剪开，置于右侧前袋腰里二层下。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5836, 'ZYSZXKZH001', '前后片配对', 15, 11.9000, 0.0297, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5837, 'ZYSZXKZH002', '前后片及附件上吊挂（前片2片*1，后片2片*1，腰头1条*1，里襟1片*1，拉链1条*1）#line#', 15, 15.3000, 0.0497, 'STITCHING', NULL, b'1', '前后片规格、布号、条数序号一致。附件完整。#line#', '前后裤片的版号、规格、布号、条数序号一致，配对成扎，按脚口顺序号把左右裤片配对成条同里襟、拉链、腰头上吊挂。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5838, 'ZYSZXKZH003', '专机合外缝（直/110cm)1条*2连合内缝（直/85cm)1条*2#line#', 200, 123.4000, 0.4319, 'STITCHING', NULL, b'1', '线路松紧适宜，不跳针，剪口对准。#line#', '合缝时对准剪口，脚口至中裆略往前推，前袋布剪口处放出0.2cm，缝份为1cm。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5839, 'ZYSZXKZH004', '平车外缝定位（直/16cm）1片*2#line#', 156, 17.1000, 0.0556, 'STITCHING', NULL, b'1', '辑线与缝线重合。#line#', '前袋口下端套结处上8cm至下8cm平机缉定位线一道。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5840, 'ZYSZXKZH005', '折烫门襟1片*1连烫平前、后袋布1片*2连烫开前袋口处外缝（直/30cm)1片*2#line#', 19, 65.4000, 0.2289, 'STITCHING', NULL, b'1', '熨烫平服，前袋处分烫平服，外缝顺直。#line#', '前后袋布烫平，门襟折进0.1cm,外缝口袋处略归。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5841, 'ZYSZXKZH006', '平机压前袋线（直/26+5cm）1片*2#line#', 156, 55.9000, 0.1956, 'STITCHING', NULL, b'1', '袋布是否平整，压线均匀。#line#', '前袋往内折1cm，第一道线从腰口往下压线至前袋底端，压线止口宽0.15cm，第二道线平剪口压线至前袋底端。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5842, 'ZYSZXKZH007', '裤腰口锁三线（直/42cm)1片*2#line#', 171, 22.0000, 0.0715, 'STITCHING', NULL, b'1', '裤片锁实，顺腰口不走样，腰口不能锁切。#line#', '前后片腰口锁三线一周，前后袋布多出腰口部份锁切。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5843, 'ZYSZXKZH008', '平机合前裆缝（直/10cm)1条*1连上拉链(直/20cm）2条*1连定里襟（直/0.8cm)1条*1#line#', 156, 64.6000, 0.2422, 'STITCHING', NULL, b'1', '浪底“十”字部位对齐，拉链平服。#line#', '内缝对齐，从前裆剪口上0.5cm合至后裆，拉链下端平裆缝出0.3cm，上端与门襟平齐缉线两道，里襟下端过门襟0.4cm，拉链平裤片缝份放进0.25cm，距腰口0.8cm里襟与裤片缝份一致定位。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5844, 'ZYSZXKZH009', '划后袋上方印（直/15cm）2片*1连上腰头（直/48+5+55cm)1条*1连打剪口2个*1 连封右边搭门止口（方角/7+4+1cm)1条*1连合后腰头缝（直/10cm)1条*1#line#', 156, 191.9000, 0.7196, 'STITCHING', NULL, b'1', '腰头左右各部位对称。腰头规格与裤身规格一致。左右搭门和位链长度一致。#line#', '裤腰口缝份 0.9cm，后袋处按板划印，后裆缝份2.3cm，后腰缝上端略收0.1cm，前裤串带与前褶重叠，左右腰头各部位对称，里襟里布与腰面缝合，腰面与里襟分缝缝制。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5845, 'ZYSZXKZH010', '专机合后裆缝（弧/48cm)1条*1#line#', 202, 34.2000, 0.1197, 'STITCHING', NULL, b'1', '缉线重合，缝份是否圆顺，裆低“十”字缝对正。#line#', '前门襟剪口下2cm处缝份为1cm顺势合至后腰腰里，要求缝份圆顺，弧度自然，裆底十字缝对正。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5846, 'ZYSZXKZH011', '专机钉腰头挂钩扣2个*1#line#', 273, 19.4000, 0.0630, 'STITCHING', NULL, b'1', '裤腰正中与拉链齿保持顺直，钩扣左右位置是否准确，钉扣牢固，不倾斜。', '裤钩扣位于门、里襟拉链上端裤腰正中与拉链齿保持顺直。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5847, 'ZYSZXKZH012', '烫开后片处腰头缝位（直/22CM）2条*1连烫开里襟处腰头缝（直/7cm)1条*1连烫开后腰头拼缝（直/20cm）1条*1#line#', 19, 36.0000, 0.1170, 'STITCHING', NULL, b'1', '里襟、后腰、后裆缝份是否批烫平服。#line#', '里襟腰头处、后腰、后裆缝份批开烫平服、后串带烫顺直。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5848, 'ZYSZXKZH013', '平车封左边搭门止口（直/4.3+8.5+3.5cm)1条*1#line#', 156, 40.7000, 0.1526, 'STITCHING', NULL, b'1', '搭门顺直，平服，搭门是否平服、宽窄长度符合要求。#line#', '左边腰面折叠缝合搭门4.3cm长，宽度3.5cm与腰面吻合。#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5849, 'ZYSZXKZH014', '平车固定后腰里（直/16+16cm）1条*1#line#', 156, 26.8000, 0.0871, 'STITCHING', NULL, b'1', '腰里不外翻，腰面与袋位平服，辑线平服。#line#', '后裤片腰口缝份与腰里二层缝合。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5850, 'ZYSZXKZH015', '平车串带定位（直/1cm)1条*6#line#', 156, 39.6000, 0.1386, 'STITCHING', NULL, b'1', '串带竖直与裤身腰里平服自然，牢固，不过位。', '串带竖直与裤身腰里平服自然，平腰下1.1cm往返三次缉线在腰里二层上。#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5851, 'ZYSZXKZH016', '平车按样压门襟（直/15cm+弯/5cm）1条*1#line#', 156, 25.6000, 0.0960, 'STITCHING', NULL, b'1', '门襟压线圆顺，无跳针，无接线。#line#', '门襟按板缉线，上端压线至腰面，下端盖住右裤片0.3cm。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5852, 'ZYSZXKZH017', '平车压里襟（直/16.5cm)1条*1连固定门里襟（直/1cm）1条*1连压里襟尾（直/12.5cm）2条*1#line#', 156, 78.3000, 0.2936, 'STITCHING', NULL, b'1', '缉线圆顺、平整无泡，里襟止品均匀，平服。', '里襟止口边与拉链齿相距0.3cm，止口宽度0.15cm,门里襟下端定位，里襟尾过内裆缝4cm，里襟比门襟长0.5cm。#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5853, 'ZYSZXKZJ001', '锁护扣扣眼（直/2cm）1个*1连腰头扣眼(直/2cm）1个*1连后口袋扣眼（直/cm）2个*1#line#', 260, 43.3000, 0.1515, 'STITCHING', NULL, b'1', '里清剪线头。扣眼位置准确。', '里襟扣眼距里襟尖角2cm与腰底线呈30度角，腰头扣眼位于搭门中心离搭头边1cm，后袋扣眼按扣眼定位线锁眼，距口袋嵌线0.6cm与袋巾垂直.', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5854, 'ZYSZXKZJ002', '手工点腰头扣位印连专机钉扣1个*1连点护扣扣位印连钉扣1个*1连点后口袋扣位印连钉扣连扣扣子2个*1#line#', 262, 40.2000, 0.1407, 'STITCHING', NULL, b'1', '后袋嵌线不吊口，不重叠，“忘不了”字样放正，钉扣牢固。#line#', '腰头扣以扣眼圆顶为钉扣点，护扣以扣眼圆头下端为钉扣点，按点印钉扣。#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5855, 'ZYSZXKZJ003', '专机前口袋套结长0.5cm4个*1及前门襟套结长1cm*1及后口袋套结长1cm4个*1#line#', 251, 38.4000, 0.1344, 'STITCHING', NULL, b'1', '套结长度、位置正确。#line#', '后袋两端套结1cm与袋巾垂直，前袋结长0.5cm，上端距腰头1cm，套住腰里二层，下端与袋巾转角明线重合，门里襟套结长1cm。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5856, 'ZYSZXKZJ004', '专机腰里定位14个*1#line#', 269, 27.5000, 0.0894, 'STITCHING', NULL, b'1', '腰里固定，不过头，不外翻，线迹均匀，前后袋布平服。#line#', '前后袋布两边与正中各一针，后裆两边各一针，共14针，固定腰里。#line#', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5857, 'ZYSZXKZJ005', '专机钉腰卡1个*1连剪扣眼线', 262, 18.8000, 0.0611, 'STITCHING', NULL, b'1', '腰卡规格与洗水唛一致。位置正确。#line#', '按洗水唛货号、规格对应的腰卡钉在右外缝腰头。', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5858, 'ZYSZXQHP001', '锁后裙片（直/49+29cm)1片*2', 171, 54.7200, 0.1778, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5859, 'ZYSZXQHP002', '缝后片省（直/8.5cm)1个*2', 156, 15.6200, 0.0547, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5860, 'ZYSZXQHP003', '缝后中缝（直/15cm+4cm)1条*1', 156, 14.2100, 0.0497, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5861, 'ZYSZXQHP004', '', 251, 7.4800, 0.0243, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5862, 'ZYSZXQHP005', '', 19, 23.6900, 0.0829, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5863, 'ZYSZXQHP006', '', 19, 11.1800, 0.0363, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5864, 'ZYSZXQHP007', '', 156, 25.9500, 0.0843, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5865, 'ZYSZXQHP008', '', 19, 9.5600, 0.0311, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5866, 'ZYSZXQHP009', '', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5867, 'ZYSZXQHP010', '', 19, 6.4400, 0.0209, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5868, 'ZYSZXQLB001', '裙里侧缝锁边（含缝里侧缝）（弧/54cm+54cm+直/38cm+直/14cm+直/35cm+直/17cm)', 180, 72.2700, 0.2529, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5869, 'ZYSZXQLB002', '缝后中缝里(直/34cm+直/5cm)', 156, 25.4200, 0.0826, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5870, 'ZYSZXQLB003', '缉底边（放入缉底边（放入线襻）（弧98/cm)', 156, 61.0400, 0.2136, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5871, 'ZYSZXQLB004', '', 19, 22.2700, 0.0724, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5872, 'ZYSZXQQP001', '锁前片（直/49+47+49cm)1片*1', 171, 26.0700, 0.0847, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5873, 'ZYSZXQQP002', '缝前省（直/8.5+8.5cm）2个*1', 156, 32.7900, 0.1148, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5874, 'ZYSZXQQP003', '前前省（直/8.5+8.5cm）2个*1', 19, 7.8600, 0.0255, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5875, 'ZYSZXQYT001', '折烫腰里（直/77cm）', 19, 18.9500, 0.0663, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5876, 'ZYSZXQYT002', '', 166, 18.3500, 0.0642, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5877, 'ZYSZXQZZ001', '缝侧缝(面）(弧/59cm+59cm)', 200, 48.9400, 0.1713, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5878, 'ZYSZXQZZ002', '', 19, 25.3100, 0.0823, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5879, 'ZYSZXQZZ003', '', 156, 1.6700, 0.0058, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5880, 'ZYSZXQZZ004', '', 19, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5881, 'ZYSZZD001', '1', 62, 29.1800, 0.1021, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5882, '驳接领仔、分缝', '', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5883, 'T0001', '上吊挂', 2, 10.0060, 0.0250, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5884, 'SWCSAS001', '度袖衩位连上介英(22CM)*2#line#', 156, 80.8120, 0.7354, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5885, 'SWCSAS002', '修袖口一圈缝份(直/上介英后/30CM)1条*2#line#', 161, 35.3570, 0.2398, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5886, 'SWCSAS003', '单针压上介英(30CM)*2 连间边线一周#line#', 156, 115.4280, 0.9234, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5887, 'SWCSAS004', '合肩缝及摆缝(15/45CM)2条*1#line#', 156, 98.9200, 0.7914, 'STITCHING', NULL, b'0', '线路整齐，牢固，平服', '线路整齐，牢固，平服', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5888, 'SWCSAS005', '三线拷侧缝（双层直/48CM)*2#line#', 177, 40.1500, 0.2724, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5889, 'SWCSAS006', '上圆袖(48CM)2条*1#line#', 177, 148.3480, 1.3500, 'STITCHING', NULL, b'0', '容位均匀，左右对称，圆顺不起皱', '容位均匀，左右对称，圆顺不起皱', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5890, 'SWCSAS007', '三线拷圆袖圈(50CM)2条*1#line#', 177, 56.7070, 0.4537, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5891, 'SWCSAS008', '上领面(弯/45CM)*1#line#', 156, 84.5180, 0.7691, 'STITCHING', NULL, b'0', '绱好领后领型圆顺服贴，后领窝不起皱', '绱好领后领型圆顺服贴，后领窝不起皱', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5892, 'SWCSAS009', '压上底领(弯45CM)*1#line#', 156, 97.6990, 0.7816, 'STITCHING', NULL, b'0', '绱好领后领型圆顺服贴，后领窝不起皱', '绱好领后领型圆顺服贴，后领窝不起皱', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5893, 'SWCSAS010', '拉筒单针环口间衬衣下脚连修剪下脚毛边(弯/31+54+31CM/比对门筒长度连划位)*1#line#', 156, 134.7990, 1.2267, 'STITCHING', NULL, b'0', '止口均匀不起皱', '止口均匀不起皱', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5894, 'SWCSBK001', '单针打后片工字活褶*1   大片#line#', 156, 22.6140, 0.1281, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5895, 'SWCSBK002', '合后担干(弯/46CM)*1 对中位#line#', 156, 39.0370, 0.3123, 'STITCHING', NULL, b'0', '后幅担干下收弓字褶，褶位要居中', '后幅担干下收弓字褶，褶位要居中', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5896, 'SWCSBK003', '三线拷后担干(双层直/46CM)*1#line#', 177, 19.3300, 0.1311, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5897, 'SWCSCL001', '落样扣烫下级一边领连点3个位(直/48CM)*1#line#', 160, 22.6830, 0.1285, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5898, 'SWCSCL002', '落样划领面净样线三边(8+43+8CM)*1#line#', 161, 14.2380, 0.0807, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5899, 'SWCSCL003', '运反领顶连领角放线吊角(尖角/直8+43+8CM)*1#line#', 156, 68.8520, 0.5508, 'STITCHING', NULL, b'0', '领尖平直不爆口，左右对称', '领尖平直不爆口，左右对称', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5900, 'SWCSCL004', '修剪上级领连翻(尖角/直6+45+6CM)*1#line#', 161, 27.1250, 0.1537, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5901, 'SWCSCL005', '间领顶边线(直/8+46+8CMCM)*1#line#', 156, 47.4600, 0.3797, 'STITCHING', NULL, b'0', '领子止口均匀平顺，左右对称', '上级领面压0.6CM明线', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5902, 'SWCSCL006', '烫平领三边明线(直/4+39+4CM)*1#line#', 160, 8.7750, 0.0497, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5903, 'SWCSCL007', '落样画线连屈封上级领脚(弯39CM)*1  #line#', 156, 28.0040, 0.1900, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5904, 'SWCSCL008', '纸板夹上级领连修止口（圆角4+39+4CM）*1#line#', 156, 48.0910, 0.4376, 'STITCHING', NULL, b'0', '领咀圆顺，左右对称', '领咀圆顺，左右对称', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5905, 'SWCSCL009', '间下级领单明线(弧/40CM)*1（过底）#line#', 156, 37.9850, 0.3039, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5906, 'SWCSCU001', '落样扣烫介英二边连对烫连划两头运反位(方角/直/23CM)*2#line#', 160, 56.2510, 0.3188, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5907, 'SWCSCU002', '对折运反介英两头修剪连翻(方角/直/4CM)*2#line#', 156, 77.3590, 0.7040, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5908, 'SWCSCU003', '烫定介英两头(方角/直/4CM)*2#line#', 156, 25.1830, 0.1427, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5909, 'SWCSFR001', '落样点前幅胸省3点*2   一头尖#line#', 161, 28.5560, 0.1618, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5910, 'SWCSFR002', '落样打前胸省(直/10CM)2个*1  一头尖#line#', 156, 50.6180, 0.3434, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5911, 'SWCSFR003', '落样扣烫明筒二边连对烫(直/55CM)*1#line#', 160, 35.9690, 0.2038, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5912, 'SWCSFR004', '上前门筒（直/55CM）*1#line#', 156, 43.3330, 0.3467, 'STITCHING', NULL, b'0', '线迹均匀平顺', '左右压0.1CM明线', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5913, 'SWCSFR005', '压上明筒1/16线(57CM)*2条*1 #line#', 156, 111.6380, 0.8931, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5914, 'SWCSFR006', '落样环口扣烫底门襟(直64CM)*1#line#', 160, 33.8170, 0.1916, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5915, 'SWCSFR007', '环间前底门襟宽线（64CM）*1  已扣烫#line#', 156, 36.0900, 0.2045, 'STITCHING', NULL, b'0', '子口均匀，线迹平顺', '子口均匀，线迹平顺', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5916, 'SWCSSL001', '拉筒拉袖衩滚条(单层/直/16CM)*2#line#', 156, 34.4470, 0.2337, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5917, 'SWCSSL002', '暗钉袖衩位(1CM)*2#line#', 156, 27.7090, 0.1880, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5918, 'SWCSSL003', '打袖口活褶(5CM)*2#line#', 156, 26.9510, 0.1828, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5919, 'SWCSSL004', '合袖底缝(直/45CM)*2#line#', 156, 66.4940, 0.5320, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5920, 'SWCSSL005', '走缩袖山碎褶(弯/20CM)*2 连度长短#line#', 156, 42.0690, 0.2854, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5921, 'SWCSSL006', '三线打袖底缝(双层/48CM)*2#line#', 177, 36.3830, 0.2468, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5922, 'SWLYAS001', '度袖衩位上介英暗线(26CM)*2#line#', 156, 74.5370, 0.6783, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5923, 'SWLYAS002', '单针压上介英(30CM)*2 #line#', 156, 91.0450, 0.8285, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5924, 'SWLYAS003', '合肩缝及摆缝(12/70CM)2条*1#line#', 156, 113.9960, 0.9120, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5925, 'SWLYAS004', '三线拷肩缝及侧缝(直/双层12CM/70CM)2条*1#line#', 156, 60.0090, 0.4801, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5926, 'SWLYAS005', '固定面里袖窿一圈(54CM)2条*1#line#', 156, 108.1850, 0.9845, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5927, 'SWLYAS006', '上圆袖(50CM)2条*1#line#', 156, 148.1060, 1.3478, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5928, 'SWLYAS007', '三线拷圆袖窿(54CM)2条*1#line#', 177, 61.6320, 0.4931, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5929, 'SWLYAS008', '三线拷下摆散口(单层/直/110CM)*1#line#', 177, 31.3340, 0.2507, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5930, 'SWLYBK001', '合后中缝(直34CM/比位留拉链位)1条*1#line#', 156, 38.7010, 0.3096, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5931, 'SWLYBK002', '三线拷后中缝连分骨拷拉链位(双层/50+97CM)*1#line#', 177, 48.2210, 0.3271, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5932, 'SWLYBK003', '烫开隐形拉链两边(56CM)*1#line#', 160, 18.7500, 0.1062, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5933, 'SWLYBK004', '合留拉链位缝(3CM)*1#line#', 156, 14.5280, 0.1162, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5934, 'SWLYBK005', '上后中隐形拉链(直54CM)2边*1(对位2处)#line#', 156, 143.4320, 1.3052, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5935, 'SWLYBK006', '套拉链里布(直/50CM)2边*1 对1个位#line#', 156, 83.5490, 0.7603, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5936, 'SWLYBK007', '包拉链尾(直/2+2CM)*1连运返领头贴修翻(直/3CM)*2 #line#', 156, 92.4350, 0.8412, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5937, 'SWLYCL001', '烫前后领圈直衬条(弯/60CM)连剪*1#line#', 160, 35.7620, 0.2027, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5938, 'SWLYCL002', '套里领圈一周(70CM)*1 对2个位 #line#', 156, 77.0220, 0.7009, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5939, 'SWLYCL003', '修领圈缝份(弯/70CM)1条*1#line#', 161, 31.8180, 0.1803, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5940, 'SWLYCL004', '压内领贴1/16助止口线(弯/62CM)1条*1#line#', 156, 46.4910, 0.3719, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5941, 'SWLYCL005', '整烫领窝(弯/70CM)1条*1#line#', 160, 26.7800, 0.1518, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5942, 'SWLYCU001', '落样扣烫介英二边连对烫连划两头运反位(方角/直/23CM)*2#line#', 160, 56.2510, 0.3188, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5943, 'SWLYCU002', '对折运反介英两头修剪连翻(方角/直/4CM)*2#line#', 156, 77.3590, 0.6189, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5944, 'SWLYCU003', '烫定介英两头(方角/直/4CM)*2#line#', 160, 24.7520, 0.1403, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5945, 'SWLYFR001', '落样点前幅两头尖腰省位4点*1#line#', 161, 15.6300, 0.0886, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5946, 'SWLYFR002', '落样点前幅胸省3点*2   一头尖#line#', 161, 28.5560, 0.1618, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5947, 'SWLYFR003', '落样打前腰省(直/10CM)2个*1  一头尖#line#', 161, 47.8060, 0.2709, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5948, 'SWLYFR004', '落样打前胸省(直/10CM)*2  一头尖#line#', 156, 53.0610, 0.3007, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5949, 'SWLYLN001', '合里布肩缝及侧缝(10CM/70CM)2条*1#line#', 156, 111.1320, 0.8891, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5950, 'SWLYLN002', '三线拷里肩缝(双层/直/10CM)2条*1及里侧缝(双层/直/70CM)2条*1#line#', 177, 59.2730, 0.4742, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5951, 'SWLYLN003', '单针环间里布下摆一周(直/100CM)*1 #line#', 156, 112.9010, 0.9032, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5952, 'SWLYSL001', '袖顶缩折(弧30CM)1条连度位*2#line#', 156, 45.0170, 0.3054, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5953, 'SWLYSL002', '走缩袖口(40CM)1条*2 连度长短#line#', 156, 51.7550, 0.3511, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5954, 'SWLYSL003', '合袖底缝(直/45CM)*2#line#', 156, 60.4300, 0.4834, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5955, 'SWLYSL004', '三线拷袖底缝(双层/48CM)*2#line#', 177, 40.2330, 0.2729, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5956, 'SWLYSL005', '落样点袖衩位2点*2#line#', 161, 19.8060, 0.1122, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5957, 'SWLYSL006', '拉筒拉袖衩滚条(单层/直/16CM)*2#line#', 156, 54.3240, 0.4346, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5958, 'SWLYSL007', '平车折定袖叉捆条*2连点位*2#line#', 156, 37.6900, 0.3015, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5959, 'SWWTAS001', '四线合前肩缝落透明肩带(直/12CM)*2#line##line#', 177, 31.1270, 0.2490, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5960, 'SWWTAS002', '四线合后肩缝落透明肩带(直/12CM)*2#line#', 177, 31.1270, 0.2490, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5961, 'SWWTAS003', '冚车冚肩缝明线（直/10CM）2条*2#line#', 186, 34.9890, 0.2799, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5962, 'SWWTAS004', '四线上袖口罗纹（直20CM)*2  开袖口#line#', 177, 45.2830, 0.4121, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5963, 'SWWTAS005', '四线上平袖（弯/45CM对肩位1个）2条*1 #line#', 177, 89.9030, 0.8181, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5964, 'SWWTAS006', '冚车间袖圈倒骨1/4线(弯/48CM)2条*1 #line#', 186, 84.5670, 0.6765, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5965, 'SWWTAS007', '四线合袖底缝及侧缝(弧/102CM/对夹底位)2条*1 #line#', 177, 84.6050, 0.6768, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5966, 'SWWTAS008', '上领面(弯/45CM)*1#line#', 156, 76.8120, 0.6990, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5967, 'SWWTAS009', '四线拷领脚边(弧/52CM)*1#line#', 177, 26.6980, 0.2136, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5968, 'SWWTAS010', '冚车冚领窝<上好领围贴后/弯65CM>1条*1#line#', 186, 42.5310, 0.3402, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5969, 'SWWTAS011', '上下摆一周(直/108CM)*1  对侧骨位#line#', 156, 72.3900, 0.5791, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5970, 'SWWTAS012', '四线拷下摆一周（直/108CM)*1#line#', 177, 35.6800, 0.2854, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5971, 'SWWTAS013', '冚车间下摆倒骨明线(弧/110CM)*1(未烫)#line#', 186, 70.9670, 0.6458, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5972, 'SWWTBK001', '间后片装饰明线（直/35CM)2条*1#line#', 156, 45.4380, 0.3635, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5973, 'SWWTCL001', '落样划领面净样线三边(8+43+8CM)*1#line#', 161, 14.2380, 0.0807, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5974, 'SWWTCL002', '运反领顶(直42CM）)*1 #line#', 156, 29.9830, 0.2399, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5975, 'SWWTCL003', '间领顶边线(直/46CMCM)*1#line#', 156, 47.4600, 0.3797, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5976, 'SWWTCL004', '落样画线连屈封领脚(弯45CM)*1#line#', 156, 37.3530, 0.2534, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5977, 'SWWTCU001', '对折拼接袖口(直/8CM)*2#line#', 156, 28.3410, 0.2267, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5978, 'SWWTCU002', '对折走袖口固定线(直/32CM)*2#line#', 156, 54.1130, 0.3671, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5979, 'SWWTFR001', '间前片装饰明线（直/20+35CM)*2#line#', 156, 62.7040, 0.5016, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5980, 'SWWTFR002', '落前中拉链(对位2个/70M)*2 拉链头折两次#line#', 156, 142.6320, 1.2980, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5981, 'SWWTFR003', '落拉链织带（直/70CM)*2#line#', 156, 66.7470, 0.6074, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5982, 'SWWTFR004', '单针间前中拉链明线2条(70CM)*1 有织带#line#', 156, 122.5030, 1.1148, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5983, 'SWWTOH001', '对折走封下摆定线(直108CM)*1#line#', 156, 49.7760, 0.3376, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5984, 'SWWTPK001', '对折烫袋唇(直/17CM)*2#line#', 160, 14.9010, 0.0844, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5985, 'SWWTPK002', '走袋唇实样宽线(直/14CM)*2   已烫好，车台定位#line#', 156, 25.5620, 0.1734, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5986, 'SWWTPK003', '落样点前身开袋位4点*2#line#', 161, 31.8180, 0.1803, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5987, 'SWWTPK004', '落唇袋于袋布(直/17CM)*2   袋唇于车实样线#line#', 156, 32.0050, 0.2560, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5988, 'SWWTPK005', '落袋唇与底袋布于前片(16+16CM)*2#line#', 156, 101.0680, 0.8085, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5989, 'SWWTPK006', '剪开单唇袋口（直/15CM)封两头三角(直/1+1CM)*2#line#', 156, 116.5230, 1.0604, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5990, 'SWWTPK007', '间前身开袋口一周明线(15+2+15+2CM)*2#line#', 156, 95.6780, 0.7654, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5991, 'SWWTPK008', '合面里袋布底（弯/38CM） *2#line#', 156, 51.7550, 0.4140, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5992, 'SWWTPK009', '三线拷前插袋袋布(圆角/20+35CM)*2#line#', 177, 34.2720, 0.2325, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5993, 'SWWTPK010', '前袋拷边线尾钉针*2个*2#line#', 156, 41.6480, 0.2825, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5994, 'SWWTPK011', '走定袋布与前片定线（直/15CM)*2#line#', 156, 28.3410, 0.1922, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5995, 'ZMCSAS001', '四线拼肩缝(直/18)1边*2', 177, 24.8660, 0.1989, 'STITCHING', NULL, b'1', '肩止口顺直平服，左右肩宽一致#line#', '肩止口顺直平服，左右肩宽一致#line#', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5996, 'ZMCSAS002', '冚膊(直/18)1边*2', 187, 15.1270, 0.0359, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5997, 'ZMCSAS003', '盖领回嘴(弧/62)1片*1', 156, 69.8300, 0.6355, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5998, 'ZMCSAS004', '上袖短袖(弧/60*2)1片*2', 181, 51.2240, 0.1921, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (5999, 'ZMCSAS005', '冚夹圈(弧/60*2)2边*1', 187, 25.3610, 0.0602, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6000, 'ZMCSAS006', '埋夹加落1折叠唛头(对横条，直/60*2)1边*2', 180, 49.7140, 0.1864, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6001, 'ZMCSAS007', '拉下摆(弧/135)1件*1,剪线1个*1', 156, 51.4910, 0.4686, 'STITCHING', NULL, b'0', '线迹平服均匀，在下摆弯位平顺不起纽#line#', '线迹平服均匀，在下摆弯位平顺不起纽#line#', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6002, 'ZMCSAS008', '开成品纽门(领*1+门筒*6)7个*1', 73, 37.4190, 0.0842, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6003, 'ZMCSAS009', '点成品纽子6位*1', 161, 16.7440, 0.0377, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6004, 'ZMCSAS010', '钉成品纽扣(领*1+纽子*6)7个*1', 261, 34.4810, 0.0776, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6005, 'ZMCSBK0001', '', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6006, 'ZMCSBK001', '', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6007, 'ZMCSCL001', '烫/画下级领1片*1', 19, 13.5650, 0.1234, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6008, 'ZMCSCL007', '间上级领(未分烫,直/8+弧/44+直/8)3边*1', 156, 30.3040, 0.2424, 'STITCHING', NULL, b'0', '线迹平服止口均匀，左右对称', '上级领连压0.6CM明线#line#', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6009, 'ZMCSFR001', '拉筒(直/77)1片*1', 156, 38.9880, 0.3119, 'STITCHING', NULL, b'0', '线迹均匀平服', '间1 1/16 寸明线', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6010, 'ZMCSFR002', '间左门筒线(直/77)1片*1', 156, 38.9880, 0.3119, 'STITCHING', NULL, b'1', '门筒要平服均匀不起纽#line##line#', '门筒要平服均匀不起纽#line##line#', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6011, 'ZMTXAS001', '级圆领(直/46)1条*1', 172, 18.5970, 0.0418, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6012, 'ZMTXAS002', '上后领条(直/46)1条*1', 156, 33.3940, 0.0793, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6013, 'ZMTXAS003', '冚圆领圈(直/46)1条*1', 187, 20.2200, 0.0480, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6014, 'ZMTXAS004', '车主唛&侧边尺码唛(直/2+2)2边*1，画领位1位*1，剪线3位*1', 156, 31.0240, 0.0737, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6015, 'ZMTXAS005', '四线合肩缝落透明肩带(直/12CM)*2#line#', 177, 31.0440, 0.1164, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6016, 'ZMTXAS006', '四线上领圈一周(弯/70CM)*1 对肩缝位2个及前后领窝位2个#line#', 177, 67.6340, 0.6155, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6017, 'ZMTXAS007', '落后领圈织带(弯/30CM)连剪*1 织带两头折边#line#', 156, 47.7550, 0.4346, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6018, 'ZMTXAS008', '单针间领窝1/4明线（弧/58CM）*1  底有织带#line#', 156, 64.5990, 0.5168, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6019, 'ZMTXAS009', '四线上平袖（弯/45CM对肩位1个）2条*1 #line#', 177, 79.3480, 0.7221, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6020, 'ZMTXAS010', '四线合袖底缝及侧缝(弧46CM/对夹底位)2条*1 #line#', 177, 66.9300, 0.6091, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6021, 'ZMTXAS011', '冚下摆一圈(对位2个/94CM)1条*1#line#', 186, 59.7570, 0.5438, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6022, 'ZMTXAS012', '冚袖口一圈(直/20CM)*2#line#', 186, 67.3400, 0.6128, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6023, 'ZMTXAS013', '拉膊*2', 177, 28.6430, 0.1943, 'STITCHING', NULL, b'0', '缝制线路整齐，牢固，平服,拼缝无起皱现象', '肩缝夹车透明胶条，四线拉膊', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6024, 'ZMTXAS014', '冚肩*2', 186, 20.6470, 0.1401, 'STITCHING', NULL, b'0', '线迹均匀平顺', '冚0.6CM明线', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6025, 'ZMTXAS015', '平车上圆领*1#line#', 156, 74.7060, 0.6798, 'STITCHING', NULL, b'0', '领型圆顺服贴，左右对称#line#', '领型圆顺服贴，左右对称#line#', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6026, 'ZMTXAS016', '落后领捆条(圆V领款)*1#line#', 156, 52.5550, 0.4204, 'STITCHING', NULL, b'0', '后领原身布捆条平顺不可扭', '后领原身布捆条平顺不可扭', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6027, 'ZMTXAS017', '及圆领散口*1#line#', 172, 19.6170, 0.1331, 'STITCHING', NULL, b'0', '线迹均匀平顺', '线迹均匀平顺', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6028, 'ZMTXAS018', '间圆领领圈线*1#line#', 186, 54.2350, 0.3679, 'STITCHING', NULL, b'0', '线迹均匀平顺', '压0.6cm明线', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6029, 'ZMTXAS019', '压后领捆条*1', 156, 24.9720, 0.1998, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6030, 'ZMTXAS020', '修后领止口(圆V领款)*1', 161, 12.6480, 0.0717, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6031, 'ZMTXAS021', '车主唛暗线*1连放尺码唛*1#line#', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6032, 'ZMTXAS022', '上长袖*2', 177, 52.7330, 0.4799, 'STITCHING', NULL, b'0', '左右袖对称，止口一致，容位均匀无起皱现象', '四线上袖，止口一致，容位均匀无起皱现象', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6033, 'ZMTXAS023', '冚袖夹线*2#line#', 186, 37.5440, 0.3004, 'STITCHING', NULL, b'0', '线迹均匀平顺', '线迹均匀平顺', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6034, 'ZMTXAS024', '四线合袖衫身侧缝短袖(净色)*2', 177, 43.4610, 0.3955, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6035, 'ZMTXAS025', '冚下脚*1', 186, 27.8590, 0.2229, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6036, 'ZMTXAS026', '封袖口压明0.5线（加暗线）#line#', 156, 38.9110, 0.2639, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6037, 'ZMTXAS027', '夹位加固*2', 156, 21.6870, 0.1471, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6038, 'ZMTXCL001', '修圆领(V领)(直/46)1条*1', 167, 7.2590, 0.0163, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6039, 'ZMTXCL002', '上扁机领(弧/46)1片*1', 156, 5.4490, 0.0354, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6040, 'ZMTXCL003', '对折拼接领子侧缝（直/6CM）*1', 156, 16.3810, 0.1310, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6041, 'ZMTXCL004', '对折走封领脚口定线(直/70CM)*1  (侧缝未烫开骨)#line#', 156, 53.8610, 0.4309, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6042, 'ZMTXCL005', '折烫罗纹立领*1', 160, 10.4720, 0.0593, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6043, 'ZMTXCL006', '烫领条*1', 160, 11.0520, 0.0626, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6044, 'ZMTXCL007', '修后领条止口*1', 161, 6.6420, 0.0451, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6045, 'ZMTXCL008', '修(圆/V领)领条子口*1#line#', 177, 9.6440, 0.0654, 'STITCHING', NULL, b'0', '止口要均匀平顺', '止口要均匀平顺', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6046, 'ZMTXCL009', '做圆领', 156, 31.5840, 0.2142, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6047, 'ZMTXSL001', '冚袖口(直/46+46)1片*2', 186, 26.3140, 0.2105, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6048, 'ZMTXSL002', '冚袖口*2', 186, 25.1800, 0.2014, 'STITCHING', NULL, b'0', '线迹均匀平顺', '袖口冚1.4CM加0.6CM双明线', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6049, 'SMCSCL001', '运领(落领三边朴+领角朴,直/8+弧/46+直/8)3边*1', 166, 35.4460, 0.2836, 'STITCHING', NULL, b'0', '止口均匀，领尖左右对称', '止口均匀，领尖左右对称', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6050, 'SMCSAS001', '包袖衫身侧缝(直/100)1边*2', 156, 44.8350, 0.4080, 'STITCHING', NULL, b'0', '线迹均匀,十字夹底骨位左右对齐', '线迹均匀,十字夹底骨位左右对齐', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6051, 'SMCSAS002', '夹左介英(折1折,直/28)1片*1', 155, 27.0680, 0.2463, 'STITCHING', NULL, b'0', '线迹均匀平服，左右介英对称', '线迹均匀平服，左右介英对称', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6052, 'SMCSAS003', '走领窝线(直/43)1片*1', 156, 12.3230, 0.0836, 'STITCHING', NULL, b'0', '线迹均匀，无需回针', '线迹均匀，无需回针', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6053, 'SMCSAS004', '夹右介英(折1折,直/28)1片*1', 155, 27.0680, 0.2463, 'STITCHING', NULL, b'1', '线迹均匀，左右对称', '线迹均匀，左右对称', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6054, 'SMCSAS005', '上领(直/46)1片*1', 155, 29.6250, 0.2696, 'STITCHING', NULL, b'1', '上领线迹均匀平服', '上领线迹均匀平服', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6055, 'SMCSAS006', '盖领(弧/46)1片*1，剪线1位*1', 155, 28.6830, 0.2610, 'STITCHING', NULL, b'1', '线迹均匀平服，不起纽', '线迹均匀平服，不起纽', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6056, 'SMCSAS007', '拼肩缝*2#line#', 156, 31.4360, 0.2861, 'STITCHING', NULL, b'0', '过肩拼接位#line#压0.1CM明线', '线迹均匀平服，左右对称', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6057, 'SMCSAS008', '上袖(沿边加朴,拉筒,弧/61+61)1边*2', 156, 47.9140, 0.4360, 'STITCHING', NULL, b'0', '袖山容位均匀，不起纽，左右对称', '袖山容位均匀，不起纽，左右对称', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6058, 'SMCSAS009', '间夹圈(弧/61+61)1边*2，撕朴2位*2', 156, 31.1630, 0.2493, 'STITCHING', NULL, b'0', '线迹均匀不起纽，夹圈圆顺不起皱', '线迹均匀不起纽，夹圈圆顺不起皱#line#', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6059, 'SMCSAS010', '拉下摆(拉筒，弧/135)1件*1，剪线1位*1', 155, 53.9700, 0.4911, 'STITCHING', NULL, b'0', '线迹均匀平服不起纽，左右对称', '线迹均匀平服不起纽，左右对称', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6060, 'SMCSAS011', '压烫长袖侧骨(3机/人，18+10\",180C)2边*1', 57, 13.4840, 0.0438, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6061, 'SMCSBK001', '落明担干(净色,工字折,沿边加朴,直/50)1件*1，手撕朴1位*1', 155, 23.3610, 0.2126, 'STITCHING', NULL, b'0', '线迹均匀平服，边褶长度、位置准确', '后幅夹车双层真破担干，担干距离两边3.5寸处车边褶，边褶深3/4寸', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6062, 'SMCSBK002', '修担干膊位&烫担干1片*1', 19, 19.3960, 0.1099, 'STITCHING', NULL, b'0', '止口烫开，膊位修剪整齐', '止口烫开，膊位修剪整齐', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6063, 'SMCSBK003', '落侧骨唛(2个重叠唛，直/4)2片*1', 155, 10.3150, 0.0825, 'STITCHING', NULL, b'0', '落唛位置准确', '落唛位置准确', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6064, 'SMCSCL002', '修/翻/烫上级领2角*1', 15, 10.8180, 0.0613, 'STITCHING', NULL, b'0', '不藏止口，领尖要尖，左右对称', '不藏止口，领尖要尖，左右对称', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6065, 'SMCSCL003', '间上级领(直/8+弧43+直/8)3边*1', 156, 20.2250, 0.1618, 'STITCHING', NULL, b'0', '止口均匀平服', '止口均匀平服', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6066, 'SMCSCL004', '走上级领底线(直/20)1边*1', 156, 5.7040, 0.0387, 'STITCHING', NULL, b'0', '止口均匀', '止口均匀，不需回针', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6067, 'SMCSCL005', '开领咀纽门2位*1', 260, 10.3670, 0.0233, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6068, 'SMCSCL006', '包下级(弧/52)1片*1', 156, 9.6080, 0.0652, 'STITCHING', NULL, b'0', '止口均匀平服', '止口均匀平服', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6069, 'SMCSCL007', '落圆咀下级(用模板，弧/49)1件*1', 156, 25.1180, 0.2286, 'STITCHING', NULL, b'0', '领咀圆顺，左右对称', '领咀圆顺，左右对称', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6070, 'SMCSCL008', '修下级底(直/49)1片*1', 167, 5.2480, 0.0356, 'STITCHING', NULL, b'0', '止口均匀', '止口均匀', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6071, 'SMCSCL009', '点下级位3位*1', 36, 4.8590, 0.0275, 'STITCHING', NULL, b'0', '点位清晰准确', '点位清晰准确', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6072, 'SMCSCL010', '开下级纽门1位*1', 259, 6.8330, 0.0387, 'STITCHING', NULL, b'0', '纽门位置准确，线迹疏密均匀', '纽门位置准确，线迹疏密均匀', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6073, 'SMCSCL011', '下级订纽1个*1', 66, 4.7520, 0.0269, 'STITCHING', NULL, b'0', '纽扣位置准确', '纽扣位置准确', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6074, 'SMCSCL012', '翻/间下级(弧/49)1片*1', 156, 17.1440, 0.0600, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6075, 'SMCSCU001', '包介英(蝴蝶拉筒，直/28)1片*2', 156, 12.9050, 0.0875, 'STITCHING', NULL, b'0', '线迹均匀不回针', '线迹均匀不回针', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6076, 'SMCSCU002', '运介英(沿边加朴，弧/38+38)1片*2', 166, 40.4970, 0.1316, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6077, 'SMCSCU003', '间圆介英(弧/38+38)1片*2，翻介英2角*2', 156, 26.6700, 0.1809, 'STITCHING', NULL, b'0', '线迹均匀平服，介英左右对称', '线迹均匀平服，介英左右对称', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6078, 'SMCSCU004', '订介英纽扣2个*2', 261, 22.4750, 0.0506, 'STITCHING', NULL, b'0', '订纽位置准确', '订纽位置准确', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6079, 'SMCSFA001', '修筒贴(对格，直/85）1片*1', 167, 10.5230, 0.0237, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6080, 'SMCSFR001', '拉纽子(条子，直/80)1片/1', 156, 17.9020, 0.1432, 'STITCHING', NULL, b'0', '止口均匀平服', '无需回针，使用蝴蝶拉筒一次性车完，止口均匀平服', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6081, 'SMCSFR001099', '', 141, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6082, 'SMCSFR0011', '拉纽子(条子，直/80)1片/1', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'1', '不起皱，要平顺', '脚口拷边或包捆条0.6CM宽；折4CM宽挑脚边，挑边线不过面#line#', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6083, 'SMCSFR002', '落筒条(直/90)1片*1', 156, 16.7680, 0.1341, 'STITCHING', NULL, b'0', '止口均匀平服', '无需回针，止口均匀平服', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6084, 'SMCSFR003', '落前幅圆袋(条子，弧/46)1片*1', 156, 41.0400, 0.1539, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6085, 'SMCSFR004', '开前幅纽门6位*1', 258, 21.4240, 0.1214, 'STITCHING', NULL, b'0', '纽门位置准确，线迹疏密均匀', '纽门位置准确，线迹疏密均匀', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6086, 'SMCSFR005', '修门襟顶&底2位*1，压烫前幅门襟&口袋(压烫18\"+冷却5\")2片*1', 111, 35.4220, 0.3223, 'STITCHING', NULL, b'1', '不起皱，要平顺', '脚口拷边或包捆条0.6CM宽；折4CM宽挑脚边，挑边线不过面#line#', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6087, 'SMCSPK001', '拉直袋口(格子，直/15)1片*1', 156, 13.8940, 0.0313, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6088, 'SMCSPK002', '焗口袋1片*1，移除衬纸1片*1', 57, 11.1350, 0.0251, 'STITCHING', NULL, b'0', '', '', 'F', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6089, 'SMCSPK003', '落袋边朴(直/9+9)2边*1', 155, 13.3890, 0.0318, 'STITCHING', NULL, b'0', '', '', 'E', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6090, 'SMCSSL001', '夹小侧(拉筒,沿边加朴，直/19)1片*2', 155, 25.7630, 0.2344, 'STITCHING', NULL, b'0', '线迹均匀平服', '线迹均匀平服', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6091, 'SMCSSL002', '封侧袖三尖(有边朴,直/3+3+1.5+1.5+3)1片*2,订小侧(直/3)1片*2', 147, 68.1600, 0.6203, 'STITCHING', NULL, b'0', '止口均匀平服，尖位要尖、对称', '止口均匀平服，尖位要尖、对称', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6092, 'SMCSCL013', '', 156, 0.0000, 0.0000, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6093, 'SMCSCU005', '开介英纽门1位*2', 73, 14.0230, 0.0795, 'STITCHING', NULL, b'0', '纽门位置准确，线迹疏密均匀', '纽门位置准确，线迹疏密均匀', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6094, 'SMCSCU006', '订介英纽扣1个*2', 261, 11.6430, 0.0660, 'STITCHING', NULL, b'1', '纽扣位置准确', '纽扣位置准确', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6095, 'SMCSCU007', '运方介英加放介英角牵条线(直/47)1片*2#line#', 156, 62.0300, 0.4962, 'STITCHING', NULL, b'0', '线迹均匀，左右对称', '线迹均匀，左右对称', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6096, 'SMCSFR008', '订前幅门襟纽扣6粒', 66, 26.5720, 0.1506, 'STITCHING', NULL, b'0', '纽扣定位准确，纽扣线松紧适宜', '纽扣定位准确，纽扣线松紧适宜', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6097, 'SMCSSL003', '夹大袖侧(拉筒,沿边加朴，直/19)1片*2', 156, 28.8040, 0.2621, 'STITCHING', NULL, b'0', '止口均匀线迹平服', '止口均匀线迹平服', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6098, 'SMCSSL004', '开侧袖纽门1位*2', 73, 12.5070, 0.0709, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6099, 'SMCSSL005', '订侧袖纽扣1位*2', 66, 11.3280, 0.0642, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6100, 'SMCSAS012', '间袖衫身侧缝(直/100)1边*2', 156, 70.2000, 0.5616, 'STITCHING', NULL, b'0', '线迹止口均匀不起纽#line#', '线迹止口均匀不起纽#line##line#', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6101, 'SMCSAS013', '间膊(直/18)1边*2', 156, 16.0560, 0.1284, 'STITCHING', NULL, b'1', '线迹均匀平服', '线迹均匀平服', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6102, 'SWCSCL021', '间下级*1#line#', 156, 21.9400, 0.1755, 'STITCHING', NULL, b'0', '止口均匀，左右对称', '下级领四周压0.1CM明线#line#', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6103, 'SWCSCL017', '上弧形领贴1边*2#line#', 156, 46.7860, 0.4258, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6104, 'SWCSCL018', '烫开弧形领贴1条*2', 160, 17.2600, 0.0978, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6105, 'SWCSCL019', '间弧形领贴1边*2', 156, 40.9320, 0.3275, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6106, 'SWCSCL020', '间上级领顶1边*1', 156, 20.0450, 0.1604, 'STITCHING', NULL, b'0', '止口均匀，线迹平服', '止口均匀，线迹平服', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6107, 'SWCSCL022', '驳立领顶*1#line#', 156, 12.5490, 0.1004, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6108, 'SWCSCL023', '开缝/折烫立领顶*1#line#', 160, 18.5020, 0.1048, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6109, 'SWCSCL024', '间立领顶*1#line#', 156, 10.3590, 0.0829, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6110, 'SWCSFR012', '封襟贴底(10CM)*2#line#', 156, 16.2970, 0.1304, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6111, 'SWCSCL010', '三线级弧形领贴1片*2', 172, 14.8770, 0.1009, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6112, 'SWCSCL011', '折烫弧形领贴*2', 160, 47.1450, 0.3198, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6113, 'SWCSCL012', '包弧形领贴止口1片*2#line#', 156, 36.2580, 0.2460, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6114, 'SWCSCL013', '折烫领贴织带*2#line#', 160, 18.9570, 0.1074, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6115, 'SWCSCL014', '上领贴织带1边*2#line#', 156, 35.1210, 0.2810, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6116, 'SWCSCL015', '折烫领贴织带1条*2#line#', 160, 20.1160, 0.1140, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6117, 'SWCSCL016', '合领贴织带1边*2#line#', 156, 29.2680, 0.2341, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6118, 'SWCSSL007', '三线级袖侧缝2边*2', 172, 68.7000, 0.4660, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6119, 'SWCSSL008', '拼袖侧缝1边*2#line#', 156, 50.3230, 0.4026, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6120, 'SWCSSL009', '间袖侧缝2边*2#line#', 156, 93.6140, 0.7489, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6121, 'SWCSSL010', '穿袖侧牵条2条*2#line#', 161, 110.4870, 0.6261, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6122, 'SWCSSL011', '拼袖侧缝(来去缝)2缝*2#line#', 156, 115.9750, 0.9278, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6123, 'SWCSAS011', '平车埋衫身侧缝1边*2#line#', 156, 49.1440, 0.4472, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6124, 'SWCSAS012', '拷边身侧缝1边*2#line#', 177, 32.2030, 0.2184, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6125, 'SWCSAS013', '拉袖口1边*2#line#', 156, 29.2680, 0.2341, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6126, 'SWCSAS014', '平车埋袖侧缝1边*2#line#', 156, 47.9650, 0.4365, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6127, 'SWCSAS015', '级袖侧骨缝1边*2#line#', 177, 35.6380, 0.2417, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6128, 'SWCSAS016', '平车上袖1片*2#line#', 156, 105.3210, 0.9584, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6129, 'SWCSAS017', '四线拷袖窿1边*2#line#', 177, 43.7100, 0.3497, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6130, 'SWCSAS018', '拷边侧骨缝(直/10cm)1边*2#line#', 177, 19.5370, 0.1563, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6131, 'SWCSAS019', '车侧骨唛*1#line#', 156, 11.7070, 0.0937, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6132, 'SWCSAS020', '拉\"U\"形前后幅下摆#line#', 156, 116.9860, 1.0646, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6133, 'SWCSAS021', '拼衫身侧缝(来去)2缝*2#line#', 156, 114.0800, 0.9126, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6134, 'SWCSAS022', '拼肩来去缝2缝*2#line#', 156, 42.6170, 0.3878, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6135, 'SWCSAS023', '落面、底筒1边*2#line#', 156, 75.2110, 0.6844, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6136, 'SWCSAS024', '封面、底筒1边*2#line#', 156, 87.7610, 0.7986, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6137, 'SWCSAS025', '封筒底*1#line#', 156, 18.8240, 0.1506, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6138, 'SWCSAS026', '拼前幅下摆贴(来去)*2缝#line#', 156, 50.1550, 0.4564, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6139, 'SWCSAS027', '间前幅下摆贴*1#line#', 156, 25.0560, 0.2280, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6140, 'SWCSAS028', '打撞钉*2#line#', 156, 31.3310, 0.1775, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6141, 'SWCSAS029', '埋夹(来去缝)2缝*2#line#', 156, 112.8170, 1.0266, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6142, 'SWCSAS030', '间侧骨*2#line#', 156, 50.1550, 0.4564, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6143, 'SWCSAS031', '拼接袖贴(10cm)*2#line#', 156, 12.5490, 0.1004, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6144, 'SWCSAS032', '开缝及折烫袖贴边*2#line#', 160, 7.9890, 0.0453, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6145, 'SWCSAS033', '上袖贴一圈*2#line#', 161, 71.0330, 0.6464, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6146, 'SWCSAS034', '翻/间袖贴*2#line#', 156, 62.6620, 0.5013, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6147, 'SWCSAS035', '折烫袖贴止口*2#line#', 160, 36.9630, 0.2095, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6148, 'SWCSAS036', '包缝袖贴*2#line#', 156, 68.9370, 0.6273, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6149, 'SWCSAS037', '级袖山1边*2#line#', 177, 30.7950, 0.2089, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6150, 'SWCSAS038', '平车上袖1片*2#line#', 156, 50.1550, 0.4564, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6151, 'SWCSBK004', '折烫后幅担干*1#line#', 160, 14.7770, 0.0837, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6152, 'SWCSBK005', '贴后幅担干*1#line#', 251, 24.0930, 0.2192, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6153, 'SWCSFR008', '拼双层暗筒*1#line#', 156, 28.2150, 0.2257, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6154, 'SWCSFR009', '间双层门襟线*1#line#', 156, 26.9510, 0.2156, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6155, 'SWCSFR010', '暗门襟开纽门*7#line#', 260, 29.0400, 0.1646, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6156, 'SWCSFR011', '暗门襟打枣*6#line#', 251, 25.3070, 0.1434, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6157, 'SWCSFR013', '翻/平烫襟贴*1#line#', 160, 24.6280, 0.1396, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6158, 'SWCSFR014', '落前幅襟贴3边*2#line#', 156, 75.2110, 0.6844, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6159, 'SWCSFR015', '封面、底门筒顶1边*2#line#', 156, 15.6660, 0.1253, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6160, 'SWCSFR016', '翻/烫封面、底门筒*2#line#', 160, 12.3350, 0.0699, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6161, 'SWCSFR017', '面筒开纽门*4个#line#', 260, 32.0900, 0.1818, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6162, 'SWCSFR018', '底筒订纽扣*4粒#line#', 66, 22.5720, 0.1279, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6163, 'SWCSFR019', '烫旗仔4边*2#line#', 160, 24.6280, 0.1396, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6164, 'SWCSFR020', '落旗仔4边*2#line#', 156, 42.6170, 0.3878, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6165, 'SMCSCU008', '驳介英顶1边*2', 156, 25.0560, 0.2004, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6166, 'SMCSCU009', '折烫介英顶*2#line#', 161, 17.7780, 0.1007, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6167, 'SMCSFR009', '运拉链贴*1#line#', 156, 43.8800, 0.3510, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6168, 'SMCSFR010', '翻/烫拉链贴*1#line#', 160, 24.6280, 0.1396, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6169, 'SMCSFR011', '间拉链贴3边*1#line#', 156, 35.1210, 0.2810, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6170, 'SMCSFR012', '落拉链贴于拉链上*1#line#', 156, 40.7220, 0.3258, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6171, 'SMCSFR013', '落前中拉链*2 #line#', 156, 127.3450, 1.1588, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6172, 'SMCSFR014', '车拉链织带*2#line#', 156, 59.5880, 0.5423, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6173, 'SMCSFR015', '单针间前中拉链明线2条#line#', 156, 109.3640, 0.8749, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6174, 'SMCSBK004', '车/订后幅工字折*1#line#', 156, 31.3310, 0.2506, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6175, 'SMCSBK005', '折烫后幅工字折*1#line#', 156, 12.5490, 0.0711, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6176, 'SMCSBK006', '订/落担干主唛*1#line#', 156, 34.4890, 0.2759, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6177, 'SMCSAS014', '画/开袖叉位*2#line#', 161, 41.4420, 0.2348, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6178, 'SMCSAS015', '上介英(单折)*2#line#', 156, 56.4300, 0.5135, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6179, 'SMCSAS016', '上袖侧拉链连介英一段2*2#line#', 156, 188.0280, 1.7111, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6180, 'SMCSAS017', '拉袖侧拉链织带2边*2#line#', 156, 75.2110, 0.6844, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6181, 'SMCSAS018', '封袖侧拉链底*2#line#', 156, 31.3310, 0.2506, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6182, 'SMCSAS019', '包拉链底织带*2#line#', 156, 50.1550, 0.4564, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6183, 'SMCSAS020', '间\"U\"形拉链线1边*2#line#', 156, 31.3310, 0.2506, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6184, 'SMCSAS021', '合介英*2#line#', 156, 50.1550, 0.4564, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6185, 'SMCSAS022', '间介英1边*2#line#', 156, 22.5720, 0.1806, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6186, 'SMCSAS023', '间介英3边*2#line#', 156, 35.1210, 0.2810, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6187, 'SWCSCU004', '运大方介英3边*2#line#', 156, 75.2110, 0.6017, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6188, 'SWCSCU005', '翻大方介英*2#line#', 161, 17.7780, 0.1007, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6189, 'SWCSCU006', '开骨烫大方介英3边*2#line#', 161, 23.6640, 0.1341, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6190, 'SWCSCU007', '间大方介英3边*2#line#', 156, 50.2810, 0.4022, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6191, 'SWCSCU008', '开介英纽门2*2#line#', 260, 20.5800, 0.1166, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6192, 'test_1%$#5', 'test_工艺1', 1, 0.0000, 0.0000, NULL, NULL, b'0', '', NULL, '', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6193, 'SMCSCL014', '画/运上级领1片*1', 156, 62.4940, 0.5000, 'STITCHING', NULL, b'0', '线迹止口均匀平服', '上级领连压0.6CM明线#line#', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6194, 'SMCSCL015', '修/翻上级领1片*1', 167, 40.7150, 0.2307, 'STITCHING', NULL, b'0', '领尖左右对称，不藏止口', '领尖左右对称，不藏止口', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6195, 'SMCSCL016', '画/走上级领底线1片*1', 156, 26.9510, 0.1828, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6196, 'SMCSCL017', '修下级领*1，修/翻领咀2边', 167, 29.9110, 0.1695, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6197, 'SMCSBK007', '拼/间双层暗担干*1#line#', 156, 60.5990, 0.5515, 'STITCHING', NULL, b'0', '线迹均匀平服#line#', '拼接后担干里外折光夹车#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6198, 'SMCSBK008', '平车间后担干*1（双层）#line#', 156, 19.4560, 0.1556, 'STITCHING', NULL, b'0', '线迹均匀#line#线迹顺直#line#', '面压0.1CM明线#line#', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6199, 'SMCSSL006', '封面袖侧(明筒式)*2', 156, 60.9350, 0.5545, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6200, 'SMCSSL007', '封底袖叉线(明筒式)*2#line#', 156, 47.5020, 0.4323, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6201, 'SMCSSL008', '间大小袖侧*2，封三尖*2#line##line#', 156, 246.8160, 2.2460, 'STITCHING', NULL, b'0', '线迹均匀平整，三尖位左右对称#line#', '线迹均匀平整，三尖位左右对称#line##line#', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6202, 'SMCSAS024', '袖口打折位1边*2', 156, 23.1190, 0.1568, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6203, 'SMCSAS025', '上介英1边*2', 156, 66.8730, 0.6085, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6204, 'SMCSAS026', '压介英线1边*2', 156, 67.8840, 0.6177, 'STITCHING', NULL, b'0', '左右介英对称#line#', '袖口介英拼接位压0.1CM加0.6CM双明线#line#', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6205, 'SMCSAS027', '开成品钮门*11，点位*11 (领子*1，门襟*6，侧袖*2，介英*2)#line#', 70, 99.2570, 0.5625, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6206, 'SMCSAS028', '点成品钮位*11(领子*1，门襟*6，侧袖*2，介英*2)#line#', 15, 37.8630, 0.2146, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6207, 'SMCSAS029', '钉成品钮*11(领子*1，门襟*6，侧袖*2，介英*2)#line#', 66, 60.3460, 0.3420, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6208, 'SMCSAS030', '绕成品纽*11(领子*1，门襟*6，侧袖*2，介英*2)#line##line#', 97, 38.6580, 0.2191, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6209, 'SMCSAS031', '大烫衬衫长袖（净色/条子）', 20, 88.8800, 0.5037, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6210, 'ZMCSCU004', '修六角介英止口(直/2+4+28+2+4)1片*2', 171, 48.4960, 0.3290, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6211, 'ZMCSCL010', '间上级领顶(直/40)1片*1', 156, 11.6360, 0.0789, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6212, 'ZMCSAS020', '间膊(直/18)1边*2', 156, 16.0560, 0.1284, 'STITCHING', NULL, b'1', '线迹均匀平服，左右对称#line#', '过肩拼接位压0.1CM明线#line#', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6213, 'SMCSAS033', '中查(梭织)', 21, 11.0570, 0.0627, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6214, 'ZMCSAS013', '间成品六角介英(直/4+2+28+2+4)1边*2，剪线1位*2', 156, 54.4220, 0.4354, 'STITCHING', NULL, b'0', '左右介英对称#line#', '袖口介英拼接位压0.1CM加0.6CM双明线，袖口边压0.1CM明线#line#', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6215, 'ZMCSCU009', '折烫介英底0.7子口*2#line#', 19, 18.7880, 0.1065, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6216, 'ZMCSCU001', '劈烫介英缝3边*2', 19, 30.1260, 0.1707, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6217, 'ZMCSSL003', '折烫大袖侧1片*2', 19, 32.4750, 0.1840, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6218, 'ZMCSSL004', '折烫小袖侧1片*2', 19, 32.4750, 0.1840, 'STITCHING', NULL, b'1', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6219, 'ZMCSAS021', '上衬衫领*1', 156, 71.5900, 0.6515, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6220, 'ZMCSCU008', '运方介英加放介英角牵条线(直/47)1片*2', 156, 63.5840, 0.5087, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6221, 'SMCSCU010', '修/翻方介英*2，修成品介英*2', 167, 72.9650, 0.4135, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6222, 'SWCSFR021', '落样点前腰省3点*2   两头尖#line#', 161, 28.5560, 0.1618, 'STITCHING', NULL, b'1', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6223, 'SWCSFR022', '落样打前腰省(直/10CM)2个*1  #line#', 156, 50.6180, 0.3434, 'STITCHING', NULL, b'1', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6224, 'SMCSSL009', '拉短袖袖口*2', 156, 35.1210, 0.2810, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6225, 'SMCSSL010', '折烫袖口*2', 19, 24.2950, 0.1377, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6226, 'SMCSCL018', '做上下级领子*1', 156, 277.8100, 2.2225, 'STITCHING', NULL, b'0', '线迹平服止口均匀，领子左右对称', '上级领连压0.6CM明线，下级领四周压0.1CM明线', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6227, 'SMCSCU011', '做方介英*2', 156, 207.3570, 1.6589, 'STITCHING', NULL, b'0', '线迹均匀平服，左右介英对称', '袖口介英拼接位#line#压0.1CM加0.6CM#line#双明线#line#，袖口边压0.1CM明线', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6228, 'SMCSCU012', '上介英*2', 156, 221.8860, 2.0192, 'STITCHING', NULL, b'0', '', '袖口介英拼接位#line#压0.1CM加0.6CM#line#双明线#line#，袖口边压0.1CM明线', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6229, 'SMCSSL011', '开袖叉封三尖*2', 156, 425.4110, 3.8712, 'STITCHING', NULL, b'0', '线迹均匀平服，左右袖叉对称#line#', '袖口开衩贴三角箭贴压0.1CM明线#line#', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6230, 'SMCSFR016', '拉左右门筒*2/落后担干*1', 156, 174.7630, 0.6117, 'STITCHING', NULL, b'0', '线迹均匀平服，工字褶要居中', '左右门筒双折间1 1/16 寸明线；#line#拼接后担干里外折光夹车，面压0.1CM明线。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6231, 'SMCSAS034', '拉膊*2/上领/车唛头', 156, 255.0280, 2.3208, 'STITCHING', NULL, b'0', '线迹均匀平服，左右对称', '过肩拼接位压0.1CM明线；#line#下级领四周压0.1CM明线', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6232, 'SMCSAS035', '上袖*2/包间侧骨缝*2/拉下摆/后整', 156, 555.0310, 5.0508, 'STITCHING', NULL, b'0', '包骨线迹均匀,十字夹底骨位左右对齐#line#下摆线迹平顺不起扭#line#', '侧缝和袖缝埋夹缝#line#压0.1CM加0.6CM#line#双明线；#line#下摆卷边#line#缝压0.6CM#line#明线#line##line#', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6233, 'SWCSBK006', '落样点前腰省3点*2   两头尖#line#', 161, 28.5560, 0.1618, 'STITCHING', NULL, b'1', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6234, 'SWCSBK007', '落样打前腰省(直/10CM)2个*1  #line#', 156, 50.6180, 0.3434, 'STITCHING', NULL, b'1', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6235, 'SWCSAS044', '拼长袖侧缝(来去缝)2缝*2，拼衫身侧缝(来去)2缝*2#line#', 156, 240.4150, 1.9233, 'STITCHING', NULL, b'0', '衣身左右侧缝来去缝', '衣身左右侧缝来去缝', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6236, 'SWCSAS041', '上圆袖*2', 156, 188.1120, 1.7118, 'STITCHING', NULL, b'0', '圆袖不起皱', '圆袖不起皱', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6237, 'SWCSAS043', '专机(开钮门*11，点位*11，订纽*11，绕纽*11)，整烫', 20, 286.4400, 1.6232, 'STITCHING', NULL, b'0', '门襟#line#按纸#line#样点#line#位开#line#平眼，#line#订纽扣', '门襟#line#按纸#line#样点#line#位开#line#平眼，#line#订纽扣', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6238, 'SWCSFR023', '打前胸*2/腰省*2，拉左右筒*2', 156, 246.9840, 1.9759, 'STITCHING', NULL, b'0', '左右拉筒压2.5CM明线；收三尖省，省尖顺直不起酒窝。', '左右拉筒压2.5CM明线；收三尖省，省尖顺直不起酒窝。', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6239, 'SWCSBK008', '打后腰省*2，落后担干*1', 156, 176.0260, 1.4082, 'STITCHING', NULL, b'0', '拼接后担干里外折光#line#夹车，面压0.1CM明线；收三角省，省尖#line#顺直不起酒窝', '拼接后担干里外折光#line#夹车，面压0.1CM明线；收三角省，省尖#line#顺直不起酒窝', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6240, 'SMCSSL012', '单针环间袖口(20CM/未烫)*2', 156, 77.0640, 0.6165, 'STITCHING', NULL, b'0', '1寸单折入袖口,先埋夹再环间袖口#line#,线迹均匀平服', '1寸单折入袖口,先埋夹再环间袖口#line#,线迹均匀平服', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6241, 'ZWTXCL006', '画/修扁机领*1，剪织带*1', 167, 24.1870, 0.1371, 'STITCHING', NULL, b'0', '画位/修领位置准确', '画位/修领位置准确', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6242, 'ZWTXCL007', '四线上扁机领暗线*1', 177, 90.5650, 0.8241, 'STITCHING', NULL, b'0', '对准刀口，左右对称', '对准刀口，左右对称', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6243, 'ZWTXCL008', '落/包后领条*1,车尺主唛', 156, 120.1860, 1.0937, 'STITCHING', NULL, b'0', '后领贴人字棉织带平顺不可扭包住止口', '后领贴人字棉织带平顺不可扭包住止口', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6244, 'ZWTXSL002', '剪/切袖口*2', 167, 16.1250, 0.1094, 'STITCHING', NULL, b'0', '止口准确整齐', '止口准确整齐', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6245, 'ZWTXSL003', '轧边车上扁机袖口*2#line#', 177, 28.7670, 0.2301, 'STITCHING', NULL, b'0', '宽窄一致，#line#左右袖对称#line#', '宽窄一致，#line#左右袖对称#line#', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6246, 'ZWTXSL004', '间/封袖口*2', 156, 23.2460, 0.1577, 'STITCHING', NULL, b'0', '面压0.1cm明线，止口宽窄一致，左右对称', '面压0.1cm明线，止口宽窄一致，左右对称', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6247, 'ZWTXFR001', '烫/修门筒*2', 167, 42.0450, 0.2383, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6248, 'ZWTXFR002', '开筒/封筒底方块*1', 156, 120.2290, 1.0941, 'STITCHING', NULL, b'0', '压0.1CM筒边方块明线，开襟四角方正，不爆口，打平#line#', '压0.1CM筒边方块明线，开襟四角方正，不爆口，打平#line#', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6249, 'ZWTXAS016', '四线拉膊/上袖*2', 177, 84.2320, 0.7665, 'STITCHING', NULL, b'0', '四线肩缝夹透明胶条，绱袖对准刀口#line#，夹#line#圈圆顺#line#', '四线肩缝夹透明胶条，绱袖对准刀口#line#，夹#line#圈圆顺#line#', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6250, 'ZWTXAS017', '四线埋夹短袖*2，级筒底*1', 177, 51.3670, 0.4674, 'STITCHING', NULL, b'0', '四线打边合缝衣身左右侧缝顺直不起吊', '四线打边合缝衣身左右侧缝顺直不起吊', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6251, 'ZWTXAS013', '冚下脚一圈*1', 186, 53.1630, 0.4253, 'STITCHING', NULL, b'1', '下摆冚1.5CM加0.6CM#line#双明线，圆顺不起扭不#line#露止口，侧缝接缝线张重合', '下摆冚1.5CM加0.6CM#line#双明线，圆顺不起扭不#line#露止口，侧缝接缝线张重合', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6252, 'ZWTXAS018', '开纽门*3,点位*3,钉扣*3,绕线*3,中查,整烫', 20, 162.8180, 0.9226, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6253, 'SWCSAS039', '拼肩缝*2，间肩缝*2', 156, 50.1550, 0.4564, 'STITCHING', NULL, b'0', '止口均匀，前片和担干的领窝位和袖窿位要对齐#line#', '止口均匀，前片和担干的领窝位和袖窿位要对齐#line#', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6254, 'ZWTXAS019', '缝袖口*2/夹位加固*2', 156, 57.4820, 0.3899, 'STITCHING', NULL, b'0', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6255, 'SWCSAS040', '装领车唛', 156, 193.3760, 1.7597, 'STITCHING', NULL, b'0', '上级领压0.6cm明线；下级领四周压0.1cm明线.领尖平直不爆口，左右对称', '上级领压0.6cm明线；下级领四周压0.1cm明线.领尖平直不爆口，左右对称', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6256, 'SWCSSL012', '三线级圆袖圈*2', 172, 43.9730, 0.2983, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6257, 'SMCSAS036', '上袖*2/间袖夹圈*2#line#', 156, 82.5390, 0.7511, 'STITCHING', NULL, b'0', '间0.6CM明线，圆顺不起皱', '间0.6CM明线，圆顺不起皱', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6258, 'SMCSAS037', '包/间袖衫身侧缝*2#line#', 156, 120.1860, 1.0937, 'STITCHING', NULL, b'1', '包骨线迹均匀,十字夹底骨位左右对齐#line#下摆线迹平顺不起扭#line#', '侧缝和袖缝埋夹缝#line#压0.1CM加0.6CM#line#双明线；#line#下摆卷边#line#缝压0.6CM#line#明线#line##line#', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6259, 'SMCSOH001', '烫画下级*1,烫袖衩条*2，折烫介英0.7止口,折烫门筒*2', 19, 119.2080, 0.6755, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6260, 'SMCSAS038', '包/间袖短袖衫身侧缝(60cm)*2#line#', 156, 90.1190, 0.8201, 'STITCHING', NULL, b'1', '包骨线迹均匀,十字夹底骨位左右对齐#line#下摆线迹平顺不起扭#line#', '侧缝和袖缝埋夹缝#line#压0.1CM加0.6CM#line#双明线；#line#下摆卷边#line#缝压0.6CM#line#明线#line##line#', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6261, 'SMCSCL019', '画/运/修/间上级领*1，走上级领底*1', 156, 139.0100, 1.1121, 'STITCHING', NULL, b'0', '线迹平服止口均匀，领子左右对称', '上级领连压0.6CM明线，下级领四周压0.1CM明线', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6262, 'SMCSCL020', '落/修/翻/间下级领*1', 156, 144.2320, 1.1539, 'STITCHING', NULL, b'1', '线迹平服止口均匀，领子左右对称', '上级领连压0.6CM明线，下级领四周压0.1CM明线', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6263, 'SMCSSL014', '封袖叉三尖*2', 156, 151.5600, 1.3792, 'STITCHING', NULL, b'1', '线迹均匀平服，左右袖叉对称#line#', '袖口开衩贴三角箭贴压0.1CM明线#line#', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6264, 'SMCSCL022', '修/翻上级领*1，修/翻上级领介英*2#line#', 167, 113.0350, 0.6405, 'STITCHING', NULL, b'0', '领、介英角尖挺，不藏止口', '领、介英角尖挺，不藏止口', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6265, 'SMCSCL021', '做介英*2，做上级领*1#line#', 156, 236.2460, 1.8900, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6266, 'SMCSCL023', '做上级领*1#line#', 156, 125.4500, 1.0036, 'STITCHING', NULL, b'1', '线迹均匀，两边领尖对称#line#', '线迹均匀，两边领尖对称#line#', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6267, 'SMCSCL024', '落下级领*1，间领*1，车唛头*1#line#', 156, 117.0700, 1.0653, 'STITCHING', NULL, b'0', '领咀圆顺，左右对称', '领咀圆顺，左右对称', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6268, 'SMCSFR017', '夹左右门筒贴*2/落后担干*1', 156, 287.4120, 1.0059, 'STITCHING', NULL, b'1', '线迹均匀平服，工字褶要居中', '夹左右门筒间1 1/16 寸明线；#line#拼接后担干里外折光夹车，面压0.1CM明线。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6269, 'SWCSAS046', '拼短袖侧缝(来去缝)2缝*2，拼衫身侧缝(来去)2缝*2#line#', 156, 217.3800, 1.7390, 'STITCHING', NULL, b'1', '衣身左右侧缝来去缝', '衣身左右侧缝来去缝', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6270, 'ZMTXAS031', '间圆领领圈线*1#line#', 156, 49.5650, 0.3965, 'STITCHING', NULL, b'0', '压0.15cm明线，线迹顺直均匀#line#', '压0.15cm明线，线迹顺直均匀', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6271, 'ZMTXAS032', '压后领捆条*1，修后领止口*1', 156, 34.4890, 0.2759, 'STITCHING', NULL, b'0', '后领贴人字棉织带平顺不可扭包住止口#line#', '后领贴人字棉织带平顺不可扭包住止口#line#', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6272, 'ZMTXAS029', '上袖长袖(净色,弧/60)1片*2', 177, 43.2040, 0.1620, 'STITCHING', NULL, b'0', '上袖按定位，容位均匀，袖笼圆顺、止口平服，左右对称#line#', '上袖按定位，容位均匀，袖笼圆顺、止口平服，左右对称#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6273, 'ZMTXAS030', '四线合袖衫身侧缝长袖(直/100,加1个唛头,净色)1边*2', 177, 48.2500, 0.4391, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6274, 'ZMTXCL012', '折烫圆领*1，后领条*1', 19, 22.5130, 0.1276, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6275, 'ZMTXAS033', '大烫短袖（圆/V领，净色/条子）#line#', 20, 84.4260, 0.4784, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6276, 'ZMTXAS034', '双针冚圆长袖口*2', 186, 40.8820, 0.3271, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6277, 'ZMTXAS035', '双针冚圆短袖口*2', 186, 31.7330, 0.2539, 'STITCHING', NULL, b'0', '袖口/下摆坎双线高须一致，双线间距0.9cm，双线顺直平服、无起扭，注意接线部位须重叠', '袖口/下摆坎双线高须一致，双线间距0.9cm，双线顺直平服、无起扭，注意接线部位须重叠', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6278, 'ZMCSAS015', '双针冚下摆一圈(直/100)1件*1', 186, 23.8120, 0.2167, 'STITCHING', NULL, b'0', '下摆坎双线高须一致，双线间距0.9cm，双线顺直平服、无起扭，注意接线部位须重叠，成品两边袖口对称、无高低。#line#', '下摆坎双线高须一致，双线间距0.9cm，双线顺直平服、无起扭，注意接线部位须重叠，成品两边袖口对称、无高低。#line#', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6279, 'ZMTXAS028', '四线级圆领散口(直/46)1条*1', 177, 17.8000, 0.1424, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6280, 'ZMCSAS017', '车主唛线1个加放尺码唛1个(直/2+2)', 156, 31.4010, 0.2512, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6281, 'ZWPLFR002', '开筒，落面底筒，压面筒0.1（三粒扣）#line##line#', 156, 52.2600, 0.4756, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6282, 'ZWPLFR003', '封面/底筒，封筒底方块#line#', 156, 76.3060, 0.6944, 'STITCHING', NULL, b'0', '门筒边压0.1cm单线，筒底按版压双线，面筒盖底筒0.1cm#line#开襟四角方正，#line#不爆口', '门筒边压0.1cm单线，筒底按版压双线，面筒盖底筒0.1cm#line#开襟四角方正，#line#不爆口', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6283, 'ZWPLCL001', '画/修扁机领*1，画/修扁机袖口*2，剪织带*1#line#', 167, 39.9890, 0.2266, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6284, 'ZWTXAS014', '封袖口压明0.5线（加暗线）#line#', 156, 38.9110, 0.2639, 'STITCHING', NULL, b'1', '', '', 'C(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6285, 'ZWPLFR001', '折烫半开胸门筒*2', 19, 12.9170, 0.0732, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6286, 'ZMTXAS036', '埋夹长袖（净色），级筒底*1#line#', 177, 58.5280, 0.5326, 'STITCHING', NULL, b'0', '', '', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6287, 'ZMTXCL013', '做V领领咀*1#line#', 156, 37.6060, 0.3008, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6288, 'ZMTXCL014', '平车上V领*1#line#', 156, 70.0320, 0.6373, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6289, 'ZMTXCL015', '及V领散口*1#line#', 172, 26.5820, 0.2127, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6290, 'ZMTXCL016', '压V领领圈线*1#line#', 156, 35.5000, 0.3230, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6291, 'ZMPLCL001', '烫画下级领*1，折烫半开胸门筒*2#line#', 19, 30.1660, 0.1709, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6292, 'ZMPLFR001', '开前幅上拉链1边*2，封筒底拉链*1#line#', 156, 229.9290, 2.0924, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6293, 'ZMPLFR002', '拉前幅拉链底织带1边*3#line#', 156, 39.7110, 0.3177, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6294, 'ZMPLFR003', '包拉链底织带*2#line#', 156, 28.2150, 0.2257, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6295, 'ZMPLFR004', '间U形筒边线*1#line#', 156, 114.9650, 0.9197, 'STITCHING', NULL, b'0', '开襟四角方正不爆口，压0.1CM明线', '开襟四角方正不爆口，压0.1CM明线', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6296, 'SWCSAS047', '装领车唛', 156, 193.3760, 1.7597, 'STITCHING', NULL, b'0', '上级领压0.6cm明线；下级领四周压0.1cm明线.领尖平直不爆口，左右对称', '上级领压0.6cm明线；下级领四周压0.1cm明线.领尖平直不爆口，左右对称', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6297, 'SMKZFA002', '级纽牌*1，级纽子*1,拷右前片门襟位,拷后片中档1边*2，级风琴袋3边*1#line#', 172, 79.7450, 0.5409, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6298, 'SMKZPK001', '落前袋贴于袋布*4，落上下拉链于袋贴边*4，落袋贴于前片*4', 19, 230.2370, 1.3047, 'STITCHING', NULL, b'0', '走线均匀美观，拉链平顺不可起拱', '走线均匀美观，拉链平顺不可起拱', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6299, 'SMKZPK002', '开前袋口*2,封两边三角及间方形袋口*2，运/翻/间袋底布#line#', 172, 251.4740, 1.7058, 'STITCHING', NULL, b'0', '走线均匀美观，拉链平顺不可起拱', '走线均匀美观，拉链平顺不可起拱', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6300, 'SMKZPK003', '做前挖袋*2 (落前袋衬袋贴，落拉链，开前袋，封袋口三角，间袋口，车袋布底，固定袋布)', 156, 496.4110, 4.5173, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6301, 'SMKZPK004', '做后挖袋*1 (落前袋衬袋贴，落拉链，开前袋，封袋口三角，车袋布底，固定袋布,)', 156, 266.3980, 2.4242, 'STITCHING', NULL, b'0', '后左开暗袋，袋口装拉链平顺不起搭，四周压撞黑色线，走线均匀美观，不可断线接线#line##line##line#', '后左开暗袋，袋口装拉链平顺不起搭，四周压撞黑色线，走线均匀美观，不可断线接线#line##line##line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6302, 'SMKZPK005', '落样运/翻/烫/间方型后袋盖*1，订/修/翻/烫型风琴袋角2边，间风琴袋3边*1，包风琴袋袋口*1#line##line#', 156, 136.6520, 1.2435, 'STITCHING', NULL, b'0', '右贴风琴袋平顺方正，袋口装拉链平服，上贴袋盖，压0.6CM明线。', '右贴风琴袋平顺方正，袋口装拉链平服，上贴袋盖，压0.6CM明线。', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6303, 'SMKZPK006', '烫风琴袋面*1，折烫风琴袋3边*1，折烫风琴袋口1边*1#line##line##line#', 19, 69.3220, 0.3928, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6304, 'SMKZPK007', '落风琴袋上下拉链2边*1，落风琴袋于后裤片*1，订袋口两端，落/间风琴袋盖*1', 156, 167.9830, 1.5286, 'STITCHING', NULL, b'0', '右贴风琴袋平顺方正，袋口装拉链平服，上贴袋盖，压0.6CM明线。', '右贴风琴袋平顺方正，袋口装拉链平服，上贴袋盖，压0.6CM明线。#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6305, 'SMKZFR002', '单针打/间前片褶（8CM）4个*2,打后腰褶（8CM）1个*2，走线固定褶位*2#line#', 156, 88.7710, 0.7102, 'STITCHING', NULL, b'0', '褶深8cm省尖平顺不起酒窝,缉线迹均匀，头尾回针，左右对称#line##line#', '褶深8cm省尖平顺不起酒窝,缉线迹均匀，头尾回针，左右对称#line##line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6306, 'SMKZBK003', '单针拼后中档1边*2#line#', 156, 33.8580, 0.2709, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6307, 'SMKZBK004', '双针间后裤片拼驳位(30CM)1边*2 (之后需要印花)#line#', 163, 26.8820, 0.2151, 'STITCHING', NULL, b'0', '拼接位间0.1加0.6cm双明线，线迹均匀平服，左右对称', '拼接位间0.1加0.6cm双明线，线迹均匀平服，左右对称', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6308, 'SMKZWB001', '拼腰节(10CM)2边*1，拼裤脚(12CM)1边*2,定位剪裤腰丈跟*1/下脚丈跟*2，驳裤脚丈跟(6cm)1边*2#line#', 156, 122.2080, 0.9777, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6309, 'SMKZWB002', '包烫腰节*1和面/底裤腰*1,前/后左右开袋位*4，点袋盖位1,点前省位8，点后腰省位*2#line##line#', 19, 168.7700, 0.9564, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6310, 'SMKZWB003', '单针做裤腰(内夹橡筋)*1，间裤腰*1，做裤脚(内夹橡筋)*2，间裤脚*2#line##line#', 156, 268.4610, 2.1477, 'STITCHING', NULL, b'0', '松紧裤腰/裤脚均分夺二道明线，方向不可起扭', '松紧裤腰/裤脚均分夺二道明线，方向不可起扭', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6311, 'SMKZWB004', '腰节打鸡眼*2#line#', 73, 18.8240, 0.1067, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6312, 'SMKZOH001', '单针拉拉链织带1条(有拉筒)#line#', 156, 25.0560, 0.1700, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6313, 'SMKZOH002', '单针间织带1条，定位剪织带*4，订织带于拉链头上*4，合纽子底(弯/5cm)连翻角*1#line#', 156, 99.0460, 0.7924, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6314, 'SMKZOH003', '单针驳裤脚和丈跟*2，裤脚对折夹丈跟一周*2，间裤脚线*2', 156, 204.9570, 1.6397, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6315, 'SMKZAS001', '单针合内侧缝(75CM)2条*1,单针合外侧缝(连合前袋边，直100/CM)*2#line##line#', 156, 144.7800, 1.3175, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6316, 'SMKZAS002', '三线拷内侧缝(直82CM)2条*1，三线拷外侧缝(双层直/100CM)2条*1#line#', 172, 97.6720, 0.7814, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6317, 'SMKZAS003', '单针合/间前后浪(弯44CM)*1，订侧唛*1', 156, 50.1550, 0.4012, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6318, 'SMKZAS004', '级前后浪里(弯44CM)*1#line##line#', 172, 18.4220, 0.1474, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6319, 'SMKZAS005', '上橡筋裤腰(直/100CM)*1,盖橡筋裤腰(直/100CM)*1#line##line#', 156, 130.2930, 1.1857, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6320, 'SMKZAS006', '单针上橡筋裤脚一周（直/40CM）1条*2,间左后袋方型面线*3条#line#', 156, 140.4000, 1.2776, 'STITCHING', NULL, b'0', '四周压撞黑色线，走线均匀美观，不可断线接线', '四周压撞黑色线，走线均匀美观，不可断线接线', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6321, 'SMKZAS007', '落纽牌/纽子*1，落拉链*1，间\"J\"型门襟*1，间前后浪*1', 156, 149.1590, 1.3573, 'STITCHING', NULL, b'0', '前中门襟装拉链不起拱，面压明线圆顺', '前中门襟装拉链不起拱，面压明线圆顺', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6322, 'SMKZAS008', '四线拷裤脚一周（直/40CM）1条*2,穿裤腰绳子*1#line#', 177, 123.2650, 0.9861, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6323, 'SMKZAS009', '大烫裤子#line#', 20, 135.0000, 0.7650, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6324, 'OP0024', '裁剪', 294, 260.0000, 0.1200, 'CUTTING', '裁剪', b'0', '裁剪', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6325, 'SMCSAS044', '整烫长袖', 19, 33.7700, 0.1914, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6326, 'SMCSAS045', '整烫短袖#line#', 19, 28.1420, 0.1595, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6327, 'SMCSAS039', '开成品钮门*7，点成品钮位*7 (领子*1，门襟*6)#line#', 70, 58.5350, 0.3317, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6328, 'SMCSAS040', '点成品钮位*7(领子*1，门襟*6)#line#', 15, 18.7720, 0.1064, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6329, 'SMCSAS041', '钉成品钮*7(领子*1，门襟*6)#line#', 66, 33.4370, 0.1895, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6330, 'SMCSAS042', '绕成品纽*7(领子*1，门襟*6)#line#', 97, 21.9400, 0.1243, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6331, 'SMCSAS043', '大烫衬衫短袖（净色/条子）', 20, 65.3130, 0.3701, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6332, 'ZWTXAS020', '落/间后领捆条2线*1，车主唛加放尺码唛4边*1', 156, 111.8480, 1.0178, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6333, 'ZMTXOH001', '落肩缝弹力条1边*2，落夹圈弹力条1边*2#line#', 156, 66.1150, 0.5289, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6334, 'ZMTXAS037', '大烫长袖（圆/V领，净色/条子）', 20, 94.4680, 0.6408, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6335, 'SMCSCU013', '包/运介英*2#line#', 156, 4.4640, 0.0357, 'STITCHING', NULL, b'0', '运介英头尾回针，线迹均匀平整', '运介英头尾回针，线迹均匀平整#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6336, 'SMCSAS046', '走领窝线*1，上领*1#line#', 156, 87.8030, 0.7990, 'STITCHING', NULL, b'0', '领窝平顺不起皱', '领窝平顺不起皱', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6337, 'SMCSAS050', '包短袖衫身侧缝*2#line#', 156, 36.5950, 0.3330, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6338, 'SMCSOH002', '烫画下级*1,折烫门筒*2#line#', 19, 52.2350, 0.2960, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6339, 'SMCSAS047', '压领线*1，车唛头*1#line#', 156, 105.5740, 0.9607, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6340, 'SMWTPK002', '做左右下前袋*2 (落袋贴2*2，开袋*2，封袋口三角2*2，落上下拉链2*2，间上下袋口线2*2，固定袋子*2，间实样线*2)', 156, 603.5850, 5.4926, 'STITCHING', NULL, b'1', '左右下开袋装拉链平顺面压袋形明线，左右对称，线迹美观#line#', '左右下开袋装拉链平顺面压袋形明线，左右对称，线迹美观#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6341, 'SMWTBK001', '拼面布后中缝*1，拼后领贴*1，运袋盖*1，订后风琴袋角*2#line#', 156, 92.1400, 0.7371, 'STITCHING', NULL, b'0', '后中点位贴风琴袋方正，袋口装拉链平顺#line#', '后中点位贴风琴袋方正，袋口装拉链平顺#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6342, 'SMWTPK004', '落/间袋盖*1，落/间拉链风琴袋*1', 156, 308.6360, 2.8086, 'STITCHING', NULL, b'0', '后中点位贴风琴袋方正，袋口装拉链平顺#line#', '后中点位贴风琴袋方正，袋口装拉链平顺#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6343, 'SMWTAS003', '接下脚贴(5)CM*2，落下脚贴于下摆(100cm)*1#line##line#', 156, 67.0840, 0.6105, 'STITCHING', NULL, b'0', '线迹均匀平服', '线迹均匀平服', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6344, 'SMWTAS005', '点下脚贴*2位，下脚贴穿孔*2个，下脚贴订小铁环*2个#line##line#', 69, 72.0950, 0.4085, 'STITCHING', NULL, b'0', '点位准确，左右对称', '点位准确，左右对称', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6345, 'SMWTAS008', '间前中拉链连领顶一段(42+18+52+66)cm*1,间下脚实样线(100cm)*1#line##line#', 156, 169.8780, 1.5459, 'STITCHING', NULL, b'0', '线迹均匀平服不起皱', '线迹均匀平服不起皱', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6346, 'SMWTSL002', '打/间袖片褶（8CM）2个*2，拼左右前后袖片(52cm)2缝*2，间左右前后袖片(52cm)2缝*2#line#', 156, 208.7050, 1.6696, 'STITCHING', NULL, b'0', '收三角省顺直，不起酒窝；间线迹均匀平服#line#', '收三角省顺直，不起酒窝；间线迹均匀平服', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6347, 'SMWTAS007', '上前中拉链于面布(66cm)*2，落拉链贴(66cm)*2#line##line#', 156, 233.1720, 2.1219, 'STITCHING', NULL, b'0', '前中门襟拉链平顺不起拱#line#', '前中门襟拉链平顺不起拱#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6348, 'SMWTAS001', '上左右前后袖(25+25cm)*2,拼/间连肩袖贴与后幅(75+75+170cm)*1#line##line#', 156, 313.3940, 2.5072, 'STITCHING', NULL, b'0', '线迹平服均匀不起皱#line#', '线迹平服均匀不起皱', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6349, 'SMWTFR002', '落/间前幅装饰片*2，落魔术贴*1', 156, 103.4260, 0.8274, 'STITCHING', NULL, b'0', '左右对称线迹平顺不起皱', '左右对称线迹平顺不起皱#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6350, 'SMWTFA002', '运/修/翻/间门襟挂面(上下方角/6+70+6CM)*1', 156, 117.8280, 0.9426, 'STITCHING', NULL, b'0', '前中门襟装拉链平顺不起拱#line#', '前中门襟装拉链平顺不起拱#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6351, 'SMWTFR001', '拼左右前幅罗纹(39+48CM)*2，间左右前幅罗纹(39+9+35CM)*2#line##line#', 156, 146.6750, 1.1734, 'STITCHING', NULL, b'0', '左右对称平顺不起皱#line#', '左右对称平顺不起皱#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6352, 'SMWTCL003', '落袋贴*2，开袋*1，封袋口三角*2，落上下拉链*2，落里袋布*1，间上下袋口线*2，固定帽底*1', 156, 313.3940, 2.8519, 'STITCHING', NULL, b'0', '绱领圆顺，领开袋装拉链内夹车帽#line#', '绱领圆顺，领开袋装拉链内夹车帽#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6353, 'SMWTCL004', '做立领*1 (落里袋布*1，车立领顶暗线*1)', 156, 90.2450, 0.7220, 'STITCHING', NULL, b'0', '绱领圆顺，领开袋装拉链内夹车帽#line#', '绱领圆顺，领开袋装拉链内夹车帽#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6354, 'SMWTPK001', '做左右上前袋*2 (落袋贴2*2，开袋*2，封袋口三角2*2，落上下拉链2*2，间上下袋口线2*2，固定袋子*2，间实样线*2)', 156, 567.2430, 5.1619, 'STITCHING', NULL, b'0', '左右上开袋装拉链平顺面压袋形明线，左右对称，线迹美观#line#', '左右上开袋装拉链平顺面压袋形明线，左右对称，线迹美观#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6355, 'SMCSCL025', '包下级领*1，落下级领*1#line#', 156, 64.3890, 0.5859, 'STITCHING', NULL, b'0', '线迹均匀，领咀领尖对称、平整、不反翘#line##line#', '线迹均匀，领咀领尖对称、平整、不反翘#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6356, 'SMCSCL026', '修/翻下级领*1，间下级领*1#line#', 156, 66.7050, 0.5336, 'STITCHING', NULL, b'0', '线迹均匀，领咀领尖对称、平整、不反翘#line#', '线迹均匀，领咀领尖对称、平整、不反翘#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6357, 'SMCSAS048', '打袖口褶位*1，上介英*2#line#', 156, 94.0770, 0.8561, 'STITCHING', NULL, b'0', '缝线均匀，褶倒向侧骨，上左右介英要对称#line#', '缝线均匀，褶倒向侧骨，上左右介英要对称#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6358, 'SMCSAS049', '压介英线*2，间介英三边线*2#line#', 156, 127.5140, 1.1604, 'STITCHING', NULL, b'0', '止口均匀，压左右介英要对称#line#', '止口均匀，压左右介英要对称#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6359, 'SMWTCL001', '拼帽中来去缝(弯/58cm)2缝*1，间帽中缝(弯/58cm)1缝*1#line##line#', 156, 100.3100, 0.8025, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6360, 'SMWTCL002', '烫帽沿/襟贴/龟背/里袋布/前风琴装饰片/袖带，画袖口/袖省/袖带/门筒挂面/各个袋/袋盖/魔术贴位', 19, 327.8630, 1.8579, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6361, 'SMWTPK003', '修/翻/烫\"V\"型风琴袋角2边*1，烫风琴袋面成型3边*2次，烫风琴袋口/袋盖*1#line##line#', 19, 132.2870, 0.7496, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6362, 'SMWTFA001', '订凹四合扣(门襟挡风牌*6，袖带*2)#line#', 69, 59.5460, 0.3374, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6363, 'SMWTSL001', '包帽沿边*1，落袖口橡筋*2，拼接袖口贴*2，间袖口*2，间袖带*2', 156, 226.8970, 1.8152, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6364, 'SMWTLN001', '落里布三尖袋*1，里布合肩缝/上袖/合侧缝*2，拼龟背于拉链襟贴2缝*1，落龟背拉链襟贴于里布*1', 156, 365.2340, 3.3236, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6365, 'SMWTOH001', '拉/间织带*1条，定位剪织带*5，订织带于拉链头上(1cm)*5', 156, 128.4820, 1.0279, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6366, 'SMWTAS002', '合袖衫身侧缝(90cm)*2#line#', 156, 87.7610, 0.7986, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6367, 'SMWTAS004', '开骨烫下脚贴*1，折烫下脚贴*1#line#', 19, 42.1930, 0.2391, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6368, 'SMWTAS006', '间下脚贴(100cm)*1，上内/外领(56cm)2缝*1，套下脚里布(100cm)*1#line##line##line#', 156, 243.8260, 2.2188, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6369, 'SMWTAS009', '间前片风琴装饰片拉链边(6cm)*2#line##line#', 156, 18.8240, 0.1506, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6370, 'SMWTAS010', '落/间门襟挂面*1，上面里袖口*2，落/间袖带*2#line#', 156, 338.4510, 3.0799, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6371, 'SMWTAS011', '穿下脚绳子*1，绳帽*2个，翻衫，整烫长袖#line#', 19, 114.5110, 0.6489, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6372, 'SMWTAS012', '订成品凸四合扣(右门襟*6，袖带2*2)#line#', 69, 75.2110, 0.4262, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6373, 'SMWTAS013', '大烫外套#line#', 20, 180.7960, 1.0245, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6374, 'SMWTPK005', '袋口打枣6个*2 (领开袋1*2，前幅开袋4*2，后幅1*2)', 295, 112.8170, 0.6393, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6375, 'SMCSAS051', '间短袖衫身侧缝*2#line#', 156, 57.4820, 0.5231, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6376, 'SMCSBK009', '落/间后担干*1#line##line#', 156, 93.0240, 0.7442, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6377, 'SMCSFR018', '左右门筒压线*2#line#', 156, 91.2980, 0.7304, 'STITCHING', NULL, b'0', '完成后门筒要平服均匀', '完成后门筒要平服均匀', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6378, 'SMCSSL015', '开袖叉*2，落大小袖侧*2#line#', 156, 101.8260, 0.8146, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6379, 'SMCSFA002', '折烫门筒2边*2', 19, 54.0160, 0.3061, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6380, 'SMCSFA003', '落左右门筒*2', 156, 84.2230, 0.6738, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6381, 'SMCSFA004', '间左右门筒2缝*2', 156, 140.4000, 1.1232, 'STITCHING', NULL, b'0', '线迹均匀平整', '线迹均匀平整', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6382, 'SMCSCL027', '整烫领子*1', 19, 20.4890, 0.1161, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6383, 'SMCSCL028', '整烫领子*1，整烫介英*2', 19, 54.2590, 0.3075, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6384, 'ZMTXAS038', '中查(针织)', 296, 11.0570, 0.0627, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6385, 'ZMTXCL017', '做圆领*1,落肩缝弹力条1边*2，落夹圈弹力条1边*2#line#', 156, 102.4150, 0.8193, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6386, 'ZMTXAS039', '四线上袖*2，四线埋夹短袖*2', 177, 77.0300, 0.7010, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6387, 'ZMTXAS040', '四线上袖*2，四线埋夹长袖*2', 177, 82.2040, 0.7481, 'STITCHING', NULL, b'1', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6388, 'OP0025', '领料', 297, 260.0000, 0.1200, 'PICKING', '领料', b'0', '领料', '1', NULL, 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6389, 'SWKZBK001', '落样单针打后下脚褶位3个*2,固定下脚褶位于脚口3个*2', 156, 188.0280, 1.5042, 'STITCHING', NULL, b'1', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6390, 'ZMTXAS043', '双针冚圆长袖口*2，双针冚下摆一圈(直/100)1件*1', 186, 63.4250, 0.5074, 'STITCHING', NULL, b'1', '袖口/下摆坎双线高须一致，双线间距0.9cm，双线顺直平服、无起扭，注意接线部位须重叠', '袖口/下摆坎双线高须一致，双线间距0.9cm，双线顺直平服、无起扭，注意接线部位须重叠', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6391, 'ZMTXAS042', '双针冚圆短袖口*2，双针冚下摆一圈(直/100)1件*1', 186, 57.2840, 0.4583, 'STITCHING', NULL, b'1', '袖口/下摆坎双线高须一致，双线间距0.9cm，双线顺直平服、无起扭，注意接线部位须重叠', '袖口/下摆坎双线高须一致，双线间距0.9cm，双线顺直平服、无起扭，注意接线部位须重叠', 'B(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6392, 'SWKZFR001', '点前后片省位*16个，点袋位*2，烫袋唇*2，粘烫袋口朴布*2，烫开拉链*1', 19, 276.8030, 1.5686, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6393, 'SWKZFR002', '打前后腰省2个*2,打前后下脚省6个*2#line#', 156, 464.6590, 3.7173, 'STITCHING', NULL, b'0', '褶深3cm，缉线均匀，头尾回针，左右对称', '褶深3cm，缉线均匀，头尾回针，左右对称', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6394, 'SWKZFR003', '打前下脚褶位3个*2,固定下脚褶位于脚口3个*2#line#', 156, 188.0280, 1.5042, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6395, 'SWKZFR004', '做前袋*2(落前袋布于前斜袋口1边,间袋口0.1cm暗线,间前斜袋口止口线0.6，合面底袋布,固定底袋布)#line#', 156, 235.5300, 2.1433, 'STITCHING', NULL, b'0', '袋口平顺，压线均匀平服，左右袋对称', '袋口平顺，压线均匀平服，左右袋对称', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6396, 'SWKZFR005', '烫定前斜袋口*2#line#', 19, 24.0930, 0.1365, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6397, 'SWKZFR006', '间前斜袋口止口线*2，合面底袋布*2，固定底袋布于裤腰及侧缝1边*2#line##line##line#', 156, 152.9070, 1.2233, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6398, 'SWKZFR007', '整烫袋口朴*2，整烫省位，整烫裤腰', 19, 216.9560, 1.2294, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6399, 'SWKZBK002', '做后单唇袋*2 ', 156, 297.0970, 2.7036, 'STITCHING', NULL, b'0', '袋口方正、不烂脚、不张开，袋高低一致，左右对称', '袋口方正、不烂脚、不张开，袋高低一致，左右对称', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6400, 'SWKZBK003', '三线锁边前后袋面底袋布2个*2#line#', 172, 79.7450, 0.5409, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6401, 'SWKZWB001', '拼接面底裤腰(35CM)*2，驳左右裤腰(直/8CM)*1，落固定拉伸条于裤腰(68CM)*1#line##line#', 156, 97.1510, 0.7772, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6402, 'SWKZWB002', '刀车修裤腰顶(70CM)*1#line#', 167, 17.4150, 0.1181, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6403, 'SWKZAS001', '合外侧缝留拉链位*1#line#', 156, 80.6020, 0.7335, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6404, 'SWKZAS002', '三线锁外侧缝2条*1，三线锁外侧缝拉链一段1条*1#line#', 172, 69.3180, 0.5545, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6405, 'SWKZAS003', '拉裤脚织带(28CM)*2#line#', 156, 25.6880, 0.2055, 'STITCHING', NULL, b'0', '拉捆条止口均匀平服不起纽', '拉捆条止口均匀平服不起纽', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6406, 'SWKZAS004', '合内侧缝(75CM)2条*1#line#', 156, 57.0190, 0.4562, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6407, 'SWKZAS005', '三线锁内侧缝(直82CM)2条*1#line#', 172, 38.2030, 0.3056, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6408, 'SWKZAS006', '车双线合前后浪*1 #line#', 156, 48.1340, 0.4380, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6409, 'SWKZAS007', '三线拷前后浪(弯/40CM)*1#line#', 172, 17.2270, 0.1169, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6410, 'SWKZAS008', '倒烫裤子侧缝#line#', 19, 48.1850, 0.2730, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6411, 'SWKZAS009', '间里裤腰顶线(62CM)*1,落暗线主唛2边于裤腰(1+1CM)*1#line#', 156, 46.9970, 0.3760, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6412, 'SWKZAS010', '点位上腰头(弯/70CM)*1，对折钉裤腰口丝带连量剪(1CM)*2#line#', 156, 137.9150, 1.2550, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6413, 'SWKZAS011', '上腰侧拉链(20+20CM)*1，翻裤腰连封裤腰头拉链一段(4CM)*2#line#', 156, 125.3240, 1.1404, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6414, 'SWKZAS012', '压上腰头落坑线(弯/70CM)*1#line#', 156, 112.8170, 1.0266, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6415, 'SWKZAS013', '包拉链尾及固定拉链尾*1,固定裤脚头1边*2，车侧缝洗水唛*1#line##line#', 156, 51.3760, 0.4110, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6416, 'SWLYFR006', '烫领，夹圈朴*2，折烫下脚*1，点面布后幅腰省位2个*2，点里布后幅腰省位2个*2', 19, 210.9220, 1.1952, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6417, 'SWLYFR007', '打后面布腰省2个*2#line#', 156, 88.9820, 0.7119, 'STITCHING', NULL, b'0', '省尖顺直不起酒窝#line#', '省尖顺直不起酒窝#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6418, 'SWLYFR008', '拼前胸片1缝*2，拼肩缝1边*2，拼上半侧缝1边*2#line#', 156, 100.2680, 0.8021, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6419, 'SWLYAS015', '拼前后片下半节侧缝1边*2,拼后中一段留拉链位1边*1，拼面腰节(76CM)1缝*1#line##line#', 156, 106.5420, 0.8523, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6420, 'SWLYAS019', '上后中拉链(32cm)2边*1', 156, 112.8170, 1.0266, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6421, 'SWLYFR010', '拼上下里布片（里布前胸片*2,里布肩缝夹尺码唛*2,上半侧缝夹丝带连量剪*2，腰省*4，拼下节侧缝夹洗水唛*2，拼上下腰节*1）#line#', 156, 287.7060, 2.3016, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6422, 'SWLYAS017', '整烫面布里布#line#', 19, 180.7960, 1.4464, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6423, 'SWLYAS020', '套里布后中于拉链(32cm)2边*1，平车订拉链尾*1，拼里布后中(28CM)*1#line##line#', 156, 106.5420, 0.8523, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6424, 'SWLYAS009', '套里布于领圈一周1边*2#line#', 156, 52.0080, 0.4161, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6425, 'SWLYAS010', '修领圈(53CM)1边*2,间里布于领圈一周(106CM)1边*2#line#', 156, 76.4750, 0.5188, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6426, 'SWLYAS011', '间里布于领圈一周(106CM)1边*2,套里布于夹圈一周(46CM)1边*2', 156, 89.0240, 0.8101, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6427, 'SWLYAS012', '套里布于夹圈一周(46CM)1边*2，修夹圈一周(46CM)1边*2#line#', 156, 81.4860, 0.5527, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6428, 'SWLYAS013', '间里布于夹圈一周(33CM)1边*2,固定上下面里片于腰节拼接位(70CM)1缝*1#line##line#', 156, 131.6410, 1.0531, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6429, 'SWLYAS014', '整烫夹圈*2 (圆夹圈已压止口线) #line#', 19, 50.6150, 0.2868, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6430, 'SWLYAS022', '套里布下摆(100CM)*1#line#', 156, 50.1550, 0.4564, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6431, 'SWLYAS023', '挑下摆(112CM)*1，翻衫，手工挑下摆一段(16CM)*1', 220, 157.4000, 1.4323, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6432, 'SWLYAS024', '整烫下摆*1#line#', 19, 72.3190, 0.4098, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6433, 'SWLYAS025', '整烫领圈*1', 19, 33.7700, 0.1914, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6434, 'SMCSCL031', '修/翻下级领*1，间下级领*1，车主唛加尺码唛*1#line#', 156, 69.7370, 0.6346, 'STITCHING', NULL, b'0', '线迹均匀，领咀领尖对称、平整、不反翘#line#', '线迹均匀，领咀领尖对称、平整、不反翘#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6435, 'SMCSCL029', '做上级领*1，做一片方介英*2#line#', 156, 194.3870, 1.5551, 'STITCHING', NULL, b'0', '线迹均匀，领咀领尖对称、平整、不反翘#line#', '线迹均匀，领咀领尖对称、平整、不反翘#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6436, 'SMCSCL030', '间上级领顶*1，落下级领*1#line#', 156, 62.7040, 0.5016, 'STITCHING', NULL, b'0', '线迹均匀，领咀领尖对称、平整、不反翘#line#', '线迹均匀，领咀领尖对称、平整、不反翘#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6437, 'SMCSAS057', '压介英线(已上介英后)*2 #line#', 156, 71.0840, 0.6469, 'STITCHING', NULL, b'0', '袖叉方块方正不爆口，左右对称，线迹均匀平服#line#', '袖叉方块方正不爆口，左右对称，线迹均匀平服#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6438, 'SMCSAS052', '压领线(回咀)*1#line#', 156, 73.1900, 0.6660, 'STITCHING', NULL, b'0', '线迹均匀，领咀领尖对称、平整、不反翘#line#', '线迹均匀，领咀领尖对称、平整、不反翘#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6439, 'SMCSSL016', '间大小袖侧*2，封袖叉方块*2#line#', 156, 248.7530, 2.2637, 'STITCHING', NULL, b'0', '袖叉方块方正不爆口，左右对称，线迹均匀平服#line#', '袖叉方块方正不爆口，左右对称，线迹均匀平服#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6440, 'SMCSAS053', '打袖口褶位*2，上介英*2#line#', 156, 100.3520, 0.9132, 'STITCHING', NULL, b'0', '袖叉方块方正不爆口，左右对称，线迹均匀平服#line#', '袖叉方块方正不爆口，左右对称，线迹均匀平服#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6441, 'ZMCSAS022', '拉下摆(高弯/135)1件*1,剪线1个*1#line#', 156, 68.4730, 0.6231, 'STITCHING', NULL, b'0', '线迹平服均匀，在下摆弯位平顺不起纽#line#', '线迹平服均匀，在下摆弯位平顺不起纽#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6442, 'ZWTXFR003', '四线锁前挂片边(120CM)*1,四线拼前片担干(46CM)*1#line##line#', 177, 49.2980, 0.3944, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6443, 'ZWTXOH003', '定位剪罗纹下摆*1，折烫罗纹下摆*1', 19, 27.1300, 0.1537, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6444, 'ZWTXOH004', '修罗纹下摆(74CM)*1#line#', 167, 16.9710, 0.1151, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6445, 'ZWTXOH005', '拼罗纹下摆(14CM)*1,落肩缝弹力条1边*2', 156, 120.1860, 0.9615, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6446, 'ZWTXAS022', '间前领圈*1,固定前挂面下摆一段(8CM)*1,落腰带于前面挂片(1+1CM)*1,订前片下摆冚边线(1+1CM)*1#line##line##line##line#', 156, 86.4970, 0.6920, 'STITCHING', NULL, b'0', '圆领领圈圆顺美观，线迹均匀平顺', '圆领领圈圆顺美观，线迹均匀平顺', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6447, 'ZWTXAS023', '冚前挂片连后片下摆一段(85CM)*1,冚圆袖口一圈2边*2#line##line#', 186, 53.3690, 0.4270, 'STITCHING', NULL, b'0', '下摆坎双线高须一致，成品两边袖口对称、无高低，双线顺直平服、无起扭，注意接线部位须重叠。', '下摆坎双线高须一致，成品两边袖口对称、无高低，双线顺直平服、无起扭，注意接线部位须重叠。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6448, 'ZWTXSL005', '冚前片袖口(28CM)1边*1,冚前片下摆中间一段(50CM)*1#line##line#', 186, 33.1340, 0.2651, 'STITCHING', NULL, b'0', '下摆坎双线高须一致，成品两边袖口对称、无高低，双线顺直平服、无起扭，注意接线部位须重叠。', '下摆坎双线高须一致，成品两边袖口对称、无高低，双线顺直平服、无起扭，注意接线部位须重叠。', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6449, 'ZWTXCL001', '折烫罗纹立领*1', 160, 10.4720, 0.0593, 'STITCHING', NULL, b'1', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6450, 'ZWTXCL010', '拼接圆领*1，落肩缝弹力条(直/11)1边*2#line#', 156, 27.1620, 0.2173, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6451, 'ZWTXSL006', '拉前袖侧片(40CM)*2,拉后袖侧片(40CM)*2#line##line#', 156, 108.6900, 0.8695, 'STITCHING', NULL, b'0', '线迹均匀顺直不起皱', '线迹均匀顺直不起皱', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6452, 'ZWTXFR005', '对折走线固定前袖侧片(13+11+8CM)*2,落前袖侧片于前片夹圈、肩缝、领圈(13+11+8CM)*2#line#', 156, 110.7960, 0.8864, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6453, 'ZWTXAS032', '四线拼肩缝(直/11)1边*2,四线拼侧缝(40CM)1边*2', 177, 62.6670, 0.5013, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6454, 'ZWTXAS033', '来去缝拼前后袖侧片(36+36CM)*2#line#', 156, 167.2250, 1.3378, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6455, 'ZWTXAS034', '平车上袖一圈(44CM)1边*2#line#', 156, 146.3380, 1.3317, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6456, 'ZWTXAS035', '冚双线圆领(57CM)*1#line#', 186, 58.2730, 0.5303, 'STITCHING', NULL, b'0', '领圈平服圆顺，无明显宽窄', '领圈平服圆顺，无明显宽窄', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6457, 'ZWTXAS038', '四线级圆袖圈*2', 177, 44.1650, 0.2996, 'STITCHING', NULL, b'1', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6458, 'ZWTXAS037', '双针冚下摆一圈(直/100)1件*1', 186, 23.8120, 0.2167, 'STITCHING', NULL, b'1', '双线顺直平服、无起扭，注意接线部位须重叠', '双线顺直平服、无起扭，注意接线部位须重叠', 'A(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6459, 'ZWTXAS036', '拉袖口(48CM)*2#line#', 156, 60.6410, 0.4851, 'STITCHING', NULL, b'0', '线迹均匀顺直不起皱', '线迹均匀顺直不起皱', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6460, 'ZWTXAS039', '落肩缝弹力条(直/7)1边*1#line#', 156, 12.5490, 0.0851, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6461, 'ZWTXAS040', '四线拼左肩缝(直/7CM)1边*1,拼袖侧缝(9CM)1边*2,拼衫身侧缝(35CM)1边*2#line#', 177, 73.9670, 0.5917, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6462, 'ZWTXAS043', '四线上左圆袖(弯/44CM)1边*1，上右袖(26CM)1边*1#line#', 177, 54.4720, 0.4957, 'STITCHING', NULL, b'0', '.袖山有容位，注意大身袖笼不能拉大变形', '.袖山有容位，注意大身袖笼不能拉大变形', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6463, 'ZWTXAS045', '拉右肩捆条(34CM)*1,拉V领捆条一圈连右吊带一段(84CM),拉左吊带连量剪*1#line#', 156, 59.5460, 0.4764, 'STITCHING', NULL, b'0', '滚条宽度0.8CM，大小要一致、平顺不能有皱痕，右肩带缝位朝下', '滚条宽度0.8CM，大小要一致、平顺不能有皱痕，右肩带缝位朝下', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6464, 'ZWTXAS046', '订前后V领尖，订左右吊带于领捆条#line##line#', 156, 87.8030, 0.7024, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6465, 'ZWTXAS047', '订洗水唛(3+3CM)*1，主唛(1+1CM)*1，尺码唛(1+1CM)*1于右侧缝#line#', 156, 54.3660, 0.4349, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6466, 'ZWTXAS048', '冚圆短袖口一圈*2，冚圆下摆一圈*1#line#', 186, 58.3150, 0.5307, 'STITCHING', NULL, b'0', '顺直不起皱、无外漏止口或漏冚', '顺直不起皱、无外漏止口或漏冚', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6467, 'SWBQAS003', '拼左侧缝裙片(85CM)*1,拼右侧裙片留拉链位(64CM)*1#line#', 156, 63.9250, 0.5114, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6468, 'SMCSOH003', '烫画下级*1,烫袖衩条*2，折烫介英0.7止口,折烫门筒*1,折烫双层门筒*1', 19, 130.6670, 0.7404, 'STITCHING', NULL, b'1', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6469, 'SMCSOH004', '烫画下级*1,烫袖衩条*2，折烫介英0.7止口,折烫门筒*2', 19, 0.0000, 0.0000, 'STITCHING', NULL, b'1', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6470, 'SMCSAS054', '开成品钮门*13，点位*13(领子*1，门襟*8，侧袖*2，袖子*2)#line#', 70, 123.3030, 0.6987, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6471, 'SMCSAS055', '钉成品钮*13(领子*1，门襟*8，侧袖*2，袖子*2)#line##line#', 66, 74.2010, 0.4205, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6472, 'SMCSAS056', '绕成品纽*13(领子*1，门襟*8，侧袖*2，袖子*2)#line#', 97, 48.0910, 0.2725, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6473, 'SWBQWB001', '落样点前后幅腰省位2个*2，点里布前后幅腰省位2个*2，平烫拉链*1', 19, 114.5110, 0.6489, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6474, 'SWLYFR012', '落样打前后腰省2个*2#line#', 156, 89.0240, 0.7122, 'STITCHING', NULL, b'0', '省尖顺直不起酒窝#line#', '省尖顺直不起酒窝#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6475, 'SWBQAS001', '拼上下裙片(56CM)*2', 156, 50.1550, 0.4012, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6476, 'SWBQAS002', '三线锁上下裙片拼缝(56CM)*2#line#', 172, 32.5160, 0.2206, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6477, 'SWBQAS004', '三线锁拉链位一边(28CM)*1,锁右侧拼缝(有拉链那边，85CM)*1,锁左侧拼缝(85CM)*1', 172, 58.2730, 0.3953, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6478, 'SWBQAS005', '打前后里布活褶2个*2,拼左侧缝里布(加放洗水唛，35CM)*1,拼右侧里布片留拉链位19CM*1', 156, 97.1510, 0.7772, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6479, 'SWBQAS006', '三线锁里布右侧缝拉链位一段(26CM)*1,三线锁里布右侧缝(37CM)*1,三线锁里布左侧拼缝(37CM)*1#line#', 172, 38.6570, 0.2622, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6480, 'SWBQAS007', '拉里布下摆一圈(112CM)*1，拼接前后裙腰片(5CM)*1，落裙腰片于裙腰(70CM)*1', 156, 83.3810, 0.7588, 'STITCHING', NULL, b'0', '下摆圆不起纽，止口均匀平服#line#', '下摆圆不起纽，止口均匀平服#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6481, 'SWBQAS008', '修裙腰(70CM)*1#line#', 167, 17.4150, 0.1181, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6482, 'SWBQAS009', '间裙腰顶线(66CM)*1，车主唛两边（1+1cm）*1#line#', 156, 46.9970, 0.3760, 'STITCHING', NULL, b'0', '线迹均匀平服#line#', '线迹均匀平服#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6483, 'SWBQAS010', '整烫裙腰*1#line#', 19, 36.1590, 0.2049, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6484, 'SWBQAS011', '落里布于裙腰(70CM)*1#line##line#', 156, 35.1210, 0.2810, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6485, 'SWBQAS012', '三线锁里布裙腰拼缝(70CM)*1#line#', 172, 23.3260, 0.1582, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6486, 'SWBQAS013', '上右侧缝拉链(22+22CM)*1#line#', 156, 94.0350, 0.8557, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6487, 'SWBQAS014', '平车订拉链尾/包拉链尾部织带*1，定里布左侧缝于面布腰拼侧缝(1CM)*1，套里布于拉链(22cm)2边*1#line##line##line#', 156, 100.2680, 0.9124, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6488, 'SWBQAS015', '拉裙片下摆(256CM)*1#line#', 156, 69.5680, 0.6331, 'STITCHING', NULL, b'0', '下摆顺直不起纽，止口均匀平服#line#', '下摆顺直不起纽，止口均匀平服#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6489, 'SMCSFR019', '间双层右门筒*1#line#', 156, 47.0390, 0.3763, 'STITCHING', NULL, b'0', '门筒要平服均匀不起纽#line#', '门筒要平服均匀不起纽#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6490, 'ZWTXCL002', '折烫圆领*1，后领条*1,烫衬于下摆纽门位*2,开纽门前片下摆*2个', 160, 53.3540, 0.3023, 'STITCHING', NULL, b'1', '', '', 'D(练', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6491, 'ZWTXCL011', '订织带头连量剪(1.5CM)*6#line#', 156, 84.0550, 0.6724, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6492, 'ZWTXCL012', '做圆领*1,落肩缝弹力条1边*2#line#', 156, 48.0910, 0.3847, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6493, 'ZWTXSL007', '冚短袖口(36CM)*2#line#', 186, 26.9110, 0.2153, 'STITCHING', NULL, b'0', '袖口顺直平服，无外漏止口，左右对称#line#', '袖口顺直平服，无外漏止口，左右对称#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6494, 'ZWTXSL008', '四线锁袖贴(33CM)2边*2#line#', 177, 41.1020, 0.2788, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6495, 'ZWTXSL009', '落袖织带于夹圈(1.5CM)2条*2,落袖贴(34CM)2边*2,间袖贴中线(34CM)1边*2#line##line##line#', 156, 152.4020, 1.2192, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6496, 'ZWTXSL010', '四线拼肩缝(直/18)1边*2,四线上袖*2，四线埋夹短袖*2#line#', 177, 104.6800, 0.9526, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6497, 'ZMTXAS044', '落/间后领捆条2线*1，车主唛加放尺码唛2边*1#line#', 156, 116.9020, 1.0638, 'STITCHING', NULL, b'0', '领圈圆顺不起纽，线迹均匀平服#line#', '领圈圆顺不起纽，线迹均匀平服#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6498, 'ZMTXAS045', '四线锁前后片下摆(100CM)1边*2#line#', 177, 47.0620, 0.3192, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6499, 'ZMTXAS046', '开纽门前片下摆*2个#line#', 70, 15.0340, 0.0852, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6500, 'ZMTXAS047', '包边前片下摆(100CM)*1#line#', 156, 35.8370, 0.2867, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6501, 'ZWTXAS050', '冚下摆两边(16CM)1边*2#line#', 186, 23.3260, 0.1866, 'STITCHING', NULL, b'0', '下摆止口均匀平服不起皱#line#', '下摆止口均匀平服不起皱#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6502, 'ZWTXAS051', '包后片下摆(100CM)*1边,车洗水唛(3+3CM)*1个#line#,穿前片下摆织带*1#line##line#', 156, 75.3800, 0.6030, 'STITCHING', NULL, b'0', '下摆止口均匀平服不起皱', '下摆止口均匀平服不起皱', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6503, 'SWCSAS048', '开成品钮门*11，点位*11(领子*1，门襟*8,介英*2)#line#', 70, 104.3520, 0.5913, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6504, 'SWCSAS049', '钉成品钮*11(领子*1，门襟*8，介英*2)#line##line#', 66, 62.7880, 0.3558, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6505, 'SWCSAS050', '绕成品纽*11(领子*1，门襟*8，介英*2)#line#', 97, 40.6800, 0.2305, 'STITCHING', NULL, b'1', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6506, 'ZWTXCL013', '折烫圆领*1，折烫前活页*2#line#', 19, 26.1170, 0.1480, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6507, 'ZMTXAS048', '车主唛(1CM)*1，车尺码唛(1CM)*1，车洗水唛(3+3CM)*1，平车上圆领*1', 156, 118.1230, 1.0749, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6508, 'SWCSAS051', '运腰带(62+6CM)1片*2#line#', 156, 70.7470, 0.5660, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6509, 'SWCSAS052', '修/翻腰带(62+6CM)1片*2#line#', 167, 82.8010, 0.5617, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6510, 'SWCSAS053', '烫腰带*2,折烫领和夹圈条*2,烫落前幅活页领圈衬#line#', 19, 136.0930, 0.7712, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6511, 'SWCSFR025', '拼袖底来去缝(19+19CM)*1,拉圆袖口(38CM)*1,拉前幅活页边部件*3片', 156, 212.2840, 1.9318, 'STITCHING', NULL, b'0', '线迹均匀平服，袖口下摆平直不起纽#line#', '线迹均匀平服，袖口下摆平直不起纽#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6512, 'SWCSFR026', '拉前幅下摆边(11+54)*1,拉后幅下摆边(20+70+13)*1,拼前活页部件(41+34CM)*1#line#', 156, 169.0360, 1.5382, 'STITCHING', NULL, b'0', '线迹均匀平服，袖口下摆平直不起纽#line#', '线迹均匀平服，袖口下摆平直不起纽#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6513, 'SWCSFR027', '三线锁后中部件(31CM)*2,三线锁拼缝前活页部件1和2(41CM)*1,三线锁拼前活页部件2和3(34CM)*1#line#', 172, 79.2500, 0.5376, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6514, 'SWCSFR028', '包后中部件边(已锁边)(31CM)*2,拼后中部件(31CM)*1,订前后幅活褶(5CM)*1，拼后片上下部件(39CM)*1#line##line##line#', 156, 164.3190, 1.3146, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6515, 'SWCSBK009', '三线锁拼缝后片上下部件(39CM)*1#line#', 172, 19.4930, 0.1322, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6516, 'SWCSFR029', '拼/修活页与前片于前V领圈(40CM)*1,间前V领圈活页与前片(19+19CM)*1#line##line#', 156, 103.0050, 0.8240, 'STITCHING', NULL, b'0', '线迹均匀平服，领圈圆顺不起纽#line#', '线迹均匀平服，领圈圆顺不起纽#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6517, 'SWCSFR030', '整烫后中拼缝*1，整烫前V圈拼缝*1#line#', 19, 37.8190, 0.2143, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6518, 'SWCSFR031', '固定前活页于前片肩缝(9CM)*2、夹圈(23CM)*1、侧缝(20CM)*1,固定腰带于左侧缝(4CM)*1#line#', 156, 106.1210, 0.8490, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6519, 'SWCSAS054', '三线锁前后片侧缝(20+30CM)*2#line#', 172, 47.7230, 0.3237, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6520, 'SWCSAS055', '拼左右侧缝(20+30CM)*1,落/修左夹圈条(44CM)*1，间左夹圈条双线(44+44CM)*1，平车合肩缝(8CM)*2#line##line##line#', 156, 261.0500, 2.0884, 'STITCHING', NULL, b'0', '线迹均匀平服，夹圈圆顺不起纽#line#', '线迹均匀平服，夹圈圆顺不起纽#line#', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6521, 'SWCSAS056', '三线锁肩缝(8CM)*2#line#', 172, 23.0790, 0.1566, 'STITCHING', NULL, b'0', '', '', 'C', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6522, 'SWCSAS057', '平车上袖(48CM)*1#line#', 156, 78.6220, 0.7155, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6523, 'SWCSAS058', '三线锁圆袖(48CM)*1#line#', 172, 30.7850, 0.2463, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6524, 'SWCSAS059', '落/修后领圈条(32CM)*1，间后领圈条双线加放主唛和尺码唛(32+32CM)*1，落下摆腰带*1，落测骨洗水唛(3+3CM)*1，封左袖口(1CM)*1#line##line#', 156, 204.3250, 1.8594, 'STITCHING', NULL, b'0', '线迹均匀平服，领圈圆顺不起纽', '线迹均匀平服，领圈圆顺不起纽', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6525, 'ZWTXAS024', '四线上袖(30CM)*2#line#', 177, 34.9350, 0.3179, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6526, 'ZWTXAS025', '间夹圈(30CM)*2#line#', 156, 24.0460, 0.1924, 'STITCHING', NULL, b'0', '袖子圆顺不起皱，左右袖一致对称，线迹均匀', '袖子圆顺不起皱，左右袖一致对称，线迹均匀', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6527, 'ZWTXAS027', '四线埋夹(锁袖侧缝14CM一段不拼合，14+80CM)*2#line#', 177, 83.2390, 0.7575, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6528, 'ZWTXAS028', '合袖口侧缝(10+5CM)*2,间方型开袖侧缝*2,订主唛暗线*1，订洗水唛*1#line##line##line#', 156, 125.4500, 1.0036, 'STITCHING', NULL, b'0', '袖口顺直平服不起皱，左右袖口大小一致', '袖口顺直平服不起皱，左右袖口大小一致', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6529, 'ZWTXAS029', '四线上罗纹下摆(74CM)*1#line#', 177, 69.8690, 0.5590, 'STITCHING', NULL, b'0', '下摆罗纹宽窄均匀一致', '下摆罗纹宽窄均匀一致', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6530, 'ZWTXAS030', '冚圆领口一圈*1，冚袖口一圈*2#line#', 186, 68.5350, 0.6237, 'STITCHING', NULL, b'0', '领子平服、美观、领圈圆顺无宽窄', '领子平服、美观、领圈圆顺无宽窄', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6531, 'SWKZOH001', '烫前袋口衬条*2,折烫裤脚2片*2,定位剪裤腰丈根*1', 19, 106.0480, 0.6009, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6532, 'SWKZWB003', '拼腰节(10CM)1边*1,拼丈根(10CM)2边*1,间裤腰夹车丈根一圈(100CM)*3,封裤腰底一圈(100CM)*1#line#', 156, 204.5360, 1.6363, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6533, 'SWKZWB004', '做前插袋*2 (落前袋布于前斜袋口,间0.1cm里袋口止口,合面底袋布,间面底袋布,固定底袋布于裤腰及侧缝)', 156, 245.0050, 2.2295, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6534, 'SWKZAS014', '合前后浪(弯62CM)*1#line#', 156, 35.1210, 0.2810, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6535, 'SWKZAS015', '三线拷前后浪(弯62CM)*1#line#', 172, 22.9140, 0.1833, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6536, 'SWKZAS016', '上橡筋裤腰一圈(直/100CM)*1#line#', 156, 67.6310, 0.6154, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6537, 'SWKZAS017', '三线拷裤腰底(已上腰,100CM)*1#line#', 172, 29.4250, 0.2354, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
INSERT INTO `operation` VALUES (6538, 'SWKZAS018', '包圆裤脚一圈(60CM)*2,车主唛加放尺码唛(1CM)*1，车洗水唛(3CM)*1#line##line#', 156, 74.5800, 0.6787, 'STITCHING', NULL, b'0', '下摆线迹均匀平服，不起纽#line#', '下摆线迹均匀平服，不起纽#line#', 'A', 1, '2019-04-09 14:32:47', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for operation_media
-- ----------------------------
DROP TABLE IF EXISTS `operation_media`;
CREATE TABLE `operation_media` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `media_id` bigint(20) NOT NULL,
  `opertation_id` bigint(20) NOT NULL,
  `media_type` int(11) NOT NULL,
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_operation_media_0` (`media_id`),
  KEY `idx_operation_media_1` (`opertation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for operation_routing
-- ----------------------------
DROP TABLE IF EXISTS `operation_routing`;
CREATE TABLE `operation_routing` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `operation_routing_order_id` bigint(20) NOT NULL,
  `operation_id` bigint(20) NOT NULL,
  `next_operation_id` bigint(20) DEFAULT NULL,
  `next_operation_no` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `next_routing_id` bigint(20) DEFAULT NULL,
  `operation_no` varchar(20) COLLATE utf8_bin NOT NULL,
  `description` varchar(3000) COLLATE utf8_bin NOT NULL,
  `machine_type_id` bigint(20) NOT NULL,
  `standard_time` double(8,4) DEFAULT NULL,
  `standard_price` double(8,4) DEFAULT NULL,
  `section_type` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `section_name` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `is_outsource` bit(1) NOT NULL,
  `qa_procedure` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `requirement` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `required_level` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_operation_routing_01` (`operation_id`),
  KEY `idx_operation_routing_02` (`operation_routing_order_id`),
  KEY `idx_operation_routing_03` (`next_routing_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of operation_routing
-- ----------------------------
BEGIN;
INSERT INTO `operation_routing` VALUES (1, 1, 6209, 0, '', NULL, 'SMCSAS031', '大烫衬衫长袖（净色/条子）', 20, 88.8800, 0.5037, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (2, 1, 6208, 6209, 'SMCSAS031', 1, 'SMCSAS030', '绕成品纽*11(领子*1，门襟*6，侧袖*2，介英*2)#line##line#', 97, 38.6580, 0.2191, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (3, 1, 6207, 6208, 'SMCSAS030', 2, 'SMCSAS029', '钉成品钮*11(领子*1，门襟*6，侧袖*2，介英*2)#line#', 66, 60.3460, 0.3420, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (4, 1, 6206, 6207, 'SMCSAS029', 3, 'SMCSAS028', '点成品钮位*11(领子*1，门襟*6，侧袖*2，介英*2)#line#', 15, 37.8630, 0.2146, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (5, 1, 6205, 6206, 'SMCSAS028', 4, 'SMCSAS027', '开成品钮门*11，点位*11 (领子*1，门襟*6，侧袖*2，介英*2)#line#', 70, 99.2570, 0.5625, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (6, 1, 6213, 6205, 'SMCSAS027', 5, 'SMCSAS033', '中查(梭织)', 21, 11.0570, 0.0627, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (7, 1, 6325, 6213, 'SMCSAS033', 6, 'SMCSAS044', '整烫长袖', 19, 33.7700, 0.1914, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (8, 1, 6001, 6325, 'SMCSAS044', 7, 'ZMCSAS007', '拉下摆(弧/135)1件*1,剪线1个*1', 156, 51.4910, 0.4686, 'STITCHING', NULL, b'0', '线迹平服均匀，在下摆弯位平顺不起纽#line#', '线迹平服均匀，在下摆弯位平顺不起纽#line#', 'A(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (9, 1, 6358, 6001, 'ZMCSAS007', 8, 'SMCSAS049', '压介英线*2，间介英三边线*2#line#', 156, 127.5140, 1.1604, 'STITCHING', NULL, b'0', '止口均匀，压左右介英要对称#line#', '止口均匀，压左右介英要对称#line#', 'A', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (10, 1, 6357, 6358, 'SMCSAS049', 9, 'SMCSAS048', '打袖口褶位*1，上介英*2#line#', 156, 94.0770, 0.8561, 'STITCHING', NULL, b'0', '缝线均匀，褶倒向侧骨，上左右介英要对称#line#', '缝线均匀，褶倒向侧骨，上左右介英要对称#line#', 'A', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (11, 1, 6100, 6357, 'SMCSAS048', 10, 'SMCSAS012', '间袖衫身侧缝(直/100)1边*2', 156, 70.2000, 0.5616, 'STITCHING', NULL, b'0', '线迹止口均匀不起纽#line#', '线迹止口均匀不起纽#line##line#', 'B(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (12, 1, 6050, 6100, 'SMCSAS012', 11, 'SMCSAS001', '包袖衫身侧缝(直/100)1边*2', 156, 44.8350, 0.4080, 'STITCHING', NULL, b'0', '线迹均匀,十字夹底骨位左右对齐', '线迹均匀,十字夹底骨位左右对齐', 'A(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (13, 1, 6058, 6050, 'SMCSAS001', 12, 'SMCSAS009', '间夹圈(弧/61+61)1边*2，撕朴2位*2', 156, 31.1630, 0.2493, 'STITCHING', NULL, b'0', '线迹均匀不起纽，夹圈圆顺不起皱', '线迹均匀不起纽，夹圈圆顺不起皱#line#', 'B(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (14, 1, 6057, 6058, 'SMCSAS009', 13, 'SMCSAS008', '上袖(沿边加朴,拉筒,弧/61+61)1边*2', 156, 47.9140, 0.4360, 'STITCHING', NULL, b'0', '袖山容位均匀，不起纽，左右对称', '袖山容位均匀，不起纽，左右对称', 'A(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (15, 1, 6339, 6057, 'SMCSAS008', 14, 'SMCSAS047', '压领线*1，车唛头*1#line#', 156, 105.5740, 0.9607, 'STITCHING', NULL, b'0', '', '', 'A', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (16, 1, 6336, 6339, 'SMCSAS047', 15, 'SMCSAS046', '走领窝线*1，上领*1#line#', 156, 87.8030, 0.7990, 'STITCHING', NULL, b'0', '领窝平顺不起皱', '领窝平顺不起皱', 'A', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (17, 1, 6253, 6336, 'SMCSAS046', 16, 'SWCSAS039', '拼肩缝*2，间肩缝*2', 156, 50.1550, 0.4564, 'STITCHING', NULL, b'0', '止口均匀，前片和担干的领窝位和袖窿位要对齐#line#', '止口均匀，前片和担干的领窝位和袖窿位要对齐#line#', 'A(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (18, 1, 6383, 6253, 'SWCSAS039', 17, 'SMCSCL028', '整烫领子*1，整烫介英*2', 19, 54.2590, 0.3075, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (19, 1, 6376, 6383, 'SMCSCL028', 18, 'SMCSBK009', '落/间后担干*1#line##line#', 156, 93.0240, 0.7442, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (20, 1, 6377, 6376, 'SMCSBK009', 19, 'SMCSFR018', '左右门筒压线*2#line#', 156, 91.2980, 0.7304, 'STITCHING', NULL, b'0', '完成后门筒要平服均匀', '完成后门筒要平服均匀', 'B', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (21, 1, 6201, 6377, 'SMCSFR018', 20, 'SMCSSL008', '间大小袖侧*2，封三尖*2#line##line#', 156, 246.8160, 2.2460, 'STITCHING', NULL, b'0', '线迹均匀平整，三尖位左右对称#line#', '线迹均匀平整，三尖位左右对称#line##line#', 'A(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (22, 1, 6378, 6201, 'SMCSSL008', 21, 'SMCSSL015', '开袖叉*2，落大小袖侧*2#line#', 156, 101.8260, 0.8146, 'STITCHING', NULL, b'0', '', '', 'B', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (23, 1, 6356, 6378, 'SMCSSL015', 22, 'SMCSCL026', '修/翻下级领*1，间下级领*1#line#', 156, 66.7050, 0.5336, 'STITCHING', NULL, b'0', '线迹均匀，领咀领尖对称、平整、不反翘#line#', '线迹均匀，领咀领尖对称、平整、不反翘#line#', 'B', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (24, 1, 6355, 6356, 'SMCSCL026', 23, 'SMCSCL025', '包下级领*1，落下级领*1#line#', 156, 64.3890, 0.5859, 'STITCHING', NULL, b'0', '线迹均匀，领咀领尖对称、平整、不反翘#line##line#', '线迹均匀，领咀领尖对称、平整、不反翘#line#', 'A', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (25, 1, 6264, 6355, 'SMCSCL025', 24, 'SMCSCL022', '修/翻上级领*1，修/翻上级领介英*2#line#', 167, 113.0350, 0.6405, 'STITCHING', NULL, b'0', '领、介英角尖挺，不藏止口', '领、介英角尖挺，不藏止口', 'D(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (26, 1, 6265, 6264, 'SMCSCL022', 25, 'SMCSCL021', '做介英*2，做上级领*1#line#', 156, 236.2460, 1.8900, 'STITCHING', NULL, b'0', '', '', 'B(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (27, 1, 6259, 6265, 'SMCSCL021', 26, 'SMCSOH001', '烫画下级*1,烫袖衩条*2，折烫介英0.7止口,折烫门筒*2', 19, 119.2080, 0.6755, 'STITCHING', NULL, b'0', '', '', 'D(练', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (28, 1, 5883, 6259, 'SMCSOH001', 27, 'T0001', '上吊挂', 2, 10.0060, 0.0250, 'STITCHING', NULL, b'0', '', '', 'D', 1, '2019-04-09 17:09:04', NULL, NULL, 0);
INSERT INTO `operation_routing` VALUES (29, 1, 4096, 5883, 'T0001', 28, 'OP0001', '裁剪', 1, 260.0000, 0.1200, 'CUTTING', '裁剪', b'0', '裁剪', '1', NULL, 1, '2019-04-09 17:09:04', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for operation_routing_order
-- ----------------------------
DROP TABLE IF EXISTS `operation_routing_order`;
CREATE TABLE `operation_routing_order` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(12) COLLATE utf8_bin NOT NULL,
  `order_status` int(11) NOT NULL,
  `order_type` int(11) NOT NULL,
  `material_id` bigint(20) NOT NULL,
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_operation_routing_order_01` (`order_no`),
  KEY `idx_operation_routing_order_02` (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of operation_routing_order
-- ----------------------------
BEGIN;
INSERT INTO `operation_routing_order` VALUES (1, 'ORO000000001', 0, 11, 16, 1, '2019-04-09 15:44:03', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for plan_code
-- ----------------------------
DROP TABLE IF EXISTS `plan_code`;
CREATE TABLE `plan_code` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_type` varchar(128) COLLATE utf8_bin NOT NULL,
  `code_no` varchar(10) COLLATE utf8_bin NOT NULL,
  `code_name` varchar(30) COLLATE utf8_bin NOT NULL,
  `description` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_plan_code_01` (`code_no`),
  KEY `idx_plan_code_02` (`code_name`),
  KEY `idx_plan_code_03` (`code_type`)
) ENGINE=InnoDB AUTO_INCREMENT=527 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of plan_code
-- ----------------------------
BEGIN;
INSERT INTO `plan_code` VALUES (1, 'EQUIPMENT_TYPE', 'MT001', '裁床', '裁床', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (2, 'EQUIPMENT_TYPE', 'MT002', '上料台', '上料台', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (3, 'EQUIPMENT_TYPE', 'MT003', '缝车', '缝车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (4, 'EQUIPMENT_TYPE', 'MT004', '坎车', '坎车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (5, 'EQUIPMENT_TYPE', 'MT005', '平车', '平车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (6, 'EQUIPMENT_TYPE', 'MT006', '中检台', '中检台', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (7, 'EQUIPMENT_TYPE', 'MT007', '烫台', '烫台', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (8, 'EQUIPMENT_TYPE', 'MT008', '尾查台', '尾查台', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (9, 'EQUIPMENT_TYPE', 'MT009', '包装', '包装', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (10, 'EQUIPMENT_TYPE', 'MT010', '印染', '印染', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (11, 'EQUIPMENT_TYPE', 'C0102', '電腦腳步車', '電腦腳步車', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (12, 'EQUIPMENT_TYPE', 'C0202', '三針人字車', '三針人字車', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (13, 'EQUIPMENT_TYPE', 'C0401', '普通雙針平車', '普通雙針平車', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (14, 'EQUIPMENT_TYPE', 'C1701', '單線橫針車', '單線橫針車', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (15, 'EQUIPMENT_TYPE', 'F0101', '手工', '手工', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (16, 'EQUIPMENT_TYPE', 'F01301', '新', '新', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (17, 'EQUIPMENT_TYPE', 'F01501', '手工（）', '手工（）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (18, 'EQUIPMENT_TYPE', 'F01601', '打鈕車', '打鈕車', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (19, 'EQUIPMENT_TYPE', 'F0201', '中烫', '中烫', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (20, 'EQUIPMENT_TYPE', 'F0202', '整烫', '整烫', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (21, 'EQUIPMENT_TYPE', 'F0301', '中查', '中查（梭织）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (22, 'EQUIPMENT_TYPE', 'F0302', '尾查', '尾查', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (23, 'EQUIPMENT_TYPE', 'F0401', '普通四合扣车', '普通四合扣车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (24, 'EQUIPMENT_TYPE', 'F0402', '气动四合扣车', '气动四合扣车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (25, 'EQUIPMENT_TYPE', 'F0501', '普通气眼车', '普通气眼车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (26, 'EQUIPMENT_TYPE', 'F0502', '气动气眼车', '气动气眼车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (27, 'EQUIPMENT_TYPE', 'F0601', '脚动翻领机', '脚动翻领机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (28, 'EQUIPMENT_TYPE', 'F0602', '手动翻领机', '手动翻领机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (29, 'EQUIPMENT_TYPE', 'F0701', '翻袖英机', '翻袖英机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (30, 'EQUIPMENT_TYPE', 'F0801', '单头啤袋机', '单头啤袋机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (31, 'EQUIPMENT_TYPE', 'F0802', '双头啤袋机', '双头啤袋机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (32, 'EQUIPMENT_TYPE', 'F0901', '烫袖叉机', '烫袖叉机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (33, 'EQUIPMENT_TYPE', 'F1001', '粘朴机', '粘朴机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (34, 'EQUIPMENT_TYPE', 'F1101', '切领机', '切领机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (35, 'EQUIPMENT_TYPE', 'F1201', '电热点位机', '电热点位机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (36, 'EQUIPMENT_TYPE', 'F1202', '切割点位机', '切割点位机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (37, 'EQUIPMENT_TYPE', 'F1301', '吸线头机', '吸线头机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (38, 'EQUIPMENT_TYPE', 'F1401', '干衣机', '干衣机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (39, 'EQUIPMENT_TYPE', 'F1501', '脱水机', '脱水机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (40, 'EQUIPMENT_TYPE', 'F1601', '洗衣机', '洗衣机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (41, 'EQUIPMENT_TYPE', 'F1701', '预缩机', '预缩机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (42, 'EQUIPMENT_TYPE', 'F1801', '卷布机', '卷布机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (43, 'EQUIPMENT_TYPE', 'F1901', '验布机', '验布机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (44, 'EQUIPMENT_TYPE', 'F2001', '松布机', '松布机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (45, 'EQUIPMENT_TYPE', 'F2101', '切捆条机', '切捆条机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (46, 'EQUIPMENT_TYPE', 'F2201', '封口机', '封口机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (47, 'EQUIPMENT_TYPE', 'F2301', '电剪刀', '电剪刀', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (48, 'EQUIPMENT_TYPE', 'F2401', '拉布机', '拉布机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (49, 'EQUIPMENT_TYPE', 'F2501', '激光烫钻机', '激光烫钻机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (50, 'EQUIPMENT_TYPE', 'F2601', '超声波烫钻机', '超声波烫钻机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (51, 'EQUIPMENT_TYPE', 'F2701', '折衣机', '折衣机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (52, 'EQUIPMENT_TYPE', 'F2801', '挖棉机', '挖棉机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (53, 'EQUIPMENT_TYPE', 'F2901', '模压机', '模压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (54, 'EQUIPMENT_TYPE', 'F3001', '剪线机', '剪线机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (55, 'EQUIPMENT_TYPE', 'F3101', '印花机', '印花机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (56, 'EQUIPMENT_TYPE', 'F3201', '摇臂式油压裁断机', '摇臂式油压裁断机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (57, 'EQUIPMENT_TYPE', 'F3301', '压烫机', '压烫机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (58, 'EQUIPMENT_TYPE', 'F3401', '立体刀床', '立体刀床', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (59, 'EQUIPMENT_TYPE', 'F3501', '定型机', '定型机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (60, 'EQUIPMENT_TYPE', 'F3502', '全自动充绒机', '全自动充绒机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (61, 'EQUIPMENT_TYPE', 'F3503', '台板', '台板', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (62, 'EQUIPMENT_TYPE', 'M101', '电脑平车', '电脑平车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (63, 'EQUIPMENT_TYPE', 'M102', '包缝机', '包缝机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (64, 'EQUIPMENT_TYPE', 'M103', '烫台', '烫台', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (65, 'EQUIPMENT_TYPE', 'M104', '套结机', '套结机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (66, 'EQUIPMENT_TYPE', 'M106', '钉扣机', '钉扣机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (67, 'EQUIPMENT_TYPE', 'M107', '附衬机', '附衬机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (68, 'EQUIPMENT_TYPE', 'M108', '多针机', '多针机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (69, 'EQUIPMENT_TYPE', 'M109', '急钮机', '急钮机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (70, 'EQUIPMENT_TYPE', 'M110', '锁眼机（平头）', '锁眼机（平头）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (71, 'EQUIPMENT_TYPE', 'M111', '检针机', '检针机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (72, 'EQUIPMENT_TYPE', 'M112', '贡针机', '贡针机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (73, 'EQUIPMENT_TYPE', 'M113', '锁眼机（圆头）', '锁眼机（圆头）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (74, 'EQUIPMENT_TYPE', 'M114', '开袋机', '开袋机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (75, 'EQUIPMENT_TYPE', 'M115', '链缝机', '链缝机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (76, 'EQUIPMENT_TYPE', 'M116', '花样机', '花样机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (77, 'EQUIPMENT_TYPE', 'M117', '三角针', '三角针', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (78, 'EQUIPMENT_TYPE', 'M118', '刷毛机', '刷毛机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (79, 'EQUIPMENT_TYPE', 'M119', '双针机', '双针机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (80, 'EQUIPMENT_TYPE', 'M121', '吸线头机', '吸线头机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (81, 'EQUIPMENT_TYPE', 'M123', '验布机', '验布机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (82, 'EQUIPMENT_TYPE', 'M124', '领角定型机', '领角定型机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (83, 'EQUIPMENT_TYPE', 'M125', '圆领机', '圆领机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (84, 'EQUIPMENT_TYPE', 'M126', '腰缝机', '腰缝机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (85, 'EQUIPMENT_TYPE', 'M127', '粘合机', '粘合机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (86, 'EQUIPMENT_TYPE', 'M128', '直刀裁剪机', '直刀裁剪机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (87, 'EQUIPMENT_TYPE', 'M129', '带式裁剪机', '带式裁剪机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (88, 'EQUIPMENT_TYPE', 'M130', '链式珠边机', '链式珠边机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (89, 'EQUIPMENT_TYPE', 'M131', '烫袖衩机', '烫袖衩机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (90, 'EQUIPMENT_TYPE', 'M132', '双头焗袖口机', '双头焗袖口机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (91, 'EQUIPMENT_TYPE', 'M133', '缩水定型机', '缩水定型机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (92, 'EQUIPMENT_TYPE', 'M134', '撬边机', '撬边机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (93, 'EQUIPMENT_TYPE', 'M135', '撬下摆机', '撬下摆机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (94, 'EQUIPMENT_TYPE', 'M136', '撬驳头机', '撬驳头机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (95, 'EQUIPMENT_TYPE', 'M137', '撬袖里机', '撬袖里机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (96, 'EQUIPMENT_TYPE', 'M138', '绱袖机', '绱袖机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (97, 'EQUIPMENT_TYPE', 'M139', '自动绕扣机', '自动绕扣机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (98, 'EQUIPMENT_TYPE', 'M140', '绣花机', '绣花机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (99, 'EQUIPMENT_TYPE', 'M141', '兄弟电脑绣花机', '兄弟电脑绣花机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (100, 'EQUIPMENT_TYPE', 'M142', '假眼机', '假眼机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (101, 'EQUIPMENT_TYPE', 'M143', '裤耳机', '裤耳机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (102, 'EQUIPMENT_TYPE', 'M144', '模板机', '模板机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (103, 'EQUIPMENT_TYPE', 'M146', '搂胸机', '搂胸机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (104, 'EQUIPMENT_TYPE', 'M148', '小蒸汽锅炉', '小蒸汽锅炉', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (105, 'EQUIPMENT_TYPE', 'M153', '三点定位机', '三点定位机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (106, 'EQUIPMENT_TYPE', 'M154', '袖笼压机', '袖笼压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (107, 'EQUIPMENT_TYPE', 'M156', '拔袖压机', '拔袖压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (108, 'EQUIPMENT_TYPE', 'M157', '袖内外缝压机', '袖内外缝压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (109, 'EQUIPMENT_TYPE', 'M158', '拔后背压机', '拔后背压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (110, 'EQUIPMENT_TYPE', 'M159', '男装前身片压机', '男装前身片压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (111, 'EQUIPMENT_TYPE', 'M160', '压机（双挂面）', '压机（双挂面）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (112, 'EQUIPMENT_TYPE', 'M161', '压机（三条缝）', '压机（三条缝）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (113, 'EQUIPMENT_TYPE', 'M162', '压机（女肩缝）', '压机（女肩缝）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (114, 'EQUIPMENT_TYPE', 'M163', '压机（女双肩）', '压机（女双肩）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (115, 'EQUIPMENT_TYPE', 'M164', '压机（双驳头）', '压机（双驳头）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (116, 'EQUIPMENT_TYPE', 'M165', '压机（男双肩）', '压机（男双肩）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (117, 'EQUIPMENT_TYPE', 'M166', '压机（袖内）', '压机（袖内）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (118, 'EQUIPMENT_TYPE', 'M167', '压机（袖外）', '压机（袖外）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (119, 'EQUIPMENT_TYPE', 'M168', '袖笼压机', '袖笼压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (120, 'EQUIPMENT_TYPE', 'M169', '压袖山机', '压袖山机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (121, 'EQUIPMENT_TYPE', 'M170', '压烫领头压机', '压烫领头压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (122, 'EQUIPMENT_TYPE', 'M171', '前身后片旋转压机', '前身后片旋转压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (123, 'EQUIPMENT_TYPE', 'M172', '女后背压机', '女后背压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (124, 'EQUIPMENT_TYPE', 'M173', '女前身压机', '女前身压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (125, 'EQUIPMENT_TYPE', 'M174', '压机（栋缝）', '压机（栋缝）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (126, 'EQUIPMENT_TYPE', 'M175', '裤腰压机', '裤腰压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (127, 'EQUIPMENT_TYPE', 'M176', '分裤缝压机', '分裤缝压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (128, 'EQUIPMENT_TYPE', 'M177', '后裆缝压机', '后裆缝压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (129, 'EQUIPMENT_TYPE', 'M178', '拔裆压机', '拔裆压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (130, 'EQUIPMENT_TYPE', 'M179', '旋转分缝压机', '旋转分缝压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (131, 'EQUIPMENT_TYPE', 'M208', '烫口袋机', '烫口袋机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (132, 'EQUIPMENT_TYPE', 'M210', '自动钉扣机', '自动钉扣机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (133, 'EQUIPMENT_TYPE', 'M211', '全自动钉扣机289', '全自动钉扣机289', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (134, 'EQUIPMENT_TYPE', 'M212', '门里襟压机', '门里襟压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (135, 'EQUIPMENT_TYPE', 'M213', '切领机', '切领机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (136, 'EQUIPMENT_TYPE', 'M216', '烫口袋三折机', '烫口袋三折机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (137, 'EQUIPMENT_TYPE', 'M217', '手工', '手工', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (138, 'EQUIPMENT_TYPE', 'M218', '平缝车（带拉筒）', '平缝车（带拉筒）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (139, 'EQUIPMENT_TYPE', 'M219', '台板', '台板', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (140, 'EQUIPMENT_TYPE', 'M220', '冲压机', '冲压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (141, 'EQUIPMENT_TYPE', 'M221', '带刀平缝机', '带刀平缝机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (142, 'EQUIPMENT_TYPE', 'M222', '烫画机', '烫画机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (143, 'EQUIPMENT_TYPE', 'M223', '上、下带刀切割机', '上、下带刀切割机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (144, 'EQUIPMENT_TYPE', 'M224', '差动平缝机', '差动平缝机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (145, 'EQUIPMENT_TYPE', 'M225', '差动链缝机', '差动链缝机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (146, 'EQUIPMENT_TYPE', 'M226', '切垫肩机', '切垫肩机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (147, 'EQUIPMENT_TYPE', 'R0101', '普通单针人字车', '普通单针人字车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (148, 'EQUIPMENT_TYPE', 'R0102', '电脑单针人字车', '电脑单针人字车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (149, 'EQUIPMENT_TYPE', 'R0103', '普通三针人字车', '普通三针人字车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (150, 'EQUIPMENT_TYPE', 'R0104', '电脑三针人字车', '电脑三针人字车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (151, 'EQUIPMENT_TYPE', 'S001', '普通平车', '普通平车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (152, 'EQUIPMENT_TYPE', 'S003', '电脑平车', '电脑平车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (153, 'EQUIPMENT_TYPE', 'S005', '三线拷边车', '三线拷边车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (154, 'EQUIPMENT_TYPE', 'S010', '刀车', '刀车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (155, 'EQUIPMENT_TYPE', 'S0101', '普通单针平车', '普通单针平车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (156, 'EQUIPMENT_TYPE', 'S0102', '电脑单针平车', '电脑单针平车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (157, 'EQUIPMENT_TYPE', 'S0103', '单针高头车', '单针高头车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (158, 'EQUIPMENT_TYPE', 'S0104', '双针高头车', '双针高头车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (159, 'EQUIPMENT_TYPE', 'S011', '带线刀车', '带线刀车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (160, 'EQUIPMENT_TYPE', 'S018', '小烫', '小烫', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (161, 'EQUIPMENT_TYPE', 'S019', '手工', '手工', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (162, 'EQUIPMENT_TYPE', 'S0201', '普通双针平车', '普通双针平车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (163, 'EQUIPMENT_TYPE', 'S0202', '电脑双针平车', '电脑双针平车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (164, 'EQUIPMENT_TYPE', 'S021', '电脑凤眼车', '电脑凤眼车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (165, 'EQUIPMENT_TYPE', 'S0301', '普通单针切刀车', '普通单针切刀车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (166, 'EQUIPMENT_TYPE', 'S0302', '电脑单针切刀车', '电脑单针切刀车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (167, 'EQUIPMENT_TYPE', 'S0303', '无针切刀车', '无针切刀车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (168, 'EQUIPMENT_TYPE', 'S0304', '双刀切刀车', '双刀切刀车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (169, 'EQUIPMENT_TYPE', 'S0401', '普通双线锁边车', '普通双线锁边车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (170, 'EQUIPMENT_TYPE', 'S0402', '电脑双线锁边车', '电脑双线锁边车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (171, 'EQUIPMENT_TYPE', 'S0403', '普通三线锁边车', '普通三线锁边车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (172, 'EQUIPMENT_TYPE', 'S0404', '电脑三线锁边车', '电脑三线锁边车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (173, 'EQUIPMENT_TYPE', 'S0405', '全自动三线锁边车', '全自动三线锁边车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (174, 'EQUIPMENT_TYPE', 'S0406', '普通三线挑脚车', '普通三线挑脚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (175, 'EQUIPMENT_TYPE', 'S0407', '电脑三线挑脚车', '电脑三线挑脚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (176, 'EQUIPMENT_TYPE', 'S0408', '普通四线锁边车', '普通四线锁边车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (177, 'EQUIPMENT_TYPE', 'S0409', '电脑四线锁边车', '电脑四线锁边车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (178, 'EQUIPMENT_TYPE', 'S0410', '普通四线辘领车', '普通四线辘领车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (179, 'EQUIPMENT_TYPE', 'S0411', '电脑四线辘领车', '电脑四线辘领车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (180, 'EQUIPMENT_TYPE', 'S0412', '普通五线锁边车', '普通五线锁边车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (181, 'EQUIPMENT_TYPE', 'S0413', '电脑五线锁边车', '电脑五线锁边车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (182, 'EQUIPMENT_TYPE', 'S0414', '普通六线锁边车', '普通六线锁边车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (183, 'EQUIPMENT_TYPE', 'S0415', '电脑六线锁边车', '电脑六线锁边车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (184, 'EQUIPMENT_TYPE', 'S0416', '无线锁边车', '无线锁边车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (185, 'EQUIPMENT_TYPE', 'S0501', '普通单针双线冚车', '普通单针双线冚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (186, 'EQUIPMENT_TYPE', 'S0502', '电脑单针双线冚车', '电脑单针双线冚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (187, 'EQUIPMENT_TYPE', 'S0503', '普通双针三线冚车', '普通双针三线冚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (188, 'EQUIPMENT_TYPE', 'S0504', '电脑双针三线冚车', '电脑双针三线冚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (189, 'EQUIPMENT_TYPE', 'S0505', '带刀双针三线冚车', '带刀双针三线冚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (190, 'EQUIPMENT_TYPE', 'S0506', '普通双针四线冚车', '普通双针四线冚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (191, 'EQUIPMENT_TYPE', 'S0507', '电脑双针四线冚车', '电脑双针四线冚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (192, 'EQUIPMENT_TYPE', 'S0508', '普通三针四线冚车', '普通三针四线冚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (193, 'EQUIPMENT_TYPE', 'S0509', '电脑三针四线冚车', '电脑三针四线冚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (194, 'EQUIPMENT_TYPE', 'S0510', '普通三针五线冚车', '普通三针五线冚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (195, 'EQUIPMENT_TYPE', 'S0511', '电脑三针五线冚车', '电脑三针五线冚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (196, 'EQUIPMENT_TYPE', 'S0512', '普通四针五线冚车', '普通四针五线冚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (197, 'EQUIPMENT_TYPE', 'S0513', '电脑四针五线冚车', '电脑四针五线冚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (198, 'EQUIPMENT_TYPE', 'S0514', '普通四针六线冚车', '普通四针六线冚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (199, 'EQUIPMENT_TYPE', 'S0515', '电脑四针六线冚车', '电脑四针六线冚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (200, 'EQUIPMENT_TYPE', 'S0601', '普通单针锁链车', '普通单针锁链车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (201, 'EQUIPMENT_TYPE', 'S0602', '电脑单针锁链车', '电脑单针锁链车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (202, 'EQUIPMENT_TYPE', 'S0603', '普通双针锁链车', '普通双针锁链车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (203, 'EQUIPMENT_TYPE', 'S0604', '电脑双针锁链车', '电脑双针锁链车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (204, 'EQUIPMENT_TYPE', 'S0701', '西装上袖车', '西装上袖车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (205, 'EQUIPMENT_TYPE', 'S0801', '单针埋夹车', '单针埋夹车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (206, 'EQUIPMENT_TYPE', 'S0802', '双针埋夹车', '双针埋夹车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (207, 'EQUIPMENT_TYPE', 'S0901', '单针上裤头车', '单针上裤头车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (208, 'EQUIPMENT_TYPE', 'S0902', '双针上裤头车', '双针上裤头车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (209, 'EQUIPMENT_TYPE', 'S0903', '四针上裤头车', '四针上裤头车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (210, 'EQUIPMENT_TYPE', 'S1001', '单针橡筋车', '单针橡筋车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (211, 'EQUIPMENT_TYPE', 'S1002', '双针橡筋车', '双针橡筋车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (212, 'EQUIPMENT_TYPE', 'S1003', '三针橡筋车', '三针橡筋车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (213, 'EQUIPMENT_TYPE', 'S1004', '四针橡筋车', '四针橡筋车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (214, 'EQUIPMENT_TYPE', 'S1005', '五针橡筋车', '五针橡筋车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (215, 'EQUIPMENT_TYPE', 'S1006', '六针橡筋车', '六针橡筋车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (216, 'EQUIPMENT_TYPE', 'S1007', '七针橡筋车', '七针橡筋车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (217, 'EQUIPMENT_TYPE', 'S1008', '八针橡筋车', '八针橡筋车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (218, 'EQUIPMENT_TYPE', 'S1009', '九针橡筋车', '九针橡筋车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (219, 'EQUIPMENT_TYPE', 'S1101', '耳仔车', '耳仔车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (220, 'EQUIPMENT_TYPE', 'S1201', '单针单线挑脚车', '单针单线挑脚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (221, 'EQUIPMENT_TYPE', 'S1301', '门筒单针链式车', '门筒单针链式车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (222, 'EQUIPMENT_TYPE', 'S1302', '门筒双针链式车', '门筒双针链式车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (223, 'EQUIPMENT_TYPE', 'S1303', '门筒单针普通车', '门筒单针普通车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (224, 'EQUIPMENT_TYPE', 'S1304', '门筒双针普通车', '门筒双针普通车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (225, 'EQUIPMENT_TYPE', 'S1401', '真珠边车', '真珠边车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (226, 'EQUIPMENT_TYPE', 'S1402', '假珠边车', '假珠边车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (227, 'EQUIPMENT_TYPE', 'S1501', '普通辘脚车', '普通辘脚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (228, 'EQUIPMENT_TYPE', 'S1502', '电脑辘脚车', '电脑辘脚车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (229, 'EQUIPMENT_TYPE', 'S1601', '月牙车', '月牙车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (230, 'EQUIPMENT_TYPE', 'S1701', '超声波车', '超声波车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (231, 'EQUIPMENT_TYPE', 'S1801', '切腰机', '切腰机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (232, 'EQUIPMENT_TYPE', 'S1802', '切腰机', '切腰机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (233, 'EQUIPMENT_TYPE', 'S1803', '自动贴袋机', '自动贴袋机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (234, 'EQUIPMENT_TYPE', 'S1804', '真珠边机', '真珠边机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (235, 'EQUIPMENT_TYPE', 'S1805', '普通人字车', '普通人字车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (236, 'EQUIPMENT_TYPE', 'S1806', '电脑平车（里布）', '电脑平车（里布）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (237, 'EQUIPMENT_TYPE', 'S1807', '撬边机（暗）', '撬边机（暗）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (238, 'EQUIPMENT_TYPE', 'S1808', '敷衬机(筒式)', '敷衬机(筒式)', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (239, 'EQUIPMENT_TYPE', 'S1809', '上棉条机', '上棉条机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (240, 'EQUIPMENT_TYPE', 'S1810', '上里袖车', '上里袖车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (241, 'EQUIPMENT_TYPE', 'S1811', '上面袖车', '上面袖车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (242, 'EQUIPMENT_TYPE', 'S1901', '缝盘车', '缝盘车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (243, 'EQUIPMENT_TYPE', 'S2001', '临缝机', '临缝机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (244, 'EQUIPMENT_TYPE', 'S2100', '电脑模板机', '电脑模板机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (245, 'EQUIPMENT_TYPE', 'S2201', '容固机', '容固机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (246, 'EQUIPMENT_TYPE', 'S2202', '热封机', '热封机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (247, 'EQUIPMENT_TYPE', 'S2203', '差动平缝机', '差动平缝机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (248, 'EQUIPMENT_TYPE', 'T0001', '烫袋口机', '烫袋口机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (249, 'EQUIPMENT_TYPE', 'T0002', '烫口袋机', '烫口袋机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (250, 'EQUIPMENT_TYPE', 'X0101', '普通套结机', '普通套结机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (251, 'EQUIPMENT_TYPE', 'X0102', '电脑套结机', '电脑套结机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (252, 'EQUIPMENT_TYPE', 'X0103', '绕扣', '绕扣', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (253, 'EQUIPMENT_TYPE', 'X0104', '自动订裤袢机', '自动订裤袢机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (254, 'EQUIPMENT_TYPE', 'X0201', '普通单头平眼车', '普通单头平眼车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (255, 'EQUIPMENT_TYPE', 'X0202', '电脑单头平眼车', '电脑单头平眼车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (256, 'EQUIPMENT_TYPE', 'X0203', '普通双头平眼车', '普通双头平眼车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (257, 'EQUIPMENT_TYPE', 'X0204', '电脑双头平眼车', '电脑双头平眼车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (258, 'EQUIPMENT_TYPE', 'X0205', '全自动双头平眼车', '全自动双头平眼车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (259, 'EQUIPMENT_TYPE', 'X0206', '普通锁眼机', '普通锁眼机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (260, 'EQUIPMENT_TYPE', 'X0207', '电脑锁眼机', '电脑锁眼机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (261, 'EQUIPMENT_TYPE', 'X0301', '普通钉扣车', '普通钉扣车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (262, 'EQUIPMENT_TYPE', 'X0302', '半自动钉扣车', '半自动钉扣车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (263, 'EQUIPMENT_TYPE', 'X0303', '全自动钉扣车', '全自动钉扣车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (264, 'EQUIPMENT_TYPE', 'X0401', '自动工字褶机', '自动工字褶机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (265, 'EQUIPMENT_TYPE', 'X0501', '开袋机', '开袋机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (266, 'EQUIPMENT_TYPE', 'X0601', '开门筒机', '开门筒机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (267, 'EQUIPMENT_TYPE', 'X0701', '自动运袖英机', '自动运袖英机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (268, 'EQUIPMENT_TYPE', 'X0801', '小型绣花车', '小型绣花车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (269, 'EQUIPMENT_TYPE', 'X0901', '钉腰里机', '钉腰里机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (270, 'EQUIPMENT_TYPE', 'X1001', '钉腰牌机', '钉腰牌机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (271, 'EQUIPMENT_TYPE', 'X1101', '菊花眼机', '菊花眼机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (272, 'EQUIPMENT_TYPE', 'X1102', '1351自动裤袢机', '1351自动裤袢机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (273, 'EQUIPMENT_TYPE', 'X1105', '钩扣机', '钩扣机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (274, 'EQUIPMENT_TYPE', 'X1106', '自动运模机', '自动运模机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (275, 'EQUIPMENT_TYPE', 'X1107', '电脑自动假眼机', '电脑自动假眼机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (276, 'EQUIPMENT_TYPE', 'X1201', '热切机', '热切机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (277, 'EQUIPMENT_TYPE', 'X1202', '压胶机', '压胶机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (278, 'EQUIPMENT_TYPE', 'X1203', '锤平机', '锤平机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (279, 'EQUIPMENT_TYPE', 'X1204', '港包机', '港包机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (280, 'EQUIPMENT_TYPE', 'X1205', '轮跟机', '轮跟机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (281, 'EQUIPMENT_TYPE', 'X1206', '铲皮机', '铲皮机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (282, 'EQUIPMENT_TYPE', 'X1208', '电脑花样车', '电脑花样车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (283, 'EQUIPMENT_TYPE', 'X1209', '冲孔机', '冲孔机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (284, 'EQUIPMENT_TYPE', 'X1301', '高头切线机', '高头切线机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (285, 'EQUIPMENT_TYPE', 'X1310', '油边机', '油边机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (286, 'EQUIPMENT_TYPE', 'X1311', '链式贡针机', '链式贡针机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (287, 'EQUIPMENT_TYPE', 'X1312', '切裤里机', '切裤里机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (288, 'EQUIPMENT_TYPE', 'X1313', '冲压机', '冲压机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (289, 'EQUIPMENT_TYPE', 'X1314', '单针链式差动机', '单针链式差动机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (290, 'EQUIPMENT_TYPE', 'X1315', '裤袢机', '裤袢机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (291, 'EQUIPMENT_TYPE', 'X1316', '垫肩切缝机', '垫肩切缝机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (292, 'EQUIPMENT_TYPE', 'Z0001', '缝袋口机', '缝袋口机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (293, 'EQUIPMENT_TYPE', 'PAD', 'pad设备', 'pad设备', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (294, 'EQUIPMENT_TYPE', 'X8888', '实样切割打印机', '实样切割打印机', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (295, 'EQUIPMENT_TYPE', 'M120', '打枣车', '打枣车', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (296, 'EQUIPMENT_TYPE', 'F0303', '中查', '中查（针织）', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (297, 'EQUIPMENT_TYPE', 'P0001', '领料', '领料', 1, '2019-04-07 14:40:34', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (512, 'MATERIAL_TYPE', 'Z001', '基准款', '基准款', 1, '2019-04-07 15:48:16', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (513, 'MATERIAL_TYPE', 'Z002', '部件', '部件', 1, '2019-04-07 15:48:16', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (514, 'MATERIAL_TYPE', 'Z003', '抽象材料', '抽象材料', 1, '2019-04-07 15:48:16', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (515, 'MATERIAL_TYPE', 'Z006', '辅料', '辅料', 1, '2019-04-07 15:48:16', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (516, 'MATERIAL_TYPE', 'Z004', '成品-大货', '成品', 1, '2019-04-07 15:48:16', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (517, 'MATERIAL_TYPE', 'Z005', '面料', '面料', 1, '2019-04-07 15:48:16', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (518, 'MATERIAL_TYPE', 'Z007', '包装材料', '包装材料', 1, '2019-04-07 15:48:16', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (519, 'MATERIAL_TYPE', 'Z008', '里布', '里布', 1, '2019-04-07 15:48:16', NULL, NULL, 0);
INSERT INTO `plan_code` VALUES (520, 'MATERIAL_TYPE', 'Z009', '衬布', '衬布', 1, '2019-04-07 15:48:16', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for production_order
-- ----------------------------
DROP TABLE IF EXISTS `production_order`;
CREATE TABLE `production_order` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(12) COLLATE utf8_bin NOT NULL,
  `order_status` int(11) NOT NULL DEFAULT '0',
  `order_type` int(11) NOT NULL,
  `requirement_order_no` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `schedule_order_no` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `fg_material_id` bigint(20) NOT NULL,
  `priority` tinyint(4) NOT NULL,
  `work_center_id` bigint(20) DEFAULT NULL,
  `routing_order_id` bigint(20) DEFAULT NULL,
  `bom_order_id` bigint(20) DEFAULT NULL,
  `qty_planned` int(11) DEFAULT NULL,
  `qty_finished` int(11) NOT NULL DEFAULT '0',
  `qty_second_quality` int(11) NOT NULL DEFAULT '0',
  `qty_defect` int(11) NOT NULL DEFAULT '0',
  `qty_actual` int(11) NOT NULL DEFAULT '0',
  `time_start_planned` datetime NOT NULL,
  `time_end_planned` datetime NOT NULL,
  `time_start_actual` datetime DEFAULT NULL,
  `time_end_actual` datetime DEFAULT NULL,
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_production_order_01` (`order_no`),
  KEY `idx_production_order_02` (`requirement_order_no`),
  KEY `idx_production_order_03` (`schedule_order_no`),
  KEY `idx_production_order_04` (`fg_material_id`),
  KEY `idx_production_order_05` (`order_status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of production_order
-- ----------------------------
BEGIN;
INSERT INTO `production_order` VALUES (1, 'PO0000000001', 0, 0, NULL, NULL, 16, 5, 3, 1, 2, 40, 0, 0, 0, 0, '2019-04-09 18:35:00', '2019-04-10 10:30:00', NULL, NULL, 1, '2019-04-09 20:41:05', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for production_order_measure
-- ----------------------------
DROP TABLE IF EXISTS `production_order_measure`;
CREATE TABLE `production_order_measure` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `production_order_id` bigint(20) NOT NULL,
  `body_no` varchar(20) COLLATE utf8_bin NOT NULL,
  `measure_data` varchar(10) COLLATE utf8_bin NOT NULL,
  `garment_size` varchar(10) COLLATE utf8_bin NOT NULL,
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_order_measure_01` (`production_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for production_order_pattern_relation
-- ----------------------------
DROP TABLE IF EXISTS `production_order_pattern_relation`;
CREATE TABLE `production_order_pattern_relation` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `production_order_id` bigint(20) NOT NULL,
  `material_id` bigint(20) NOT NULL,
  `media_id` bigint(20) NOT NULL,
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_production_order_pattern_relation_01` (`production_order_id`),
  KEY `idx_production_order_pattern_relation_02` (`material_id`),
  KEY `idx_production_order_pattern_relation_03` (`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for production_order_size
-- ----------------------------
DROP TABLE IF EXISTS `production_order_size`;
CREATE TABLE `production_order_size` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `production_order_id` bigint(20) NOT NULL,
  `size` varchar(20) COLLATE utf8_bin NOT NULL,
  `qyt_planned` int(11) NOT NULL,
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_order_size_01` (`production_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of production_order_size
-- ----------------------------
BEGIN;
INSERT INTO `production_order_size` VALUES (1, 1, 'S165/88A', 10, 1, '2019-04-09 20:41:05', NULL, NULL, 0);
INSERT INTO `production_order_size` VALUES (2, 1, 'M170/92A', 10, 1, '2019-04-09 20:41:05', NULL, NULL, 0);
INSERT INTO `production_order_size` VALUES (3, 1, 'L175/96A', 10, 1, '2019-04-09 20:41:05', NULL, NULL, 0);
INSERT INTO `production_order_size` VALUES (4, 1, 'XL180/100A', 10, 1, '2019-04-09 20:41:05', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for program_privilege
-- ----------------------------
DROP TABLE IF EXISTS `program_privilege`;
CREATE TABLE `program_privilege` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `program_id` varchar(50) COLLATE utf8_bin NOT NULL,
  `privilege_code` varchar(50) COLLATE utf8_bin NOT NULL,
  `privilege_name` varchar(120) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `IDX_PROGRAM_PRIVILEGE_0` (`program_id`),
  KEY `IDX_PROGRAM_PRIVILEGE_1` (`privilege_code`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of program_privilege
-- ----------------------------
BEGIN;
INSERT INTO `program_privilege` VALUES (1, 'SYS01', 'RUN', '系统运行');
INSERT INTO `program_privilege` VALUES (2, 'SYS01_01', 'RUN', '系统运行');
INSERT INTO `program_privilege` VALUES (3, 'SYS01_01', 'INSERT', '新增');
INSERT INTO `program_privilege` VALUES (4, 'SYS01_01', 'UPDATE', '修改');
INSERT INTO `program_privilege` VALUES (5, 'SYS01_01', 'DELETE', '删除');
INSERT INTO `program_privilege` VALUES (6, 'SYS01_01', 'STOP_USER', '暂停账户');
INSERT INTO `program_privilege` VALUES (7, 'SYS01_01', 'START_USER', '启用账户');
INSERT INTO `program_privilege` VALUES (8, 'SYS01_01', 'RESET_PASSWORD', '重设密码');
INSERT INTO `program_privilege` VALUES (9, 'SYS01_01', 'ASSIGN_ROLE', '授权');
INSERT INTO `program_privilege` VALUES (10, 'SYS01_02', 'RUN', '系统运行');
INSERT INTO `program_privilege` VALUES (11, 'SYS01_02', 'INSERT', '新增');
INSERT INTO `program_privilege` VALUES (12, 'SYS01_02', 'UPDATE', '修改');
INSERT INTO `program_privilege` VALUES (13, 'SYS01_02', 'DELETE', '删除');
INSERT INTO `program_privilege` VALUES (14, 'SYS01_02', 'ASSIGN_ROLE', '授权');
INSERT INTO `program_privilege` VALUES (15, 'SYS01_03', 'RUN', '系统运行');
INSERT INTO `program_privilege` VALUES (16, 'SYS01_03', 'INSERT', '新增');
INSERT INTO `program_privilege` VALUES (17, 'SYS01_03', 'UPDATE', '修改');
INSERT INTO `program_privilege` VALUES (18, 'SYS01_03', 'DELETE', '删除');
INSERT INTO `program_privilege` VALUES (19, 'SYS02', 'RUN', '运行');
INSERT INTO `program_privilege` VALUES (20, 'SYS02_01', 'RUN', '运行');
INSERT INTO `program_privilege` VALUES (21, 'SYS02_01_01', 'RUN', '运行');
INSERT INTO `program_privilege` VALUES (22, 'SYS02_01_01', 'INSERT', '新增');
INSERT INTO `program_privilege` VALUES (23, 'SYS02_01_01', 'UPDATE', '修改');
INSERT INTO `program_privilege` VALUES (24, 'SYS02_01_01', 'DELETE', '删除');
INSERT INTO `program_privilege` VALUES (25, 'SYS02_01_02', 'RUN', '运行');
INSERT INTO `program_privilege` VALUES (26, 'SYS02_01_02', 'INSERT', '新增');
INSERT INTO `program_privilege` VALUES (27, 'SYS02_01_02', 'UPDATE', '修改');
INSERT INTO `program_privilege` VALUES (28, 'SYS02_01_02', 'DELETE', '删除');
INSERT INTO `program_privilege` VALUES (29, 'SYS02_01_03', 'RUN', '运行');
INSERT INTO `program_privilege` VALUES (30, 'SYS02_01_03', 'INSERT', '新增');
INSERT INTO `program_privilege` VALUES (31, 'SYS02_01_03', 'UPDATE', '修改');
INSERT INTO `program_privilege` VALUES (32, 'SYS02_01_03', 'DELETE', '删除');
INSERT INTO `program_privilege` VALUES (33, 'SYS02_01_04', 'RUN', '运行');
INSERT INTO `program_privilege` VALUES (34, 'SYS02_01_04', 'INSERT', '新增');
INSERT INTO `program_privilege` VALUES (35, 'SYS02_01_04', 'UPDATE', '修改');
INSERT INTO `program_privilege` VALUES (36, 'SYS02_01_04', 'DELETE', '删除');
INSERT INTO `program_privilege` VALUES (37, 'SYS02_01_05', 'RUN', '运行');
INSERT INTO `program_privilege` VALUES (38, 'SYS02_01_05', 'INSERT', '新增');
INSERT INTO `program_privilege` VALUES (39, 'SYS02_01_05', 'UPDATE', '修改');
INSERT INTO `program_privilege` VALUES (40, 'SYS02_01_05', 'DELETE', '删除');
INSERT INTO `program_privilege` VALUES (41, 'SYS02_02', 'RUN', '运行');
INSERT INTO `program_privilege` VALUES (42, 'SYS02_02_01', 'RUN', '运行');
INSERT INTO `program_privilege` VALUES (43, 'SYS02_02_01', 'INSERT', '新增');
INSERT INTO `program_privilege` VALUES (44, 'SYS02_02_01', 'UPDATE', '修改');
INSERT INTO `program_privilege` VALUES (45, 'SYS02_02_01', 'DELETE', '删除');
INSERT INTO `program_privilege` VALUES (46, 'SYS02_02_02', 'RUN', '运行');
INSERT INTO `program_privilege` VALUES (47, 'SYS02_02_02', 'INSERT', '新增');
INSERT INTO `program_privilege` VALUES (48, 'SYS02_02_02', 'UPDATE', '修改');
INSERT INTO `program_privilege` VALUES (49, 'SYS02_02_02', 'DELETE', '删除');
INSERT INTO `program_privilege` VALUES (50, 'SYS02_02_03', 'RUN', '运行');
INSERT INTO `program_privilege` VALUES (51, 'SYS02_02_03', 'INSERT', '新增');
INSERT INTO `program_privilege` VALUES (52, 'SYS02_02_03', 'UPDATE', '修改');
INSERT INTO `program_privilege` VALUES (53, 'SYS02_02_03', 'DELETE', '删除');
COMMIT;

-- ----------------------------
-- Table structure for quality_check
-- ----------------------------
DROP TABLE IF EXISTS `quality_check`;
CREATE TABLE `quality_check` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `production_order_id` bigint(20) NOT NULL,
  `size_no` varchar(50) COLLATE utf8_bin NOT NULL,
  `size_name` varchar(50) COLLATE utf8_bin NOT NULL,
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_quality_check_01` (`production_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for quality_check_detail
-- ----------------------------
DROP TABLE IF EXISTS `quality_check_detail`;
CREATE TABLE `quality_check_detail` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quality_check_id` bigint(20) NOT NULL,
  `component_no` varchar(50) COLLATE utf8_bin NOT NULL,
  `component_name` varchar(50) COLLATE utf8_bin NOT NULL,
  `standard_value` varchar(50) COLLATE utf8_bin NOT NULL,
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_quality_check_detail_01` (`quality_check_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for role_privilege
-- ----------------------------
DROP TABLE IF EXISTS `role_privilege`;
CREATE TABLE `role_privilege` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `program_privilege_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `program_id` varchar(50) COLLATE utf8_bin NOT NULL,
  `privilege_code` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `IDX_ROLE_PRIVILEGE_0` (`role_id`),
  KEY `IDX_ROLE_PRIVILEGE_1` (`program_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of role_privilege
-- ----------------------------
BEGIN;
INSERT INTO `role_privilege` VALUES (1, 1, 1, 'SYS01', 'RUN');
INSERT INTO `role_privilege` VALUES (2, 2, 1, 'SYS01_01', 'RUN');
INSERT INTO `role_privilege` VALUES (3, 3, 1, 'SYS01_01', 'INSERT');
INSERT INTO `role_privilege` VALUES (4, 4, 1, 'SYS01_01', 'UPDATE');
INSERT INTO `role_privilege` VALUES (5, 5, 1, 'SYS01_01', 'DELETE');
INSERT INTO `role_privilege` VALUES (6, 6, 1, 'SYS01_01', 'STOP_USER');
INSERT INTO `role_privilege` VALUES (7, 7, 1, 'SYS01_01', 'START_USER');
INSERT INTO `role_privilege` VALUES (8, 8, 1, 'SYS01_01', 'RESET_PASSWORD');
INSERT INTO `role_privilege` VALUES (9, 9, 1, 'SYS01_01', 'ASSIGN_ROLE');
INSERT INTO `role_privilege` VALUES (10, 10, 1, 'SYS01_02', 'RUN');
INSERT INTO `role_privilege` VALUES (11, 11, 1, 'SYS01_02', 'INSERT');
INSERT INTO `role_privilege` VALUES (12, 12, 1, 'SYS01_02', 'UPDATE');
INSERT INTO `role_privilege` VALUES (13, 13, 1, 'SYS01_02', 'DELETE');
INSERT INTO `role_privilege` VALUES (14, 14, 1, 'SYS01_02', 'ASSIGN_ROLE');
INSERT INTO `role_privilege` VALUES (15, 15, 1, 'SYS01_03', 'RUN');
INSERT INTO `role_privilege` VALUES (16, 16, 1, 'SYS01_03', 'INSERT');
INSERT INTO `role_privilege` VALUES (17, 17, 1, 'SYS01_03', 'UPDATE');
INSERT INTO `role_privilege` VALUES (18, 18, 1, 'SYS01_03', 'DELETE');
INSERT INTO `role_privilege` VALUES (19, 19, 1, 'SYS02', 'RUN');
INSERT INTO `role_privilege` VALUES (20, 20, 1, 'SYS02_01', 'RUN');
INSERT INTO `role_privilege` VALUES (21, 21, 1, 'SYS02_01_01', 'RUN');
INSERT INTO `role_privilege` VALUES (22, 22, 1, 'SYS02_01_01', 'INSERT');
INSERT INTO `role_privilege` VALUES (23, 23, 1, 'SYS02_01_01', 'UPDATE');
INSERT INTO `role_privilege` VALUES (24, 24, 1, 'SYS02_01_01', 'DELETE');
INSERT INTO `role_privilege` VALUES (25, 25, 1, 'SYS02_01_02', 'RUN');
INSERT INTO `role_privilege` VALUES (26, 26, 1, 'SYS02_01_02', 'INSERT');
INSERT INTO `role_privilege` VALUES (27, 27, 1, 'SYS02_01_02', 'UPDATE');
INSERT INTO `role_privilege` VALUES (28, 28, 1, 'SYS02_01_02', 'DELETE');
INSERT INTO `role_privilege` VALUES (29, 29, 1, 'SYS02_01_03', 'RUN');
INSERT INTO `role_privilege` VALUES (30, 30, 1, 'SYS02_01_03', 'INSERT');
INSERT INTO `role_privilege` VALUES (31, 31, 1, 'SYS02_01_03', 'UPDATE');
INSERT INTO `role_privilege` VALUES (32, 32, 1, 'SYS02_01_03', 'DELETE');
INSERT INTO `role_privilege` VALUES (33, 33, 1, 'SYS02_01_04', 'RUN');
INSERT INTO `role_privilege` VALUES (34, 34, 1, 'SYS02_01_04', 'INSERT');
INSERT INTO `role_privilege` VALUES (35, 35, 1, 'SYS02_01_04', 'UPDATE');
INSERT INTO `role_privilege` VALUES (36, 36, 1, 'SYS02_01_04', 'DELETE');
INSERT INTO `role_privilege` VALUES (37, 37, 1, 'SYS02_01_05', 'RUN');
INSERT INTO `role_privilege` VALUES (38, 38, 1, 'SYS02_01_05', 'INSERT');
INSERT INTO `role_privilege` VALUES (39, 39, 1, 'SYS02_01_05', 'UPDATE');
INSERT INTO `role_privilege` VALUES (40, 40, 1, 'SYS02_01_05', 'DELETE');
INSERT INTO `role_privilege` VALUES (41, 41, 1, 'SYS02_02', 'RUN');
INSERT INTO `role_privilege` VALUES (42, 42, 1, 'SYS02_02_01', 'RUN');
INSERT INTO `role_privilege` VALUES (43, 43, 1, 'SYS02_02_01', 'INSERT');
INSERT INTO `role_privilege` VALUES (44, 44, 1, 'SYS02_02_01', 'UPDATE');
INSERT INTO `role_privilege` VALUES (45, 45, 1, 'SYS02_02_01', 'DELETE');
INSERT INTO `role_privilege` VALUES (46, 46, 1, 'SYS02_02_02', 'RUN');
INSERT INTO `role_privilege` VALUES (47, 47, 1, 'SYS02_02_02', 'INSERT');
INSERT INTO `role_privilege` VALUES (48, 48, 1, 'SYS02_02_02', 'UPDATE');
INSERT INTO `role_privilege` VALUES (49, 49, 1, 'SYS02_02_02', 'DELETE');
INSERT INTO `role_privilege` VALUES (50, 50, 1, 'SYS02_02_03', 'RUN');
INSERT INTO `role_privilege` VALUES (51, 51, 1, 'SYS02_02_03', 'INSERT');
INSERT INTO `role_privilege` VALUES (52, 52, 1, 'SYS02_02_03', 'UPDATE');
INSERT INTO `role_privilege` VALUES (53, 53, 1, 'SYS02_02_03', 'DELETE');
COMMIT;

-- ----------------------------
-- Table structure for role_user
-- ----------------------------
DROP TABLE IF EXISTS `role_user`;
CREATE TABLE `role_user` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `IDX_ROLE_USER_0` (`role_id`),
  KEY `IDX_ROLE_USER_1` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of role_user
-- ----------------------------
BEGIN;
INSERT INTO `role_user` VALUES (1, 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for system_program
-- ----------------------------
DROP TABLE IF EXISTS `system_program`;
CREATE TABLE `system_program` (
  `record_id` varchar(50) COLLATE utf8_bin NOT NULL,
  `program_code` varchar(50) COLLATE utf8_bin NOT NULL,
  `program_name` varchar(120) COLLATE utf8_bin NOT NULL,
  `url` varchar(255) COLLATE utf8_bin NOT NULL,
  `glyph` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `show_order` int(11) NOT NULL,
  `parameters` varchar(255) COLLATE utf8_bin NOT NULL,
  `parent_id` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `IDX_SYSTEM_PROGRAM_0` (`program_code`),
  KEY `IDX_SYSTEM_PROGRAM_1` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of system_program
-- ----------------------------
BEGIN;
INSERT INTO `system_program` VALUES ('SYS01', 'SYS01', '系统管理', '', '0xf013', 0, '', 'SYS01');
INSERT INTO `system_program` VALUES ('SYS01_01', 'SYS01_01', '用户管理', 'app.view.admin.systemUser.SystemUser', '0xf007', 0, '', 'SYS01');
INSERT INTO `system_program` VALUES ('SYS01_02', 'SYS01_02', '角色管理', 'app.view.admin.systemRole.SystemRole', '0xf233', 1, '', 'SYS01');
INSERT INTO `system_program` VALUES ('SYS01_03', 'SYS01_03', '系统参数', 'app.view.admin.systemParameter.SystemParameter', '0xf085', 2, '', 'SYS01');
INSERT INTO `system_program` VALUES ('SYS02', 'SYS02', '工厂', '', '0xf1ad', 1, '', 'SYS02');
INSERT INTO `system_program` VALUES ('SYS02_01', 'SYS02_01', '编码', '', '0xf029', 0, '', 'SYS02');
INSERT INTO `system_program` VALUES ('SYS02_01_01', 'SYS02_01_01', '尺码', 'app.view.imms.code.size.Size', '0xf0c9', 3, '', 'SYS02_01');
INSERT INTO `system_program` VALUES ('SYS02_01_02', 'SYS02_01_02', '缺陷代码', 'app.view.imms.code.defectCode.DefectCode', '0xf002', 2, '', 'SYS02_01');
INSERT INTO `system_program` VALUES ('SYS02_01_03', 'SYS02_01_03', '设备类型', 'app.view.imms.code.machineType.MachineType', '0xf239', 3, '', 'SYS02_01');
INSERT INTO `system_program` VALUES ('SYS02_01_04', 'SYS02_01_04', '物料类型', 'app.view.imms.code.materialType.MaterialType', '0xf00b', 4, '', 'SYS02_01');
INSERT INTO `system_program` VALUES ('SYS02_01_05', 'SYS02_01_05', '物料单位', 'app.view.imms.code.uom.Uom', '0xf039', 5, '', 'SYS02_01');
INSERT INTO `system_program` VALUES ('SYS02_02', 'SYS02_02', '物料', '', '0xf187', 0, '', 'SYS02');
INSERT INTO `system_program` VALUES ('SYS02_02_01', 'SYS02_02_01', '物料', 'app.view.imms.material.material.Material', '0xf187', 1, '', 'SYS02_02');
INSERT INTO `system_program` VALUES ('SYS02_02_02', 'SYS02_02_02', 'BOM 单', 'app.view.imms.material.bomOrder.BomOrder', '0xf0e8', 2, '', 'SYS02_02');
INSERT INTO `system_program` VALUES ('SYS02_02_03', 'SYS02_02_03', 'BOM 项', 'app.view.imms.material.bom.Bom', '0xf2a1', 3, '', 'SYS02_02');
COMMIT;

-- ----------------------------
-- Table structure for system_role
-- ----------------------------
DROP TABLE IF EXISTS `system_role`;
CREATE TABLE `system_role` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_code` varchar(20) COLLATE utf8_bin NOT NULL,
  `role_name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `IDX_SYSTEM_ROLE_0` (`role_code`),
  KEY `IDX_SYSTEM_ROLE_1` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of system_role
-- ----------------------------
BEGIN;
INSERT INTO `system_role` VALUES (1, 'admin', '系统管理员');
COMMIT;

-- ----------------------------
-- Table structure for system_user
-- ----------------------------
DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_code` varchar(20) COLLATE utf8_bin NOT NULL,
  `user_name` varchar(50) COLLATE utf8_bin NOT NULL,
  `pwd` varchar(50) COLLATE utf8_bin NOT NULL,
  `user_status` tinyint(4) NOT NULL,
  `email` varchar(255) COLLATE utf8_bin NOT NULL,
  `is_online` bit(1) NOT NULL DEFAULT b'0',
  `last_login_time` datetime DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `IDX_SYSTEM_USER_0` (`user_code`),
  KEY `IDX_SYSTEM_USER_1` (`user_name`),
  KEY `IDX_SYSTEM_USER_2` (`user_status`),
  KEY `IDX_SYSTEM_USER_3` (`is_online`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of system_user
-- ----------------------------
BEGIN;
INSERT INTO `system_user` VALUES (1, 'C00001', '刘永红', 'e10adc3949ba59abbe56e057f20f883e', 0, 'liuyonghong@zhxh.com', b'0', NULL);
COMMIT;

-- ----------------------------
-- Table structure for tree_code
-- ----------------------------
DROP TABLE IF EXISTS `tree_code`;
CREATE TABLE `tree_code` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_type` varchar(128) COLLATE utf8_bin NOT NULL,
  `code_no` varchar(10) COLLATE utf8_bin NOT NULL,
  `code_name` varchar(30) COLLATE utf8_bin NOT NULL,
  `description` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `parent_id` bigint(20) NOT NULL DEFAULT '0',
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_tree_code_01` (`code_no`),
  KEY `idx_tree_code_02` (`code_name`),
  KEY `idx_tree_code_03` (`parent_id`),
  KEY `idx_tree_code_04` (`code_type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of tree_code
-- ----------------------------
BEGIN;
INSERT INTO `tree_code` VALUES (1, 'TREE_CODE_TYPE_DEFECT', 'defect', '缺陷代码', NULL, 0, 1, '2019-04-07 14:36:12', NULL, NULL, 0);
INSERT INTO `tree_code` VALUES (2, 'TREE_CODE_TYPE_MATERIAL', 'material', '物料类别', NULL, 0, 1, '2019-04-07 14:36:12', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for work_organization_unit
-- ----------------------------
DROP TABLE IF EXISTS `work_organization_unit`;
CREATE TABLE `work_organization_unit` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `organization_type` varchar(128) COLLATE utf8_bin NOT NULL,
  `organization_code` varchar(50) COLLATE utf8_bin NOT NULL,
  `organization_name` varchar(50) COLLATE utf8_bin NOT NULL,
  `sequence_no` int(11) NOT NULL DEFAULT '1',
  `description` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `parent_organization_id` bigint(20) NOT NULL,
  `cost_price_ratio` double(8,4) NOT NULL DEFAULT '1.0000',
  `main_orbit_length` int(11) NOT NULL DEFAULT '0',
  `rotate_direction` int(11) NOT NULL DEFAULT '0',
  `line_distance` int(11) NOT NULL DEFAULT '0',
  `work_station_type` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '',
  `machine_type_id` bigint(20) NOT NULL DEFAULT '0',
  `is_on_line` bit(1) NOT NULL DEFAULT b'1',
  `operator_id` bigint(20) NOT NULL DEFAULT '0',
  `is_available` bit(1) NOT NULL DEFAULT b'1',
  `wip_max` int(11) NOT NULL DEFAULT '0',
  `wip_current` int(11) NOT NULL DEFAULT '0',
  `wip_in_transit` int(11) NOT NULL DEFAULT '0',
  `direction` int(11) NOT NULL DEFAULT '0',
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `opt_flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`record_id`),
  KEY `idx_work_organization_unit_01` (`organization_code`),
  KEY `idx_work_organization_unit_02` (`organization_type`),
  KEY `idx_work_organization_unit_03` (`parent_organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of work_organization_unit
-- ----------------------------
BEGIN;
INSERT INTO `work_organization_unit` VALUES (1, 'ORG_LANT', 'A', 'A厂', 0, 'T恤厂', 0, 0.1000, 0, 0, 0, '', 0, b'1', 0, b'1', 0, 0, 0, 0, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (2, 'ORG_WORK_CENTER', 'A.04', '缝制车间', 1, NULL, 1, 1.0000, 30, 1, 0, '', 0, b'1', 0, b'1', 0, 0, 0, 0, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (3, 'ORG_WORK_CENTER', 'A.03', '裁剪车间', 2, NULL, 1, 1.0000, 0, 0, 0, '', 0, b'1', 0, b'1', 0, 0, 0, 0, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (4, 'ORG_WORK_LINE', 'A.04.00', '上裁片线', 0, NULL, 2, 1.0000, 0, 1, 0, '', 0, b'1', 0, b'1', 0, 0, 0, 0, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (5, 'ORG_WORK_LINE', 'A.04.01', 'PL01', 1, NULL, 2, 1.0000, 0, 1, 5, '', 0, b'1', 0, b'1', 0, 0, 0, 0, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (6, 'ORG_WORK_LINE', 'A.04.02', 'PL02', 2, NULL, 2, 1.0000, 0, 1, 5, '', 0, b'1', 0, b'1', 0, 0, 0, 0, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (7, 'ORG_WORK_LINE', 'A.04.03', 'PL03', 3, NULL, 2, 1.0000, 0, 1, 5, '', 0, b'1', 0, b'1', 0, 0, 0, 0, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (8, 'ORG_WORK_LINE', 'A.04.04', 'PL04', 4, NULL, 2, 1.0000, 0, 1, 5, '', 0, b'1', 0, b'1', 0, 0, 0, 0, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (9, 'ORG_WORK_LINE', 'A.04.05', 'PL05', 5, NULL, 2, 1.0000, 0, 1, 5, '', 0, b'1', 0, b'1', 0, 0, 0, 0, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (10, 'ORG_WORK_STATION', 'A.04.00.001', '上', 1, '上裁片1', 4, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (11, 'ORG_WORK_STATION', 'A.04.03.022', '平', 22, '', 7, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (12, 'ORG_WORK_STATION', 'A.04.03.023', '平', 23, '', 7, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (13, 'ORG_WORK_STATION', 'A.04.03.024', '平', 24, '', 7, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (14, 'ORG_WORK_STATION', 'A.04.04.025', '三', 25, '', 8, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (15, 'ORG_WORK_STATION', 'A.04.04.026', '平', 26, '', 8, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (16, 'ORG_WORK_STATION', 'A.04.04.027', '平', 27, '', 8, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (17, 'ORG_WORK_STATION', 'A.04.04.028', '平', 28, '', 8, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (18, 'ORG_WORK_STATION', 'A.04.04.029', '平', 29, '', 8, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (19, 'ORG_WORK_STATION', 'A.04.04.030', '平', 30, '', 8, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (20, 'ORG_WORK_STATION', 'A.04.04.031', '平', 31, '', 8, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (21, 'ORG_WORK_STATION', 'A.04.04.032', '平', 32, '', 8, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (22, 'ORG_WORK_STATION', 'A.04.05.033', '查', 33, '', 9, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (23, 'ORG_WORK_STATION', 'A.04.05.034', '金', 34, '', 9, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (24, 'ORG_WORK_STATION', 'A.04.05.035', '钉', 35, '', 9, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (25, 'ORG_WORK_STATION', 'A.04.05.036', '钮', 36, '', 9, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (26, 'ORG_WORK_STATION', 'A.04.05.037', '烫', 37, '中烫1', 9, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 10, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (27, 'ORG_WORK_STATION', 'A.04.05.038', '烫', 38, '中烫2', 9, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (28, 'ORG_WORK_STATION', 'A.04.03.021', '平', 21, '', 7, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (29, 'ORG_WORK_STATION', 'A.04.05.039', '枣', 39, '', 9, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (30, 'ORG_WORK_STATION', 'A.04.03.020', '平', 20, '', 7, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (31, 'ORG_WORK_STATION', 'A.04.03.018', '平', 18, '', 7, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'0', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (32, 'ORG_WORK_STATION', 'A.04.01.001', '四', 1, '', 5, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (33, 'ORG_WORK_STATION', 'A.04.01.002', '四', 2, '', 5, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (34, 'ORG_WORK_STATION', 'A.04.01.003', '冚', 3, '', 5, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (35, 'ORG_WORK_STATION', 'A.04.01.004', '平', 4, '', 5, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (36, 'ORG_WORK_STATION', 'A.04.01.005', '平', 5, '', 5, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (37, 'ORG_WORK_STATION', 'A.04.01.006', '平', 6, '', 5, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (38, 'ORG_WORK_STATION', 'A.04.01.007', '平', 7, '', 5, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'0', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (39, 'ORG_WORK_STATION', 'A.04.01.008', '查', 8, '', 5, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (40, 'ORG_WORK_STATION', 'A.04.02.009', '平', 9, '', 6, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (41, 'ORG_WORK_STATION', 'A.04.02.010', '平', 10, '', 6, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (42, 'ORG_WORK_STATION', 'A.04.02.011', '平', 11, '', 6, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (43, 'ORG_WORK_STATION', 'A.04.02.012', '平', 12, '', 6, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (44, 'ORG_WORK_STATION', 'A.04.02.013', '中', 13, '', 6, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (45, 'ORG_WORK_STATION', 'A.04.02.014', '平', 14, '', 6, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (46, 'ORG_WORK_STATION', 'A.04.02.015', '刀', 15, '', 6, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (47, 'ORG_WORK_STATION', 'A.04.02.016', '平', 16, '', 6, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (48, 'ORG_WORK_STATION', 'A.04.03.017', '平', 17, '', 7, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (49, 'ORG_WORK_STATION', 'A.04.03.019', '平', 19, '', 7, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'0', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
INSERT INTO `work_organization_unit` VALUES (50, 'ORG_WORK_STATION', 'A.04.05.040', '凤', 40, '', 9, 1.0000, 0, 0, 0, 'STITCHING', 0, b'0', 0, b'1', 3, 0, 0, 1, 0, '0001-01-01 00:00:00', NULL, NULL, 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
