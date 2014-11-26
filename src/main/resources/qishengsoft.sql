/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : qishengsoft

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2014-11-26 14:42:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `bbuy`
-- ----------------------------
DROP TABLE IF EXISTS `bbuy`;
CREATE TABLE `bbuy` (
  `buyid` int(9) NOT NULL COMMENT '采购ID',
  `btype` varchar(3) NOT NULL COMMENT '单据类型',
  `buyname` varchar(64) DEFAULT NULL COMMENT '采购名称',
  `buyno` varchar(16) NOT NULL COMMENT '采购编号',
  `relateno` varchar(16) DEFAULT NULL COMMENT '关联单据号',
  `buydate` varchar(10) DEFAULT NULL COMMENT '采购日期',
  `currflow` varchar(32) DEFAULT NULL COMMENT '当前流程',
  `maker` varchar(32) DEFAULT NULL COMMENT '制单人',
  `createtime` varchar(19) DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`buyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购表';

-- ----------------------------
-- Records of bbuy
-- ----------------------------
INSERT INTO `bbuy` VALUES ('2', 'CGD', '采购单名称一', 'CGD-2013-0002', null, '2013-03-01', '结束', 'ZHOUJD', '2013-03-01 17:03:37', '备注二');
INSERT INTO `bbuy` VALUES ('3', 'JYD', '简易采购单1', 'JYD-2013-0001', null, '2014-05-01', '结束', 'ZHOUJD', '2013-03-01 17:05:32', '');
INSERT INTO `bbuy` VALUES ('4', 'CGD', '采购单名称三', 'CGD-2013-0003', null, '2013-03-01', '结束', 'ZHOUJD', '2013-03-02 20:44:21', '备注三');
INSERT INTO `bbuy` VALUES ('5', 'CGD', '采购单2', 'CGD-2014-0001', null, '2014-07-04', '结束', 'ZHOUJD', '2014-07-04 11:16:49', '');
INSERT INTO `bbuy` VALUES ('6', 'CGD', '采购单3', 'CGD-2014-0002', null, '2014-07-04', '结束', 'ZHOUJD', '2014-07-04 11:20:29', '');
INSERT INTO `bbuy` VALUES ('7', 'CGD', '采购单4', 'CGD-2014-0003', null, '2014-06-01', '结束', 'ZHOUJD', '2014-07-04 11:31:38', '');
INSERT INTO `bbuy` VALUES ('8', 'CGD', '2014.07.19小周采购', 'CGD-2014-0004', null, '2014-07-19', '结束', 'ZHOUJD', '2014-07-19 14:16:29', '');
INSERT INTO `bbuy` VALUES ('9', 'CGD', '2014.08.20采购', 'CGD-20140820-001', null, '2014-08-20', '结束', 'ZHOUJD', '2014-08-20 14:55:12', '');
INSERT INTO `bbuy` VALUES ('13', 'CGD', '2014.09.01采购', 'CGD-20140901-001', 'XSD-20140828-002', '2014-09-01', '结束', 'ZHOUJD', '2014-09-01 17:04:22', '');
INSERT INTO `bbuy` VALUES ('35', 'CGD', '2014.10.22采购', 'CGD-20141022-002', '', '2014-10-22', '结束', 'ZHOUJD', '2014-10-22 18:37:22', '合并采购单（XSD-20140925-001）');
INSERT INTO `bbuy` VALUES ('36', 'CGD', '2014.11.14采购', 'CGD-20141114-001', 'XSD-20141114-001', '2014-11-14', '结束', 'ZHOUJD', '2014-11-14 10:24:02', '');
INSERT INTO `bbuy` VALUES ('40', 'CGD', '2014.11.18采购', 'CGD-20141118-002', '', '2014-11-18', '结束', 'ZHOUJD', '2014-11-18 15:15:09', '合并采购单（XSD-20141118-001）');
INSERT INTO `bbuy` VALUES ('42', 'CGD', '2014.11.18采购', 'CGD-20141118-003', 'XSD-20141118-001', '2014-11-18', '申请', 'ZHOUJD', '2014-11-18 15:29:13', '');

-- ----------------------------
-- Table structure for `bbuyrow`
-- ----------------------------
DROP TABLE IF EXISTS `bbuyrow`;
CREATE TABLE `bbuyrow` (
  `buyrowid` int(7) NOT NULL AUTO_INCREMENT COMMENT '采购行项ID',
  `buyid` int(7) NOT NULL COMMENT '采购单ID',
  `materialid` int(5) DEFAULT NULL COMMENT '物资ID',
  `materialname` varchar(64) NOT NULL COMMENT '物资名称',
  `unit` int(3) DEFAULT NULL COMMENT '计量单位',
  `price` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '预算单价',
  `num` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '采购数量',
  `sum` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '总价',
  `manuid` int(9) DEFAULT NULL COMMENT '供应商ID',
  `manuname` varchar(64) DEFAULT NULL COMMENT '供应商名称',
  `manucontact` varchar(64) DEFAULT NULL COMMENT '联系人',
  `manutel` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `remarkrow` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`buyrowid`)
) ENGINE=InnoDB AUTO_INCREMENT=350 DEFAULT CHARSET=utf8 COMMENT='采购行项表';

-- ----------------------------
-- Records of bbuyrow
-- ----------------------------
INSERT INTO `bbuyrow` VALUES ('118', '2', '1', '物资名称一1', '1', '0.22', '1.00', '0.22', '4', '供应商A', '周少华', '11111111', null);
INSERT INTO `bbuyrow` VALUES ('145', '4', '1', '物资名称一1', '1', '0.22', '3.00', '0.66', '4', '供应商A', '周少华', '11111111', '备注3');
INSERT INTO `bbuyrow` VALUES ('146', '4', '4', '物资三', '1', '33.30', '2.00', '66.60', '4', '供应商A', '周少华', '11111111', null);
INSERT INTO `bbuyrow` VALUES ('147', '4', '5', '物资四', '2', '4444.00', '0.00', '0.00', '8', '供应商B', '供应商B联系人', '00000', null);
INSERT INTO `bbuyrow` VALUES ('148', '4', null, '物资五', '3', '3.00', '2.00', '6.00', null, null, null, null, '小卖部采购');
INSERT INTO `bbuyrow` VALUES ('179', '7', '1', '物资A11', '1', '0.22', '433.00', '95.26', '4', '供应商A', '周少华', '11111111', null);
INSERT INTO `bbuyrow` VALUES ('180', '7', '6', '物资A21', '3', '43.20', '22.00', '950.40', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('181', '7', '4', '物资B11', '1', '33.30', '44.00', '1465.20', '4', '供应商A', '周少华', '11111111', null);
INSERT INTO `bbuyrow` VALUES ('182', '7', '5', '物资B12', '2', '4444.00', '2.00', '8888.00', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('183', '6', '1', '物资A11', '1', '0.22', '421.00', '92.62', '4', '供应商A', '周少华', '11111111', null);
INSERT INTO `bbuyrow` VALUES ('184', '6', '6', '物资A21', '3', '43.20', '22.00', '950.40', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('185', '6', '5', '物资B12', '2', '4444.00', '1.00', '4444.00', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('186', '5', '6', '物资A21', '3', '43.20', '22.00', '950.40', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('187', '5', '5', '物资B12', '2', '4444.00', '1.00', '4444.00', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('188', '3', null, '简易采购物品1', '1', '544.00', '3.00', '1632.00', null, null, null, null, null);
INSERT INTO `bbuyrow` VALUES ('189', '3', null, '简易采购物品2', '1', '342.00', '2.00', '684.00', null, null, null, null, null);
INSERT INTO `bbuyrow` VALUES ('190', '3', null, '简易采购物品3', '2', '12.00', '32.00', '384.00', null, null, null, null, null);
INSERT INTO `bbuyrow` VALUES ('207', '8', '5', '物资B12', '2', '44.00', '60.00', '2640.00', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('208', '8', '1', '物资A11', '1', '0.22', '2200.00', '484.00', '4', '供应商A', '周少华', '11111111', null);
INSERT INTO `bbuyrow` VALUES ('212', '9', '6', '物资A21', '1', '43.20', '110.00', '4752.00', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('213', '9', '1', '物资A11', '1', '0.22', '23.00', '5.06', '4', '供应商A', '周少华', '11111111', null);
INSERT INTO `bbuyrow` VALUES ('214', '9', '9', '5', '1', '5.00', '43.00', '215.00', '4', '供应商A', '周少华', '11111111', null);
INSERT INTO `bbuyrow` VALUES ('227', '13', '1', '物资A11', '1', '0.22', '70.00', '15.40', '4', '供应商A', '周少华', '11111111', null);
INSERT INTO `bbuyrow` VALUES ('228', '13', '5', '物资B12', '1', '44.00', '5.00', '220.00', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('229', '13', '6', '物资A21', '1', '43.20', '6.00', '259.20', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('293', '35', '1', '物资A11', '1', '0.22', '1017.00', '223.74', '4', '供应商A', '周少华', '11111111', null);
INSERT INTO `bbuyrow` VALUES ('294', '35', '4', '物资B11', '1', '33.30', '7.00', '233.10', '4', '供应商A', '周少华', '11111111', null);
INSERT INTO `bbuyrow` VALUES ('295', '35', '5', '物资B12', '1', '44.00', '135.00', '5940.00', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('296', '35', '6', '物资A21', '1', '43.20', '165.00', '7128.00', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('312', '36', '1', '物资A11', '1', '0.22', '46.00', '10.12', '4', '供应商A', '周少华', '11111111', null);
INSERT INTO `bbuyrow` VALUES ('313', '36', '5', '物资B12', '1', '44.00', '3.00', '132.00', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('314', '36', '6', '物资A21', '1', '43.20', '4.00', '172.80', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('342', '40', '1', '物资A11', '1', '0.22', '22.00', '4.84', '4', '供应商A', '周少华', '11111111', null);
INSERT INTO `bbuyrow` VALUES ('343', '40', '5', '物资B12', '1', '44.00', '3.00', '132.00', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('344', '40', '6', '物资A21', '1', '43.20', '6.00', '259.20', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('345', '42', '1', '物资A11', '1', '0.22', '22.00', '4.84', '4', '供应商A', '周少华', '11111111', null);
INSERT INTO `bbuyrow` VALUES ('346', '42', '5', '物资B12', '1', '44.00', '3.00', '132.00', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('347', '42', '6', '物资A21', '1', '43.20', '6.00', '259.20', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('348', '42', '6', '物资A21', '1', '43.20', '0.00', '0.00', '8', '供应商B', '供应商B', '00000', null);
INSERT INTO `bbuyrow` VALUES ('349', '42', '1', '物资A11', '1', '0.22', '0.00', '0.00', '4', '供应商A', '周少华', '11111111', null);

-- ----------------------------
-- Table structure for `bpay`
-- ----------------------------
DROP TABLE IF EXISTS `bpay`;
CREATE TABLE `bpay` (
  `payid` int(9) NOT NULL COMMENT '单据ID',
  `btype` varchar(16) NOT NULL COMMENT '单据类型',
  `maker` varchar(32) DEFAULT NULL COMMENT '制单人',
  `paydate` varchar(10) DEFAULT NULL COMMENT '付款日期/收款日期',
  `relateno` varchar(16) DEFAULT NULL COMMENT '采购单号/销售单号',
  `relatemoney` double(12,2) DEFAULT '0.00' COMMENT '关联金额',
  `currflow` varchar(32) NOT NULL COMMENT '当前流程',
  `createtime` varchar(19) DEFAULT NULL COMMENT '创建时间',
  `operatetime` varchar(19) DEFAULT NULL COMMENT '结束时间',
  `operater` varchar(64) DEFAULT NULL COMMENT '操作人ID',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`payid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='付款单/收款单';

-- ----------------------------
-- Records of bpay
-- ----------------------------
INSERT INTO `bpay` VALUES ('24', 'SKD', 'ZHOUJD', '2013-03-06', 'XSD-2013-0001', '36.60', '结束', '2013-03-06 19:41:56', null, null, '');
INSERT INTO `bpay` VALUES ('25', 'YFD', 'ZHOUJD', '2013-03-06', 'XSD-2013-0001', '36.60', '结束', '2013-03-06 19:41:56', null, null, '');
INSERT INTO `bpay` VALUES ('30', 'GZD', 'ZHOUJD', '2013-03-07', 'GZD-2013-0001', '5300.34', '结束', '2013-03-11 16:29:47', null, null, '');
INSERT INTO `bpay` VALUES ('31', 'FKD', 'ZHOUJD', '2014-06-01', 'CGD-2014-0003', '11398.86', '结束', '2014-07-12 13:58:07', null, null, '');
INSERT INTO `bpay` VALUES ('32', 'SKD', 'ZHOUJD', '2014-03-12', 'XSD-2014-0006', '8170.00', '结束', '2014-07-13 16:17:30', null, null, '');
INSERT INTO `bpay` VALUES ('33', 'YFD', 'ZHOUJD', '2014-03-12', 'XSD-2014-0006', '8170.00', '结束', '2014-07-13 16:17:30', null, null, '');
INSERT INTO `bpay` VALUES ('34', 'SKD', 'ZHOUJD', '2014-04-02', 'XSD-2014-0005', '10260.00', '结束', '2014-07-13 16:17:35', null, null, '');
INSERT INTO `bpay` VALUES ('35', 'YFD', 'ZHOUJD', '2014-04-02', 'XSD-2014-0005', '10260.00', '结束', '2014-07-13 16:17:35', null, null, '');
INSERT INTO `bpay` VALUES ('36', 'SKD', 'ZHOUJD', '2014-06-12', 'XSD-2014-0004', '8594.60', '结束', '2014-07-13 16:17:40', null, null, '');
INSERT INTO `bpay` VALUES ('37', 'YFD', 'ZHOUJD', '2014-06-12', 'XSD-2014-0004', '8594.60', '结束', '2014-07-13 16:17:40', null, null, '');
INSERT INTO `bpay` VALUES ('38', 'SKD', 'ZHOUJD', '2014-06-02', 'XSD-2014-0003', '9440.80', '结束', '2014-07-13 16:17:47', null, null, '');
INSERT INTO `bpay` VALUES ('39', 'YFD', 'ZHOUJD', '2014-06-02', 'XSD-2014-0003', '9440.80', '结束', '2014-07-13 16:17:47', null, null, '');
INSERT INTO `bpay` VALUES ('40', 'SKD', 'ZHOUJD', '2014-07-01', 'XSD-2014-0002', '24318.80', '结束', '2014-07-13 16:17:52', null, null, '');
INSERT INTO `bpay` VALUES ('41', 'YFD', 'ZHOUJD', '2014-07-01', 'XSD-2014-0002', '24318.80', '结束', '2014-07-13 16:17:52', null, null, '');
INSERT INTO `bpay` VALUES ('42', 'SKD', 'ZHOUJD', '2014-07-13', 'XSD-2014-0001', '12106.60', '结束', '2014-07-13 16:17:58', null, null, '');
INSERT INTO `bpay` VALUES ('43', 'YFD', 'ZHOUJD', '2014-07-13', 'XSD-2014-0001', '12106.60', '结束', '2014-07-13 16:17:58', null, null, '');
INSERT INTO `bpay` VALUES ('44', 'GZD', 'ZHOUJD', '2013-02-28', 'GZD-2013-0002', '7000.30', '结束', '2014-07-14 20:10:23', null, null, '');
INSERT INTO `bpay` VALUES ('45', 'FKD', 'ZHOUJD', '2014-07-04', 'CGD-2014-0002', '5487.02', '结束', '2014-07-14 20:21:22', null, null, '');
INSERT INTO `bpay` VALUES ('46', 'FKD', 'ZHOUJD', '2014-07-04', 'CGD-2014-0001', '5394.40', '结束', '2014-07-14 20:21:28', null, null, '');
INSERT INTO `bpay` VALUES ('47', 'FKD', 'ZHOUJD', '2014-05-01', 'JYD-2013-0001', '4511.26', '结束', '2014-07-14 20:22:30', null, null, '');
INSERT INTO `bpay` VALUES ('48', 'FKD', 'ZHOUJD', '2014-07-19', 'CGD-2014-0004', '48.84', '结束', '2014-07-28 20:49:14', null, null, '');
INSERT INTO `bpay` VALUES ('49', 'SKD', 'ZHOUJD', '2014-07-18', 'XSD-2014-0007', '950.40', '结束', '2014-07-28 20:49:54', null, null, '');
INSERT INTO `bpay` VALUES ('50', 'YFD', 'ZHOUJD', '2014-07-18', 'XSD-2014-0007', '950.40', '结束', '2014-07-28 20:49:54', null, null, '');
INSERT INTO `bpay` VALUES ('51', 'GZD', 'ZHOUJD', '2014-06', 'GZD-20140728-001', '3480.00', '结束', '2014-07-28 21:07:01', null, null, '');
INSERT INTO `bpay` VALUES ('52', 'GZD', 'ZHOUJD', '2014-06', 'GZD-20140728-002', '3248.00', '结束', '2014-07-28 22:38:17', '2014-07-28 21:21:24', null, '');
INSERT INTO `bpay` VALUES ('53', 'SKD', 'ZHOUJD', '2014-08-20', 'XSD-20140820-001', '7522.62', '结束', '2014-08-20 14:34:44', '2014-08-20 08:55:18', 'ZHOUJD', '');
INSERT INTO `bpay` VALUES ('54', 'YFD', 'ZHOUJD', '2014-08-20', 'XSD-20140820-001', '7522.62', '结束', '2014-08-20 14:34:44', '2014-08-20 08:55:18', 'ZHOUJD', '');
INSERT INTO `bpay` VALUES ('55', 'FKD', 'ZHOUJD', '2014-08-20', 'CGD-20140820-001', '4972.06', '结束', '2014-08-20 14:57:59', '2014-08-20 08:55:18', 'ZHOUJD', '');
INSERT INTO `bpay` VALUES ('56', 'GZD', 'ZHOUJD', '2014-07', 'GZD-20140820-001', '2250.00', '结束', '2014-08-20 15:23:35', '2014-08-20 15:05:16', 'ZHOUJD', '');
INSERT INTO `bpay` VALUES ('57', 'GZD', 'ZHOUJD', '2014-07', 'GZD-20140820-002', '3596.00', '结束', '2014-08-20 15:34:56', '2014-08-20 15:05:16', 'ZHOUJD', '');
INSERT INTO `bpay` VALUES ('58', 'SKD', 'ZHOUJD', '2014-08-28', 'XSD-20140828-001', '1017.00', '结束', '2014-08-28 15:33:16', '2014-08-28 11:05:14', 'ZHOUJD', '');
INSERT INTO `bpay` VALUES ('59', 'FKD', 'ZHOUJD', '2014-09-01', 'CGD-20140901-001', '494.60', '结束', '2014-09-01 17:28:36', '2014-09-01 17:29:54', 'ZHOUJD', '');
INSERT INTO `bpay` VALUES ('60', 'SKD', 'ZHOUJD', '2014-08-28', 'XSD-20140828-002', '847.90', '结束', '2014-09-01 17:29:22', '2014-09-01 17:29:57', 'ZHOUJD', '');
INSERT INTO `bpay` VALUES ('61', 'GZD', 'ZHOUJD', '2014-09', 'GZD-20141022-001', '5730.00', '结束', '2014-10-22 18:22:34', '2014-10-22 18:23:28', 'ZHOUJD', '');
INSERT INTO `bpay` VALUES ('62', 'SKD', 'ZHOUJD', '2014-09-25', 'XSD-20140925-001', '10984.90', '结束', '2014-10-22 18:35:41', '2014-10-22 18:37:01', 'ZHOUJD', '');
INSERT INTO `bpay` VALUES ('63', 'FKD', 'ZHOUJD', '2014-10-22', 'CGD-20141022-002', '13524.84', '结束', '2014-10-22 18:38:35', '2014-10-22 18:38:58', 'ZHOUJD', '');
INSERT INTO `bpay` VALUES ('64', 'FKD', 'ZHOUJD', '2014-11-14', 'CGD-20141114-001', '314.92', '结束', '2014-11-14 10:26:48', '2014-11-14 10:39:02', 'ZHOUJD', '');
INSERT INTO `bpay` VALUES ('68', 'SKD', 'ZHOUJD', '2014-11-14', 'XSD-20141114-001', '535.20', '结束', '2014-11-14 18:01:34', '2014-11-14 18:01:46', 'ZHOUJD', '');
INSERT INTO `bpay` VALUES ('81', 'FKD', 'ZHOUJD', '2014-11-18', 'CGD-20141118-002', '396.04', '结束', '2014-11-26 10:59:59', '2014-11-26 11:01:22', 'ZHOUJD', '');
INSERT INTO `bpay` VALUES ('82', 'SKD', 'ZHOUJD', '2014-11-18', 'XSD-20141118-001', '690.90', '结束', '2014-11-26 11:10:25', '2014-11-26 11:11:15', 'ZHOUJD', '');
INSERT INTO `bpay` VALUES ('84', 'GZD', 'ZHOUJD', '2014-10', 'GZD-20141126-001', '5740.10', '结束', '2014-11-26 11:25:25', '2014-11-26 11:28:10', 'ZHOUJD', '');

-- ----------------------------
-- Table structure for `bpayrow`
-- ----------------------------
DROP TABLE IF EXISTS `bpayrow`;
CREATE TABLE `bpayrow` (
  `payrowid` int(9) NOT NULL AUTO_INCREMENT COMMENT '行项ID',
  `payid` int(9) NOT NULL COMMENT '单据ID',
  `bankcardno` varchar(32) DEFAULT NULL COMMENT '银行卡卡号',
  `manuid` int(9) DEFAULT NULL COMMENT '供应商ID',
  `manubankname` varchar(64) DEFAULT NULL COMMENT '供应商开户银行',
  `manubankcardno` varchar(32) DEFAULT NULL COMMENT '供应商银行卡卡号',
  `manuaccountname` varchar(64) DEFAULT NULL COMMENT '供应商账户名称',
  `plansum` double(12,2) DEFAULT '0.00' COMMENT '应付金额',
  `realsum` double(12,2) DEFAULT '0.00' COMMENT '实付金额',
  `remarkrow` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`payrowid`)
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bpayrow
-- ----------------------------
INSERT INTO `bpayrow` VALUES ('4', '4', '6227001823550093014', '4', '建设银行泉州分行', '1111111111', '周少华', '1111.00', '11111.00', '111111');
INSERT INTO `bpayrow` VALUES ('14', '11', '00000', null, null, null, null, '6.00', '6.00', null);
INSERT INTO `bpayrow` VALUES ('15', '11', '6227001823550093014', '4', '建设银行泉州分行', '1111111111', '周少华', '67.26', '67.26', null);
INSERT INTO `bpayrow` VALUES ('16', '11', '6227001823550093014', '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '0.00', '1.00', null);
INSERT INTO `bpayrow` VALUES ('20', '15', '00000', '5', '中国银行泉州分行', '22222222', '刘星', '36.60', '36.60', null);
INSERT INTO `bpayrow` VALUES ('28', '20', '00000', null, null, null, null, '0.00', '30.60', '运费');
INSERT INTO `bpayrow` VALUES ('72', '30', '00000', null, '建设银行南安支行', '11111111', '员工一', '2100.12', '2100.12', null);
INSERT INTO `bpayrow` VALUES ('73', '30', '00000', null, '建设银行南安支行', '22222222', '员工二', '2200.22', '2200.22', null);
INSERT INTO `bpayrow` VALUES ('74', '30', '00000', null, '建设银行南安支行', '33333333', '员工三', '1000.00', '1000.00', null);
INSERT INTO `bpayrow` VALUES ('80', '31', '6227001823550092014', '4', '建设银行泉州分行', '1111111111', '周少华', '1560.46', '1560.46', null);
INSERT INTO `bpayrow` VALUES ('81', '31', '6227001823550092014', '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '9838.40', '9838.40', null);
INSERT INTO `bpayrow` VALUES ('96', '42', '622909116836651310', '9', '中国银行泉州分行', '2222222', '客户B', '12106.60', '12106.60', null);
INSERT INTO `bpayrow` VALUES ('97', '43', '622909116836651310', '7', '工商银行泉州分行', '33333333', '林长城', '321.00', '321.00', null);
INSERT INTO `bpayrow` VALUES ('98', '40', '622909116836651310', '5', '中国银行泉州分行', '22222222', '刘星', '24318.80', '24318.80', null);
INSERT INTO `bpayrow` VALUES ('100', '41', '622909116836651310', '10', '建设银行南安支行', '66666666', '物流B', '304.40', '304.40', null);
INSERT INTO `bpayrow` VALUES ('101', '38', '622909116836651310', '5', '中国银行泉州分行', '22222222', '刘星', '9440.80', '9440.80', null);
INSERT INTO `bpayrow` VALUES ('102', '39', '00000', '10', '建设银行南安支行', '66666666', '物流B', '322.00', '322.00', null);
INSERT INTO `bpayrow` VALUES ('103', '36', '00000', '9', null, null, null, '8594.60', '8594.60', null);
INSERT INTO `bpayrow` VALUES ('104', '37', '00000', '7', '工商银行泉州分行', '33333333', '林长城', '543.00', '543.00', null);
INSERT INTO `bpayrow` VALUES ('105', '34', '622909116836651310', '5', '中国银行泉州分行', '22222222', '刘星', '10260.00', '10260.00', null);
INSERT INTO `bpayrow` VALUES ('106', '32', '622909116836651310', '9', '中国银行泉州分行', '2222222', '客户B', '8170.00', '8170.00', null);
INSERT INTO `bpayrow` VALUES ('107', '24', '00000', '5', '中国银行泉州分行', '22222222', '刘星', '36.60', '36.60', null);
INSERT INTO `bpayrow` VALUES ('108', '35', '00000', '7', '工商银行泉州分行', '33333333', '林长城', '233.00', '233.00', null);
INSERT INTO `bpayrow` VALUES ('109', '33', '00000', '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '322.00', '322.00', null);
INSERT INTO `bpayrow` VALUES ('110', '25', '00000', '10', '建设银行南安支行', '66666666', '物流B', '32.00', '32.00', null);
INSERT INTO `bpayrow` VALUES ('121', '44', '622909116836651310', null, '建设银行南安支行', '11111111', '员工一', '3000.10', '3000.10', null);
INSERT INTO `bpayrow` VALUES ('122', '44', '622909116836651310', null, '建设银行南安支行', '22222222', '员工二', '4000.20', '4000.20', null);
INSERT INTO `bpayrow` VALUES ('124', '47', '00000', null, null, null, null, '2700.00', '2700.00', null);
INSERT INTO `bpayrow` VALUES ('125', '46', '622909116836651310', '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '5394.40', '5394.40', null);
INSERT INTO `bpayrow` VALUES ('126', '45', '622909116836651310', '4', '建设银行泉州分行', '1111111111', '周少华', '92.62', '92.62', null);
INSERT INTO `bpayrow` VALUES ('127', '45', '622909116836651310', '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '5394.40', '5394.40', null);
INSERT INTO `bpayrow` VALUES ('136', '48', '622909116836651310', '4', '建设银行泉州分行', '1111111111', '周少华', '484.00', '484.00', null);
INSERT INTO `bpayrow` VALUES ('137', '48', '622909116836651310', '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '2640.00', '2640.00', null);
INSERT INTO `bpayrow` VALUES ('139', '49', '622909116836651310', '5', '中国银行泉州分行', '22222222', '刘星', '22446.00', '22446.00', null);
INSERT INTO `bpayrow` VALUES ('140', '50', '622909116836651310', '7', '工商银行泉州分行', '33333333', '林长城', '465.00', '465.00', null);
INSERT INTO `bpayrow` VALUES ('141', '51', '622909116836651310', null, '建设银行南安支行', '11111111', '员工一', '1590.00', '1590.00', null);
INSERT INTO `bpayrow` VALUES ('142', '51', '622909116836651310', null, '建设银行南安支行', '22222222', '员工二', '1890.00', '1890.00', null);
INSERT INTO `bpayrow` VALUES ('148', '52', '622909116836651310', null, '建设银行南安支行', '11111111', '员工一', '1484.00', '1484.00', null);
INSERT INTO `bpayrow` VALUES ('149', '52', '622909116836651310', null, '建设银行南安支行', '22222222', '员工二', '1764.00', '1764.00', null);
INSERT INTO `bpayrow` VALUES ('154', '53', '6227001823550092014', '5', '中国银行泉州分行', '22222222', '刘星', '8513.92', '8513.92', null);
INSERT INTO `bpayrow` VALUES ('155', '54', '00000', '7', '工商银行泉州分行', '33333333', '林长城', '323.00', '323.00', null);
INSERT INTO `bpayrow` VALUES ('161', '55', '00000', '4', '建设银行泉州分行', '1111111111', '周少华', '220.06', '220.06', null);
INSERT INTO `bpayrow` VALUES ('162', '55', '00000', '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '4752.00', '4752.00', null);
INSERT INTO `bpayrow` VALUES ('164', '56', '00000', null, null, null, '员工三', '2250.00', '2250.00', null);
INSERT INTO `bpayrow` VALUES ('170', '57', '00000', null, '建设银行南安支行', '11111111', '员工一', '1643.00', '1643.01', null);
INSERT INTO `bpayrow` VALUES ('171', '57', '00000', null, '建设银行南安支行', '22222222', '员工二', '1953.00', '1953.03', null);
INSERT INTO `bpayrow` VALUES ('173', '58', '6227001823550092014', '5', '中国银行泉州分行', '22222222', '刘星', '1017.00', '1017.00', null);
INSERT INTO `bpayrow` VALUES ('181', '59', '622909116836651310', '4', '建设银行泉州分行', '1111111111', '周少华', '15.40', '15.40', null);
INSERT INTO `bpayrow` VALUES ('182', '59', '622909116836651310', '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '479.20', '479.20', null);
INSERT INTO `bpayrow` VALUES ('183', '60', '6227001823550092014', '9', '中国银行泉州分行', '2222222', '客户B', '847.90', '847.90', null);
INSERT INTO `bpayrow` VALUES ('187', '61', '00000', null, '建设银行南安支行', '11111111', '员工一', '1590.00', '1590.00', null);
INSERT INTO `bpayrow` VALUES ('188', '61', '00000', null, '建设银行南安支行', '22222222', '员工二', '1890.00', '1890.00', null);
INSERT INTO `bpayrow` VALUES ('189', '61', '00000', null, null, null, '员工三', '2250.00', '2250.00', null);
INSERT INTO `bpayrow` VALUES ('191', '62', '622909116836651310', '5', '中国银行泉州分行', '22222222', '刘星', '10984.90', '10984.90', null);
INSERT INTO `bpayrow` VALUES ('195', '63', '622909116836651310', '4', '建设银行泉州分行', '1111111111', '周少华', '456.84', '456.84', null);
INSERT INTO `bpayrow` VALUES ('196', '63', '622909116836651310', '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '13068.00', '13068.00', null);
INSERT INTO `bpayrow` VALUES ('204', '65', null, '4', '建设银行泉州分行', '1111111111', '周少华', '10.12', '10.12', null);
INSERT INTO `bpayrow` VALUES ('205', '65', null, '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '304.80', '304.80', null);
INSERT INTO `bpayrow` VALUES ('207', '66', null, '4', '建设银行泉州分行', '1111111111', '周少华', '10.12', '10.12', null);
INSERT INTO `bpayrow` VALUES ('208', '66', null, '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '304.80', '304.80', null);
INSERT INTO `bpayrow` VALUES ('210', '67', null, '4', '建设银行泉州分行', '1111111111', '周少华', '10.12', '10.12', null);
INSERT INTO `bpayrow` VALUES ('211', '67', null, '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '304.80', '304.80', null);
INSERT INTO `bpayrow` VALUES ('213', '64', '00000', '4', '建设银行泉州分行', '1111111111', '周少华', '10.12', '10.12', null);
INSERT INTO `bpayrow` VALUES ('214', '64', '6227001823550092014', '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '304.80', '304.80', null);
INSERT INTO `bpayrow` VALUES ('216', '68', '6227001823550092014', '9', '中国银行泉州分行', '2222222', '客户B', '535.20', '535.20', null);
INSERT INTO `bpayrow` VALUES ('222', '81', '6227001823550092014', '4', '建设银行泉州分行', '1111111111', '周少华', '4.84', '4.84', null);
INSERT INTO `bpayrow` VALUES ('223', '81', '622909116836651310', '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '391.20', '391.20', null);
INSERT INTO `bpayrow` VALUES ('226', '82', '622909116836651310', '5', '中国银行泉州分行', '22222222', '刘星', '690.90', '690.10', null);
INSERT INTO `bpayrow` VALUES ('233', '84', '6227001823550092014', null, '建设银行南安支行', '11111111', '员工一', '1537.00', '1537.40', null);
INSERT INTO `bpayrow` VALUES ('234', '84', '6227001823550092014', null, '建设银行南安支行', '22222222', '员工二', '1953.10', '1953.50', null);
INSERT INTO `bpayrow` VALUES ('235', '84', '622909116836651310', null, '兴业银行仑仓支行', '33333333', '员工三', '2250.00', '2250.60', null);

-- ----------------------------
-- Table structure for `breceandpay`
-- ----------------------------
DROP TABLE IF EXISTS `breceandpay`;
CREATE TABLE `breceandpay` (
  `receandpay` int(9) NOT NULL COMMENT '其它收支ID',
  `happendate` varchar(10) DEFAULT NULL COMMENT '发生日期',
  `bankcardid` int(9) NOT NULL COMMENT '银行卡ID',
  `receandpaytype` int(1) NOT NULL COMMENT '收支类型',
  `money` double(12,2) NOT NULL COMMENT '金额',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  `createtime` varchar(19) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`receandpay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='其它收支表';

-- ----------------------------
-- Records of breceandpay
-- ----------------------------
INSERT INTO `breceandpay` VALUES ('1', '2013-02-18', '2', '1', '50.50', '今天收入50.5元', '2013-02-18 16:28:40');
INSERT INTO `breceandpay` VALUES ('2', '2013-02-18', '1', '2', '10.50', '钱包支出10.5', '2013-02-18 16:31:01');
INSERT INTO `breceandpay` VALUES ('3', '2013-02-18', '2', '2', '50.50', '支出50.5', '2013-02-18 16:44:32');
INSERT INTO `breceandpay` VALUES ('4', '2013-07-01', '2', '1', '120000.00', '初始资金', '2014-07-12 14:01:11');
INSERT INTO `breceandpay` VALUES ('5', '2014-10-22', '1', '2', '1.22', '测试', '2014-10-22 17:24:02');
INSERT INTO `breceandpay` VALUES ('6', '2014-10-22', '1', '1', '1.22', '测试', '2014-10-22 17:24:18');
INSERT INTO `breceandpay` VALUES ('7', '2014-11-13', '1', '1', '1.00', '1', '2014-11-13 18:07:04');
INSERT INTO `breceandpay` VALUES ('87', '2014-11-26', '2', '1', '2.12', '测试收入', '2014-11-26 12:17:45');

-- ----------------------------
-- Table structure for `bsalary`
-- ----------------------------
DROP TABLE IF EXISTS `bsalary`;
CREATE TABLE `bsalary` (
  `salaryid` int(9) NOT NULL COMMENT 'ID',
  `salarytype` int(1) DEFAULT NULL COMMENT '单据类型',
  `salaryname` varchar(64) DEFAULT NULL COMMENT '工资单名称',
  `salaryno` varchar(16) NOT NULL COMMENT '工资编号',
  `salarydate` varchar(10) DEFAULT NULL COMMENT '日期',
  `currflow` varchar(32) DEFAULT NULL COMMENT '当前流程',
  `maker` varchar(32) DEFAULT NULL COMMENT '制单人',
  `createtime` varchar(19) DEFAULT NULL COMMENT '创建日期',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`salaryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bsalary
-- ----------------------------
INSERT INTO `bsalary` VALUES ('1', '1', '2013.02工资', 'GZD-2013-0001', '2013-03', '结束', 'ZHOUJD', '2013-03-11 16:04:32', '无');
INSERT INTO `bsalary` VALUES ('2', '3', '2012年终奖', 'GZD-2013-0002', '2013-02', '结束', 'ZHOUJD', '2013-03-11 16:41:27', '');
INSERT INTO `bsalary` VALUES ('7', '1', '2014年06月份工资单', 'GZD-20140728-001', '2014-06', '结束', 'ZHOUJD', '2014-07-28 21:06:51', '');
INSERT INTO `bsalary` VALUES ('8', '1', '2014年06月份工资单', 'GZD-20140728-002', '2014-06', '结束', 'ZHOUJD', '2014-07-28 22:38:07', '');
INSERT INTO `bsalary` VALUES ('9', '1', '2014年07月份工资单', 'GZD-20140820-001', '2014-07', '结束', 'ZHOUJD', '2014-08-20 15:09:27', '补发【员工三】工资');
INSERT INTO `bsalary` VALUES ('10', '1', '2014年07月份工资单', 'GZD-20140820-002', '2014-07', '结束', 'ZHOUJD', '2014-08-20 15:34:49', '');
INSERT INTO `bsalary` VALUES ('13', '1', '2014年09月份工资单', 'GZD-20141022-001', '2014-09', '结束', 'ZHOUJD', '2014-10-22 18:19:57', '');
INSERT INTO `bsalary` VALUES ('83', '1', '2014年10月份工资单', 'GZD-20141126-001', '2014-10', '结束', 'ZHOUJD', '2014-11-26 11:18:14', '');

-- ----------------------------
-- Table structure for `bsalaryrow`
-- ----------------------------
DROP TABLE IF EXISTS `bsalaryrow`;
CREATE TABLE `bsalaryrow` (
  `salaryrowid` int(9) NOT NULL AUTO_INCREMENT COMMENT '行项ID',
  `salaryid` int(9) DEFAULT NULL COMMENT '主表ID',
  `staffid` int(9) DEFAULT NULL COMMENT '员工',
  `planmoney` double(12,2) DEFAULT NULL COMMENT '应付款',
  `remarkrow` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`salaryrowid`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bsalaryrow
-- ----------------------------
INSERT INTO `bsalaryrow` VALUES ('28', '1', '2', '2100.12', '员工一工资');
INSERT INTO `bsalaryrow` VALUES ('29', '1', '3', '2200.22', '员工二工资');
INSERT INTO `bsalaryrow` VALUES ('30', '1', '4', '1000.00', '员工三工资');
INSERT INTO `bsalaryrow` VALUES ('40', '2', '2', '3000.10', null);
INSERT INTO `bsalaryrow` VALUES ('41', '2', '3', '4000.20', null);
INSERT INTO `bsalaryrow` VALUES ('52', '5', '2', '0.00', null);
INSERT INTO `bsalaryrow` VALUES ('53', '5', '3', '63.00', null);
INSERT INTO `bsalaryrow` VALUES ('68', '7', '2', '1590.00', null);
INSERT INTO `bsalaryrow` VALUES ('69', '7', '3', '1890.00', null);
INSERT INTO `bsalaryrow` VALUES ('72', '8', '2', '1484.00', null);
INSERT INTO `bsalaryrow` VALUES ('73', '8', '3', '1764.00', null);
INSERT INTO `bsalaryrow` VALUES ('75', '9', '5', '2250.00', null);
INSERT INTO `bsalaryrow` VALUES ('78', '10', '2', '1643.00', null);
INSERT INTO `bsalaryrow` VALUES ('79', '10', '3', '1953.00', null);
INSERT INTO `bsalaryrow` VALUES ('92', '13', '2', '1590.00', null);
INSERT INTO `bsalaryrow` VALUES ('93', '13', '3', '1890.00', null);
INSERT INTO `bsalaryrow` VALUES ('94', '13', '5', '2250.00', null);
INSERT INTO `bsalaryrow` VALUES ('101', '83', '2', '1537.00', null);
INSERT INTO `bsalaryrow` VALUES ('102', '83', '3', '1953.10', null);
INSERT INTO `bsalaryrow` VALUES ('103', '83', '5', '2250.00', null);

-- ----------------------------
-- Table structure for `bsell`
-- ----------------------------
DROP TABLE IF EXISTS `bsell`;
CREATE TABLE `bsell` (
  `sellid` int(7) NOT NULL COMMENT '销售单ID',
  `sellno` varchar(16) NOT NULL COMMENT '销售单编号',
  `selldate` varchar(10) DEFAULT NULL COMMENT '销售日期',
  `manuid` int(9) NOT NULL COMMENT '客户ID',
  `currflow` varchar(32) DEFAULT NULL COMMENT '当前流程',
  `maker` varchar(32) DEFAULT NULL COMMENT '制单人',
  `createtime` varchar(19) DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`sellid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='销售表';

-- ----------------------------
-- Records of bsell
-- ----------------------------
INSERT INTO `bsell` VALUES ('2', 'XSD-2013-0001', '2013-03-06', '5', '结束', 'ZHOUJD', '2013-03-06 17:32:44', '备注');
INSERT INTO `bsell` VALUES ('3', 'XSD-2014-0001', '2014-07-13', '9', '结束', 'ZHOUJD', '2014-07-13 16:13:58', '');
INSERT INTO `bsell` VALUES ('4', 'XSD-2014-0002', '2014-07-01', '5', '结束', 'ZHOUJD', '2014-07-13 16:14:35', '');
INSERT INTO `bsell` VALUES ('5', 'XSD-2014-0003', '2014-06-02', '5', '结束', 'ZHOUJD', '2014-07-13 16:15:17', '');
INSERT INTO `bsell` VALUES ('6', 'XSD-2014-0004', '2014-06-12', '9', '结束', 'ZHOUJD', '2014-07-13 16:16:21', '');
INSERT INTO `bsell` VALUES ('7', 'XSD-2014-0005', '2014-04-02', '5', '结束', 'ZHOUJD', '2014-07-13 16:16:52', '');
INSERT INTO `bsell` VALUES ('8', 'XSD-2014-0006', '2014-03-12', '5', '结束', 'ZHOUJD', '2014-07-13 16:17:13', '');
INSERT INTO `bsell` VALUES ('10', 'XSD-2014-0007', '2014-07-18', '5', '结束', 'ZHOUJD', '2014-07-18 19:08:31', '');
INSERT INTO `bsell` VALUES ('11', 'XSD-20140820-001', '2014-08-20', '5', '结束', 'ZHOUJD', '2014-08-20 11:14:34', '');
INSERT INTO `bsell` VALUES ('12', 'XSD-20140828-001', '2014-08-28', '5', '结束', 'ZHOUJD', '2014-08-28 11:50:07', '');
INSERT INTO `bsell` VALUES ('13', 'XSD-20140828-002', '2014-08-28', '9', '结束', 'ZHOUJD', '2014-08-28 15:53:20', '');
INSERT INTO `bsell` VALUES ('14', 'XSD-20140925-001', '2014-09-25', '5', '结束', 'ZHOUJD', '2014-09-25 16:44:19', '');
INSERT INTO `bsell` VALUES ('15', 'XSD-20141114-001', '2014-11-14', '9', '结束', 'ZHOUJD', '2014-11-14 10:23:17', '');
INSERT INTO `bsell` VALUES ('38', 'XSD-20141118-001', '2014-11-18', '5', '结束', 'ZHOUJD', '2014-11-18 15:14:37', '');

-- ----------------------------
-- Table structure for `bsellrow`
-- ----------------------------
DROP TABLE IF EXISTS `bsellrow`;
CREATE TABLE `bsellrow` (
  `sellrowid` int(7) NOT NULL AUTO_INCREMENT COMMENT '销售行项ID',
  `sellid` int(7) NOT NULL COMMENT '销售单ID',
  `productid` int(5) DEFAULT NULL COMMENT '产品编码',
  `productname` varchar(64) NOT NULL COMMENT '产品名称',
  `unit` int(3) DEFAULT NULL COMMENT '计量单位',
  `costprice` double(12,2) DEFAULT '0.00' COMMENT '成本单价',
  `planprice` double(12,2) DEFAULT '0.00' COMMENT '预算单价',
  `realprice` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '实际单价',
  `num` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '销售数量',
  `profit` double(12,2) DEFAULT '0.00' COMMENT '利润',
  `realsum` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '实际总价',
  `remarkrow` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`sellrowid`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8 COMMENT='销售行项表';

-- ----------------------------
-- Records of bsellrow
-- ----------------------------
INSERT INTO `bsellrow` VALUES ('18', '2', '1', '产品1', '2', '113.80', '12.20', '12.20', '1.00', '-101.60', '12.20', null);
INSERT INTO `bsellrow` VALUES ('19', '2', '1', '产品1', '2', '113.80', '12.20', '12.20', '2.00', '-101.60', '24.40', null);
INSERT INTO `bsellrow` VALUES ('33', '8', '2', '产品2', '1', '170.44', '190.00', '190.00', '43.00', '19.56', '8170.00', null);
INSERT INTO `bsellrow` VALUES ('34', '7', '2', '产品2', '1', '170.44', '190.00', '190.00', '54.00', '19.56', '10260.00', null);
INSERT INTO `bsellrow` VALUES ('35', '6', '2', '产品2', '1', '170.44', '190.00', '190.00', '21.00', '19.56', '3990.00', null);
INSERT INTO `bsellrow` VALUES ('36', '6', '3', '产品3', '1', '163.40', '200.20', '200.20', '23.00', '36.80', '4604.60', null);
INSERT INTO `bsellrow` VALUES ('37', '5', '1', '产品1', '2', '113.80', '120.00', '120.00', '53.00', '6.20', '6360.00', null);
INSERT INTO `bsellrow` VALUES ('38', '5', '2', '产品2', '1', '170.44', '190.00', '190.00', '12.00', '19.56', '2280.00', null);
INSERT INTO `bsellrow` VALUES ('39', '5', '3', '产品3', '1', '163.40', '200.20', '200.20', '4.00', '36.80', '800.80', null);
INSERT INTO `bsellrow` VALUES ('40', '4', '2', '产品2', '1', '170.44', '190.00', '190.00', '33.00', '19.56', '6270.00', null);
INSERT INTO `bsellrow` VALUES ('41', '4', '3', '产品3', '1', '163.40', '200.20', '200.20', '44.00', '36.80', '8808.80', null);
INSERT INTO `bsellrow` VALUES ('42', '4', '1', '产品1', '2', '113.80', '120.00', '120.00', '77.00', '6.20', '9240.00', null);
INSERT INTO `bsellrow` VALUES ('43', '3', '1', '产品1', '2', '113.80', '120.00', '120.00', '11.00', '6.20', '1320.00', null);
INSERT INTO `bsellrow` VALUES ('44', '3', '2', '产品2', '1', '170.44', '190.00', '190.00', '22.00', '19.56', '4180.00', null);
INSERT INTO `bsellrow` VALUES ('45', '3', '3', '产品3', '1', '163.40', '200.20', '200.20', '33.00', '36.80', '6606.60', null);
INSERT INTO `bsellrow` VALUES ('123', '10', '2', '产品2', '1', '170.44', '190.00', '190.00', '60.00', '19.56', '11400.00', null);
INSERT INTO `bsellrow` VALUES ('124', '10', '3', '产品3', '1', '163.40', '200.20', '200.20', '30.00', '36.80', '6006.00', null);
INSERT INTO `bsellrow` VALUES ('125', '10', '1', '产品1', '2', '113.80', '120.00', '120.00', '42.00', '6.20', '5040.00', null);
INSERT INTO `bsellrow` VALUES ('130', '11', '1', '产品1', '1', '113.80', '123.20', '123.21', '22.00', '9.41', '2710.62', null);
INSERT INTO `bsellrow` VALUES ('131', '11', '2', '产品2', '1', '170.44', '200.50', '200.50', '24.00', '30.06', '4812.00', null);
INSERT INTO `bsellrow` VALUES ('132', '11', '5', '产品8', '1', '33.30', '43.10', '43.10', '23.00', '9.80', '991.30', null);
INSERT INTO `bsellrow` VALUES ('147', '12', '1', '产品1', '1', '113.80', '123.20', '123.20', '5.00', '9.40', '616.00', null);
INSERT INTO `bsellrow` VALUES ('148', '12', '2', '产品2', '1', '170.44', '200.50', '200.50', '2.00', '30.06', '401.00', null);
INSERT INTO `bsellrow` VALUES ('161', '13', '1', '产品1', '1', '47.64', '123.20', '123.20', '2.00', '75.56', '246.40', null);
INSERT INTO `bsellrow` VALUES ('162', '13', '2', '产品2', '1', '190.24', '200.50', '200.50', '3.00', '10.26', '601.50', null);
INSERT INTO `bsellrow` VALUES ('178', '14', '1', '产品1', '1', '47.64', '123.20', '123.20', '22.00', '75.56', '2710.40', null);
INSERT INTO `bsellrow` VALUES ('179', '14', '2', '产品2', '1', '190.24', '200.50', '200.50', '21.00', '10.26', '4210.50', null);
INSERT INTO `bsellrow` VALUES ('180', '14', '3', '产品3', '1', '163.40', '203.20', '203.20', '20.00', '39.80', '4064.00', null);
INSERT INTO `bsellrow` VALUES ('185', '15', '1', '产品1', '1', '47.64', '123.20', '124.20', '1.00', '76.56', '124.20', null);
INSERT INTO `bsellrow` VALUES ('186', '15', '2', '产品2', '1', '190.24', '200.50', '205.50', '2.00', '15.26', '411.00', null);
INSERT INTO `bsellrow` VALUES ('208', '38', '2', '产品2', '1', '190.24', '200.50', '200.50', '1.00', '10.26', '200.50', null);
INSERT INTO `bsellrow` VALUES ('209', '38', '3', '产品3', '1', '163.40', '203.20', '203.20', '2.00', '39.80', '406.40', null);
INSERT INTO `bsellrow` VALUES ('210', '38', '80', '树叶淋浴', '1', '32.00', '42.00', '42.00', '2.00', '10.00', '84.00', null);

-- ----------------------------
-- Table structure for `btransferaccount`
-- ----------------------------
DROP TABLE IF EXISTS `btransferaccount`;
CREATE TABLE `btransferaccount` (
  `transferaccountid` int(9) NOT NULL COMMENT '内部转账ID',
  `bankcardid` int(9) DEFAULT NULL COMMENT '银行卡ID',
  `transferbankcardid` int(9) DEFAULT NULL COMMENT '转入账号',
  `transfermoney` double(12,2) DEFAULT NULL COMMENT '转入金额',
  `transferremark` varchar(512) DEFAULT NULL COMMENT '转入备注',
  `createtime` varchar(19) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`transferaccountid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='内部转账表';

-- ----------------------------
-- Records of btransferaccount
-- ----------------------------
INSERT INTO `btransferaccount` VALUES ('6', '2', '1', '20.50', '转入钱包', '2013-02-17 16:19:44');
INSERT INTO `btransferaccount` VALUES ('7', '2', '1', '21.50', null, '2013-02-17 17:00:39');
INSERT INTO `btransferaccount` VALUES ('8', '2', '1', '8.00', '转入钱包', '2013-02-17 17:02:56');
INSERT INTO `btransferaccount` VALUES ('9', '2', '1', '50000.00', '转到现金', '2014-08-20 14:59:00');
INSERT INTO `btransferaccount` VALUES ('10', '1', '2', '1.00', '测试', '2014-10-22 17:21:47');
INSERT INTO `btransferaccount` VALUES ('11', '1', '2', '1.00', '测试', '2014-10-22 17:22:11');
INSERT INTO `btransferaccount` VALUES ('12', '1', '2', '2.00', '测试用', '2014-11-17 21:25:15');
INSERT INTO `btransferaccount` VALUES ('85', '2', '3', '1.23', '测试转入', '2014-11-26 11:47:39');

-- ----------------------------
-- Table structure for `bwork`
-- ----------------------------
DROP TABLE IF EXISTS `bwork`;
CREATE TABLE `bwork` (
  `workid` int(9) NOT NULL AUTO_INCREMENT,
  `workmonth` varchar(7) NOT NULL COMMENT '月份',
  `staffid` int(9) DEFAULT NULL COMMENT '员工ID',
  PRIMARY KEY (`workid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bwork
-- ----------------------------
INSERT INTO `bwork` VALUES ('1', '2014-07', '2');
INSERT INTO `bwork` VALUES ('2', '2014-07', '3');
INSERT INTO `bwork` VALUES ('3', '2014-06', '2');
INSERT INTO `bwork` VALUES ('4', '2014-06', '3');
INSERT INTO `bwork` VALUES ('5', '2014-08', '2');
INSERT INTO `bwork` VALUES ('6', '2014-08', '3');
INSERT INTO `bwork` VALUES ('7', '2014-08', '5');
INSERT INTO `bwork` VALUES ('8', '2014-07', '5');
INSERT INTO `bwork` VALUES ('9', '2014-10', '2');
INSERT INTO `bwork` VALUES ('10', '2014-10', '3');
INSERT INTO `bwork` VALUES ('11', '2014-10', '5');
INSERT INTO `bwork` VALUES ('12', '2014-09', '2');
INSERT INTO `bwork` VALUES ('13', '2014-09', '3');
INSERT INTO `bwork` VALUES ('14', '2014-09', '5');
INSERT INTO `bwork` VALUES ('15', '2014-11', '2');
INSERT INTO `bwork` VALUES ('16', '2014-11', '3');
INSERT INTO `bwork` VALUES ('17', '2014-11', '5');

-- ----------------------------
-- Table structure for `bworkrow`
-- ----------------------------
DROP TABLE IF EXISTS `bworkrow`;
CREATE TABLE `bworkrow` (
  `workrowid` int(9) NOT NULL AUTO_INCREMENT COMMENT '考勤从表ID',
  `workid` int(9) NOT NULL COMMENT '考勤主表ID',
  `workdate` varchar(10) NOT NULL COMMENT '考勤日期',
  `starttime` varchar(19) DEFAULT NULL COMMENT '上班时间',
  `endtime` varchar(19) DEFAULT NULL COMMENT '下班时间',
  `workstatus` int(2) DEFAULT NULL COMMENT '考勤状态',
  `salary` double(12,2) DEFAULT NULL COMMENT '增减工资',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`workrowid`)
) ENGINE=InnoDB AUTO_INCREMENT=75967 DEFAULT CHARSET=utf8 COMMENT='考勤表';

-- ----------------------------
-- Records of bworkrow
-- ----------------------------
INSERT INTO `bworkrow` VALUES ('74988', '2', '2014-07-01', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('74989', '2', '2014-07-02', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('74990', '2', '2014-07-03', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('74991', '2', '2014-07-04', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('74992', '2', '2014-07-05', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('74993', '2', '2014-07-06', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('74994', '2', '2014-07-07', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('74995', '2', '2014-07-08', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('74996', '2', '2014-07-09', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('74997', '2', '2014-07-10', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('74998', '2', '2014-07-11', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('74999', '2', '2014-07-12', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75000', '2', '2014-07-13', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75001', '2', '2014-07-14', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75002', '2', '2014-07-15', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75003', '2', '2014-07-16', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75004', '2', '2014-07-17', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75005', '2', '2014-07-18', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75006', '2', '2014-07-19', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75007', '2', '2014-07-20', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75008', '2', '2014-07-21', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75009', '2', '2014-07-22', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75010', '2', '2014-07-23', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75011', '2', '2014-07-24', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75012', '2', '2014-07-25', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75013', '2', '2014-07-26', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75014', '2', '2014-07-27', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75015', '2', '2014-07-28', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75016', '2', '2014-07-29', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75017', '2', '2014-07-30', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75018', '2', '2014-07-31', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75141', '3', '2014-06-01', null, null, null, '0.00', null);
INSERT INTO `bworkrow` VALUES ('75142', '3', '2014-06-02', null, null, null, '0.00', null);
INSERT INTO `bworkrow` VALUES ('75143', '3', '2014-06-03', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75144', '3', '2014-06-04', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75145', '3', '2014-06-05', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75146', '3', '2014-06-06', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75147', '3', '2014-06-07', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75148', '3', '2014-06-08', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75149', '3', '2014-06-09', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75150', '3', '2014-06-10', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75151', '3', '2014-06-11', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75152', '3', '2014-06-12', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75153', '3', '2014-06-13', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75154', '3', '2014-06-14', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75155', '3', '2014-06-15', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75156', '3', '2014-06-16', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75157', '3', '2014-06-17', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75158', '3', '2014-06-18', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75159', '3', '2014-06-19', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75160', '3', '2014-06-20', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75161', '3', '2014-06-21', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75162', '3', '2014-06-22', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75163', '3', '2014-06-23', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75164', '3', '2014-06-24', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75165', '3', '2014-06-25', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75166', '3', '2014-06-26', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75167', '3', '2014-06-27', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75168', '3', '2014-06-28', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75169', '3', '2014-06-29', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75170', '3', '2014-06-30', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75171', '4', '2014-06-01', null, null, null, '0.00', null);
INSERT INTO `bworkrow` VALUES ('75172', '4', '2014-06-02', null, null, null, '0.00', null);
INSERT INTO `bworkrow` VALUES ('75173', '4', '2014-06-03', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75174', '4', '2014-06-04', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75175', '4', '2014-06-05', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75176', '4', '2014-06-06', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75177', '4', '2014-06-07', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75178', '4', '2014-06-08', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75179', '4', '2014-06-09', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75180', '4', '2014-06-10', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75181', '4', '2014-06-11', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75182', '4', '2014-06-12', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75183', '4', '2014-06-13', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75184', '4', '2014-06-14', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75185', '4', '2014-06-15', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75186', '4', '2014-06-16', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75187', '4', '2014-06-17', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75188', '4', '2014-06-18', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75189', '4', '2014-06-19', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75190', '4', '2014-06-20', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75191', '4', '2014-06-21', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75192', '4', '2014-06-22', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75193', '4', '2014-06-23', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75194', '4', '2014-06-24', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75195', '4', '2014-06-25', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75196', '4', '2014-06-26', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75197', '4', '2014-06-27', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75198', '4', '2014-06-28', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75199', '4', '2014-06-29', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75200', '4', '2014-06-30', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75201', '1', '2014-07-01', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75202', '1', '2014-07-02', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75203', '1', '2014-07-03', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75204', '1', '2014-07-04', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75205', '1', '2014-07-05', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75206', '1', '2014-07-06', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75207', '1', '2014-07-07', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75208', '1', '2014-07-08', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75209', '1', '2014-07-09', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75210', '1', '2014-07-10', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75211', '1', '2014-07-11', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75212', '1', '2014-07-12', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75213', '1', '2014-07-13', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75214', '1', '2014-07-14', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75215', '1', '2014-07-15', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75216', '1', '2014-07-16', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75217', '1', '2014-07-17', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75218', '1', '2014-07-18', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75219', '1', '2014-07-19', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75220', '1', '2014-07-20', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75221', '1', '2014-07-21', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75222', '1', '2014-07-22', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75223', '1', '2014-07-23', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75224', '1', '2014-07-24', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75225', '1', '2014-07-25', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75226', '1', '2014-07-26', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75227', '1', '2014-07-27', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75228', '1', '2014-07-28', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75229', '1', '2014-07-29', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75230', '1', '2014-07-30', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75231', '1', '2014-07-31', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75294', '5', '2014-08-01', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75295', '5', '2014-08-02', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75296', '5', '2014-08-03', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75297', '5', '2014-08-04', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75298', '5', '2014-08-05', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75299', '5', '2014-08-06', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75300', '5', '2014-08-07', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75301', '5', '2014-08-08', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75302', '5', '2014-08-09', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75303', '5', '2014-08-10', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75304', '5', '2014-08-11', null, null, null, '53.00', null);
INSERT INTO `bworkrow` VALUES ('75305', '5', '2014-08-12', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75306', '5', '2014-08-13', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75307', '5', '2014-08-14', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75308', '5', '2014-08-15', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75309', '5', '2014-08-16', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75310', '5', '2014-08-17', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75311', '5', '2014-08-18', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75312', '5', '2014-08-19', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75313', '5', '2014-08-20', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75314', '5', '2014-08-21', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75315', '5', '2014-08-22', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75316', '5', '2014-08-23', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75317', '5', '2014-08-24', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75318', '5', '2014-08-25', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75319', '5', '2014-08-26', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75320', '5', '2014-08-27', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75321', '5', '2014-08-28', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75322', '5', '2014-08-29', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75323', '5', '2014-08-30', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75324', '5', '2014-08-31', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75325', '6', '2014-08-01', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75326', '6', '2014-08-02', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75327', '6', '2014-08-03', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75328', '6', '2014-08-04', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75329', '6', '2014-08-05', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75330', '6', '2014-08-06', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75331', '6', '2014-08-07', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75332', '6', '2014-08-08', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75333', '6', '2014-08-09', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75334', '6', '2014-08-10', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75335', '6', '2014-08-11', null, null, null, '63.00', null);
INSERT INTO `bworkrow` VALUES ('75336', '6', '2014-08-12', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75337', '6', '2014-08-13', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75338', '6', '2014-08-14', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75339', '6', '2014-08-15', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75340', '6', '2014-08-16', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75341', '6', '2014-08-17', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75342', '6', '2014-08-18', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75343', '6', '2014-08-19', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75344', '6', '2014-08-20', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75345', '6', '2014-08-21', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75346', '6', '2014-08-22', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75347', '6', '2014-08-23', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75348', '6', '2014-08-24', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75349', '6', '2014-08-25', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75350', '6', '2014-08-26', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75351', '6', '2014-08-27', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75352', '6', '2014-08-28', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75353', '6', '2014-08-29', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75354', '6', '2014-08-30', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75355', '6', '2014-08-31', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75387', '7', '2014-08-01', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75388', '7', '2014-08-02', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75389', '7', '2014-08-03', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75390', '7', '2014-08-04', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75391', '7', '2014-08-05', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75392', '7', '2014-08-06', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75393', '7', '2014-08-07', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75394', '7', '2014-08-08', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75395', '7', '2014-08-09', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75396', '7', '2014-08-10', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75397', '7', '2014-08-11', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75398', '7', '2014-08-12', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75399', '7', '2014-08-13', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75400', '7', '2014-08-14', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75401', '7', '2014-08-15', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75402', '7', '2014-08-16', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75403', '7', '2014-08-17', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75404', '7', '2014-08-18', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75405', '7', '2014-08-19', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75406', '7', '2014-08-20', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75407', '7', '2014-08-21', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75408', '7', '2014-08-22', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75409', '7', '2014-08-23', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75410', '7', '2014-08-24', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75411', '7', '2014-08-25', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75412', '7', '2014-08-26', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75413', '7', '2014-08-27', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75414', '7', '2014-08-28', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75415', '7', '2014-08-29', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75416', '7', '2014-08-30', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75417', '7', '2014-08-31', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75449', '8', '2014-07-01', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75450', '8', '2014-07-02', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75451', '8', '2014-07-03', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75452', '8', '2014-07-04', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75453', '8', '2014-07-05', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75454', '8', '2014-07-06', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75455', '8', '2014-07-07', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75456', '8', '2014-07-08', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75457', '8', '2014-07-09', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75458', '8', '2014-07-10', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75459', '8', '2014-07-11', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75460', '8', '2014-07-12', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75461', '8', '2014-07-13', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75462', '8', '2014-07-14', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75463', '8', '2014-07-15', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75464', '8', '2014-07-16', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75465', '8', '2014-07-17', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75466', '8', '2014-07-18', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75467', '8', '2014-07-19', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75468', '8', '2014-07-20', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75469', '8', '2014-07-21', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75470', '8', '2014-07-22', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75471', '8', '2014-07-23', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75472', '8', '2014-07-24', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75473', '8', '2014-07-25', null, null, '5', null, null);
INSERT INTO `bworkrow` VALUES ('75474', '8', '2014-07-26', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75475', '8', '2014-07-27', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75476', '8', '2014-07-28', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75477', '8', '2014-07-29', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75478', '8', '2014-07-30', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75479', '8', '2014-07-31', null, null, null, '75.00', null);
INSERT INTO `bworkrow` VALUES ('75663', '12', '2014-09-01', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75664', '12', '2014-09-02', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75665', '12', '2014-09-03', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75666', '12', '2014-09-04', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75667', '12', '2014-09-05', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75668', '12', '2014-09-06', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75669', '12', '2014-09-07', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75670', '12', '2014-09-08', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75671', '12', '2014-09-09', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75672', '12', '2014-09-10', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75673', '12', '2014-09-11', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75674', '12', '2014-09-12', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75675', '12', '2014-09-13', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75676', '12', '2014-09-14', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75677', '12', '2014-09-15', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75678', '12', '2014-09-16', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75679', '12', '2014-09-17', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75680', '12', '2014-09-18', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75681', '12', '2014-09-19', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75682', '12', '2014-09-20', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75683', '12', '2014-09-21', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75684', '12', '2014-09-22', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75685', '12', '2014-09-23', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75686', '12', '2014-09-24', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75687', '12', '2014-09-25', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75688', '12', '2014-09-26', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75689', '12', '2014-09-27', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75690', '12', '2014-09-28', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75691', '12', '2014-09-29', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75692', '12', '2014-09-30', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75693', '13', '2014-09-01', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75694', '13', '2014-09-02', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75695', '13', '2014-09-03', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75696', '13', '2014-09-04', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75697', '13', '2014-09-05', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75698', '13', '2014-09-06', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75699', '13', '2014-09-07', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75700', '13', '2014-09-08', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75701', '13', '2014-09-09', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75702', '13', '2014-09-10', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75703', '13', '2014-09-11', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75704', '13', '2014-09-12', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75705', '13', '2014-09-13', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75706', '13', '2014-09-14', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75707', '13', '2014-09-15', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75708', '13', '2014-09-16', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75709', '13', '2014-09-17', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75710', '13', '2014-09-18', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75711', '13', '2014-09-19', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75712', '13', '2014-09-20', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75713', '13', '2014-09-21', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75714', '13', '2014-09-22', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75715', '13', '2014-09-23', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75716', '13', '2014-09-24', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75717', '13', '2014-09-25', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75718', '13', '2014-09-26', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75719', '13', '2014-09-27', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75720', '13', '2014-09-28', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75721', '13', '2014-09-29', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75722', '13', '2014-09-30', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75723', '14', '2014-09-01', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75724', '14', '2014-09-02', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75725', '14', '2014-09-03', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75726', '14', '2014-09-04', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75727', '14', '2014-09-05', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75728', '14', '2014-09-06', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75729', '14', '2014-09-07', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75730', '14', '2014-09-08', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75731', '14', '2014-09-09', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75732', '14', '2014-09-10', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75733', '14', '2014-09-11', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75734', '14', '2014-09-12', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75735', '14', '2014-09-13', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75736', '14', '2014-09-14', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75737', '14', '2014-09-15', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75738', '14', '2014-09-16', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75739', '14', '2014-09-17', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75740', '14', '2014-09-18', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75741', '14', '2014-09-19', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75742', '14', '2014-09-20', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75743', '14', '2014-09-21', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75744', '14', '2014-09-22', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75745', '14', '2014-09-23', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75746', '14', '2014-09-24', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75747', '14', '2014-09-25', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75748', '14', '2014-09-26', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75749', '14', '2014-09-27', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75750', '14', '2014-09-28', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75751', '14', '2014-09-29', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75752', '14', '2014-09-30', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75753', '15', '2014-11-01', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75754', '15', '2014-11-02', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75755', '15', '2014-11-03', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75756', '15', '2014-11-04', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75757', '15', '2014-11-05', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75758', '15', '2014-11-06', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75759', '15', '2014-11-07', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75760', '15', '2014-11-08', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75761', '15', '2014-11-09', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75762', '15', '2014-11-10', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75763', '15', '2014-11-11', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75764', '15', '2014-11-12', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75765', '15', '2014-11-13', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75766', '15', '2014-11-14', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75767', '15', '2014-11-15', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75768', '15', '2014-11-16', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75769', '15', '2014-11-17', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75770', '15', '2014-11-18', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75771', '15', '2014-11-19', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75772', '15', '2014-11-20', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75773', '15', '2014-11-21', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75774', '15', '2014-11-22', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75775', '15', '2014-11-23', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75776', '15', '2014-11-24', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75777', '15', '2014-11-25', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75778', '15', '2014-11-26', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75779', '15', '2014-11-27', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75780', '15', '2014-11-28', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75781', '15', '2014-11-29', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75782', '15', '2014-11-30', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75783', '16', '2014-11-01', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75784', '16', '2014-11-02', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75785', '16', '2014-11-03', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75786', '16', '2014-11-04', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75787', '16', '2014-11-05', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75788', '16', '2014-11-06', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75789', '16', '2014-11-07', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75790', '16', '2014-11-08', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75791', '16', '2014-11-09', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75792', '16', '2014-11-10', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75793', '16', '2014-11-11', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75794', '16', '2014-11-12', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75795', '16', '2014-11-13', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75796', '16', '2014-11-14', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75797', '16', '2014-11-15', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75798', '16', '2014-11-16', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75799', '16', '2014-11-17', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75800', '16', '2014-11-18', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75801', '16', '2014-11-19', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75802', '16', '2014-11-20', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75803', '16', '2014-11-21', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75804', '16', '2014-11-22', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75805', '16', '2014-11-23', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75806', '16', '2014-11-24', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75807', '16', '2014-11-25', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75808', '16', '2014-11-26', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75809', '16', '2014-11-27', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75810', '16', '2014-11-28', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75811', '16', '2014-11-29', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75812', '16', '2014-11-30', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75813', '17', '2014-11-01', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75814', '17', '2014-11-02', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75815', '17', '2014-11-03', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75816', '17', '2014-11-04', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75817', '17', '2014-11-05', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75818', '17', '2014-11-06', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75819', '17', '2014-11-07', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75820', '17', '2014-11-08', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75821', '17', '2014-11-09', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75822', '17', '2014-11-10', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75823', '17', '2014-11-11', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75824', '17', '2014-11-12', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75825', '17', '2014-11-13', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75826', '17', '2014-11-14', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75827', '17', '2014-11-15', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75828', '17', '2014-11-16', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75829', '17', '2014-11-17', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75830', '17', '2014-11-18', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75831', '17', '2014-11-19', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75832', '17', '2014-11-20', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75833', '17', '2014-11-21', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75834', '17', '2014-11-22', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75835', '17', '2014-11-23', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75836', '17', '2014-11-24', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75837', '17', '2014-11-25', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75838', '17', '2014-11-26', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75839', '17', '2014-11-27', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75840', '17', '2014-11-28', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75841', '17', '2014-11-29', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75842', '17', '2014-11-30', null, null, null, null, null);
INSERT INTO `bworkrow` VALUES ('75874', '9', '2014-10-01', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75875', '9', '2014-10-02', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75876', '9', '2014-10-03', null, null, '5', '0.00', '请假一天');
INSERT INTO `bworkrow` VALUES ('75877', '9', '2014-10-04', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75878', '9', '2014-10-05', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75879', '9', '2014-10-06', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75880', '9', '2014-10-07', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75881', '9', '2014-10-08', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75882', '9', '2014-10-09', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75883', '9', '2014-10-10', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75884', '9', '2014-10-11', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75885', '9', '2014-10-12', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75886', '9', '2014-10-13', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75887', '9', '2014-10-14', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75888', '9', '2014-10-15', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75889', '9', '2014-10-16', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75890', '9', '2014-10-17', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75891', '9', '2014-10-18', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75892', '9', '2014-10-19', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75893', '9', '2014-10-20', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75894', '9', '2014-10-21', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75895', '9', '2014-10-22', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75896', '9', '2014-10-23', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75897', '9', '2014-10-24', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75898', '9', '2014-10-25', null, null, '5', '0.00', '请假一天');
INSERT INTO `bworkrow` VALUES ('75899', '9', '2014-10-26', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75900', '9', '2014-10-27', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75901', '9', '2014-10-28', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75902', '9', '2014-10-29', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75903', '9', '2014-10-30', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75904', '9', '2014-10-31', null, null, '1', '53.00', null);
INSERT INTO `bworkrow` VALUES ('75905', '10', '2014-10-01', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75906', '10', '2014-10-02', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75907', '10', '2014-10-03', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75908', '10', '2014-10-04', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75909', '10', '2014-10-05', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75910', '10', '2014-10-06', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75911', '10', '2014-10-07', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75912', '10', '2014-10-08', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75913', '10', '2014-10-09', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75914', '10', '2014-10-10', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75915', '10', '2014-10-11', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75916', '10', '2014-10-12', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75917', '10', '2014-10-13', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75918', '10', '2014-10-14', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75919', '10', '2014-10-15', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75920', '10', '2014-10-16', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75921', '10', '2014-10-17', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75922', '10', '2014-10-18', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75923', '10', '2014-10-19', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75924', '10', '2014-10-20', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75925', '10', '2014-10-21', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75926', '10', '2014-10-22', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75927', '10', '2014-10-23', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75928', '10', '2014-10-24', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75929', '10', '2014-10-25', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75930', '10', '2014-10-26', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75931', '10', '2014-10-27', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75932', '10', '2014-10-28', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75933', '10', '2014-10-29', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75934', '10', '2014-10-30', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75935', '10', '2014-10-31', null, null, '1', '63.00', null);
INSERT INTO `bworkrow` VALUES ('75936', '11', '2014-10-01', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75937', '11', '2014-10-02', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75938', '11', '2014-10-03', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75939', '11', '2014-10-04', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75940', '11', '2014-10-05', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75941', '11', '2014-10-06', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75942', '11', '2014-10-07', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75943', '11', '2014-10-08', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75944', '11', '2014-10-09', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75945', '11', '2014-10-10', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75946', '11', '2014-10-11', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75947', '11', '2014-10-12', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75948', '11', '2014-10-13', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75949', '11', '2014-10-14', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75950', '11', '2014-10-15', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75951', '11', '2014-10-16', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75952', '11', '2014-10-17', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75953', '11', '2014-10-18', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75954', '11', '2014-10-19', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75955', '11', '2014-10-20', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75956', '11', '2014-10-21', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75957', '11', '2014-10-22', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75958', '11', '2014-10-23', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75959', '11', '2014-10-24', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75960', '11', '2014-10-25', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75961', '11', '2014-10-26', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75962', '11', '2014-10-27', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75963', '11', '2014-10-28', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75964', '11', '2014-10-29', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75965', '11', '2014-10-30', null, null, '1', '75.00', null);
INSERT INTO `bworkrow` VALUES ('75966', '11', '2014-10-31', null, null, '5', null, null);

-- ----------------------------
-- Table structure for `cdict`
-- ----------------------------
DROP TABLE IF EXISTS `cdict`;
CREATE TABLE `cdict` (
  `dictid` int(4) NOT NULL COMMENT '字典表ID',
  `dicttype` varchar(64) DEFAULT NULL COMMENT '字典类型',
  `createtime` varchar(19) DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dictid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典表';

-- ----------------------------
-- Records of cdict
-- ----------------------------
INSERT INTO `cdict` VALUES ('10', '计量单位', '2014-08-21 18:24:03', '');
INSERT INTO `cdict` VALUES ('11', '状态', '2014-08-22 11:02:27', null);
INSERT INTO `cdict` VALUES ('12', '员工状态', '2014-08-22 11:12:34', null);
INSERT INTO `cdict` VALUES ('13', '考勤状态', '2014-08-22 11:13:27', null);
INSERT INTO `cdict` VALUES ('14', '员工类别', '2014-08-22 11:24:42', null);
INSERT INTO `cdict` VALUES ('15', '工资类型', '2014-08-22 11:28:50', null);
INSERT INTO `cdict` VALUES ('16', '供应商类别', '2014-08-22 11:32:46', '');
INSERT INTO `cdict` VALUES ('17', '是否', '2014-08-22 11:37:56', null);
INSERT INTO `cdict` VALUES ('18', '收支类型', '2014-08-22 11:40:37', null);
INSERT INTO `cdict` VALUES ('19', '银行类型', '2014-08-22 12:42:18', '');
INSERT INTO `cdict` VALUES ('20', '流程状态', '2014-08-22 12:52:03', null);
INSERT INTO `cdict` VALUES ('21', '单据类型', '2014-09-01 14:24:57', '');

-- ----------------------------
-- Table structure for `cdictrow`
-- ----------------------------
DROP TABLE IF EXISTS `cdictrow`;
CREATE TABLE `cdictrow` (
  `dictrowid` int(6) NOT NULL AUTO_INCREMENT COMMENT '字典行项表ID',
  `dictid` int(4) DEFAULT NULL COMMENT '关联字典表ID',
  `dictname` varchar(256) DEFAULT NULL COMMENT '字典名称',
  `dictvalue` varchar(128) DEFAULT NULL COMMENT '字典值',
  `sordid` int(3) DEFAULT NULL COMMENT '排序',
  `rowremark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dictrowid`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8 COMMENT='字典行项表';

-- ----------------------------
-- Records of cdictrow
-- ----------------------------
INSERT INTO `cdictrow` VALUES ('27', '10', '只', '1', '1', null);
INSERT INTO `cdictrow` VALUES ('28', '10', '盒', '2', '2', null);
INSERT INTO `cdictrow` VALUES ('29', '10', '个', '3', '3', null);
INSERT INTO `cdictrow` VALUES ('30', '10', '箱', '4', '4', null);
INSERT INTO `cdictrow` VALUES ('31', '10', '件', '5', '5', null);
INSERT INTO `cdictrow` VALUES ('32', '11', '禁用', '0', '2', null);
INSERT INTO `cdictrow` VALUES ('33', '11', '可用', '1', '1', null);
INSERT INTO `cdictrow` VALUES ('34', '12', '在职', '1', '1', null);
INSERT INTO `cdictrow` VALUES ('35', '12', '离职', '2', '2', null);
INSERT INTO `cdictrow` VALUES ('36', '13', '正常', '1', '1', null);
INSERT INTO `cdictrow` VALUES ('37', '13', '迟到', '2', '2', null);
INSERT INTO `cdictrow` VALUES ('38', '13', '早退', '3', '3', null);
INSERT INTO `cdictrow` VALUES ('39', '13', '旷工', '4', '4', null);
INSERT INTO `cdictrow` VALUES ('40', '13', '请假', '5', '5', null);
INSERT INTO `cdictrow` VALUES ('41', '13', '放假', '6', '6', null);
INSERT INTO `cdictrow` VALUES ('42', '14', '正式员工', '1', '1', null);
INSERT INTO `cdictrow` VALUES ('43', '14', '临时员工', '2', '2', null);
INSERT INTO `cdictrow` VALUES ('44', '15', '工资', '1', '1', null);
INSERT INTO `cdictrow` VALUES ('45', '15', '过节费', '2', '2', null);
INSERT INTO `cdictrow` VALUES ('46', '15', '年终奖', '3', '3', null);
INSERT INTO `cdictrow` VALUES ('50', '16', '供应商', '1', '1', null);
INSERT INTO `cdictrow` VALUES ('51', '16', '客户', '2', '2', null);
INSERT INTO `cdictrow` VALUES ('52', '16', '物流', '3', '3', null);
INSERT INTO `cdictrow` VALUES ('53', '17', '是', '1', '1', null);
INSERT INTO `cdictrow` VALUES ('54', '17', '否', '0', '2', null);
INSERT INTO `cdictrow` VALUES ('55', '18', '收入', '1', '1', null);
INSERT INTO `cdictrow` VALUES ('56', '18', '支出', '2', '2', null);
INSERT INTO `cdictrow` VALUES ('78', '20', '申请', '申请', '1', null);
INSERT INTO `cdictrow` VALUES ('79', '20', '结束', '结束', '2', null);
INSERT INTO `cdictrow` VALUES ('98', '19', '中国建设银行', '1', '1', null);
INSERT INTO `cdictrow` VALUES ('99', '19', '中国工商银行', '2', '2', null);
INSERT INTO `cdictrow` VALUES ('100', '19', '中国银行', '3', '3', null);
INSERT INTO `cdictrow` VALUES ('101', '19', '中国农业银行', '4', '4', null);
INSERT INTO `cdictrow` VALUES ('102', '19', '招商银行', '5', '5', null);
INSERT INTO `cdictrow` VALUES ('103', '19', '兴业银行', '6', '6', null);
INSERT INTO `cdictrow` VALUES ('104', '19', '其它', '9', '9', null);
INSERT INTO `cdictrow` VALUES ('105', '21', '采购单', 'CGD', '1', null);
INSERT INTO `cdictrow` VALUES ('106', '21', '产品单', 'CPD', '2', null);
INSERT INTO `cdictrow` VALUES ('107', '21', '付款单', 'FKD', '3', null);
INSERT INTO `cdictrow` VALUES ('108', '21', '工资单', 'GZD', '4', null);
INSERT INTO `cdictrow` VALUES ('109', '21', '简易采购单', 'JYD', '5', null);
INSERT INTO `cdictrow` VALUES ('110', '21', '收款单', 'SKD', '6', null);
INSERT INTO `cdictrow` VALUES ('111', '21', '物资单', 'WZD', '7', null);
INSERT INTO `cdictrow` VALUES ('112', '21', '销售单', 'XSD', '8', null);
INSERT INTO `cdictrow` VALUES ('113', '21', '运费单', 'YFD', '9', null);

-- ----------------------------
-- Table structure for `cseq`
-- ----------------------------
DROP TABLE IF EXISTS `cseq`;
CREATE TABLE `cseq` (
  `seq` int(9) DEFAULT NULL COMMENT '序列值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='序列';

-- ----------------------------
-- Records of cseq
-- ----------------------------
INSERT INTO `cseq` VALUES ('87');

-- ----------------------------
-- Table structure for `sbankcard`
-- ----------------------------
DROP TABLE IF EXISTS `sbankcard`;
CREATE TABLE `sbankcard` (
  `bankcardid` int(9) NOT NULL AUTO_INCREMENT COMMENT '银行卡ID',
  `bankcardno` varchar(32) NOT NULL COMMENT '银行卡卡号',
  `bankname` varchar(64) DEFAULT NULL COMMENT '开户银行名称',
  `banktype` int(2) DEFAULT NULL COMMENT '银行类型',
  `accountname` varchar(64) DEFAULT NULL COMMENT '账户名称',
  `money` double(12,2) DEFAULT NULL COMMENT '金额',
  `status` int(1) DEFAULT NULL COMMENT '是否可用',
  `priority` int(2) DEFAULT '0' COMMENT '优先级',
  `remark` varchar(512) NOT NULL COMMENT '备注',
  `changetype` varchar(20) DEFAULT NULL COMMENT '更改类型',
  `changeid` int(9) DEFAULT NULL COMMENT '更改相关ID',
  PRIMARY KEY (`bankcardid`,`bankcardno`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='银行卡管理表';

-- ----------------------------
-- Records of sbankcard
-- ----------------------------
INSERT INTO `sbankcard` VALUES ('1', '00000', '现金', '9', '现金', '42695.32', '1', '1', '此为现金', 'btransferaccount', '11');
INSERT INTO `sbankcard` VALUES ('2', '6227001823550092014', '建设银行福州支行', '2', '林珊珊', '65851.25', '1', '2', '', 'breceandpay', '87');
INSERT INTO `sbankcard` VALUES ('3', '622909116836651310', '兴业银行福州支行', '6', '王建辉', '53133.07', '1', '3', '', 'btransferaccount', '85');

-- ----------------------------
-- Table structure for `sbankcard_log`
-- ----------------------------
DROP TABLE IF EXISTS `sbankcard_log`;
CREATE TABLE `sbankcard_log` (
  `logid` int(9) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `bankcardid` int(9) DEFAULT NULL COMMENT '银行卡ID',
  `oldmoney` double(12,2) DEFAULT NULL COMMENT '更改前金额',
  `newmoney` double(12,2) DEFAULT NULL COMMENT '更改后金额',
  `changemoney` double(12,2) DEFAULT NULL COMMENT '交易金额',
  `changetime` datetime DEFAULT NULL COMMENT '更改时间',
  `changetype` varchar(20) DEFAULT NULL COMMENT '更改类型',
  `changeid` int(9) DEFAULT NULL COMMENT '更改相关ID',
  PRIMARY KEY (`logid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='银行卡更改日志表';

-- ----------------------------
-- Records of sbankcard_log
-- ----------------------------
INSERT INTO `sbankcard_log` VALUES ('5', '1', '42706.44', '42707.44', '-1.00', '2014-11-13 18:07:04', 'breceandpay', '7');
INSERT INTO `sbankcard_log` VALUES ('6', '1', '42707.44', '42697.32', '10.12', '2014-11-14 10:39:03', 'bpayrow', '213');
INSERT INTO `sbankcard_log` VALUES ('7', '2', '69113.70', '68808.90', '304.80', '2014-11-14 10:39:03', 'bpayrow', '214');
INSERT INTO `sbankcard_log` VALUES ('8', '2', '68808.90', '69344.10', '-535.20', '2014-11-14 18:01:46', 'bpayrow', '216');
INSERT INTO `sbankcard_log` VALUES ('9', '1', '42697.32', '42695.32', '2.00', '2014-11-17 21:25:15', 'btransferaccount', '12');
INSERT INTO `sbankcard_log` VALUES ('10', '2', '69344.10', '69346.10', '-2.00', '2014-11-17 21:25:15', 'btransferaccount', '12');
INSERT INTO `sbankcard_log` VALUES ('11', '2', '69346.10', '69341.26', '4.84', '2014-11-26 11:01:23', 'bpayrow', '222');
INSERT INTO `sbankcard_log` VALUES ('12', '3', '55083.54', '54692.34', '391.20', '2014-11-26 11:01:23', 'bpayrow', '223');
INSERT INTO `sbankcard_log` VALUES ('13', '3', '54692.34', '55382.44', '-690.10', '2014-11-26 11:11:15', 'bpayrow', '226');
INSERT INTO `sbankcard_log` VALUES ('14', '2', '69341.26', '67803.86', '1537.40', '2014-11-26 11:28:11', 'bpayrow', '233');
INSERT INTO `sbankcard_log` VALUES ('15', '2', '67803.86', '65850.36', '1953.50', '2014-11-26 11:28:11', 'bpayrow', '234');
INSERT INTO `sbankcard_log` VALUES ('16', '3', '55382.44', '53131.84', '2250.60', '2014-11-26 11:28:11', 'bpayrow', '235');
INSERT INTO `sbankcard_log` VALUES ('17', '2', '65850.36', '65849.13', '1.23', '2014-11-26 11:47:39', 'btransferaccount', '85');
INSERT INTO `sbankcard_log` VALUES ('18', '3', '53131.84', '53133.07', '-1.23', '2014-11-26 11:47:39', 'btransferaccount', '85');
INSERT INTO `sbankcard_log` VALUES ('19', '2', '65849.13', '65851.25', '-2.12', '2014-11-26 12:17:45', 'breceandpay', '87');
INSERT INTO `sbankcard_log` VALUES ('20', '1', '42695.32', '42695.32', '0.00', '2014-11-26 14:34:39', 'btransferaccount', '11');

-- ----------------------------
-- Table structure for `scompany`
-- ----------------------------
DROP TABLE IF EXISTS `scompany`;
CREATE TABLE `scompany` (
  `companyid` int(2) NOT NULL AUTO_INCREMENT COMMENT '公司编号',
  `companyname` varchar(64) DEFAULT NULL COMMENT '公司名称',
  `contact` varchar(32) DEFAULT NULL COMMENT '联系人',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `fax` varchar(32) DEFAULT NULL COMMENT '传真',
  `tel` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `zip` varchar(6) DEFAULT NULL COMMENT '邮政编码',
  `email` varchar(32) DEFAULT NULL COMMENT '电子邮箱',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`companyid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='公司信息';

-- ----------------------------
-- Records of scompany
-- ----------------------------
INSERT INTO `scompany` VALUES ('1', '岐盛', '周坚定', '福建南安', '059586211111', '059586211111', '362300', 'zjdxxxx@163.com', '这是一家好公司');

-- ----------------------------
-- Table structure for `sfile`
-- ----------------------------
DROP TABLE IF EXISTS `sfile`;
CREATE TABLE `sfile` (
  `fileid` int(9) NOT NULL COMMENT '文件ID',
  `pid` int(9) DEFAULT NULL COMMENT '关联ID',
  `btype` varchar(32) DEFAULT NULL COMMENT '类型',
  `filename` varchar(128) DEFAULT NULL COMMENT '文件名',
  `suffix` varchar(8) DEFAULT NULL COMMENT '后缀名',
  `createuser` varchar(64) DEFAULT NULL COMMENT '创建人',
  `createtime` varchar(20) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`fileid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文件表';

-- ----------------------------
-- Records of sfile
-- ----------------------------

-- ----------------------------
-- Table structure for `slog`
-- ----------------------------
DROP TABLE IF EXISTS `slog`;
CREATE TABLE `slog` (
  `logid` int(9) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `logtype` varchar(20) NOT NULL COMMENT '操作类型',
  `operater` varchar(64) NOT NULL COMMENT '操作人ID',
  `operatetime` varchar(20) NOT NULL COMMENT '操作时间',
  `remark` text COMMENT '备注',
  PRIMARY KEY (`logid`)
) ENGINE=InnoDB AUTO_INCREMENT=464 DEFAULT CHARSET=utf8 COMMENT='日志表';

-- ----------------------------
-- Records of slog
-- ----------------------------
INSERT INTO `slog` VALUES ('1', '登录', 'ZHOUJD', '2014-07-29 17:25:37', null);
INSERT INTO `slog` VALUES ('2', '登录', 'ZHOUJD', '2014-07-29 18:58:59', null);
INSERT INTO `slog` VALUES ('3', '登录', 'LINCC', '2014-07-29 18:58:59', null);
INSERT INTO `slog` VALUES ('4', '登录', 'ZHOUJD', '2014-07-29 18:58:59', null);
INSERT INTO `slog` VALUES ('5', '登录', 'ZH112014', '2014-07-29 18:58:59', null);
INSERT INTO `slog` VALUES ('6', '登录', 'ZHOUJD', '2014-07-29 18:58:59', null);
INSERT INTO `slog` VALUES ('7', '登录', 'ZH112014', '2014-07-29 18:58:59', null);
INSERT INTO `slog` VALUES ('8', '登录', 'ZHOUJD', '2014-07-29 18:58:59', null);
INSERT INTO `slog` VALUES ('9', '登录', 'ZHOUJD', '2014-07-30 10:51:09', null);
INSERT INTO `slog` VALUES ('10', '登录', 'ZHOUJD', '2014-07-30 11:42:53', null);
INSERT INTO `slog` VALUES ('11', '登录', 'ZHOUJD', '2014-07-30 12:33:09', null);
INSERT INTO `slog` VALUES ('12', '登录', 'ZHOUJD', '2014-07-31 09:39:46', null);
INSERT INTO `slog` VALUES ('13', '登录', 'ZHOUJD', '2014-07-31 09:39:46', null);
INSERT INTO `slog` VALUES ('14', '登录', 'ZHOUJD', '2014-07-31 09:39:46', null);
INSERT INTO `slog` VALUES ('15', '登录', 'ZHOUJD', '2014-07-31 09:39:46', null);
INSERT INTO `slog` VALUES ('16', '登录', 'ZHOUJD', '2014-08-10 21:15:34', null);
INSERT INTO `slog` VALUES ('17', '登录', 'ZHOUJD', '2014-08-10 21:15:34', null);
INSERT INTO `slog` VALUES ('18', '登录', 'ZHOUJD', '2014-08-11 08:37:20', null);
INSERT INTO `slog` VALUES ('19', '登录', 'ZHOUJD', '2014-08-11 08:37:20', null);
INSERT INTO `slog` VALUES ('20', '登录', 'ZHOUJD', '2014-08-11 14:57:24', null);
INSERT INTO `slog` VALUES ('21', '登录', 'ZHOUJD', '2014-08-11 14:57:24', null);
INSERT INTO `slog` VALUES ('22', '登录', 'ZHOUJD', '2014-08-11 14:57:24', null);
INSERT INTO `slog` VALUES ('23', '登录', 'ZHOUJD', '2014-08-11 14:57:24', null);
INSERT INTO `slog` VALUES ('24', '登录', 'ZHOUJD', '2014-08-11 14:57:24', null);
INSERT INTO `slog` VALUES ('25', '登录', 'ZHOUJD', '2014-08-11 14:57:24', null);
INSERT INTO `slog` VALUES ('26', '登录', 'ZHOUJD', '2014-08-12 14:34:18', null);
INSERT INTO `slog` VALUES ('27', '登录', 'ZHOUJD', '2014-08-12 14:34:18', null);
INSERT INTO `slog` VALUES ('28', '登录', 'ZHOUJD', '2014-08-12 14:34:18', null);
INSERT INTO `slog` VALUES ('29', '登录', 'ZHOUJD', '2014-08-12 14:34:18', null);
INSERT INTO `slog` VALUES ('30', '登录', 'ZHOUJD', '2014-08-12 15:01:00', null);
INSERT INTO `slog` VALUES ('31', '登录', 'ZHOUJD', '2014-08-12 18:08:21', null);
INSERT INTO `slog` VALUES ('32', '登录', 'ZHOUJD', '2014-08-13 15:57:57', null);
INSERT INTO `slog` VALUES ('33', '登录', 'ZHOUJD', '2014-08-13 15:57:57', null);
INSERT INTO `slog` VALUES ('34', '登录', 'ZHOUJD', '2014-08-13 15:57:57', null);
INSERT INTO `slog` VALUES ('35', '登录', 'ZHOUJD', '2014-08-13 17:04:07', null);
INSERT INTO `slog` VALUES ('38', '修改银行卡', 'ZHOUJD', '2014-08-13 17:04:07', 'bankcardno:00000,accountname:钱包,status:1,remark:此为钱包,bankname:无,priority:1,banktype:99,money:9579.54,bankcardid:1');
INSERT INTO `slog` VALUES ('39', '登录', 'ZHOUJD', '2014-08-13 17:35:48', '');
INSERT INTO `slog` VALUES ('46', '修改产品', 'ZHOUJD', '2014-08-13 17:35:48', 'realprice:120.00,remark:产品一备注,planprice:116.60,productno:20101001,producttypename:产品类别一1,createdate:2013-03-06,unit:1,productid:1,producttype:14,productname:产品1');
INSERT INTO `slog` VALUES ('47', '登录', 'ZHOUJD', '2014-08-17 14:53:31', '');
INSERT INTO `slog` VALUES ('48', '登录', 'ZHOUJD', '2014-08-19 16:02:29', '');
INSERT INTO `slog` VALUES ('49', '修改银行卡', 'ZHOUJD', '2014-08-19 16:02:29', 'bankcardno:00000,accountname:现金,status:1,remark:此为现金,bankname:无,priority:1,banktype:99,money:9579.54,bankcardid:1');
INSERT INTO `slog` VALUES ('50', '登录', 'ZHOUJD', '2014-08-19 16:19:59', '');
INSERT INTO `slog` VALUES ('51', '修改用户', 'ZHOUJD', '2014-08-19 16:19:59', 'tele:15060066666,birthday:null,username:测试账号,roleid:2,userid:ceshi');
INSERT INTO `slog` VALUES ('52', '登录', 'ZHOUJD', '2014-08-19 17:05:16', '');
INSERT INTO `slog` VALUES ('53', '新增产品', 'ZHOUJD', '2014-08-19 17:05:16', 'realprice:0.00,remark:null,planprice:8,productno:20101004,producttypename:产品类别一1,createdate:2014-08-19 17:07:21,unit:1,productid:6,producttype:14,productname:22');
INSERT INTO `slog` VALUES ('54', '新增产品', 'ZHOUJD', '2014-08-19 17:05:16', 'realprice:0.00,remark:233,planprice:5,productno:20101004,producttypename:产品类别一1,createdate:2014-08-19 17:09:54,unit:1,productid:7,producttype:14,productname:123');
INSERT INTO `slog` VALUES ('55', '登录', 'ZHOUJD', '2014-08-19 17:14:09', '');
INSERT INTO `slog` VALUES ('56', '新增产品', 'ZHOUJD', '2014-08-19 17:14:09', 'realprice:0.00,remark:null,planprice:0.00,productno:20101004,producttypename:产品类别一1,createdate:2014-08-19 17:14:25,unit:1,productid:8,producttype:14,productname:11');
INSERT INTO `slog` VALUES ('57', '新增产品', 'ZHOUJD', '2014-08-19 17:14:09', 'realprice:0.00,remark:null,planprice:0.00,productno:20101004,producttypename:产品类别一1,createdate:2014-08-19 17:16:22,unit:1,productid:9,producttype:14,productname:1111');
INSERT INTO `slog` VALUES ('58', '新增产品', 'ZHOUJD', '2014-08-19 17:14:09', 'realprice:0.00,remark:null,planprice:0.00,productno:20101005,producttypename:产品类别一1,createdate:2014-08-19 17:16:27,unit:1,productid:10,producttype:14,productname:2222');
INSERT INTO `slog` VALUES ('59', '新增产品', 'ZHOUJD', '2014-08-19 17:14:09', 'realprice:0.00,remark:null,planprice:0.00,productno:20101006,producttypename:产品类别一1,createdate:2014-08-19 17:16:32,unit:1,productid:11,producttype:14,productname:3333');
INSERT INTO `slog` VALUES ('60', '新增产品', 'ZHOUJD', '2014-08-19 17:14:09', 'realprice:0.00,remark:null,planprice:0.00,productno:20101004,producttypename:产品类别一1,createdate:2014-08-19 17:21:15,unit:1,productid:12,producttype:14,productname:22');
INSERT INTO `slog` VALUES ('61', '删除产品', 'ZHOUJD', '2014-08-19 17:14:09', '12');
INSERT INTO `slog` VALUES ('62', '新增产品', 'ZHOUJD', '2014-08-19 17:14:09', 'realprice:0.00,remark:null,planprice:0.00,productno:20101004,producttypename:产品类别一1,createdate:2014-08-19 17:24:19,unit:1,productid:13,producttype:14,productname:222');
INSERT INTO `slog` VALUES ('63', '删除产品', 'ZHOUJD', '2014-08-19 17:14:09', '13');
INSERT INTO `slog` VALUES ('64', '新增产品', 'ZHOUJD', '2014-08-19 17:14:09', 'realprice:0.00,remark:null,planprice:0.00,productno:20101004,producttypename:产品类别一1,createdate:2014-08-19 17:24:45,unit:1,productid:14,producttype:14,productname:2222');
INSERT INTO `slog` VALUES ('65', '删除产品', 'ZHOUJD', '2014-08-19 17:14:09', '14');
INSERT INTO `slog` VALUES ('66', '新增产品', 'ZHOUJD', '2014-08-19 17:14:09', 'realprice:0.00,remark:null,planprice:0.00,productno:20101004,producttypename:产品类别一1,createdate:2014-08-19 17:25:20,unit:1,productid:15,producttype:14,productname:22');
INSERT INTO `slog` VALUES ('67', '删除产品', 'ZHOUJD', '2014-08-19 17:14:09', '15');
INSERT INTO `slog` VALUES ('68', '删除用户', 'ZHOUJD', '2014-08-19 17:14:09', 'ceshi');
INSERT INTO `slog` VALUES ('69', '新增用户', 'ZHOUJD', '2014-08-19 17:14:09', 'tele:null,passwd:21218cca77804d2ba1922c33e0151105,birthday:null,username:测试账号,roleid:3,userid:CESHI');
INSERT INTO `slog` VALUES ('70', '登录', 'ZHOUJD', '2014-08-19 17:48:22', '');
INSERT INTO `slog` VALUES ('71', '新增模块', 'ZHOUJD', '2014-08-19 17:48:22', 'modulename:日志管理,sn:Log,priority:99,description:,parentid:103,rel:log_list,url:/log/list');
INSERT INTO `slog` VALUES ('72', '修改模块', 'ZHOUJD', '2014-08-19 17:48:22', 'modulename:日志管理,sn:Log,priority:1,description:null,moduleid:10132,parentid:103,rel:log_list,url:/log/list');
INSERT INTO `slog` VALUES ('73', '登录', 'ZHOUJD', '2014-08-19 17:48:22', '');
INSERT INTO `slog` VALUES ('74', '登录', 'ZHOUJD', '2014-08-19 17:48:22', '');
INSERT INTO `slog` VALUES ('75', '登录', 'ZHOUJD', '2014-08-19 17:48:22', '');
INSERT INTO `slog` VALUES ('76', '登录', 'ZHOUJD', '2014-08-19 18:30:32', '');
INSERT INTO `slog` VALUES ('77', '修改用户', 'ZHOUJD', '2014-08-19 18:30:32', 'tele:null,birthday:null,username:测试账号,roleid:3,userid:CESHI');
INSERT INTO `slog` VALUES ('78', '登录', 'ZHOUJD', '2014-08-19 18:45:36', '');
INSERT INTO `slog` VALUES ('79', '登录', 'ZHOUJD', '2014-08-19 18:45:36', '');
INSERT INTO `slog` VALUES ('80', '登录', 'ZHOUJD', '2014-08-19 18:45:36', '');
INSERT INTO `slog` VALUES ('81', '登录', 'ZHOUJD', '2014-08-20 08:55:18', '');
INSERT INTO `slog` VALUES ('82', '登录', 'ZHOUJD', '2014-08-20 08:55:18', '');
INSERT INTO `slog` VALUES ('83', '修改产品', 'ZHOUJD', '2014-08-20 08:55:18', 'profit:5.4,realprice:122.00,remark:产品一备注,costprice:116.6,productno:20101001,producttypename:产品类别一1,createdate:2013-03-06,unit:1,productid:1,producttype:14,productname:产品1');
INSERT INTO `slog` VALUES ('84', '修改产品', 'ZHOUJD', '2014-08-20 08:55:18', 'profit:9.06,realprice:200.50,remark:null,costprice:191.44,productno:20101002,producttypename:产品类别一1,createdate:2014-07-12,unit:1,productid:2,producttype:14,productname:产品2');
INSERT INTO `slog` VALUES ('85', '修改产品', 'ZHOUJD', '2014-08-20 08:55:18', 'profit:6.8,realprice:203.20,remark:null,costprice:196.4,productno:20101003,producttypename:产品类别一1,createdate:2014-07-12,unit:1,productid:3,producttype:14,productname:产品3');
INSERT INTO `slog` VALUES ('86', '修改产品', 'ZHOUJD', '2014-08-20 08:55:18', 'profit:9.8,realprice:43.10,remark:null,costprice:33.3,productno:20102001,producttypename:产品类别一2,createdate:2014-08-11,unit:1,productid:5,producttype:15,productname:产品8');
INSERT INTO `slog` VALUES ('87', '修改产品', 'ZHOUJD', '2014-08-20 08:55:18', 'profit:9.4,realprice:123.00,remark:产品一备注,costprice:113.6,productno:20101001,producttypename:产品类别一1,createdate:2013-03-06,unit:1,productid:1,producttype:14,productname:产品1');
INSERT INTO `slog` VALUES ('88', '修改产品', 'ZHOUJD', '2014-08-20 08:55:18', 'profit:30.06,realprice:200.50,remark:null,costprice:170.44,productno:20101002,producttypename:产品类别一1,createdate:2014-07-12,unit:1,productid:2,producttype:14,productname:产品2');
INSERT INTO `slog` VALUES ('89', '修改产品', 'ZHOUJD', '2014-08-20 08:55:18', 'profit:39.8,realprice:203.20,remark:null,costprice:163.4,productno:20101003,producttypename:产品类别一1,createdate:2014-07-12,unit:1,productid:3,producttype:14,productname:产品3');
INSERT INTO `slog` VALUES ('90', '修改产品', 'ZHOUJD', '2014-08-20 08:55:18', 'profit:9.4,realprice:123.00,remark:产品一备注,costprice:113.6,productno:20101001,producttypename:产品类别一1,createdate:2013-03-06,unit:1,productid:1,producttype:14,productname:产品1');
INSERT INTO `slog` VALUES ('91', '修改产品', 'ZHOUJD', '2014-08-20 08:55:18', 'profit:30.06,realprice:200.50,remark:null,costprice:170.44,productno:20101002,producttypename:产品类别一1,createdate:2014-07-12,unit:1,productid:2,producttype:14,productname:产品2');
INSERT INTO `slog` VALUES ('92', '修改产品', 'ZHOUJD', '2014-08-20 08:55:18', 'profit:9.4,realprice:123.20,remark:产品一备注,costprice:113.8,productno:20101001,producttypename:产品类别一1,createdate:2013-03-06,unit:1,productid:1,producttype:14,productname:产品1');
INSERT INTO `slog` VALUES ('93', '新增销售单', 'ZHOUJD', '2014-08-20 08:55:18', 'sellno:XSD-20140820-001,remark:null,maker:ZHOUJD,manuid:5,allrealsum:7399.2,allprofit:918.84,manuname:客户A,createtime:2014-08-20 11:14:34,sellid:11,currflow:申请,selldate:2014-08-20');
INSERT INTO `slog` VALUES ('94', '登录', 'ZHOUJD', '2014-08-20 08:55:18', '');
INSERT INTO `slog` VALUES ('95', '登录', 'ZHOUJD', '2014-08-20 08:55:18', '');
INSERT INTO `slog` VALUES ('96', '修改销售单', 'ZHOUJD', '2014-08-20 08:55:18', 'sellno:XSD-20140820-001,remark:null,maker:ZHOUJD,manuid:5,makername:周坚定,allrealsum:7522.62,allprofit:928.46,manuname:客户A,createtime:2014-08-20 11:14:34,sellid:11,currflow:申请,selldate:2014-08-20');
INSERT INTO `slog` VALUES ('97', '修改销售单', 'ZHOUJD', '2014-08-20 08:55:18', 'sellno:XSD-20140820-001,remark:null,maker:ZHOUJD,manuid:5,makername:周坚定,allrealsum:8513.92,allprofit:1153.86,manuname:客户A,createtime:2014-08-20 11:14:34,sellid:11,currflow:结束,selldate:2014-08-20');
INSERT INTO `slog` VALUES ('98', '修改银行卡', 'ZHOUJD', '2014-08-20 08:55:18', 'bankcardno:00000,accountname:现金,status:1,remark:此为现金,bankname:现金,priority:1,banktype:99,money:9579.54,bankcardid:1');
INSERT INTO `slog` VALUES ('99', '修改单据', 'ZHOUJD', '2014-08-20 08:55:18', 'btypename:收款单,operatetime:2014-08-20 08:55:18,remark:null,operater:ZHOUJD,allplansum:8513.92,makername:周坚定,createtime:2014-08-20 14:34:44,relateno:XSD-20140820-001,btype:SKD,maker:ZHOUJD,relatemoney:7522.62,paydate:2014-08-20,payid:53,allrealsum:8513.92,currflow:申请');
INSERT INTO `slog` VALUES ('100', '修改单据', 'ZHOUJD', '2014-08-20 08:55:18', 'btypename:运费单,operatetime:2014-08-20 08:55:18,remark:null,operater:ZHOUJD,allplansum:323,makername:周坚定,createtime:2014-08-20 14:34:44,relateno:XSD-20140820-001,btype:YFD,maker:ZHOUJD,relatemoney:7522.62,paydate:2014-08-20,payid:54,allrealsum:323,currflow:申请');
INSERT INTO `slog` VALUES ('101', '修改单据', 'ZHOUJD', '2014-08-20 08:55:18', 'btypename:收款单,operatetime:2014-08-20 08:55:18,remark:null,operater:ZHOUJD,allplansum:8513.92,makername:周坚定,createtime:2014-08-20 14:34:44,relateno:XSD-20140820-001,btype:SKD,maker:ZHOUJD,relatemoney:7522.62,paydate:2014-08-20,payid:53,allrealsum:8513.92,currflow:结束');
INSERT INTO `slog` VALUES ('102', '修改单据', 'ZHOUJD', '2014-08-20 08:55:18', 'btypename:运费单,operatetime:2014-08-20 08:55:18,remark:null,operater:ZHOUJD,allplansum:323,makername:周坚定,createtime:2014-08-20 14:34:44,relateno:XSD-20140820-001,btype:YFD,maker:ZHOUJD,relatemoney:7522.62,paydate:2014-08-20,payid:54,allrealsum:323,currflow:结束');
INSERT INTO `slog` VALUES ('103', '新增采购单', 'ZHOUJD', '2014-08-20 08:55:18', 'btype:CGD,remark:null,allsum:4972.06,maker:ZHOUJD,buyname:2014.08.20采购,createtime:2014-08-20 14:55:12,buyid:9,currflow:申请,buydate:2014-08-20,buyno:CGD-20140820-001');
INSERT INTO `slog` VALUES ('104', '修改采购单', 'ZHOUJD', '2014-08-20 08:55:18', 'btypename:采购单,btype:CGD,remark:null,allsum:4972.06,maker:ZHOUJD,makername:周坚定,buyname:2014.08.20采购,createtime:2014-08-20 14:55:12,buyid:9,currflow:结束,buydate:2014-08-20,buyno:CGD-20140820-001');
INSERT INTO `slog` VALUES ('105', '修改单据', 'ZHOUJD', '2014-08-20 08:55:18', 'btypename:付款单,operatetime:2014-08-20 08:55:18,remark:null,operater:ZHOUJD,allplansum:4972.06,makername:周坚定,createtime:2014-08-20 14:57:59,relateno:CGD-20140820-001,btype:FKD,maker:ZHOUJD,relatemoney:4972.06,paydate:2014-08-20,payid:55,allrealsum:4972.06,currflow:申请');
INSERT INTO `slog` VALUES ('106', '修改单据', 'ZHOUJD', '2014-08-20 08:55:18', 'btypename:付款单,operatetime:2014-08-20 08:55:18,remark:null,operater:ZHOUJD,allplansum:4972.06,makername:周坚定,createtime:2014-08-20 14:57:59,relateno:CGD-20140820-001,btype:FKD,maker:ZHOUJD,relatemoney:4972.06,paydate:2014-08-20,payid:55,allrealsum:4972.06,currflow:结束');
INSERT INTO `slog` VALUES ('107', '登录', 'ZHOUJD', '2014-08-20 15:05:16', '');
INSERT INTO `slog` VALUES ('108', '新增员工', 'ZHOUJD', '2014-08-20 15:05:16', 'stafftype:1,accountno:,accountname:,remark:,priority:3,tel:15060000021,staffstatus:1,bank:,salary:75,staffname:员工三');
INSERT INTO `slog` VALUES ('109', '新增工资单', 'ZHOUJD', '2014-08-20 15:05:16', 'remark:null,maker:ZHOUJD,salaryno:GZD-20140820-001,salarytype:1,salaryname:2014年07月份工资单,createtime:2014-08-20 15:09:27,salaryid:9,salarydate:2014-07,allplanmoney:5846,currflow:申请');
INSERT INTO `slog` VALUES ('110', '修改工资单', 'ZHOUJD', '2014-08-20 15:05:16', 'remark:补发【员工三】工资,maker:ZHOUJD,salarytypename:工资,makername:周坚定,salaryno:GZD-20140820-001,salarytype:1,salaryname:2014年07月份工资单,createtime:2014-08-20 15:09:27,salaryid:9,salarydate:2014-07,allplanmoney:2250,currflow:结束');
INSERT INTO `slog` VALUES ('111', '修改员工', 'ZHOUJD', '2014-08-20 15:05:16', 'stafftype:1,accountno:null,accountname:员工三,remark:null,priority:3,tel:15060000021,staffstatus:1,staffid:5,bank:null,salary:75.00,staffname:员工三');
INSERT INTO `slog` VALUES ('112', '修改单据', 'ZHOUJD', '2014-08-20 15:05:16', 'btypename:工资单,operatetime:2014-08-20 15:05:16,remark:null,operater:ZHOUJD,allplansum:2250,makername:周坚定,createtime:2014-08-20 15:23:35,relateno:GZD-20140820-001,btype:GZD,maker:ZHOUJD,relatemoney:2250.00,paydate:2014-07,payid:56,allrealsum:2250,currflow:结束');
INSERT INTO `slog` VALUES ('113', '新增工资单', 'ZHOUJD', '2014-08-20 15:05:16', 'remark:null,maker:ZHOUJD,salaryno:GZD-20140820-002,salarytype:1,salaryname:2014年07月份工资单,createtime:2014-08-20 15:34:49,salaryid:10,salarydate:2014-07,allplanmoney:3596,currflow:申请');
INSERT INTO `slog` VALUES ('114', '修改工资单', 'ZHOUJD', '2014-08-20 15:05:16', 'remark:null,maker:ZHOUJD,salarytypename:工资,makername:周坚定,salaryno:GZD-20140820-002,salarytype:1,salaryname:2014年07月份工资单,createtime:2014-08-20 15:34:49,salaryid:10,salarydate:2014-07,allplanmoney:3596,currflow:结束');
INSERT INTO `slog` VALUES ('115', '修改单据', 'ZHOUJD', '2014-08-20 15:05:16', 'btypename:工资单,operatetime:2014-08-20 15:05:16,remark:null,operater:ZHOUJD,allplansum:3596,makername:周坚定,createtime:2014-08-20 15:34:56,relateno:GZD-20140820-002,btype:GZD,maker:ZHOUJD,relatemoney:3596.00,paydate:2014-07,payid:57,allrealsum:3596.03,currflow:申请');
INSERT INTO `slog` VALUES ('116', '修改单据', 'ZHOUJD', '2014-08-20 15:05:16', 'btypename:工资单,operatetime:2014-08-20 15:05:16,remark:null,operater:ZHOUJD,allplansum:3596,makername:周坚定,createtime:2014-08-20 15:34:56,relateno:GZD-20140820-002,btype:GZD,maker:ZHOUJD,relatemoney:3596.00,paydate:2014-07,payid:57,allrealsum:3596.04,currflow:结束');
INSERT INTO `slog` VALUES ('117', '登录', 'ZHOUJD', '2014-08-21 17:22:57', '');
INSERT INTO `slog` VALUES ('118', '新增模块', 'ZHOUJD', '2014-08-21 17:22:57', 'modulename:字典管理,sn:Dict,priority:1,description:,parentid:10106,rel:dict_list,url:/dict/list');
INSERT INTO `slog` VALUES ('119', '登录', 'ZHOUJD', '2014-08-21 17:22:57', '');
INSERT INTO `slog` VALUES ('120', '登录', 'ZHOUJD', '2014-08-21 17:22:57', '');
INSERT INTO `slog` VALUES ('121', '登录', 'ZHOUJD', '2014-08-21 17:22:57', '');
INSERT INTO `slog` VALUES ('122', '登录', 'ZHOUJD', '2014-08-21 17:43:51', '');
INSERT INTO `slog` VALUES ('123', '登录', 'ZHOUJD', '2014-08-22 10:09:06', '');
INSERT INTO `slog` VALUES ('124', '登录', 'ZHOUJD', '2014-08-22 10:09:06', '');
INSERT INTO `slog` VALUES ('125', '登录', 'ZHOUJD', '2014-08-22 10:21:00', '');
INSERT INTO `slog` VALUES ('126', '登录', 'ZHOUJD', '2014-08-22 10:30:40', '');
INSERT INTO `slog` VALUES ('127', '登录', 'ZHOUJD', '2014-08-22 10:32:47', '');
INSERT INTO `slog` VALUES ('128', '登录', 'ZHOUJD', '2014-08-22 10:50:04', '');
INSERT INTO `slog` VALUES ('129', '登录', 'ZHOUJD', '2014-08-22 10:52:08', '');
INSERT INTO `slog` VALUES ('130', '修改物资', 'ZHOUJD', '2014-08-22 10:52:08', 'unit:1,price:0.22,remark:null,materialtypename:物资类型A-1,materialname:物资A11,createdate:2013-02-24,manuid:4,materialtype:5,materialno:10101001,manuname:供应商A,materialid:1');
INSERT INTO `slog` VALUES ('131', '修改物资', 'ZHOUJD', '2014-08-22 10:52:08', 'unit:2,price:0.22,remark:null,materialtypename:物资类型A-1,materialname:物资A11,createdate:2013-02-24,manuid:4,materialtype:5,materialno:10101001,manuname:供应商A,materialid:1');
INSERT INTO `slog` VALUES ('132', '修改物资', 'ZHOUJD', '2014-08-22 10:52:08', 'unit:1,price:0.22,remark:null,materialtypename:物资类型A-1,materialname:物资A11,createdate:2013-02-24,manuid:4,materialtype:5,materialno:10101001,manuname:供应商A,materialid:1');
INSERT INTO `slog` VALUES ('133', '登录', 'ZHOUJD', '2014-08-22 11:23:51', '');
INSERT INTO `slog` VALUES ('134', '登录', 'ZHOUJD', '2014-08-22 11:23:51', '');
INSERT INTO `slog` VALUES ('135', '登录', 'ZHOUJD', '2014-08-22 11:23:51', '');
INSERT INTO `slog` VALUES ('136', '修改用户', 'ZHOUJD', '2014-08-22 11:23:51', 'tele:18979578121,birthday:2013-01-01,username:林长城,roleid:2,userid:LINCC');
INSERT INTO `slog` VALUES ('137', '修改模块', 'ZHOUJD', '2014-08-22 11:23:51', 'modulename:用户管理,sn:User,priority:1,description:用户管理-描述,moduleid:10101,parentid:101,rel:user_list,url:/user/list');
INSERT INTO `slog` VALUES ('138', '修改供应商', 'ZHOUJD', '2014-08-22 11:23:51', 'manuemail:null,remark:null,manutypeid:2,createdate:2013-02-25,manuid:9,statusid:1,manucontact:无,manuname:客户B,manutel:00000,priority:12');
INSERT INTO `slog` VALUES ('139', '修改员工', 'ZHOUJD', '2014-08-22 11:23:51', 'stafftype:1,accountno:11111111,accountname:员工一,remark:备注1,priority:1,tel:11111111,staffstatus:1,staffid:2,bank:建设银行南安支行,salary:53.00,staffname:员工一');
INSERT INTO `slog` VALUES ('140', '修改银行卡', 'ZHOUJD', '2014-08-22 11:23:51', 'bankcardno:00000,accountname:现金,status:1,remark:此为现金,bankname:现金,priority:1,banktype:9,money:48438.44,bankcardid:1');
INSERT INTO `slog` VALUES ('141', '登录', 'ZHOUJD', '2014-08-22 16:41:27', '');
INSERT INTO `slog` VALUES ('142', '删除模块', 'ZHOUJD', '2014-08-22 16:41:27', '10107');
INSERT INTO `slog` VALUES ('143', '登录', 'ZHOUJD', '2014-08-22 16:41:27', '');
INSERT INTO `slog` VALUES ('144', '登录', 'ZHOUJD', '2014-08-22 18:04:48', '');
INSERT INTO `slog` VALUES ('145', '登录', 'ZHOUJD', '2014-08-24 10:09:44', '');
INSERT INTO `slog` VALUES ('146', '登录', 'ZHOUJD', '2014-08-24 21:42:51', '');
INSERT INTO `slog` VALUES ('147', '登录', 'ZHOUJD', '2014-08-25 18:57:25', '');
INSERT INTO `slog` VALUES ('148', '登录', 'ZHOUJD', '2014-08-25 19:05:32', '');
INSERT INTO `slog` VALUES ('149', '登录', 'ZHOUJD', '2014-08-25 19:13:36', '');
INSERT INTO `slog` VALUES ('150', '登录', 'ZHOUJD', '2014-08-28 10:47:19', '');
INSERT INTO `slog` VALUES ('151', '修改用户', 'ZHOUJD', '2014-08-28 10:47:19', 'tele:null,birthday:null,username:测试账号,roleid:3,userid:CESHI');
INSERT INTO `slog` VALUES ('152', '修改用户', 'ZHOUJD', '2014-08-28 10:47:19', 'tele:null,birthday:null,username:测试账号2,roleid:3,userid:CESHI');
INSERT INTO `slog` VALUES ('153', '修改用户', 'ZHOUJD', '2014-08-28 10:47:19', 'tele:null,birthday:null,username:测试账号,roleid:3,userid:CESHI');
INSERT INTO `slog` VALUES ('154', '修改用户', 'ZHOUJD', '2014-08-28 10:47:19', 'tele:null,birthday:null,username:测试账号,roleid:3,userid:CESHI');
INSERT INTO `slog` VALUES ('155', '登录', 'ZHOUJD', '2014-08-28 11:05:14', '');
INSERT INTO `slog` VALUES ('156', '登录', 'ZHOUJD', '2014-08-28 11:05:14', '');
INSERT INTO `slog` VALUES ('157', '修改物资', 'ZHOUJD', '2014-08-28 11:05:14', 'unit:1,usestock:1,stock:545,price:0.22,remark:null,materialtypename:物资类型A-1,materialname:物资A11,createdate:2013-02-24,manuid:4,materialtype:5,materialno:10101001,manuname:供应商A,alarmnum:9999,materialid:1');
INSERT INTO `slog` VALUES ('158', '新增销售单', 'ZHOUJD', '2014-08-28 11:05:14', 'sellno:XSD-20140828-001,remark:null,maker:ZHOUJD,manuid:5,allrealsum:1017,allprofit:107.12,manuname:客户A,createtime:2014-08-28 11:50:07,sellid:12,currflow:申请,selldate:2014-08-28');
INSERT INTO `slog` VALUES ('159', '登录', 'ZHOUJD', '2014-08-28 11:05:14', '');
INSERT INTO `slog` VALUES ('160', '修改产品', 'ZHOUJD', '2014-08-28 11:05:14', 'profit:9.4,realprice:123.20,remark:产品一备注,costprice:113.8,productno:20101001,producttypename:产品类别一1,createdate:2013-03-06,unit:1,productid:1,producttype:14,productname:产品1');
INSERT INTO `slog` VALUES ('161', '修改产品', 'ZHOUJD', '2014-08-28 11:05:14', 'profit:10.26,realprice:200.50,remark:null,costprice:190.24,productno:20101002,producttypename:产品类别一1,createdate:2014-07-12,unit:1,productid:2,producttype:14,productname:产品2');
INSERT INTO `slog` VALUES ('162', '修改产品', 'ZHOUJD', '2014-08-28 11:05:14', 'profit:39.8,realprice:203.20,remark:null,costprice:163.4,productno:20101003,producttypename:产品类别一1,createdate:2014-07-12,unit:1,productid:3,producttype:14,productname:产品3');
INSERT INTO `slog` VALUES ('163', '修改物资', 'ZHOUJD', '2014-08-28 11:05:14', 'unit:1,usestock:1,stock:342,price:44.00,remark:null,materialtypename:物资类型B-1,materialname:物资B12,createdate:2013-03-04,manuid:8,materialtype:8,materialno:10201002,manuname:供应商B,alarmnum:100,materialid:5');
INSERT INTO `slog` VALUES ('164', '修改物资', 'ZHOUJD', '2014-08-28 11:05:14', 'unit:1,usestock:0,stock:0.00,price:33.30,remark:null,materialtypename:物资类型B-1,materialname:物资B11,createdate:2013-03-04,manuid:4,materialtype:8,materialno:10201001,manuname:供应商A,alarmnum:9999.00,materialid:4');
INSERT INTO `slog` VALUES ('165', '修改物资', 'ZHOUJD', '2014-08-28 11:05:14', 'unit:1,usestock:null,stock:null,price:43.20,remark:null,materialtypename:物资类型A-2,materialname:物资A21,createdate:2014-07-04,manuid:8,materialtype:6,materialno:10102001,manuname:供应商B,alarmnum:null,materialid:6');
INSERT INTO `slog` VALUES ('166', '修改物资', 'ZHOUJD', '2014-08-28 11:05:14', 'unit:1,usestock:null,stock:null,price:43.20,remark:null,materialtypename:物资类型A-2,materialname:物资A21,createdate:2014-07-04,manuid:8,materialtype:6,materialno:10102001,manuname:供应商B,alarmnum:null,materialid:6');
INSERT INTO `slog` VALUES ('167', '修改物资', 'ZHOUJD', '2014-08-28 11:05:14', 'unit:1,usestock:null,stock:null,price:43.20,remark:null,materialtypename:物资类型A-2,materialname:物资A21,createdate:2014-07-04,manuid:8,materialtype:6,materialno:10102001,manuname:供应商B,alarmnum:null,materialid:6');
INSERT INTO `slog` VALUES ('168', '修改物资', 'ZHOUJD', '2014-08-28 11:05:14', 'unit:1,usestock:null,stock:null,price:43.20,remark:null,materialtypename:物资类型A-2,materialname:物资A21,createdate:2014-07-04,manuid:8,materialtype:6,materialno:10102001,manuname:供应商B,alarmnum:null,materialid:6');
INSERT INTO `slog` VALUES ('169', '修改物资', 'ZHOUJD', '2014-08-28 11:05:14', 'unit:1,usestock:null,stock:null,price:43.20,remark:null,materialtypename:物资类型A-2,materialname:物资A21,createdate:2014-07-04,manuid:8,materialtype:6,materialno:10102001,manuname:供应商B,alarmnum:null,materialid:6');
INSERT INTO `slog` VALUES ('170', '修改物资', 'ZHOUJD', '2014-08-28 11:05:14', 'unit:1,usestock:null,stock:null,price:43.20,remark:null,materialtypename:物资类型A-2,materialname:物资A21,createdate:2014-07-04,manuid:8,materialtype:6,materialno:10102001,manuname:供应商B,alarmnum:null,materialid:6');
INSERT INTO `slog` VALUES ('171', '修改物资', 'ZHOUJD', '2014-08-28 11:05:14', 'unit:1,usestock:1,stock:501.00,price:0.22,remark:null,materialtypename:物资类型A-1,materialname:物资A11,createdate:2013-02-24,manuid:4,materialtype:5,materialno:10101001,manuname:供应商A,alarmnum:9999,materialid:1');
INSERT INTO `slog` VALUES ('172', '修改物资', 'ZHOUJD', '2014-08-28 11:05:14', 'unit:1,usestock:0,stock:0.00,price:33.30,remark:null,materialtypename:物资类型B-1,materialname:物资B11,createdate:2013-03-04,manuid:4,materialtype:8,materialno:10201001,manuname:供应商A,alarmnum:0,materialid:4');
INSERT INTO `slog` VALUES ('173', '修改物资', 'ZHOUJD', '2014-08-28 11:05:14', 'unit:1,usestock:1,stock:335.00,price:44.00,remark:null,materialtypename:物资类型B-1,materialname:物资B12,createdate:2013-03-04,manuid:8,materialtype:8,materialno:10201002,manuname:供应商B,alarmnum:100.00,materialid:5');
INSERT INTO `slog` VALUES ('174', '修改物资', 'ZHOUJD', '2014-08-28 11:05:14', 'unit:1,usestock:0,stock:0.00,price:33.30,remark:null,materialtypename:物资类型B-1,materialname:物资B11,createdate:2013-03-04,manuid:4,materialtype:8,materialno:10201001,manuname:供应商A,alarmnum:0.00,materialid:4');
INSERT INTO `slog` VALUES ('175', '修改物资', 'ZHOUJD', '2014-08-28 11:05:14', 'unit:1,usestock:1,stock:501.00,price:0.22,remark:null,materialtypename:物资类型A-1,materialname:物资A11,createdate:2013-02-24,manuid:4,materialtype:5,materialno:10101001,manuname:供应商A,alarmnum:9999.00,materialid:1');
INSERT INTO `slog` VALUES ('176', '修改产品', 'ZHOUJD', '2014-08-28 11:05:14', 'profit:75.56,realprice:123.20,remark:产品一备注,costprice:47.64,productno:20101001,producttypename:产品类别一1,createdate:2013-03-06,unit:1,productid:1,producttype:14,productname:产品1');
INSERT INTO `slog` VALUES ('177', '修改产品', 'ZHOUJD', '2014-08-28 11:05:14', 'profit:10.26,realprice:200.50,remark:null,costprice:190.24,productno:20101002,producttypename:产品类别一1,createdate:2014-07-12,unit:1,productid:2,producttype:14,productname:产品2');
INSERT INTO `slog` VALUES ('178', '修改产品', 'ZHOUJD', '2014-08-28 11:05:14', 'profit:39.8,realprice:203.20,remark:null,costprice:163.4,productno:20101003,producttypename:产品类别一1,createdate:2014-07-12,unit:1,productid:3,producttype:14,productname:产品3');
INSERT INTO `slog` VALUES ('179', '修改产品', 'ZHOUJD', '2014-08-28 11:05:14', 'profit:9.8,realprice:43.10,remark:null,costprice:33.3,productno:20102001,producttypename:产品类别一2,createdate:2014-08-11,unit:1,productid:5,producttype:15,productname:产品8');
INSERT INTO `slog` VALUES ('180', '修改销售单', 'ZHOUJD', '2014-08-28 11:05:14', 'sellno:XSD-20140828-001,remark:null,maker:ZHOUJD,manuid:5,makername:周坚定,allrealsum:1017,allprofit:107.12,manuname:客户A,createtime:2014-08-28 11:50:07,sellid:12,currflow:申请,selldate:2014-08-28');
INSERT INTO `slog` VALUES ('181', '登录', 'ZHOUJD', '2014-08-28 11:05:14', '');
INSERT INTO `slog` VALUES ('182', '修改销售单', 'ZHOUJD', '2014-08-28 11:05:14', 'sellno:XSD-20140828-001,remark:null,maker:ZHOUJD,manuid:5,makername:周坚定,allrealsum:1017,allprofit:107.12,manuname:客户A,createtime:2014-08-28 11:50:07,sellid:12,currflow:申请,selldate:2014-08-28');
INSERT INTO `slog` VALUES ('183', '修改销售单', 'ZHOUJD', '2014-08-28 11:05:14', 'sellno:XSD-20140828-001,remark:null,maker:ZHOUJD,manuid:5,makername:周坚定,allrealsum:1017,allprofit:107.12,manuname:客户A,createtime:2014-08-28 11:50:07,sellid:12,currflow:申请,selldate:2014-08-28');
INSERT INTO `slog` VALUES ('184', '登录', 'ZHOUJD', '2014-08-28 11:05:14', '');
INSERT INTO `slog` VALUES ('185', '修改销售单', 'ZHOUJD', '2014-08-28 11:05:14', 'sellno:XSD-20140828-001,remark:null,maker:ZHOUJD,manuid:5,makername:周坚定,allrealsum:1017,allprofit:107.12,manuname:客户A,createtime:2014-08-28 11:50:07,sellid:12,currflow:结束,selldate:2014-08-28');
INSERT INTO `slog` VALUES ('186', '修改单据', 'ZHOUJD', '2014-08-28 11:05:14', 'btypename:收款单,operatetime:2014-08-28 11:05:14,remark:null,operater:ZHOUJD,allplansum:1017,makername:周坚定,createtime:2014-08-28 15:33:16,relateno:XSD-20140828-001,btype:SKD,maker:ZHOUJD,relatemoney:1017.00,paydate:2014-08-28,payid:58,allrealsum:1017,currflow:结束');
INSERT INTO `slog` VALUES ('187', '登录', 'ZHOUJD', '2014-08-28 15:42:17', '');
INSERT INTO `slog` VALUES ('188', '修改产品', 'ZHOUJD', '2014-08-28 15:42:17', 'profit:75.56,realprice:123.20,remark:产品一备注,costprice:47.64,productno:20101001,producttypename:产品类别一1,createdate:2013-03-06,unit:1,productid:1,producttype:14,productname:产品1');
INSERT INTO `slog` VALUES ('189', '修改产品', 'ZHOUJD', '2014-08-28 15:42:17', 'profit:10.26,realprice:200.50,remark:null,costprice:190.24,productno:20101002,producttypename:产品类别一1,createdate:2014-07-12,unit:1,productid:2,producttype:14,productname:产品2');
INSERT INTO `slog` VALUES ('190', '修改产品', 'ZHOUJD', '2014-08-28 15:42:17', 'profit:39.8,realprice:203.20,remark:null,costprice:163.4,productno:20101003,producttypename:产品类别一1,createdate:2014-07-12,unit:1,productid:3,producttype:14,productname:产品3');
INSERT INTO `slog` VALUES ('191', '登录', 'ZHOUJD', '2014-08-28 15:52:35', '');
INSERT INTO `slog` VALUES ('192', '修改产品', 'ZHOUJD', '2014-08-28 15:52:58', 'profit:9.8,realprice:43.10,remark:null,costprice:33.3,productno:20102001,producttypename:产品类别一2,createdate:2014-08-11,unit:1,productid:5,producttype:15,productname:产品8');
INSERT INTO `slog` VALUES ('193', '新增销售单', 'ZHOUJD', '2014-08-28 15:53:20', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,costprice:0.00,planprice:0.00,productno:,sellrowid:,maker:ZHOUJD,manuid:9,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,productname:');
INSERT INTO `slog` VALUES ('194', '登录', 'ZHOUJD', '2014-08-28 15:56:14', '');
INSERT INTO `slog` VALUES ('195', '登录', 'ZHOUJD', '2014-08-28 16:02:22', '');
INSERT INTO `slog` VALUES ('196', '修改物资', 'ZHOUJD', '2014-08-28 16:05:58', 'unit:1,usestock:1,stock:447.00,price:0.22,remark:null,materialtypename:物资类型A-1,materialname:物资A11,createdate:2013-02-24,manuid:4,materialtype:5,materialno:10101001,manuname:供应商A,alarmnum:9999.00,materialid:1');
INSERT INTO `slog` VALUES ('197', '新增物资', 'ZHOUJD', '2014-08-28 16:09:15', 'unit:1,usestock:,stock:0,price:3,remark:,materialtypename:物资类型C-1,materialname:222,createdate:2014-08-28 16:09:15,manuid:8,materialtype:10,materialno:10301001,manuname:供应商B,alarmnum:9999');
INSERT INTO `slog` VALUES ('198', '删除物资', 'ZHOUJD', '2014-08-28 16:09:32', '26');
INSERT INTO `slog` VALUES ('199', '登录', 'ZHOUJD', '2014-08-28 16:24:32', '');
INSERT INTO `slog` VALUES ('200', '登录', 'ZHOUJD', '2014-08-28 16:45:38', '');
INSERT INTO `slog` VALUES ('201', '修改物资', 'ZHOUJD', '2014-08-28 16:46:08', 'unit:1,usestock:1,stock:447.00,price:0.22,remark:null,materialtypename:物资类型A-1,materialname:物资A11,createdate:2013-02-24,manuid:4,materialtype:5,materialno:10101001,manuname:供应商A,alarmnum:9999.00,materialid:1');
INSERT INTO `slog` VALUES ('202', '登录', 'ZHOUJD', '2014-09-01 10:54:19', '');
INSERT INTO `slog` VALUES ('203', '登录', 'ZHOUJD', '2014-09-01 10:57:31', '');
INSERT INTO `slog` VALUES ('204', '登录', 'ZHOUJD', '2014-09-01 11:29:31', '');
INSERT INTO `slog` VALUES ('205', '修改销售单', 'ZHOUJD', '2014-09-01 11:29:40', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:1,productname:');
INSERT INTO `slog` VALUES ('206', '修改销售单', 'ZHOUJD', '2014-09-01 11:29:57', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:1,productname:');
INSERT INTO `slog` VALUES ('207', '修改销售单', 'ZHOUJD', '2014-09-01 11:30:09', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:1,productname:');
INSERT INTO `slog` VALUES ('208', '修改销售单', 'ZHOUJD', '2014-09-01 11:30:49', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:1,productname:');
INSERT INTO `slog` VALUES ('209', '修改销售单', 'ZHOUJD', '2014-09-01 11:31:25', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:,productname:');
INSERT INTO `slog` VALUES ('210', '修改销售单', 'ZHOUJD', '2014-09-01 11:31:31', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:,productname:');
INSERT INTO `slog` VALUES ('211', '修改销售单', 'ZHOUJD', '2014-09-01 11:31:59', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:1,productname:');
INSERT INTO `slog` VALUES ('212', '修改销售单', 'ZHOUJD', '2014-09-01 11:34:02', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:1,productname:');
INSERT INTO `slog` VALUES ('213', '修改销售单', 'ZHOUJD', '2014-09-01 11:34:13', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:1,productname:');
INSERT INTO `slog` VALUES ('214', '修改销售单', 'ZHOUJD', '2014-09-01 11:34:29', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:1,productname:');
INSERT INTO `slog` VALUES ('215', '登录', 'ZHOUJD', '2014-09-01 11:38:13', '');
INSERT INTO `slog` VALUES ('216', '修改销售单', 'ZHOUJD', '2014-09-01 11:44:03', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:1,productname:');
INSERT INTO `slog` VALUES ('217', '修改销售单', 'ZHOUJD', '2014-09-01 11:44:25', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:1,productname:');
INSERT INTO `slog` VALUES ('218', '修改销售单', 'ZHOUJD', '2014-09-01 11:44:50', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:1,productname:');
INSERT INTO `slog` VALUES ('219', '修改销售单', 'ZHOUJD', '2014-09-01 11:45:42', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:1,productname:');
INSERT INTO `slog` VALUES ('220', '修改销售单', 'ZHOUJD', '2014-09-01 11:45:46', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:1,productname:');
INSERT INTO `slog` VALUES ('221', '修改销售单', 'ZHOUJD', '2014-09-01 11:45:56', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:1,productname:');
INSERT INTO `slog` VALUES ('222', '修改销售单', 'ZHOUJD', '2014-09-01 11:46:01', 'sellno:XSD-20140828-002,profit:0,realprice:0.00,remark:null,productno:,costprice:0.00,planprice:0.00,sellrowid:,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:0,allprofit:0,manuname:客户B,realsum:0,createtime:2014-08-28 15:53:20,unit:,num:0.00,productid:,sellid:13,currflow:申请,selldate:2014-08-28,remarkrow:,addBuy:1,productname:');
INSERT INTO `slog` VALUES ('223', '登录', 'ZHOUJD', '2014-09-01 14:04:28', '');
INSERT INTO `slog` VALUES ('224', '登录', 'ZHOUJD', '2014-09-01 15:16:44', '');
INSERT INTO `slog` VALUES ('225', '登录', 'ZHOUJD', '2014-09-01 15:52:26', '');
INSERT INTO `slog` VALUES ('226', '修改销售单', 'ZHOUJD', '2014-09-01 15:53:06', 'sellno:XSD-20140828-002,remark:null,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:847.9,allprofit:181.9,manuname:客户B,createtime:2014-08-28 15:53:20,sellid:13,currflow:申请,selldate:2014-08-28,addBuy:');
INSERT INTO `slog` VALUES ('227', '登录', 'ZHOUJD', '2014-09-01 16:43:54', '');
INSERT INTO `slog` VALUES ('228', '登录', 'ZHOUJD', '2014-09-01 16:43:54', '');
INSERT INTO `slog` VALUES ('229', '修改销售单', 'ZHOUJD', '2014-09-01 16:46:57', 'sellno:XSD-20140828-002,remark:null,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:847.9,allprofit:181.9,manuname:客户B,createtime:2014-08-28 15:53:20,sellid:13,currflow:申请,selldate:2014-08-28,addBuy:1');
INSERT INTO `slog` VALUES ('230', '修改销售单', 'ZHOUJD', '2014-09-01 16:51:13', 'sellno:XSD-20140828-002,remark:null,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:847.9,allprofit:181.9,manuname:客户B,createtime:2014-08-28 15:53:20,sellid:13,currflow:申请,selldate:2014-08-28,addBuy:1');
INSERT INTO `slog` VALUES ('231', '修改销售单', 'ZHOUJD', '2014-09-01 16:51:57', 'sellno:XSD-20140828-002,remark:null,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:847.9,allprofit:181.9,manuname:客户B,createtime:2014-08-28 15:53:20,sellid:13,currflow:申请,selldate:2014-08-28,addBuy:1');
INSERT INTO `slog` VALUES ('232', '修改销售单', 'ZHOUJD', '2014-09-01 16:53:10', 'sellno:XSD-20140828-002,remark:null,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:847.9,allprofit:181.9,manuname:客户B,createtime:2014-08-28 15:53:20,sellid:13,currflow:申请,selldate:2014-08-28,addBuy:1');
INSERT INTO `slog` VALUES ('233', '删除采购单', 'ZHOUJD', '2014-09-01 17:03:43', '12');
INSERT INTO `slog` VALUES ('234', '修改销售单', 'ZHOUJD', '2014-09-01 17:04:22', 'sellno:XSD-20140828-002,remark:null,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:847.9,allprofit:181.9,manuname:客户B,createtime:2014-08-28 15:53:20,sellid:13,currflow:申请,selldate:2014-08-28,addBuy:1');
INSERT INTO `slog` VALUES ('235', '修改采购单', 'ZHOUJD', '2014-09-01 17:28:36', 'btypename:采购单,remark:null,allsum:494.6,makername:周坚定,buyname:2014.09.01采购,createtime:2014-09-01 17:04:22,relateno:XSD-20140828-002,buyno:CGD-20140901-001,btype:CGD,maker:ZHOUJD,buyid:13,currflow:结束,buydate:2014-09-01');
INSERT INTO `slog` VALUES ('236', '修改销售单', 'ZHOUJD', '2014-09-01 17:29:22', 'sellno:XSD-20140828-002,remark:null,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:847.9,allprofit:181.9,manuname:客户B,createtime:2014-08-28 15:53:20,sellid:13,currflow:结束,selldate:2014-08-28,addBuy:');
INSERT INTO `slog` VALUES ('237', '修改单据', 'ZHOUJD', '2014-09-01 17:29:41', 'btypename:付款单,operatetime:2014-09-01 17:29:41,remark:null,operater:ZHOUJD,allplansum:494.6,makername:周坚定,createtime:2014-09-01 17:28:36,relateno:CGD-20140901-001,btype:FKD,maker:ZHOUJD,relatemoney:494.60,paydate:2014-09-01,payid:59,allrealsum:494.6,currflow:申请');
INSERT INTO `slog` VALUES ('238', '修改单据', 'ZHOUJD', '2014-09-01 17:29:46', 'btypename:收款单,operatetime:2014-09-01 17:29:46,remark:null,operater:ZHOUJD,allplansum:847.9,makername:周坚定,createtime:2014-09-01 17:29:22,relateno:XSD-20140828-002,btype:SKD,maker:ZHOUJD,relatemoney:847.90,paydate:2014-08-28,payid:60,allrealsum:847.9,currflow:申请');
INSERT INTO `slog` VALUES ('239', '修改单据', 'ZHOUJD', '2014-09-01 17:29:54', 'btypename:付款单,operatetime:2014-09-01 17:29:54,remark:null,operater:ZHOUJD,allplansum:494.6,makername:周坚定,createtime:2014-09-01 17:28:36,relateno:CGD-20140901-001,btype:FKD,maker:ZHOUJD,relatemoney:494.60,paydate:2014-09-01,payid:59,allrealsum:494.6,currflow:结束');
INSERT INTO `slog` VALUES ('240', '修改单据', 'ZHOUJD', '2014-09-01 17:29:58', 'btypename:收款单,operatetime:2014-09-01 17:29:57,remark:null,operater:ZHOUJD,allplansum:847.9,makername:周坚定,createtime:2014-09-01 17:29:22,relateno:XSD-20140828-002,btype:SKD,maker:ZHOUJD,relatemoney:847.90,paydate:2014-08-28,payid:60,allrealsum:847.9,currflow:结束');
INSERT INTO `slog` VALUES ('241', '修改物资', 'ZHOUJD', '2014-09-01 17:30:19', 'unit:1,usestock:1,stock:307.00,price:0.22,remark:null,materialtypename:物资类型A-1,materialname:物资A11,createdate:2013-02-24,manuid:4,materialtype:5,materialno:10101001,manuname:供应商A,alarmnum:100,materialid:1');
INSERT INTO `slog` VALUES ('242', '登录', 'ZHOUJD', '2014-09-01 17:34:08', '');
INSERT INTO `slog` VALUES ('243', '登录', 'ZHOUJD', '2014-09-02 14:56:37', '');
INSERT INTO `slog` VALUES ('244', '新增采购单', 'ZHOUJD', '2014-09-02 14:56:57', 'btype:CGD,remark:null,allsum:,maker:ZHOUJD,buyname:2014.09.02采购,createtime:2014-09-02 14:56:57,buyid:14,currflow:申请,buydate:2014-09-02,buyno:CGD-20140902-001');
INSERT INTO `slog` VALUES ('245', '新增采购单', 'ZHOUJD', '2014-09-02 14:57:08', 'btype:CGD,remark:null,allsum:66.6,maker:ZHOUJD,buyname:2014.09.02采购,createtime:2014-09-02 14:57:08,buyid:15,currflow:申请,buydate:2014-09-02,buyno:CGD-20140902-002');
INSERT INTO `slog` VALUES ('246', '修改采购单', 'ZHOUJD', '2014-09-02 14:57:24', 'btypename:采购单,remark:null,allsum:0.66,makername:周坚定,buyname:2014.09.02采购,createtime:2014-09-02 14:56:57,relateno:null,buyno:CGD-20140902-001,btype:CGD,maker:ZHOUJD,buyid:14,currflow:申请,buydate:2014-09-02');
INSERT INTO `slog` VALUES ('247', '登录', 'ZHOUJD', '2014-09-02 15:43:27', '');
INSERT INTO `slog` VALUES ('248', '登录', 'ZHOUJD', '2014-09-02 16:21:13', '');
INSERT INTO `slog` VALUES ('249', '登录', 'ZHOUJD', '2014-09-02 16:22:05', '');
INSERT INTO `slog` VALUES ('250', '修改采购单', 'ZHOUJD', '2014-09-02 16:26:41', 'btypename:采购单,remark:合并采购单,allsum:67.26,makername:周坚定,buyname:2014.09.02采购,createtime:2014-09-02 16:24:09,relateno:null,buyno:CGD-20140902-003,btype:CGD,maker:ZHOUJD,buyid:16,currflow:申请,buydate:2014-09-02');
INSERT INTO `slog` VALUES ('251', '新增采购单', 'ZHOUJD', '2014-09-02 17:15:47', 'btype:CGD,remark:null,allsum:275.9,maker:ZHOUJD,buyname:2014.09.02采购,createtime:2014-09-02 17:15:47,buyid:18,currflow:申请,buydate:2014-09-02,buyno:CGD-20140902-005');
INSERT INTO `slog` VALUES ('252', '新增采购单', 'ZHOUJD', '2014-09-02 17:18:42', 'btype:CGD,remark:null,allsum:0.44,maker:ZHOUJD,buyname:2014.09.02采购,createtime:2014-09-02 17:18:41,buyid:21,currflow:申请,buydate:2014-09-02,buyno:CGD-20140902-008');
INSERT INTO `slog` VALUES ('253', '新增采购单', 'ZHOUJD', '2014-09-02 17:39:36', 'btype:CGD,remark:null,allsum:87.2,maker:ZHOUJD,buyname:2014.09.02采购,createtime:2014-09-02 17:39:35,buyid:23,currflow:申请,buydate:2014-09-02,buyno:CGD-20140902-010');
INSERT INTO `slog` VALUES ('254', '新增采购单', 'ZHOUJD', '2014-09-02 17:39:56', 'btype:CGD,remark:null,allsum:88,maker:ZHOUJD,buyname:2014.09.02采购,createtime:2014-09-02 17:39:56,buyid:24,currflow:申请,buydate:2014-09-02,buyno:CGD-20140902-011');
INSERT INTO `slog` VALUES ('255', '新增采购单', 'ZHOUJD', '2014-09-02 17:44:00', 'btype:CGD,remark:null,allsum:88,maker:ZHOUJD,buyname:2014.09.02采购,createtime:2014-09-02 17:44:00,buyid:26,currflow:申请,buydate:2014-09-02,buyno:CGD-20140902-013');
INSERT INTO `slog` VALUES ('256', '新增采购单', 'ZHOUJD', '2014-09-02 17:44:21', 'btype:CGD,remark:null,allsum:66.6,maker:ZHOUJD,buyname:2014.09.02采购,createtime:2014-09-02 17:44:21,buyid:28,currflow:申请,buydate:2014-09-02,buyno:CGD-20140902-015');
INSERT INTO `slog` VALUES ('257', '登录', 'ZHOUJD', '2014-09-10 16:00:02', '');
INSERT INTO `slog` VALUES ('258', '登录', 'ZHOUJD', '2014-09-10 16:06:41', '');
INSERT INTO `slog` VALUES ('259', '修改用户', 'ZHOUJD', '2014-09-10 16:06:52', 'tele:null,birthday:null,username:测试账号,roleid:3,userid:CESHI');
INSERT INTO `slog` VALUES ('260', '登录', 'ZHOUJD', '2014-09-10 16:12:39', '');
INSERT INTO `slog` VALUES ('261', '登录', 'ZHOUJD', '2014-09-10 19:09:51', '');
INSERT INTO `slog` VALUES ('262', '登录', 'ZHOUJD', '2014-09-10 19:34:49', '');
INSERT INTO `slog` VALUES ('263', '登录', 'ZHOUJD', '2014-09-11 14:11:24', '');
INSERT INTO `slog` VALUES ('264', '修改供应商', 'ZHOUJD', '2014-09-11 14:49:33', 'manuemail:b@yecoo.com,remark:备注B,manutypeid:2,createdate:2013-02-21,manuid:5,statusid:1,manucontact:刘星,manuname:客户A,referee:推荐人,manutel:22222222,priority:11');
INSERT INTO `slog` VALUES ('265', '登录', 'ZHOUJD', '2014-09-11 15:20:18', '');
INSERT INTO `slog` VALUES ('266', '登录', 'ZHOUJD', '2014-09-11 15:30:35', '');
INSERT INTO `slog` VALUES ('267', '登录', 'ZHOUJD', '2014-09-11 15:34:50', '');
INSERT INTO `slog` VALUES ('268', '登录', 'ZHOUJD', '2014-09-11 15:38:28', '');
INSERT INTO `slog` VALUES ('269', '登录', 'ZHOUJD', '2014-09-11 15:42:05', '');
INSERT INTO `slog` VALUES ('270', '登录', 'ZHOUJD', '2014-09-11 15:49:07', '');
INSERT INTO `slog` VALUES ('271', '登录', 'ZHOUJD', '2014-09-11 15:49:45', '');
INSERT INTO `slog` VALUES ('272', '登录', 'ZHOUJD', '2014-09-11 18:58:06', '');
INSERT INTO `slog` VALUES ('273', '登录', 'ZHOUJD', '2014-09-11 19:05:24', '');
INSERT INTO `slog` VALUES ('274', '登录', 'ZHOUJD', '2014-09-11 19:38:06', '');
INSERT INTO `slog` VALUES ('275', '登录', 'ZHOUJD', '2014-09-11 19:38:50', '');
INSERT INTO `slog` VALUES ('276', '登录', 'ZHOUJD', '2014-09-11 19:39:51', '');
INSERT INTO `slog` VALUES ('277', '登录', 'ZHOUJD', '2014-09-18 10:48:34', '');
INSERT INTO `slog` VALUES ('278', '登录', 'ZHOUJD', '2014-09-18 11:42:46', '');
INSERT INTO `slog` VALUES ('279', '登录', 'ZHOUJD', '2014-09-18 11:44:26', '');
INSERT INTO `slog` VALUES ('280', '登录', 'ZHOUJD', '2014-09-18 11:46:29', '');
INSERT INTO `slog` VALUES ('281', '登录', 'ZHOUJD', '2014-09-18 11:47:44', '');
INSERT INTO `slog` VALUES ('282', '登录', 'ZHOUJD', '2014-09-18 11:49:16', '');
INSERT INTO `slog` VALUES ('283', '登录', 'ZHOUJD', '2014-09-18 11:50:19', '');
INSERT INTO `slog` VALUES ('284', '登录', 'ZHOUJD', '2014-09-18 14:15:12', '');
INSERT INTO `slog` VALUES ('285', '登录', 'ZHOUJD', '2014-09-18 14:18:18', '');
INSERT INTO `slog` VALUES ('286', '登录', 'ZHOUJD', '2014-09-18 14:18:46', '');
INSERT INTO `slog` VALUES ('287', '登录', 'ZHOUJD', '2014-09-18 14:19:31', '');
INSERT INTO `slog` VALUES ('288', '登录', 'ZHOUJD', '2014-09-18 14:20:34', '');
INSERT INTO `slog` VALUES ('289', '登录', 'ZHOUJD', '2014-09-18 14:24:24', '');
INSERT INTO `slog` VALUES ('290', '登录', 'ZHOUJD', '2014-09-18 15:20:46', '');
INSERT INTO `slog` VALUES ('291', '登录', 'ZHOUJD', '2014-09-18 15:32:22', '');
INSERT INTO `slog` VALUES ('292', '登录', 'ZHOUJD', '2014-09-18 15:34:01', '');
INSERT INTO `slog` VALUES ('293', '登录', 'ZHOUJD', '2014-09-18 15:42:26', '');
INSERT INTO `slog` VALUES ('294', '登录', 'ZHOUJD', '2014-09-18 15:45:38', '');
INSERT INTO `slog` VALUES ('295', '登录', 'ZHOUJD', '2014-09-25 16:32:01', '');
INSERT INTO `slog` VALUES ('296', '新增销售单', 'ZHOUJD', '2014-09-25 16:44:19', 'sellno:XSD-20140925-001,remark:null,maker:ZHOUJD,manuid:9,allrealsum:10984.9,allprofit:2673.78,manuname:客户B,createtime:2014-09-25 16:44:19,sellid:14,currflow:申请,selldate:2014-09-25');
INSERT INTO `slog` VALUES ('297', '修改销售单', 'ZHOUJD', '2014-09-25 16:52:31', 'sellno:XSD-20140925-001,remark:null,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:10984.9,allprofit:2673.78,manuname:客户B,createtime:2014-09-25 16:44:19,sellid:14,currflow:申请,selldate:2014-09-25,addBuy:1');
INSERT INTO `slog` VALUES ('298', '修改销售单', 'ZHOUJD', '2014-09-25 16:53:04', 'sellno:XSD-20140925-001,remark:null,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:10984.9,allprofit:2673.78,manuname:客户B,createtime:2014-09-25 16:44:19,sellid:14,currflow:申请,selldate:2014-09-25,addBuy:1');
INSERT INTO `slog` VALUES ('299', '修改销售单', 'ZHOUJD', '2014-09-25 16:55:52', 'sellno:XSD-20140925-001,remark:null,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:10984.9,allprofit:2673.78,manuname:客户B,createtime:2014-09-25 16:44:19,sellid:14,currflow:申请,selldate:2014-09-25,addBuy:1');
INSERT INTO `slog` VALUES ('300', '修改销售单', 'ZHOUJD', '2014-09-25 17:09:20', 'sellno:XSD-20140925-001,remark:null,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:10984.9,allprofit:2673.78,manuname:客户B,createtime:2014-09-25 16:44:19,sellid:14,currflow:申请,selldate:2014-09-25,addBuy:1');
INSERT INTO `slog` VALUES ('301', '登录', 'ZHOUJD', '2014-09-25 17:35:23', '');
INSERT INTO `slog` VALUES ('302', '登录', 'ZHOUJD', '2014-10-09 17:32:00', '');
INSERT INTO `slog` VALUES ('303', '登录', 'ZHOUJD', '2014-10-21 16:53:04', '');
INSERT INTO `slog` VALUES ('304', '登录', 'ZHOUJD', '2014-10-22 16:03:13', '');
INSERT INTO `slog` VALUES ('305', '修改用户', 'ZHOUJD', '2014-10-22 16:04:03', 'tele:null,birthday:null,username:测试账号,roleid:3,userid:CESHI');
INSERT INTO `slog` VALUES ('306', '登录', 'ZHOUJD', '2014-10-22 16:16:57', '');
INSERT INTO `slog` VALUES ('307', '修改模块', 'ZHOUJD', '2014-10-22 16:22:53', 'modulename:用户管理,sn:User,priority:1,description:用户管理-描述,moduleid:10101,parentid:101,rel:user_list,url:/user/list');
INSERT INTO `slog` VALUES ('308', '修改供应商', 'ZHOUJD', '2014-10-22 16:31:23', 'manuemail:b@yecoo.com,remark:备注B,manutypeid:2,createdate:2013-02-21,manuid:5,statusid:1,manucontact:刘星,manuname:客户A,referee:推荐人,manutel:22222222,priority:11');
INSERT INTO `slog` VALUES ('309', '登录', 'ZHOUJD', '2014-10-22 16:53:13', '');
INSERT INTO `slog` VALUES ('310', '修改银行卡', 'ZHOUJD', '2014-10-22 17:19:46', 'bankcardno:00000,accountname:现金,status:1,remark:此为现金,bankname:现金,priority:1,banktype:9,money:48438.44,bankcardid:1');
INSERT INTO `slog` VALUES ('311', '新增工资单', 'ZHOUJD', '2014-10-22 17:29:05', 'remark:null,maker:ZHOUJD,salaryno:GZD-20141022-001,salarytype:1,salaryname:2014年09月份工资单,createtime:2014-10-22 17:29:05,salaryid:11,salarydate:2014-09,allplanmoney:5730,currflow:结束');
INSERT INTO `slog` VALUES ('312', '登录', 'ZHOUJD', '2014-10-22 18:08:23', '');
INSERT INTO `slog` VALUES ('313', '新增工资单', 'ZHOUJD', '2014-10-22 18:18:35', 'remark:null,maker:ZHOUJD,salaryno:GZD-20141022-001,currflowname:申请,salarytype:1,salaryname:2014年09月份工资单,createtime:2014-10-22 18:18:35,salaryid:12,salarydate:2014-09,allplanmoney:5730,currflow:1');
INSERT INTO `slog` VALUES ('314', '新增工资单', 'ZHOUJD', '2014-10-22 18:19:57', 'remark:null,maker:ZHOUJD,salaryno:GZD-20141022-001,salarytype:1,salaryname:2014年09月份工资单,createtime:2014-10-22 18:19:57,salaryid:13,salarydate:2014-09,allplanmoney:5730,currflow:申请');
INSERT INTO `slog` VALUES ('315', '修改工资单', 'ZHOUJD', '2014-10-22 18:22:27', 'remark:null,maker:ZHOUJD,salarytypename:工资,makername:周坚定,salaryno:GZD-20141022-001,salarytype:1,salaryname:2014年09月份工资单,createtime:2014-10-22 18:19:57,salaryid:13,salarydate:2014-09,allplanmoney:5730,currflow:申请');
INSERT INTO `slog` VALUES ('316', '修改工资单', 'ZHOUJD', '2014-10-22 18:22:34', 'remark:null,maker:ZHOUJD,salarytypename:工资,makername:周坚定,salaryno:GZD-20141022-001,salarytype:1,salaryname:2014年09月份工资单,createtime:2014-10-22 18:19:57,salaryid:13,salarydate:2014-09,allplanmoney:5730,currflow:结束');
INSERT INTO `slog` VALUES ('317', '修改单据', 'ZHOUJD', '2014-10-22 18:23:28', 'btypename:工资单,operatetime:2014-10-22 18:23:28,remark:null,operater:ZHOUJD,allplansum:5730,makername:周坚定,createtime:2014-10-22 18:22:34,relateno:GZD-20141022-001,btype:GZD,maker:ZHOUJD,relatemoney:5730.00,paydate:2014-09,payid:61,allrealsum:5730,currflow:结束');
INSERT INTO `slog` VALUES ('318', '修改物资类型', 'ZHOUJD', '2014-10-22 18:27:10', 'materialtypeno:10101,remark:物资类型A-1备注,materialtypename:物资类型A-1,priority:1,parent:2,materialtype:5');
INSERT INTO `slog` VALUES ('319', '修改物资', 'ZHOUJD', '2014-10-22 18:27:26', 'unit:1,usestock:1,stock:307.00,price:0.22,remark:null,materialtypename:物资类型A-1,materialname:物资A11,createdate:2013-02-24,manuid:4,materialtype:5,materialno:10101001,manuname:供应商A,alarmnum:100.00,materialid:1');
INSERT INTO `slog` VALUES ('320', '修改销售单', 'ZHOUJD', '2014-10-22 18:35:41', 'sellno:XSD-20140925-001,remark:null,maker:ZHOUJD,manuid:5,makername:周坚定,allrealsum:10984.9,allprofit:2673.78,manuname:客户A,createtime:2014-09-25 16:44:19,sellid:14,currflow:结束,selldate:2014-09-25,addBuy:1');
INSERT INTO `slog` VALUES ('321', '修改单据', 'ZHOUJD', '2014-10-22 18:37:01', 'btypename:收款单,operatetime:2014-10-22 18:37:01,remark:null,operater:ZHOUJD,allplansum:10984.9,makername:周坚定,createtime:2014-10-22 18:35:41,relateno:XSD-20140925-001,btype:SKD,maker:ZHOUJD,relatemoney:10984.90,paydate:2014-09-25,payid:62,allrealsum:10984.9,currflow:结束');
INSERT INTO `slog` VALUES ('322', '修改采购单', 'ZHOUJD', '2014-10-22 18:38:35', 'btypename:采购单,remark:合并采购单（XSD-20140925-001）,allsum:13524.84,makername:周坚定,buyname:2014.10.22采购,createtime:2014-10-22 18:37:22,relateno:null,buyno:CGD-20141022-002,btype:CGD,maker:ZHOUJD,buyid:35,currflow:结束,buydate:2014-10-22');
INSERT INTO `slog` VALUES ('323', '修改单据', 'ZHOUJD', '2014-10-22 18:38:58', 'btypename:付款单,operatetime:2014-10-22 18:38:58,remark:null,operater:ZHOUJD,allplansum:13524.84,makername:周坚定,createtime:2014-10-22 18:38:35,relateno:CGD-20141022-002,btype:FKD,maker:ZHOUJD,relatemoney:13524.84,paydate:2014-10-22,payid:63,allrealsum:13524.84,currflow:结束');
INSERT INTO `slog` VALUES ('324', '登录', 'ZHOUJD', '2014-10-29 09:11:40', '');
INSERT INTO `slog` VALUES ('325', '登录', 'ZHOUJD', '2014-10-29 09:33:35', '');
INSERT INTO `slog` VALUES ('326', '登录', 'ZHOUJD', '2014-10-29 09:38:41', '');
INSERT INTO `slog` VALUES ('327', '登录', 'ZHOUJD', '2014-10-29 09:44:29', '');
INSERT INTO `slog` VALUES ('328', '登录', 'LINCC', '2014-10-29 09:44:58', '');
INSERT INTO `slog` VALUES ('329', '登录', 'LINCC', '2014-10-29 10:19:21', '');
INSERT INTO `slog` VALUES ('330', '修改物资类型', 'LINCC', '2014-10-29 10:19:41', 'materialtypeno:101,remark:物资类型A备注,materialtypename:物资类型A,priority:1,parent:1,materialtype:2');
INSERT INTO `slog` VALUES ('331', '新增物资类型', 'LINCC', '2014-10-29 10:20:03', 'materialtypeno:104,remark:,materialtypename:123,priority:99,parent:1');
INSERT INTO `slog` VALUES ('332', '修改物资类型', 'LINCC', '2014-10-29 10:20:10', 'materialtypeno:104,remark:null,materialtypename:123,priority:99,parent:1,materialtype:11');
INSERT INTO `slog` VALUES ('333', '修改物资类型', 'LINCC', '2014-10-29 10:20:16', 'materialtypeno:105,remark:null,materialtypename:123,priority:99,parent:1,materialtype:11');
INSERT INTO `slog` VALUES ('334', '登录', 'ZHOUJD', '2014-10-29 10:20:58', '');
INSERT INTO `slog` VALUES ('335', '删除物资类型', 'ZHOUJD', '2014-10-29 10:21:11', '11');
INSERT INTO `slog` VALUES ('336', '修改物资类型', 'ZHOUJD', '2014-10-29 10:21:35', 'materialtypeno:10101,remark:物资类型A-1备注,materialtypename:物资类型A-1,priority:1,parent:2,materialtype:5');
INSERT INTO `slog` VALUES ('337', '新增物资类型', 'ZHOUJD', '2014-10-29 10:21:41', 'materialtypeno:10104,remark:,materialtypename:33,priority:99,parent:2');
INSERT INTO `slog` VALUES ('338', '删除物资类型', 'ZHOUJD', '2014-10-29 10:22:41', '12');
INSERT INTO `slog` VALUES ('339', '新增物资类型', 'ZHOUJD', '2014-10-29 10:22:53', 'materialtypeno:A,remark:,materialtypename:AA,priority:99,parent:1');
INSERT INTO `slog` VALUES ('340', '删除物资类型', 'ZHOUJD', '2014-10-29 10:23:42', '13');
INSERT INTO `slog` VALUES ('341', '登录', 'ZHOUJD', '2014-10-29 10:28:32', '');
INSERT INTO `slog` VALUES ('342', '新增产品类型', 'ZHOUJD', '2014-10-29 10:29:43', 'producttypeno:204,remark:,producttypename:1,priority:99,parent:1');
INSERT INTO `slog` VALUES ('343', '修改产品类型', 'ZHOUJD', '2014-10-29 10:29:51', 'producttypeno:204,remark:null,producttypename:111,priority:99,parent:1,producttypeall:1-20,producttype:20');
INSERT INTO `slog` VALUES ('344', '修改产品类型', 'ZHOUJD', '2014-10-29 10:30:21', 'producttypeno:204,remark:null,producttypename:111,priority:99,parent:1,producttypeall:1-20,producttype:20');
INSERT INTO `slog` VALUES ('345', '删除产品类型', 'ZHOUJD', '2014-10-29 10:30:49', '20');
INSERT INTO `slog` VALUES ('346', '登录', 'ZHOUJD', '2014-10-29 10:41:59', '');
INSERT INTO `slog` VALUES ('347', '登录', 'ZHOUJD', '2014-10-29 10:42:21', '');
INSERT INTO `slog` VALUES ('348', '登录', 'ZHOUJD', '2014-10-29 10:42:48', '');
INSERT INTO `slog` VALUES ('349', '登录', 'ZHOUJD', '2014-10-29 10:45:51', '');
INSERT INTO `slog` VALUES ('350', '登录', 'ZHOUJD', '2014-10-29 10:46:18', '');
INSERT INTO `slog` VALUES ('351', '登录', 'ZHOUJD', '2014-10-29 10:46:25', '');
INSERT INTO `slog` VALUES ('352', '登录', 'ZHOUJD', '2014-10-29 11:14:53', '');
INSERT INTO `slog` VALUES ('353', '登录', 'ZHOUJD', '2014-10-29 11:14:53', '');
INSERT INTO `slog` VALUES ('354', '登录', 'ZHOUJD', '2014-11-11 17:03:56', '');
INSERT INTO `slog` VALUES ('355', '登录', 'ZHOUJD', '2014-11-13 18:05:05', '');
INSERT INTO `slog` VALUES ('356', '登录', 'ZHOUJD', '2014-11-14 10:21:47', '');
INSERT INTO `slog` VALUES ('357', '新增销售单', 'ZHOUJD', '2014-11-14 10:23:17', 'sellno:XSD-20141114-001,remark:null,maker:ZHOUJD,manuid:9,allrealsum:535.2,allprofit:107.08,manuname:客户B,createtime:2014-11-14 10:23:17,sellid:15,currflow:申请,selldate:2014-11-14');
INSERT INTO `slog` VALUES ('358', '修改销售单', 'ZHOUJD', '2014-11-14 10:24:02', 'sellno:XSD-20141114-001,remark:null,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:535.2,allprofit:107.08,manuname:客户B,createtime:2014-11-14 10:23:17,sellid:15,currflow:申请,selldate:2014-11-14,addBuy:1');
INSERT INTO `slog` VALUES ('359', '修改采购单', 'ZHOUJD', '2014-11-14 10:26:48', 'btypename:采购单,remark:null,allsum:314.92,makername:周坚定,buyname:2014.11.14采购,createtime:2014-11-14 10:24:02,relateno:XSD-20141114-001,buyno:CGD-20141114-001,btype:CGD,maker:ZHOUJD,buyid:36,currflow:结束,buydate:2014-11-14');
INSERT INTO `slog` VALUES ('360', '修改单据', 'ZHOUJD', '2014-11-14 10:28:13', 'btypename:付款单,operatetime:2014-11-14 10:28:12,remark:null,operater:ZHOUJD,allplansum:314.92,makername:周坚定,createtime:2014-11-14 10:26:48,relateno:CGD-20141114-001,btype:FKD,maker:ZHOUJD,relatemoney:314.92,paydate:2014-11-14,payid:64,allrealsum:314.92,currflow:申请');
INSERT INTO `slog` VALUES ('361', '修改单据', 'ZHOUJD', '2014-11-14 10:28:20', 'btypename:付款单,operatetime:2014-11-14 10:28:20,remark:null,operater:ZHOUJD,allplansum:314.92,makername:周坚定,createtime:2014-11-14 10:26:48,relateno:CGD-20141114-001,btype:FKD,maker:ZHOUJD,relatemoney:314.92,paydate:2014-11-14,payid:64,allrealsum:314.92,currflow:结束');
INSERT INTO `slog` VALUES ('362', '修改采购单', 'ZHOUJD', '2014-11-14 10:33:40', 'btypename:采购单,remark:null,allsum:314.92,makername:周坚定,buyname:2014.11.14采购,createtime:2014-11-14 10:24:02,relateno:XSD-20141114-001,buyno:CGD-20141114-001,btype:CGD,maker:ZHOUJD,buyid:36,currflow:申请,buydate:2014-11-14');
INSERT INTO `slog` VALUES ('363', '修改采购单', 'ZHOUJD', '2014-11-14 10:35:07', 'btypename:采购单,remark:null,allsum:314.92,makername:周坚定,buyname:2014.11.14采购,createtime:2014-11-14 10:24:02,relateno:XSD-20141114-001,buyno:CGD-20141114-001,btype:CGD,maker:ZHOUJD,buyid:36,currflow:结束,buydate:2014-11-14');
INSERT INTO `slog` VALUES ('364', '修改采购单', 'ZHOUJD', '2014-11-14 10:35:34', 'btypename:采购单,remark:null,allsum:314.92,makername:周坚定,buyname:2014.11.14采购,createtime:2014-11-14 10:24:02,relateno:XSD-20141114-001,buyno:CGD-20141114-001,btype:CGD,maker:ZHOUJD,buyid:36,currflow:结束,buydate:2014-11-14');
INSERT INTO `slog` VALUES ('365', '修改采购单', 'ZHOUJD', '2014-11-14 10:37:23', 'btypename:采购单,remark:null,allsum:314.92,makername:周坚定,buyname:2014.11.14采购,createtime:2014-11-14 10:24:02,relateno:XSD-20141114-001,buyno:CGD-20141114-001,btype:CGD,maker:ZHOUJD,buyid:36,currflow:结束,buydate:2014-11-14');
INSERT INTO `slog` VALUES ('366', '修改单据', 'ZHOUJD', '2014-11-14 10:39:03', 'btypename:付款单,operatetime:2014-11-14 10:39:02,remark:null,operater:ZHOUJD,allplansum:314.92,makername:周坚定,createtime:2014-11-14 10:26:48,relateno:CGD-20141114-001,btype:FKD,maker:ZHOUJD,relatemoney:314.92,paydate:2014-11-14,payid:64,allrealsum:314.92,currflow:结束');
INSERT INTO `slog` VALUES ('367', '登录', 'ZHOUJD', '2014-11-14 17:53:37', '');
INSERT INTO `slog` VALUES ('368', '修改销售单', 'ZHOUJD', '2014-11-14 18:01:34', 'sellno:XSD-20141114-001,remark:null,maker:ZHOUJD,manuid:9,makername:周坚定,allrealsum:535.2,allprofit:107.08,manuname:客户B,createtime:2014-11-14 10:23:17,sellid:15,currflow:结束,selldate:2014-11-14,addBuy:');
INSERT INTO `slog` VALUES ('369', '修改单据', 'ZHOUJD', '2014-11-14 18:01:46', 'btypename:收款单,operatetime:2014-11-14 18:01:46,remark:null,operater:ZHOUJD,allplansum:535.2,makername:周坚定,createtime:2014-11-14 18:01:34,relateno:XSD-20141114-001,btype:SKD,maker:ZHOUJD,relatemoney:535.20,paydate:2014-11-14,payid:68,allrealsum:535.2,currflow:结束');
INSERT INTO `slog` VALUES ('370', '登录', 'ZHOUJD', '2014-11-17 18:08:30', '');
INSERT INTO `slog` VALUES ('371', '登录', 'ZHOUJD', '2014-11-17 18:08:42', '');
INSERT INTO `slog` VALUES ('372', '登录', 'ZHOUJD', '2014-11-17 18:12:16', '');
INSERT INTO `slog` VALUES ('373', '登录', 'ZHOUJD', '2014-11-17 18:12:22', '');
INSERT INTO `slog` VALUES ('374', '登录', 'ZHOUJD', '2014-11-17 18:12:27', '');
INSERT INTO `slog` VALUES ('375', '登录', 'ZHOUJD', '2014-11-17 18:12:44', '');
INSERT INTO `slog` VALUES ('376', '登录', 'ZHOUJD', '2014-11-17 18:12:50', '');
INSERT INTO `slog` VALUES ('377', '登录', 'ZHOUJD', '2014-11-17 18:13:05', '');
INSERT INTO `slog` VALUES ('378', '登录', 'ZHOUJD', '2014-11-17 18:13:46', '');
INSERT INTO `slog` VALUES ('379', '登录', 'ZHOUJD', '2014-11-17 21:19:39', '');
INSERT INTO `slog` VALUES ('380', '新增销售单', 'ZHOUJD', '2014-11-17 22:40:16', 'sellno:XSD-20141117-001,profit:0,realprice:0.00,remark:null,costprice:0.00,planprice:0.00,productno:,sellrowid:,maker:ZHOUJD,manuid:5,allrealsum:0,allprofit:0,manuname:客户A,realsum:0,createtime:2014-11-17 22:40:16,unit:,num:0.00,productid:,sellid:16,currflow:申请,selldate:2014-11-17,remarkrow:,productname:');
INSERT INTO `slog` VALUES ('381', '删除销售单', 'ZHOUJD', '2014-11-17 22:40:25', '16');
INSERT INTO `slog` VALUES ('382', '新增采购单', 'ZHOUJD', '2014-11-17 22:57:56', 'btype:CGD,remark:null,allsum:,maker:ZHOUJD,buyname:2014.11.17采购,createtime:2014-11-17 22:57:56,buyid:37,currflow:申请,buydate:2014-11-17,buyno:CGD-20141117-001');
INSERT INTO `slog` VALUES ('383', '删除采购单', 'ZHOUJD', '2014-11-17 22:58:52', '44');
INSERT INTO `slog` VALUES ('384', '新增采购单', 'ZHOUJD', '2014-11-17 22:59:49', 'btype:CGD,remark:null,allsum:,maker:ZHOUJD,buyname:2014.11.17采购,createtime:2014-11-17 22:59:10,buyid:37,currflow:申请,buydate:2014-11-17,buyno:CGD-20141117-001');
INSERT INTO `slog` VALUES ('385', '登录', 'ZHOUJD', '2014-11-18 11:29:24', '');
INSERT INTO `slog` VALUES ('386', '登录', 'ZHOUJD', '2014-11-18 14:35:26', '');
INSERT INTO `slog` VALUES ('387', '新增采购单', 'ZHOUJD', '2014-11-18 15:08:56', 'btype:CGD,remark:null,allsum:,maker:ZHOUJD,buyname:2014.11.18采购,createtime:2014-11-18 15:08:56,buyid:37,currflow:申请,buydate:2014-11-18,buyno:CGD-20141118-001');
INSERT INTO `slog` VALUES ('388', '删除采购单', 'ZHOUJD', '2014-11-18 15:13:12', '37');
INSERT INTO `slog` VALUES ('389', '登录', 'ZHOUJD', '2014-11-18 15:14:24', '');
INSERT INTO `slog` VALUES ('390', '新增销售单', 'ZHOUJD', '2014-11-18 15:14:37', 'sellno:XSD-20141118-001,remark:null,maker:ZHOUJD,manuid:5,allrealsum:606.9,allprofit:89.86,manuname:客户A,createtime:2014-11-18 15:14:37,sellid:38,currflow:申请,selldate:2014-11-18');
INSERT INTO `slog` VALUES ('391', '修改销售单', 'ZHOUJD', '2014-11-18 15:14:50', 'sellno:XSD-20141118-001,remark:null,maker:ZHOUJD,manuid:5,makername:周坚定,allrealsum:606.9,allprofit:89.86,manuname:客户A,createtime:2014-11-18 15:14:37,sellid:38,currflow:申请,selldate:2014-11-18,addBuy:1');
INSERT INTO `slog` VALUES ('392', '登录', 'ZHOUJD', '2014-11-18 15:27:29', '');
INSERT INTO `slog` VALUES ('393', '修改采购单', 'ZHOUJD', '2014-11-18 15:27:39', 'btypename:采购单,remark:合并采购单（XSD-20141118-001）,allsum:396.04,makername:周坚定,buyname:2014.11.18采购,createtime:2014-11-18 15:15:09,relateno:null,buyno:CGD-20141118-002,btype:CGD,maker:ZHOUJD,buyid:40,currflow:申请,buydate:2014-11-18');
INSERT INTO `slog` VALUES ('394', '修改销售单', 'ZHOUJD', '2014-11-18 15:27:43', 'sellno:XSD-20141118-001,remark:null,maker:ZHOUJD,manuid:5,makername:周坚定,allrealsum:606.9,allprofit:89.86,manuname:客户A,createtime:2014-11-18 15:14:37,sellid:38,currflow:申请,selldate:2014-11-18,addBuy:');
INSERT INTO `slog` VALUES ('395', '修改销售单', 'ZHOUJD', '2014-11-18 15:27:53', 'sellno:XSD-20141118-001,remark:null,maker:ZHOUJD,manuid:5,makername:周坚定,allrealsum:606.9,allprofit:89.86,manuname:客户A,createtime:2014-11-18 15:14:37,sellid:38,currflow:申请,selldate:2014-11-18,addBuy:1');
INSERT INTO `slog` VALUES ('396', '删除采购单', 'ZHOUJD', '2014-11-18 15:28:38', '41');
INSERT INTO `slog` VALUES ('397', '修改销售单', 'ZHOUJD', '2014-11-18 15:29:13', 'sellno:XSD-20141118-001,remark:null,maker:ZHOUJD,manuid:5,makername:周坚定,allrealsum:606.9,allprofit:89.86,manuname:客户A,createtime:2014-11-18 15:14:37,sellid:38,currflow:申请,selldate:2014-11-18,addBuy:1');
INSERT INTO `slog` VALUES ('398', '修改销售单', 'ZHOUJD', '2014-11-18 15:29:25', 'sellno:XSD-20141118-001,remark:null,maker:ZHOUJD,manuid:5,makername:周坚定,allrealsum:606.9,allprofit:89.86,manuname:客户A,createtime:2014-11-18 15:14:37,sellid:38,currflow:申请,selldate:2014-11-18,addBuy:1');
INSERT INTO `slog` VALUES ('399', '登录', 'ZHOUJD', '2014-11-24 09:40:19', '');
INSERT INTO `slog` VALUES ('400', '登录', 'ZHOUJD', '2014-11-24 10:13:24', '');
INSERT INTO `slog` VALUES ('401', '登录', 'ZHOUJD', '2014-11-24 10:26:51', '');
INSERT INTO `slog` VALUES ('402', '登录', 'ZHOUJD', '2014-11-24 11:42:33', '');
INSERT INTO `slog` VALUES ('403', '登录', 'ZHOUJD', '2014-11-24 14:38:36', '');
INSERT INTO `slog` VALUES ('404', '登录', 'ZHOUJD', '2014-11-24 15:04:12', '');
INSERT INTO `slog` VALUES ('405', '新增产品', 'ZHOUJD', '2014-11-24 15:08:23', 'profit:0,realprice:0.00,remark:null,costprice:0,productno:20101004,producttypename:产品类别一1,createdate:2014-11-24 15:08:23,unit:1,productid:49,producttype:14,productname:abc');
INSERT INTO `slog` VALUES ('406', '删除产品', 'ZHOUJD', '2014-11-24 15:09:15', '49');
INSERT INTO `slog` VALUES ('407', '登录', 'ZHOUJD', '2014-11-24 15:11:01', '');
INSERT INTO `slog` VALUES ('408', '新增产品', 'ZHOUJD', '2014-11-24 15:11:10', 'profit:0,realprice:0.00,remark:null,costprice:0,productno:20101004,producttypename:产品类别一1,createdate:2014-11-24 15:11:10,unit:1,productid:52,producttype:14,productname:bb');
INSERT INTO `slog` VALUES ('409', '删除产品', 'ZHOUJD', '2014-11-24 15:14:03', '52');
INSERT INTO `slog` VALUES ('410', '新增产品', 'ZHOUJD', '2014-11-24 15:15:08', 'profit:0,realprice:0.00,remark:null,costprice:0,productno:20101004,producttypename:产品类别一1,createdate:2014-11-24 15:15:08,unit:1,productid:57,producttype:14,productname:bbb');
INSERT INTO `slog` VALUES ('411', '删除产品', 'ZHOUJD', '2014-11-24 15:18:33', '57');
INSERT INTO `slog` VALUES ('412', '登录', 'ZHOUJD', '2014-11-25 10:29:11', '');
INSERT INTO `slog` VALUES ('413', '新增产品', 'ZHOUJD', '2014-11-25 10:39:22', 'profit:0,realprice:0.00,remark:null,costprice:0,productno:20101004,producttypename:产品类别一1,createdate:2014-11-25 10:39:22,unit:1,productid:61,producttype:14,productname:dddd');
INSERT INTO `slog` VALUES ('414', '登录', 'ZHOUJD', '2014-11-25 10:41:02', '');
INSERT INTO `slog` VALUES ('415', '登录', 'ZHOUJD', '2014-11-25 10:47:44', '');
INSERT INTO `slog` VALUES ('416', '登录', 'ZHOUJD', '2014-11-25 11:12:24', '');
INSERT INTO `slog` VALUES ('417', '登录', 'ZHOUJD', '2014-11-25 11:23:48', '');
INSERT INTO `slog` VALUES ('418', '删除产品', 'ZHOUJD', '2014-11-25 11:42:34', '61');
INSERT INTO `slog` VALUES ('419', '登录', 'ZHOUJD', '2014-11-25 11:49:06', '');
INSERT INTO `slog` VALUES ('420', '修改产品', 'ZHOUJD', '2014-11-25 11:49:33', 'profit:75.56,realprice:123.20,remark:产品一备注,costprice:47.64,productno:20101001,producttypename:产品类别一1,createdate:2013-03-06,unit:1,productid:1,producttype:14,productname:产品1');
INSERT INTO `slog` VALUES ('421', '登录', 'ZHOUJD', '2014-11-25 14:20:45', '');
INSERT INTO `slog` VALUES ('422', '新增产品类型', 'ZHOUJD', '2014-11-25 14:29:39', 'producttypeno:JL04,remark:,producttypename:金龙系列,priority:4,parent:1');
INSERT INTO `slog` VALUES ('423', '修改产品类型', 'ZHOUJD', '2014-11-25 14:30:26', 'producttypeno:JL,remark:null,producttypename:金龙系列,priority:4,parent:1,producttypeall:1-18,producttype:18');
INSERT INTO `slog` VALUES ('424', '新增产品类型', 'ZHOUJD', '2014-11-25 14:31:00', 'producttypeno:JL01,remark:,producttypename:金龙淋浴,priority:1,parent:18');
INSERT INTO `slog` VALUES ('425', '新增产品类型', 'ZHOUJD', '2014-11-25 14:31:47', 'producttypeno:JL02,remark:,producttypename:金龙花洒,priority:2,parent:18');
INSERT INTO `slog` VALUES ('426', '新增产品类型', 'ZHOUJD', '2014-11-25 14:33:54', 'producttypeno:DL,remark:,producttypename:李德林,priority:5,parent:1');
INSERT INTO `slog` VALUES ('427', '新增产品类型', 'ZHOUJD', '2014-11-25 14:34:34', 'producttypeno:DL01,remark:,producttypename:金龙系列,priority:1,parent:21');
INSERT INTO `slog` VALUES ('428', '新增产品类型', 'ZHOUJD', '2014-11-25 14:34:58', 'producttypeno:DL0101,remark:,producttypename:金龙淋浴,priority:1,parent:22');
INSERT INTO `slog` VALUES ('429', '新增产品', 'ZHOUJD', '2014-11-25 14:36:30', 'profit:0,realprice:0.00,remark:null,costprice:0,productno:DL0101001,producttypename:金龙淋浴,createdate:2014-11-25 14:36:30,unit:1,productid:80,producttype:23,productname:树叶淋浴');
INSERT INTO `slog` VALUES ('430', '修改产品', 'ZHOUJD', '2014-11-25 14:37:30', 'profit:-32,realprice:0.00,remark:null,costprice:32,productno:DL0101001,producttypename:金龙淋浴,createdate:2014-11-25 14:36:30,unit:1,productid:80,producttype:23,productname:树叶淋浴');
INSERT INTO `slog` VALUES ('431', '修改产品类型', 'ZHOUJD', '2014-11-25 14:39:21', 'producttypeno:DL01,remark:null,producttypename:真龍系列,priority:1,parent:21,producttypeall:1-21-22,producttype:22');
INSERT INTO `slog` VALUES ('432', '修改产品类型', 'ZHOUJD', '2014-11-25 14:39:31', 'producttypeno:DL0101,remark:null,producttypename:真龍淋浴,priority:1,parent:22,producttypeall:1-21-22-23,producttype:23');
INSERT INTO `slog` VALUES ('433', '登录', 'ZHOUJD', '2014-11-25 14:50:07', '');
INSERT INTO `slog` VALUES ('434', '登录', 'ZHOUJD', '2014-11-25 15:42:26', '');
INSERT INTO `slog` VALUES ('435', '登录', 'ZHOUJD', '2014-11-25 15:43:27', '');
INSERT INTO `slog` VALUES ('436', '修改采购单', 'ZHOUJD', '2014-11-25 15:49:34', 'btypename:采购单,remark:合并采购单（XSD-20141118-001）,allsum:396.04,makername:周坚定,buyname:2014.11.18采购,createtime:2014-11-18 15:15:09,relateno:null,buyno:CGD-20141118-002,btype:CGD,maker:ZHOUJD,buyid:40,currflow:申请,buydate:2014-11-18');
INSERT INTO `slog` VALUES ('437', '修改用户', 'ZHOUJD', '2014-11-25 15:54:55', 'tele:null,birthday:null,username:测试账号,roleid:3,userid:CESHI');
INSERT INTO `slog` VALUES ('438', '修改模块', 'ZHOUJD', '2014-11-25 15:57:43', 'modulename:用户管理,sn:User,priority:1,description:用户管理-描述,moduleid:10101,parentid:101,rel:user_list,url:/user/list');
INSERT INTO `slog` VALUES ('439', '修改物资', 'ZHOUJD', '2014-11-25 16:02:45', 'unit:1,usestock:1,stock:956.00,price:0.22,remark:null,materialtypename:物资类型A-1,materialname:物资A11,createdate:2013-02-24,manuid:4,materialtype:5,materialno:10101001,manuname:供应商A,alarmnum:100.00,materialid:1');
INSERT INTO `slog` VALUES ('440', '修改产品', 'ZHOUJD', '2014-11-25 16:09:12', 'profit:10,realprice:42,remark:null,costprice:32,productno:DL0101001,producttypename:真龍淋浴,createdate:2014-11-25 14:36:30,unit:1,productid:80,producttype:23,productname:树叶淋浴');
INSERT INTO `slog` VALUES ('441', '修改销售单', 'ZHOUJD', '2014-11-25 16:09:30', 'sellno:XSD-20141118-001,remark:null,maker:ZHOUJD,manuid:5,makername:周坚定,allrealsum:690.9,allprofit:109.86,manuname:客户A,createtime:2014-11-18 15:14:37,sellid:38,currflow:申请,selldate:2014-11-18,addBuy:');
INSERT INTO `slog` VALUES ('442', '登录', 'ZHOUJD', '2014-11-26 09:17:06', '');
INSERT INTO `slog` VALUES ('443', '登录', 'ZHOUJD', '2014-11-26 10:50:13', '');
INSERT INTO `slog` VALUES ('444', '登录', 'ZHOUJD', '2014-11-26 10:52:29', '');
INSERT INTO `slog` VALUES ('445', '修改采购单', 'ZHOUJD', '2014-11-26 11:00:01', 'btypename:采购单,remark:合并采购单（XSD-20141118-001）,allsum:396.04,makername:周坚定,buyname:2014.11.18采购,createtime:2014-11-18 15:15:09,relateno:null,buyno:CGD-20141118-002,btype:CGD,maker:ZHOUJD,buyid:40,currflow:结束,buydate:2014-11-18');
INSERT INTO `slog` VALUES ('446', '修改单据', 'ZHOUJD', '2014-11-26 11:01:12', 'btypename:付款单,operatetime:2014-11-26 11:01:12,remark:null,operater:ZHOUJD,allplansum:396.04,makername:周坚定,createtime:2014-11-26 10:59:59,relateno:CGD-20141118-002,btype:FKD,maker:ZHOUJD,relatemoney:396.04,paydate:2014-11-18,payid:81,allrealsum:396.04,currflow:申请');
INSERT INTO `slog` VALUES ('447', '修改单据', 'ZHOUJD', '2014-11-26 11:01:24', 'btypename:付款单,operatetime:2014-11-26 11:01:22,remark:null,operater:ZHOUJD,allplansum:396.04,makername:周坚定,createtime:2014-11-26 10:59:59,relateno:CGD-20141118-002,btype:FKD,maker:ZHOUJD,relatemoney:396.04,paydate:2014-11-18,payid:81,allrealsum:396.04,currflow:结束');
INSERT INTO `slog` VALUES ('448', '登录', 'ZHOUJD', '2014-11-26 11:03:47', '');
INSERT INTO `slog` VALUES ('449', '修改销售单', 'ZHOUJD', '2014-11-26 11:04:41', 'sellno:XSD-20141118-001,remark:null,maker:ZHOUJD,manuid:5,makername:周坚定,allrealsum:690.9,allprofit:109.86,manuname:客户A,createtime:2014-11-18 15:14:37,sellid:38,currflow:申请,selldate:2014-11-18,addBuy:');
INSERT INTO `slog` VALUES ('450', '修改销售单', 'ZHOUJD', '2014-11-26 11:10:25', 'sellno:XSD-20141118-001,remark:null,maker:ZHOUJD,manuid:5,makername:周坚定,allrealsum:690.9,allprofit:109.86,manuname:客户A,createtime:2014-11-18 15:14:37,sellid:38,currflow:结束,selldate:2014-11-18,addBuy:');
INSERT INTO `slog` VALUES ('451', '修改单据', 'ZHOUJD', '2014-11-26 11:11:10', 'btypename:收款单,operatetime:2014-11-26 11:11:10,remark:null,operater:ZHOUJD,allplansum:690.9,makername:周坚定,createtime:2014-11-26 11:10:25,relateno:XSD-20141118-001,btype:SKD,maker:ZHOUJD,relatemoney:690.90,paydate:2014-11-18,payid:82,allrealsum:690.1,currflow:申请');
INSERT INTO `slog` VALUES ('452', '修改单据', 'ZHOUJD', '2014-11-26 11:11:15', 'btypename:收款单,operatetime:2014-11-26 11:11:15,remark:null,operater:ZHOUJD,allplansum:690.9,makername:周坚定,createtime:2014-11-26 11:10:25,relateno:XSD-20141118-001,btype:SKD,maker:ZHOUJD,relatemoney:690.90,paydate:2014-11-18,payid:82,allrealsum:690.1,currflow:结束');
INSERT INTO `slog` VALUES ('453', '修改员工', 'ZHOUJD', '2014-11-26 11:16:58', 'stafftype:1,accountno:33333333,accountname:员工三,remark:null,priority:3,tel:15060000021,staffstatus:1,staffid:5,bank:兴业银行仑仓支行,salary:75.00,staffname:员工三');
INSERT INTO `slog` VALUES ('454', '新增工资单', 'ZHOUJD', '2014-11-26 11:18:15', 'remark:null,maker:ZHOUJD,salaryno:GZD-20141126-001,salarytype:1,salaryname:2014年10月份工资单,createtime:2014-11-26 11:18:14,salaryid:83,salarydate:2014-10,allplanmoney:5740,currflow:申请');
INSERT INTO `slog` VALUES ('455', '修改工资单', 'ZHOUJD', '2014-11-26 11:25:26', 'remark:null,maker:ZHOUJD,salarytypename:工资,makername:周坚定,salaryno:GZD-20141126-001,salarytype:1,salaryname:2014年10月份工资单,createtime:2014-11-26 11:18:14,salaryid:83,salarydate:2014-10,allplanmoney:5740.1,currflow:结束');
INSERT INTO `slog` VALUES ('456', '修改单据', 'ZHOUJD', '2014-11-26 11:27:46', 'btypename:工资单,operatetime:2014-11-26 11:27:46,remark:null,operater:ZHOUJD,allplansum:5740.1,makername:周坚定,createtime:2014-11-26 11:25:25,relateno:GZD-20141126-001,btype:GZD,maker:ZHOUJD,relatemoney:5740.10,paydate:2014-10,payid:84,allrealsum:5740.6,currflow:申请');
INSERT INTO `slog` VALUES ('457', '修改单据', 'ZHOUJD', '2014-11-26 11:28:11', 'btypename:工资单,operatetime:2014-11-26 11:28:10,remark:null,operater:ZHOUJD,allplansum:5740.1,makername:周坚定,createtime:2014-11-26 11:25:25,relateno:GZD-20141126-001,btype:GZD,maker:ZHOUJD,relatemoney:5740.10,paydate:2014-10,payid:84,allrealsum:5741.5,currflow:结束');
INSERT INTO `slog` VALUES ('458', '登录', 'ZHOUJD', '2014-11-26 14:16:54', '');
INSERT INTO `slog` VALUES ('459', '修改采购单', 'ZHOUJD', '2014-11-26 14:30:21', 'btypename:采购单,remark:null,allsum:396.04,makername:周坚定,buyname:2014.11.18采购,createtime:2014-11-18 15:29:13,relateno:XSD-20141118-001,buyno:CGD-20141118-003,btype:CGD,maker:ZHOUJD,buyid:42,currflow:申请,buydate:2014-11-18');
INSERT INTO `slog` VALUES ('460', '修改银行卡', 'ZHOUJD', '2014-11-26 14:34:39', 'bankcardno:00000,accountname:现金,status:1,remark:此为现金,bankname:现金,priority:1,banktype:9,money:42695.32,bankcardid:1');
INSERT INTO `slog` VALUES ('461', '修改物资类型', 'ZHOUJD', '2014-11-26 14:35:01', 'materialtypeno:10101,remark:物资类型A-1备注,materialtypename:物资类型A-1,priority:1,parent:2,materialtype:5');
INSERT INTO `slog` VALUES ('462', '登录', 'ZHOUJD', '2014-11-26 14:37:55', '');
INSERT INTO `slog` VALUES ('463', '登录', 'ZHOUJD', '2014-11-26 14:38:10', '');

-- ----------------------------
-- Table structure for `smanu`
-- ----------------------------
DROP TABLE IF EXISTS `smanu`;
CREATE TABLE `smanu` (
  `manuid` int(4) NOT NULL COMMENT '供应商ID',
  `manuname` varchar(64) DEFAULT NULL COMMENT '供应商名称',
  `manutypeid` int(2) DEFAULT NULL COMMENT '供应商类别',
  `statusid` int(1) DEFAULT NULL COMMENT '供应商状态',
  `createdate` varchar(20) DEFAULT NULL COMMENT '创建日期',
  `manucontact` varchar(64) DEFAULT NULL COMMENT '联系人',
  `manutel` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `manuemail` varchar(64) DEFAULT NULL COMMENT 'EMAIL',
  `priority` int(3) DEFAULT '0' COMMENT '优先级',
  `referee` varchar(32) DEFAULT NULL COMMENT '推荐人',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`manuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商表';

-- ----------------------------
-- Records of smanu
-- ----------------------------
INSERT INTO `smanu` VALUES ('4', '供应商A', '1', '1', '2013-02-05', '周少华', '11111111', '', '41', null, '备注a');
INSERT INTO `smanu` VALUES ('5', '客户A', '2', '1', '2013-02-21', '刘星', '22222222', 'b@yecoo.com', '11', '推荐人', '备注B');
INSERT INTO `smanu` VALUES ('7', '物流A', '3', '1', '2013-02-21', '林长城', '33333333', '', '81', null, '');
INSERT INTO `smanu` VALUES ('8', '供应商B', '1', '1', '2013-02-25', '供应商B', '00000', '', '42', null, '');
INSERT INTO `smanu` VALUES ('9', '客户B', '2', '1', '2013-02-25', '无', '00000', '', '12', null, '');
INSERT INTO `smanu` VALUES ('10', '物流B', '3', '1', '2013-02-25', '无', '00000', '', '82', null, '');

-- ----------------------------
-- Table structure for `smanurow`
-- ----------------------------
DROP TABLE IF EXISTS `smanurow`;
CREATE TABLE `smanurow` (
  `manurowid` int(4) NOT NULL AUTO_INCREMENT COMMENT '供应商账号ID',
  `manuid` int(4) NOT NULL COMMENT '供应商ID',
  `bankrow` varchar(64) DEFAULT NULL COMMENT '开户银行',
  `accountnorow` varchar(32) DEFAULT NULL COMMENT '公司银行账号',
  `accountnamerow` varchar(64) DEFAULT NULL COMMENT '帐户名称',
  `priorityrow` int(2) DEFAULT '0' COMMENT '优先级',
  `remarkrow` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`manurowid`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8 COMMENT='供应商账号表';

-- ----------------------------
-- Records of smanurow
-- ----------------------------
INSERT INTO `smanurow` VALUES ('195', '7', '工商银行泉州分行', '33333333', '林长城', '9', null);
INSERT INTO `smanurow` VALUES ('196', '10', '建设银行南安支行', '66666666', '物流B', '9', null);
INSERT INTO `smanurow` VALUES ('197', '4', '建设银行泉州分行', '1111111111', '周少华', '1', null);
INSERT INTO `smanurow` VALUES ('198', '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '9', null);
INSERT INTO `smanurow` VALUES ('199', '9', '中国银行泉州分行', '2222222', '客户B', '1', null);
INSERT INTO `smanurow` VALUES ('201', '5', '中国银行泉州分行', '22222222', '刘星', '9', null);

-- ----------------------------
-- Table structure for `smaterial`
-- ----------------------------
DROP TABLE IF EXISTS `smaterial`;
CREATE TABLE `smaterial` (
  `materialid` int(5) NOT NULL AUTO_INCREMENT COMMENT '物资ID',
  `materialno` varchar(11) NOT NULL COMMENT '物资编码',
  `materialname` varchar(64) DEFAULT NULL COMMENT '物资名称',
  `materialtype` int(5) NOT NULL COMMENT '物资类型',
  `unit` int(3) DEFAULT NULL COMMENT '计量单位',
  `price` double(12,2) DEFAULT NULL COMMENT '单价',
  `manuid` int(9) DEFAULT NULL COMMENT '供应商',
  `usestock` varchar(1) DEFAULT NULL COMMENT '是否启用库存',
  `stock` double(12,2) DEFAULT NULL COMMENT '库存量',
  `alarmnum` double(12,2) DEFAULT NULL COMMENT '报警量',
  `createdate` varchar(19) DEFAULT NULL COMMENT '新增时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`materialid`),
  UNIQUE KEY `uni_smaterial_no` (`materialno`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of smaterial
-- ----------------------------
INSERT INTO `smaterial` VALUES ('1', '10101001', '物资A11', '5', '1', '0.22', '4', '1', '956.00', '100.00', '2013-02-24', '');
INSERT INTO `smaterial` VALUES ('4', '10201001', '物资B11', '8', '1', '33.30', '4', '0', '0.00', '0.00', '2013-03-04', '');
INSERT INTO `smaterial` VALUES ('5', '10201002', '物资B12', '8', '1', '44.00', '8', '1', '399.00', '100.00', '2013-03-04', '');
INSERT INTO `smaterial` VALUES ('6', '10102001', '物资A21', '6', '1', '43.20', '8', null, null, null, '2014-07-04', '');
INSERT INTO `smaterial` VALUES ('8', '10103001', '4', '7', '1', '4.00', '4', null, null, null, '2014-08-12 15:51:04', '');
INSERT INTO `smaterial` VALUES ('9', '10103002', '5', '7', '1', '5.00', '4', null, null, null, '2014-08-12 15:51:13', '');
INSERT INTO `smaterial` VALUES ('10', '10103003', '6', '7', '1', '6.00', '8', null, null, null, '2014-08-12 15:51:22', '');
INSERT INTO `smaterial` VALUES ('11', '10103004', '7', '7', '1', '7.00', '8', null, null, null, '2014-08-12 15:51:30', '');
INSERT INTO `smaterial` VALUES ('12', '10103005', '8', '7', '1', '8.00', '4', null, null, null, '2014-08-12 15:52:12', '');
INSERT INTO `smaterial` VALUES ('13', '10103006', '9', '7', '1', '9.00', '4', null, null, null, '2014-08-12 15:52:24', '');
INSERT INTO `smaterial` VALUES ('14', '10103007', '10', '7', '1', '10.00', '4', null, null, null, '2014-08-12 15:52:35', '');
INSERT INTO `smaterial` VALUES ('15', '10103008', '11', '7', '1', '11.00', '8', null, null, null, '2014-08-12 15:52:43', '');
INSERT INTO `smaterial` VALUES ('16', '10103009', '12', '7', '1', '12.00', '4', null, null, null, '2014-08-12 15:53:14', '');
INSERT INTO `smaterial` VALUES ('17', '10103010', '13', '7', '1', '13.00', '4', null, null, null, '2014-08-12 15:54:33', '');
INSERT INTO `smaterial` VALUES ('18', '10103011', '14', '7', '1', '14.00', '4', null, null, null, '2014-08-12 15:54:42', '');
INSERT INTO `smaterial` VALUES ('19', '10103012', '15', '7', '1', '15.00', '8', null, null, null, '2014-08-12 15:54:51', '');
INSERT INTO `smaterial` VALUES ('20', '10103013', '16', '7', '1', '16.00', '4', null, null, null, '2014-08-12 15:55:12', '');
INSERT INTO `smaterial` VALUES ('21', '10103014', '17', '7', '1', '17.00', '4', null, null, null, '2014-08-12 15:55:20', '');
INSERT INTO `smaterial` VALUES ('22', '10103015', '18', '7', '1', '18.00', '4', null, null, null, '2014-08-12 15:55:27', '');
INSERT INTO `smaterial` VALUES ('23', '10103016', '19', '7', '1', '19.00', '8', null, null, null, '2014-08-12 15:55:42', '');
INSERT INTO `smaterial` VALUES ('24', '10103017', '20', '7', '1', '20.00', '8', null, null, null, '2014-08-12 15:55:50', '');
INSERT INTO `smaterial` VALUES ('25', '10103018', '21', '7', '1', '21.00', '8', null, null, null, '2014-08-12 15:56:23', '');

-- ----------------------------
-- Table structure for `smaterialtype`
-- ----------------------------
DROP TABLE IF EXISTS `smaterialtype`;
CREATE TABLE `smaterialtype` (
  `materialtype` int(5) NOT NULL AUTO_INCREMENT COMMENT '物资类型主键',
  `materialtypeno` varchar(9) DEFAULT NULL COMMENT '物资类型编码',
  `materialtypename` varchar(64) NOT NULL COMMENT '物资类型名称',
  `priority` int(3) DEFAULT NULL COMMENT '优先级',
  `parent` varchar(8) DEFAULT NULL COMMENT '父级编号',
  `materialtypeall` varchar(64) DEFAULT NULL,
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`materialtype`),
  UNIQUE KEY `u_smaterialtype_no` (`materialtypeno`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of smaterialtype
-- ----------------------------
INSERT INTO `smaterialtype` VALUES ('1', '1', '根节点', '1', null, '1', null);
INSERT INTO `smaterialtype` VALUES ('2', '101', '物资类型A', '1', '1', '1-2', '物资类型A备注');
INSERT INTO `smaterialtype` VALUES ('3', '102', '物资类型B', '2', '1', '1-3', '物资类型B备注');
INSERT INTO `smaterialtype` VALUES ('4', '103', '物资类型C', '99', '1', '1-4', '');
INSERT INTO `smaterialtype` VALUES ('5', '10101', '物资类型A-1', '1', '2', '1-2-5', '物资类型A-1备注');
INSERT INTO `smaterialtype` VALUES ('6', '10102', '物资类型A-2', '2', '2', '1-2-6', '');
INSERT INTO `smaterialtype` VALUES ('7', '10103', '物资类型A-3', '99', '2', '1-2-7', '');
INSERT INTO `smaterialtype` VALUES ('8', '10201', '物资类型B-1', '1', '3', '1-3-8', '');
INSERT INTO `smaterialtype` VALUES ('9', '10202', '物资类型B-2', '99', '3', '1-3-9', '');
INSERT INTO `smaterialtype` VALUES ('10', '10301', '物资类型C-1', '99', '4', '1-4-10', '');

-- ----------------------------
-- Table structure for `smodule`
-- ----------------------------
DROP TABLE IF EXISTS `smodule`;
CREATE TABLE `smodule` (
  `moduleid` int(10) NOT NULL AUTO_INCREMENT COMMENT '模块ID',
  `modulename` varchar(64) NOT NULL COMMENT '模块名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `priority` int(3) DEFAULT '99' COMMENT '优先级（数值越小，优先级越高）',
  `url` varchar(128) DEFAULT NULL COMMENT '模块地址 ',
  `parentid` int(10) DEFAULT NULL COMMENT '父级ID',
  `sn` varchar(32) DEFAULT NULL COMMENT '授权名称',
  `rel` varchar(32) DEFAULT NULL COMMENT '页面标识',
  PRIMARY KEY (`moduleid`)
) ENGINE=InnoDB AUTO_INCREMENT=10134 DEFAULT CHARSET=utf8 COMMENT='模块表';

-- ----------------------------
-- Records of smodule
-- ----------------------------
INSERT INTO `smodule` VALUES ('1', '根模块', '所有模块的根节点，不能删除', '1', '#', null, null, null);
INSERT INTO `smodule` VALUES ('101', '系统管理', '系统管理-描述', '2', '', '1', 'Configs', '');
INSERT INTO `smodule` VALUES ('103', '其它管理', '其它管理-描述', '99', '', '1', 'Others', '');
INSERT INTO `smodule` VALUES ('10101', '用户管理', '用户管理-描述', '1', '/user/list', '101', 'User', 'user_list');
INSERT INTO `smodule` VALUES ('10102', '角色管理', '角色管理-描述', '2', '/role/list', '101', 'Role', 'role_list');
INSERT INTO `smodule` VALUES ('10105', '模块管理', '模块管理-描述', '3', '/module/tree', '101', 'Module', 'module_tree');
INSERT INTO `smodule` VALUES ('10106', '资料管理', '资料管理-描述', '3', '', '1', 'Datas', '');
INSERT INTO `smodule` VALUES ('10108', '公司信息管理', '公司信息管理', '99', '/company/edi/1', '10106', 'Company', 'company_edi');
INSERT INTO `smodule` VALUES ('10109', '供应商管理', '供应商管理', '99', '/manu/list?first=true', '10106', 'Manu', 'manu_list');
INSERT INTO `smodule` VALUES ('10110', '员工管理', '员工管理', '99', '/staff/list?first=true', '10106', 'Staff', 'staff_list');
INSERT INTO `smodule` VALUES ('10111', '财务管理', '财务管理', '4', '', '1', 'Finances', '');
INSERT INTO `smodule` VALUES ('10112', '银行卡管理', '银行卡管理', '99', '/bankcard/list?first=true', '10111', 'Bankcard', 'bankcard_list');
INSERT INTO `smodule` VALUES ('10113', '单据管理', '', '99', '/pay/list?first=true', '10111', 'Pay', 'pay_list');
INSERT INTO `smodule` VALUES ('10114', '物资管理', '', '5', '', '1', 'Materials', '');
INSERT INTO `smodule` VALUES ('10115', '物资类型管理', '', '1', '/materialtype/tree', '10114', 'Materialtype', 'materialtype_tree');
INSERT INTO `smodule` VALUES ('10116', '物资管理', '', '2', '/material/tree', '10114', 'Material', 'material_tree');
INSERT INTO `smodule` VALUES ('10117', '采购管理', '', '99', '/buy/list?first=true', '10114', 'Buy', 'buy_list');
INSERT INTO `smodule` VALUES ('10118', '产品管理', '', '6', '', '1', 'Products', '');
INSERT INTO `smodule` VALUES ('10119', '产品类别管理', '', '1', '/producttype/tree', '10118', 'Producttype', 'producttype_tree');
INSERT INTO `smodule` VALUES ('10120', '产品管理', '', '2', '/product/tree', '10118', 'Product', 'product_tree');
INSERT INTO `smodule` VALUES ('10121', '销售管理', '', '3', '/sell/list?first=true', '10118', 'Sell', 'sell_list');
INSERT INTO `smodule` VALUES ('10122', '工资管理', '', '99', '/salary/list?first=true', '10111', 'Salary', 'salary_list');
INSERT INTO `smodule` VALUES ('10123', '报表管理', '', '7', '', '1', 'Reports', '');
INSERT INTO `smodule` VALUES ('10124', '月度供应商报表', '', '1', '/report/reportBuy', '10123', 'ReportBuy', 'buy_report');
INSERT INTO `smodule` VALUES ('10125', '月度客户报表', '', '2', '/report/reportSell', '10123', 'ReportSell', 'sell_report');
INSERT INTO `smodule` VALUES ('10126', '月度综合报表', '', '3', '/report/reportColligate', '10123', 'ReportColligate', 'colligate_report');
INSERT INTO `smodule` VALUES ('10127', '综合统计报表', '', '8', '/report/reportStatistics', '10123', 'ReportStatistics', 'statistics_report');
INSERT INTO `smodule` VALUES ('10128', '综合产品报表', '', '5', '/report/reportProduct', '10123', 'ReportProduct', 'product_report');
INSERT INTO `smodule` VALUES ('10129', '综合物资报表', '', '4', '/report/reportMaterial', '10123', 'ReportMaterial', 'material_report');
INSERT INTO `smodule` VALUES ('10130', '综合供应商报表', '', '6', '/report/reportManu', '10123', 'ReportManu', 'manu_report');
INSERT INTO `smodule` VALUES ('10131', '综合客户报表', '', '7', '/report/reportClient', '10123', 'ReportClient', 'client_report');
INSERT INTO `smodule` VALUES ('10132', '日志管理', '', '1', '/log/list', '103', 'Log', 'log_list');
INSERT INTO `smodule` VALUES ('10133', '字典管理', '', '1', '/dict/list', '10106', 'Dict', 'dict_list');

-- ----------------------------
-- Table structure for `spermission`
-- ----------------------------
DROP TABLE IF EXISTS `spermission`;
CREATE TABLE `spermission` (
  `roleid` int(10) NOT NULL COMMENT '角色ID',
  `permission` varchar(255) NOT NULL COMMENT '资源代码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限表';

-- ----------------------------
-- Records of spermission
-- ----------------------------
INSERT INTO `spermission` VALUES ('3', 'Finances:view');
INSERT INTO `spermission` VALUES ('3', 'Salary:view');
INSERT INTO `spermission` VALUES ('3', 'Materials:view');
INSERT INTO `spermission` VALUES ('3', 'Buy:view');
INSERT INTO `spermission` VALUES ('3', 'Products:view');
INSERT INTO `spermission` VALUES ('3', 'Sell:view');
INSERT INTO `spermission` VALUES ('3', 'Reports:view');
INSERT INTO `spermission` VALUES ('3', 'ReportBuy:view');
INSERT INTO `spermission` VALUES ('3', 'ReportSell:view');
INSERT INTO `spermission` VALUES ('3', 'ReportColligate:view');
INSERT INTO `spermission` VALUES ('3', 'ReportMaterial:view');
INSERT INTO `spermission` VALUES ('3', 'ReportProduct:view');
INSERT INTO `spermission` VALUES ('3', 'ReportManu:view');
INSERT INTO `spermission` VALUES ('3', 'ReportClient:view');
INSERT INTO `spermission` VALUES ('3', 'ReportStatistics:view');
INSERT INTO `spermission` VALUES ('2', 'Datas:view');
INSERT INTO `spermission` VALUES ('2', 'Unit:view');
INSERT INTO `spermission` VALUES ('2', 'Unit:add');
INSERT INTO `spermission` VALUES ('2', 'Unit:edi');
INSERT INTO `spermission` VALUES ('2', 'Manu:view');
INSERT INTO `spermission` VALUES ('2', 'Manu:add');
INSERT INTO `spermission` VALUES ('2', 'Manu:edi');
INSERT INTO `spermission` VALUES ('2', 'Staff:view');
INSERT INTO `spermission` VALUES ('2', 'Staff:add');
INSERT INTO `spermission` VALUES ('2', 'Staff:edi');
INSERT INTO `spermission` VALUES ('2', 'Finances:view');
INSERT INTO `spermission` VALUES ('2', 'Pay:view');
INSERT INTO `spermission` VALUES ('2', 'Pay:add');
INSERT INTO `spermission` VALUES ('2', 'Pay:edi');
INSERT INTO `spermission` VALUES ('2', 'Salary:view');
INSERT INTO `spermission` VALUES ('2', 'Salary:add');
INSERT INTO `spermission` VALUES ('2', 'Salary:edi');
INSERT INTO `spermission` VALUES ('2', 'Materials:view');
INSERT INTO `spermission` VALUES ('2', 'Materialtype:view');
INSERT INTO `spermission` VALUES ('2', 'Materialtype:add');
INSERT INTO `spermission` VALUES ('2', 'Materialtype:edi');
INSERT INTO `spermission` VALUES ('2', 'Material:view');
INSERT INTO `spermission` VALUES ('2', 'Material:add');
INSERT INTO `spermission` VALUES ('2', 'Material:edi');
INSERT INTO `spermission` VALUES ('2', 'Buy:view');
INSERT INTO `spermission` VALUES ('2', 'Buy:add');
INSERT INTO `spermission` VALUES ('2', 'Buy:edi');
INSERT INTO `spermission` VALUES ('2', 'Products:view');
INSERT INTO `spermission` VALUES ('2', 'Producttype:view');
INSERT INTO `spermission` VALUES ('2', 'Producttype:add');
INSERT INTO `spermission` VALUES ('2', 'Producttype:edi');
INSERT INTO `spermission` VALUES ('2', 'Product:view');
INSERT INTO `spermission` VALUES ('2', 'Product:add');
INSERT INTO `spermission` VALUES ('2', 'Product:edi');
INSERT INTO `spermission` VALUES ('2', 'Sell:view');
INSERT INTO `spermission` VALUES ('2', 'Sell:add');
INSERT INTO `spermission` VALUES ('2', 'Sell:edi');
INSERT INTO `spermission` VALUES ('2', 'Reports:view');
INSERT INTO `spermission` VALUES ('2', 'ReportBuy:view');
INSERT INTO `spermission` VALUES ('2', 'ReportSell:view');
INSERT INTO `spermission` VALUES ('2', 'ReportColligate:view');
INSERT INTO `spermission` VALUES ('2', 'ReportMaterial:view');
INSERT INTO `spermission` VALUES ('2', 'ReportProduct:view');
INSERT INTO `spermission` VALUES ('2', 'ReportManu:view');
INSERT INTO `spermission` VALUES ('2', 'ReportClient:view');
INSERT INTO `spermission` VALUES ('2', 'ReportStatistics:view');
INSERT INTO `spermission` VALUES ('1', 'Configs:view');
INSERT INTO `spermission` VALUES ('1', 'User:view');
INSERT INTO `spermission` VALUES ('1', 'User:add');
INSERT INTO `spermission` VALUES ('1', 'User:edi');
INSERT INTO `spermission` VALUES ('1', 'User:delete');
INSERT INTO `spermission` VALUES ('1', 'Role:view');
INSERT INTO `spermission` VALUES ('1', 'Role:add');
INSERT INTO `spermission` VALUES ('1', 'Role:edi');
INSERT INTO `spermission` VALUES ('1', 'Role:delete');
INSERT INTO `spermission` VALUES ('1', 'Module:view');
INSERT INTO `spermission` VALUES ('1', 'Module:add');
INSERT INTO `spermission` VALUES ('1', 'Module:edi');
INSERT INTO `spermission` VALUES ('1', 'Module:delete');
INSERT INTO `spermission` VALUES ('1', 'Datas:view');
INSERT INTO `spermission` VALUES ('1', 'Dict:view');
INSERT INTO `spermission` VALUES ('1', 'Dict:add');
INSERT INTO `spermission` VALUES ('1', 'Dict:edi');
INSERT INTO `spermission` VALUES ('1', 'Dict:delete');
INSERT INTO `spermission` VALUES ('1', 'Company:view');
INSERT INTO `spermission` VALUES ('1', 'Company:add');
INSERT INTO `spermission` VALUES ('1', 'Company:edi');
INSERT INTO `spermission` VALUES ('1', 'Company:delete');
INSERT INTO `spermission` VALUES ('1', 'Manu:view');
INSERT INTO `spermission` VALUES ('1', 'Manu:add');
INSERT INTO `spermission` VALUES ('1', 'Manu:edi');
INSERT INTO `spermission` VALUES ('1', 'Manu:delete');
INSERT INTO `spermission` VALUES ('1', 'Staff:view');
INSERT INTO `spermission` VALUES ('1', 'Staff:add');
INSERT INTO `spermission` VALUES ('1', 'Staff:edi');
INSERT INTO `spermission` VALUES ('1', 'Staff:delete');
INSERT INTO `spermission` VALUES ('1', 'Finances:view');
INSERT INTO `spermission` VALUES ('1', 'Bankcard:view');
INSERT INTO `spermission` VALUES ('1', 'Bankcard:add');
INSERT INTO `spermission` VALUES ('1', 'Bankcard:edi');
INSERT INTO `spermission` VALUES ('1', 'Bankcard:other');
INSERT INTO `spermission` VALUES ('1', 'Pay:view');
INSERT INTO `spermission` VALUES ('1', 'Pay:add');
INSERT INTO `spermission` VALUES ('1', 'Pay:edi');
INSERT INTO `spermission` VALUES ('1', 'Pay:delete');
INSERT INTO `spermission` VALUES ('1', 'Pay:other');
INSERT INTO `spermission` VALUES ('1', 'Salary:view');
INSERT INTO `spermission` VALUES ('1', 'Salary:add');
INSERT INTO `spermission` VALUES ('1', 'Salary:edi');
INSERT INTO `spermission` VALUES ('1', 'Salary:delete');
INSERT INTO `spermission` VALUES ('1', 'Materials:view');
INSERT INTO `spermission` VALUES ('1', 'Materialtype:view');
INSERT INTO `spermission` VALUES ('1', 'Materialtype:add');
INSERT INTO `spermission` VALUES ('1', 'Materialtype:edi');
INSERT INTO `spermission` VALUES ('1', 'Materialtype:delete');
INSERT INTO `spermission` VALUES ('1', 'Material:view');
INSERT INTO `spermission` VALUES ('1', 'Material:add');
INSERT INTO `spermission` VALUES ('1', 'Material:edi');
INSERT INTO `spermission` VALUES ('1', 'Material:delete');
INSERT INTO `spermission` VALUES ('1', 'Buy:view');
INSERT INTO `spermission` VALUES ('1', 'Buy:add');
INSERT INTO `spermission` VALUES ('1', 'Buy:edi');
INSERT INTO `spermission` VALUES ('1', 'Buy:delete');
INSERT INTO `spermission` VALUES ('1', 'Products:view');
INSERT INTO `spermission` VALUES ('1', 'Producttype:view');
INSERT INTO `spermission` VALUES ('1', 'Producttype:add');
INSERT INTO `spermission` VALUES ('1', 'Producttype:edi');
INSERT INTO `spermission` VALUES ('1', 'Producttype:delete');
INSERT INTO `spermission` VALUES ('1', 'Product:view');
INSERT INTO `spermission` VALUES ('1', 'Product:add');
INSERT INTO `spermission` VALUES ('1', 'Product:edi');
INSERT INTO `spermission` VALUES ('1', 'Product:delete');
INSERT INTO `spermission` VALUES ('1', 'Sell:view');
INSERT INTO `spermission` VALUES ('1', 'Sell:add');
INSERT INTO `spermission` VALUES ('1', 'Sell:edi');
INSERT INTO `spermission` VALUES ('1', 'Sell:delete');
INSERT INTO `spermission` VALUES ('1', 'Sell:other');
INSERT INTO `spermission` VALUES ('1', 'Reports:view');
INSERT INTO `spermission` VALUES ('1', 'ReportBuy:view');
INSERT INTO `spermission` VALUES ('1', 'ReportSell:view');
INSERT INTO `spermission` VALUES ('1', 'ReportColligate:view');
INSERT INTO `spermission` VALUES ('1', 'ReportMaterial:view');
INSERT INTO `spermission` VALUES ('1', 'ReportProduct:view');
INSERT INTO `spermission` VALUES ('1', 'ReportManu:view');
INSERT INTO `spermission` VALUES ('1', 'ReportClient:view');
INSERT INTO `spermission` VALUES ('1', 'ReportStatistics:view');
INSERT INTO `spermission` VALUES ('1', 'Others:view');
INSERT INTO `spermission` VALUES ('1', 'Log:view');
INSERT INTO `spermission` VALUES ('1', 'Log:edi');

-- ----------------------------
-- Table structure for `sproduct`
-- ----------------------------
DROP TABLE IF EXISTS `sproduct`;
CREATE TABLE `sproduct` (
  `productid` int(9) NOT NULL COMMENT '产品ID',
  `productno` varchar(11) NOT NULL COMMENT '产品编码',
  `productname` varchar(64) DEFAULT NULL COMMENT '产品名称',
  `producttype` int(5) DEFAULT NULL COMMENT '产品类型',
  `unit` int(3) DEFAULT NULL COMMENT '计量单位',
  `costprice` double(12,2) DEFAULT NULL COMMENT '成本',
  `profit` double(12,2) DEFAULT NULL COMMENT '利润',
  `realprice` double(12,2) NOT NULL COMMENT '产品单价',
  `createdate` varchar(19) DEFAULT NULL COMMENT '新增日期',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`productid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
-- Records of sproduct
-- ----------------------------
INSERT INTO `sproduct` VALUES ('1', '20101001', '产品1', '14', '1', '47.64', '75.56', '123.20', '2013-03-06', '产品一备注');
INSERT INTO `sproduct` VALUES ('2', '20101002', '产品2', '14', '1', '190.24', '10.26', '200.50', '2014-07-12', '');
INSERT INTO `sproduct` VALUES ('3', '20101003', '产品3', '14', '1', '163.40', '39.80', '203.20', '2014-07-12', '');
INSERT INTO `sproduct` VALUES ('5', '20102001', '产品8', '15', '1', '33.30', '9.80', '43.10', '2014-08-11', '');
INSERT INTO `sproduct` VALUES ('80', 'DL0101001', '树叶淋浴', '23', '1', '32.00', '10.00', '42.00', '2014-11-25 14:36:30', '');

-- ----------------------------
-- Table structure for `sproductrow`
-- ----------------------------
DROP TABLE IF EXISTS `sproductrow`;
CREATE TABLE `sproductrow` (
  `productrowid` int(9) NOT NULL AUTO_INCREMENT COMMENT '行项ID',
  `productid` int(9) DEFAULT NULL COMMENT '产品ID',
  `materialid` int(9) DEFAULT NULL COMMENT '物资ID',
  `materialno` varchar(13) DEFAULT NULL COMMENT '物资编号',
  `materialname` varchar(64) DEFAULT NULL COMMENT '物资名称',
  `materialprice` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '物资单价',
  `materialnum` double(9,2) NOT NULL DEFAULT '0.00' COMMENT '物资数量',
  `materialsum` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '物资总价',
  `remarkrow` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`productrowid`)
) ENGINE=InnoDB AUTO_INCREMENT=262 DEFAULT CHARSET=utf8 COMMENT='产品行项表';

-- ----------------------------
-- Records of sproductrow
-- ----------------------------
INSERT INTO `sproductrow` VALUES ('232', '2', '1', '10101001', '物资A11', '0.22', '22.00', '4.84', null);
INSERT INTO `sproductrow` VALUES ('233', '2', '6', '10102001', '物资A21', '43.20', '2.00', '86.40', null);
INSERT INTO `sproductrow` VALUES ('234', '2', '5', '10201002', '物资B12', '44.00', '1.00', '44.00', null);
INSERT INTO `sproductrow` VALUES ('235', '2', null, null, '其他成本', '22.00', '1.00', '22.00', null);
INSERT INTO `sproductrow` VALUES ('236', '2', null, null, '人力成本', '33.00', '1.00', '33.00', null);
INSERT INTO `sproductrow` VALUES ('237', '3', '6', '10102001', '物资A21', '43.20', '2.00', '86.40', null);
INSERT INTO `sproductrow` VALUES ('238', '3', '5', '10201002', '物资B12', '44.00', '1.00', '44.00', null);
INSERT INTO `sproductrow` VALUES ('239', '3', null, null, '其他成本', '11.00', '1.00', '11.00', null);
INSERT INTO `sproductrow` VALUES ('240', '3', null, null, '人力成本', '22.00', '1.00', '22.00', null);
INSERT INTO `sproductrow` VALUES ('241', '5', '4', '10201001', '物资B11', '33.30', '1.00', '33.30', null);
INSERT INTO `sproductrow` VALUES ('250', '1', '5', '10201002', '物资B12', '44.00', '1.00', '44.00', null);
INSERT INTO `sproductrow` VALUES ('251', '1', '1', '10101001', '物资A11', '0.22', '2.00', '0.44', null);
INSERT INTO `sproductrow` VALUES ('252', '1', null, null, '其他成本', '1.20', '1.00', '1.20', null);
INSERT INTO `sproductrow` VALUES ('253', '1', null, null, '人力成本', '2.00', '1.00', '2.00', null);
INSERT INTO `sproductrow` VALUES ('259', '80', null, null, '人力成本', '4.00', '1.00', '4.00', null);
INSERT INTO `sproductrow` VALUES ('260', '80', null, null, '其他成本', '5.00', '1.00', '5.00', null);
INSERT INTO `sproductrow` VALUES ('261', '80', null, null, '手把', '23.00', '1.00', '23.00', null);

-- ----------------------------
-- Table structure for `sproducttype`
-- ----------------------------
DROP TABLE IF EXISTS `sproducttype`;
CREATE TABLE `sproducttype` (
  `producttype` int(5) NOT NULL AUTO_INCREMENT COMMENT '产品类别主键',
  `producttypeno` varchar(9) DEFAULT NULL COMMENT '产品类别编号',
  `producttypename` varchar(64) NOT NULL COMMENT '产品类别名称',
  `priority` int(3) DEFAULT NULL COMMENT '优先级',
  `parent` varchar(8) DEFAULT NULL COMMENT '父级编号',
  `producttypeall` varchar(64) DEFAULT NULL,
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`producttype`),
  UNIQUE KEY `u_sproducttype_no` (`producttypeno`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sproducttype
-- ----------------------------
INSERT INTO `sproducttype` VALUES ('1', '2', '根节点', '1', null, '1', null);
INSERT INTO `sproducttype` VALUES ('11', '201', '产品类别一', '1', '1', '1-11', '');
INSERT INTO `sproducttype` VALUES ('12', '202', '产品类别二', '2', '1', '1-12', '产品类别二');
INSERT INTO `sproducttype` VALUES ('13', '203', '产品类别三', '3', '1', '1-13', '产品类别三');
INSERT INTO `sproducttype` VALUES ('14', '20101', '产品类别一1', '1', '11', '1-11-14', '产品类别一1');
INSERT INTO `sproducttype` VALUES ('15', '20102', '产品类别一2', '2', '11', '1-11-15', '产品类别一2');
INSERT INTO `sproducttype` VALUES ('16', '20201', '产品类别二1', '1', '12', '1-12-16', '产品类别二1');
INSERT INTO `sproducttype` VALUES ('17', '20202', '产品类别二2', '2', '12', '1-12-17', '');
INSERT INTO `sproducttype` VALUES ('18', 'JL', '金龙系列', '4', '1', '1-18', '');
INSERT INTO `sproducttype` VALUES ('19', 'JL01', '金龙淋浴', '1', '18', '1-18-19', '');
INSERT INTO `sproducttype` VALUES ('20', 'JL02', '金龙花洒', '2', '18', '1-18-20', '');
INSERT INTO `sproducttype` VALUES ('21', 'DL', '李德林', '5', '1', '1-21', '');
INSERT INTO `sproducttype` VALUES ('22', 'DL01', '真龍系列', '1', '21', '1-21-22', '');
INSERT INTO `sproducttype` VALUES ('23', 'DL0101', '真龍淋浴', '1', '22', '1-21-22-23', '');

-- ----------------------------
-- Table structure for `srole`
-- ----------------------------
DROP TABLE IF EXISTS `srole`;
CREATE TABLE `srole` (
  `roleid` int(10) NOT NULL COMMENT '角色编号',
  `rolename` varchar(128) NOT NULL COMMENT '角色名称',
  `priority` int(4) DEFAULT '99' COMMENT '优先级（数据越小，优先级越高）',
  PRIMARY KEY (`roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of srole
-- ----------------------------
INSERT INTO `srole` VALUES ('1', '管理员', '2');
INSERT INTO `srole` VALUES ('2', '普通用户', '3');
INSERT INTO `srole` VALUES ('3', '游客', '4');

-- ----------------------------
-- Table structure for `sstaff`
-- ----------------------------
DROP TABLE IF EXISTS `sstaff`;
CREATE TABLE `sstaff` (
  `staffid` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工编号',
  `staffname` varchar(32) DEFAULT NULL COMMENT '员工姓名',
  `stafftype` int(1) DEFAULT NULL COMMENT '员工类别（默认：正式员工）',
  `staffstatus` int(1) DEFAULT NULL COMMENT '员工状态（默认：在职）',
  `tel` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `bank` varchar(64) DEFAULT NULL COMMENT '工资开户银行',
  `accountno` varchar(32) DEFAULT NULL COMMENT '工资银行账号',
  `accountname` varchar(64) DEFAULT NULL COMMENT '工资帐户名称',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  `salary` double(12,2) DEFAULT NULL COMMENT '工资',
  `priority` int(2) DEFAULT '0' COMMENT '优先级',
  `photo` varchar(64) DEFAULT NULL COMMENT '照片路径',
  PRIMARY KEY (`staffid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='员工表';

-- ----------------------------
-- Records of sstaff
-- ----------------------------
INSERT INTO `sstaff` VALUES ('2', '员工一', '1', '1', '11111111', '建设银行南安支行', '11111111', '员工一', '备注1', '53.00', '1', null);
INSERT INTO `sstaff` VALUES ('3', '员工二', '1', '1', '22222222', '建设银行南安支行', '22222222', '员工二', '备注2', '63.00', '2', null);
INSERT INTO `sstaff` VALUES ('4', '员工三', '1', '2', '33333333', '建设银行南安支行', '33333333', '员工三', '', null, '0', null);
INSERT INTO `sstaff` VALUES ('5', '员工三', '1', '1', '15060000021', '兴业银行仑仓支行', '33333333', '员工三', '', '75.00', '3', null);

-- ----------------------------
-- Table structure for `suser`
-- ----------------------------
DROP TABLE IF EXISTS `suser`;
CREATE TABLE `suser` (
  `userid` varchar(64) NOT NULL COMMENT '用户账号',
  `username` varchar(128) NOT NULL COMMENT '用户名称',
  `passwd` varchar(128) NOT NULL COMMENT '用户密码',
  `tele` varchar(32) DEFAULT NULL COMMENT '手机号码',
  `valid` varchar(1) DEFAULT '1' COMMENT '是否有效（1：是，其它：否）',
  `birthday` varchar(10) DEFAULT NULL COMMENT '出生日期',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of suser
-- ----------------------------
INSERT INTO `suser` VALUES ('CESHI', '测试账号', '21218cca77804d2ba1922c33e0151105', '', '1', '');
INSERT INTO `suser` VALUES ('LINCC', '林长城', '21218cca77804d2ba1922c33e0151105', '18979578121', '1', '2013-01-01');
INSERT INTO `suser` VALUES ('ZH112014', '张红', '21218cca77804d2ba1922c33e0151105', '18979172171', '1', '2013-01-01');
INSERT INTO `suser` VALUES ('ZH112208', '张宏', '21218cca77804d2ba1922c33e0151105', '18979576017', '1', '2012-12-06');
INSERT INTO `suser` VALUES ('ZHD103272', '朱宏东', '21218cca77804d2ba1922c33e0151105', '18979372566', '0', null);
INSERT INTO `suser` VALUES ('ZHD105069', '邹海东', '21218cca77804d2ba1922c33e0151105', '18979275921', '1', '');
INSERT INTO `suser` VALUES ('ZHF103099', '章海峰', '21218cca77804d2ba1922c33e0151105', '18979376001', '1', null);
INSERT INTO `suser` VALUES ('ZHJ301206', '邹惠娟', '21218cca77804d2ba1922c33e0151105', '18979172594', '1', null);
INSERT INTO `suser` VALUES ('ZHM103839', '祝敏慧', '21218cca77804d2ba1922c33e0151105', '18979371121', '1', null);
INSERT INTO `suser` VALUES ('ZHM110447', '郑宏梅', '21218cca77804d2ba1922c33e0151105', '18979472833', '1', null);
INSERT INTO `suser` VALUES ('ZHOUJD', '周坚定', '21218cca77804d2ba1922c33e0151105', '059122222222', '1', '1986-09-19');
INSERT INTO `suser` VALUES ('ZHQ110244', '郑华清', '21218cca77804d2ba1922c33e0151105', '18979470368', '1', null);
INSERT INTO `suser` VALUES ('ZHS103676', '张海生', '21218cca77804d2ba1922c33e0151105', '18979376181', '1', null);
INSERT INTO `suser` VALUES ('ZHS104149', '朱洪水', '21218cca77804d2ba1922c33e0151105', '18979273113', '1', null);
INSERT INTO `suser` VALUES ('ZHS112987', '邹焕松', '21218cca77804d2ba1922c33e0151105', '18979170119', '1', null);
INSERT INTO `suser` VALUES ('ZW113015', '张伟', '21218cca77804d2ba1922c33e0151105', '18979172586', '1', null);
INSERT INTO `suser` VALUES ('ZWB103784', '占卫斌', '21218cca77804d2ba1922c33e0151105', '18979371927', '1', null);
INSERT INTO `suser` VALUES ('ZWD123117', '曾文迪', '21218cca77804d2ba1922c33e0151105', '18979172001', '1', null);
INSERT INTO `suser` VALUES ('ZWF103071', '周文锋', '21218cca77804d2ba1922c33e0151105', '18979376218', '1', null);
INSERT INTO `suser` VALUES ('ZWJ110683', '周文建', '21218cca77804d2ba1922c33e0151105', '18979578401', '1', null);
INSERT INTO `suser` VALUES ('ZWP103093', '赵维平', '21218cca77804d2ba1922c33e0151105', '18979376155', '1', null);
INSERT INTO `suser` VALUES ('ZWQ105325', '周文启', '21218cca77804d2ba1922c33e0151105', '18979274169', '1', null);
INSERT INTO `suser` VALUES ('ZWQ112737', '曾卫强', '21218cca77804d2ba1922c33e0151105', '18979172022', '1', null);
INSERT INTO `suser` VALUES ('ZWZ111693', '周文政', '21218cca77804d2ba1922c33e0151105', '18979578541', '1', null);
INSERT INTO `suser` VALUES ('ZX100099', '张鑫', '21218cca77804d2ba1922c33e0151105', '18979278998', '1', null);

-- ----------------------------
-- Table structure for `suser_role`
-- ----------------------------
DROP TABLE IF EXISTS `suser_role`;
CREATE TABLE `suser_role` (
  `userid` varchar(64) NOT NULL DEFAULT '' COMMENT '用户账号',
  `roleid` int(10) NOT NULL COMMENT '角色编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';

-- ----------------------------
-- Records of suser_role
-- ----------------------------
INSERT INTO `suser_role` VALUES ('ZHOUJD', '1');
INSERT INTO `suser_role` VALUES ('ZH112014', '3');
INSERT INTO `suser_role` VALUES ('LINCC', '2');
INSERT INTO `suser_role` VALUES ('CESHI', '3');

-- ----------------------------
-- Procedure structure for `proc_dbinit`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_dbinit`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_dbinit`()
    COMMENT '数据库初始化'
BEGIN
	TRUNCATE TABLE bbuy;
	TRUNCATE TABLE bbuyrow;
	TRUNCATE TABLE bpay;
	TRUNCATE TABLE bpayrow;
	TRUNCATE TABLE breceandpay;
	TRUNCATE TABLE bsalary;
	TRUNCATE TABLE bsalaryrow;
	TRUNCATE TABLE bsell;
	TRUNCATE TABLE bsellrow;
	TRUNCATE TABLE btransferaccount;
	TRUNCATE TABLE bwork;
	TRUNCATE TABLE bworkrow;
	TRUNCATE TABLE sbankcard;
	TRUNCATE TABLE slog;
	TRUNCATE TABLE smanu;
	TRUNCATE TABLE smanurow;
	TRUNCATE TABLE smaterial;
	TRUNCATE TABLE sproduct;
	TRUNCATE TABLE sproductrow;
	TRUNCATE TABLE sstaff;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `func_getBankcardno`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getBankcardno`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getBankcardno`(ibankcardid int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vbankcardno VARCHAR(255);

    SELECT bankcardno INTO vbankcardno FROM sbankcard WHERE bankcardid = ibankcardid;

		return vbankcardno;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `func_getDictName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getDictName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getDictName`(vdicttype varchar(32), vdictvalue varchar(32)) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vdictname VARCHAR(255);

    SELECT dictname INTO vdictname FROM cdictrow a WHERE dictvalue = vdictvalue AND EXISTS (SELECT 1 FROM cdict b WHERE b.dictid = a.dictid AND b.dicttype = vdicttype);

		return vdictname;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `func_getManuName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getManuName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getManuName`(imanuid int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vmanuname VARCHAR(255);

    SELECT manuname INTO vmanuname FROM smanu WHERE manuid = imanuid;

		return vmanuname;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `func_getMaterialtypeName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getMaterialtypeName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getMaterialtypeName`(imaterialtype int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vmaterialtypename VARCHAR(255);

    SELECT materialtypename INTO vmaterialtypename FROM smaterialtype WHERE materialtype = imaterialtype;

		return vmaterialtypename;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `func_getModuleName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getModuleName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getModuleName`(`imoduleid` int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vmodulename VARCHAR(255);

    SELECT modulename INTO vmodulename FROM smodule WHERE moduleid = imoduleid;

		return vmodulename;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `func_getProducttypeName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getProducttypeName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getProducttypeName`(iproducttype int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vproducttypename VARCHAR(255);

    SELECT producttypename INTO vproducttypename FROM sproducttype WHERE producttype = iproducttype;

		return vproducttypename;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `func_getSalaryByMonth`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getSalaryByMonth`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getSalaryByMonth`(istaffid int, vworkmonth varchar(7)) RETURNS double(12,2)
BEGIN
		DECLARE isum DOUBLE(12,2);
		SET isum = 0.00;
		
		SELECT IFNULL(SUM(a.salary), 0) INTO isum FROM bworkrow a, bwork b WHERE a.workid = b.workid AND b.staffid = istaffid AND b.workmonth = vworkmonth;

		return isum;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `func_getStaffName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getStaffName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getStaffName`(istaffid int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vstaffname VARCHAR(255);

    SELECT staffname INTO vstaffname FROM sstaff WHERE staffid = istaffid;

		return vstaffname;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `func_getSum`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getSum`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getSum`(iid int, vbtype varchar(3)) RETURNS double(12,2)
BEGIN
		DECLARE isum DOUBLE(12,2);
		SET isum = 0.00;
		
		CASE
			WHEN(SELECT 'CGD' LIKE vbtype)=1 THEN
				SELECT SUM(sum) INTO isum FROM bbuyrow WHERE buyid = iid;
			WHEN(SELECT 'CPD' LIKE vbtype)=1 THEN
				SELECT SUM(materialsum) INTO isum FROM sproductrow WHERE productid = iid;
			WHEN(SELECT 'XSD' LIKE vbtype)=1 THEN
				SELECT SUM(realsum) INTO isum FROM bsellrow WHERE sellid = iid;
			WHEN(SELECT 'GZD' LIKE vbtype)=1 THEN
				SELECT SUM(planmoney) INTO isum FROM bsalaryrow WHERE salaryid = iid;
	
		END CASE;


		return isum;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `func_getUrlByNo`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getUrlByNo`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getUrlByNo`(billno varchar(32)) RETURNS varchar(128) CHARSET utf8
BEGIN
		DECLARE _url VARCHAR(128);
		SET _url = '';
		
		CASE

			WHEN (SELECT billno LIKE 'CGD%')=1 OR (SELECT billno LIKE 'JYD%')=1 THEN
				SELECT CONCAT('/buy/edi/', buyid) INTO _url FROM bbuy WHERE buyno = billno;
			WHEN (SELECT billno LIKE 'XSD%')=1 THEN
				SELECT CONCAT('/sell/edi/', sellid) INTO _url FROM bsell WHERE sellno = billno;
			WHEN (SELECT billno LIKE 'GZD%')=1 THEN
				SELECT CONCAT('/salary/edi/', salaryid) INTO _url FROM bsalary WHERE salaryno = billno;
	
		END CASE;

		RETURN _url;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `func_getUserName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getUserName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getUserName`(vuser varchar(32)) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vusername VARCHAR(255);

    SELECT username INTO vusername FROM suser WHERE userid = vuser;

		return vusername;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `tri_sbankcard`;
DELIMITER ;;
CREATE TRIGGER `tri_sbankcard` AFTER UPDATE ON `sbankcard` FOR EACH ROW begin
	insert into sbankcard_log(bankcardid, oldmoney, newmoney, changemoney, changetime, changetype, changeid)
		values (new.bankcardid, old.money, new.money, old.money - new.money, now(), new.changetype, new.changeid);
end
;;
DELIMITER ;
