/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : qishengsoft

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2014-08-11 10:52:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `bbuy`
-- ----------------------------
DROP TABLE IF EXISTS `bbuy`;
CREATE TABLE `bbuy` (
  `buyid` int(9) NOT NULL AUTO_INCREMENT COMMENT '采购ID',
  `btype` varchar(3) NOT NULL COMMENT '单据类型',
  `buyname` varchar(64) DEFAULT NULL COMMENT '采购名称',
  `buyno` varchar(16) NOT NULL COMMENT '采购编号',
  `buydate` varchar(10) DEFAULT NULL COMMENT '采购日期',
  `currflow` varchar(32) DEFAULT NULL COMMENT '当前流程',
  `maker` varchar(32) DEFAULT NULL COMMENT '制单人',
  `createtime` varchar(19) DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`buyid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='采购表';

-- ----------------------------
-- Records of bbuy
-- ----------------------------
INSERT INTO `bbuy` VALUES ('2', 'CGD', '采购单名称一', 'CGD-2013-0002', '2013-03-01', '结束', 'ZHOUJD', '2013-03-01 17:03:37', '备注二');
INSERT INTO `bbuy` VALUES ('3', 'JYD', '简易采购单1', 'JYD-2013-0001', '2014-05-01', '结束', 'ZHOUJD', '2013-03-01 17:05:32', '');
INSERT INTO `bbuy` VALUES ('4', 'CGD', '采购单名称三', 'CGD-2013-0003', '2013-03-01', '结束', 'ZHOUJD', '2013-03-02 20:44:21', '备注三');
INSERT INTO `bbuy` VALUES ('5', 'CGD', '采购单2', 'CGD-2014-0001', '2014-07-04', '结束', 'ZHOUJD', '2014-07-04 11:16:49', '');
INSERT INTO `bbuy` VALUES ('6', 'CGD', '采购单3', 'CGD-2014-0002', '2014-07-04', '结束', 'ZHOUJD', '2014-07-04 11:20:29', '');
INSERT INTO `bbuy` VALUES ('7', 'CGD', '采购单4', 'CGD-2014-0003', '2014-06-01', '结束', 'ZHOUJD', '2014-07-04 11:31:38', '');
INSERT INTO `bbuy` VALUES ('8', 'CGD', '2014.07.19小周采购', 'CGD-2014-0004', '2014-07-19', '结束', 'ZHOUJD', '2014-07-19 14:16:29', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8 COMMENT='采购行项表';

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

-- ----------------------------
-- Table structure for `bpay`
-- ----------------------------
DROP TABLE IF EXISTS `bpay`;
CREATE TABLE `bpay` (
  `payid` int(9) NOT NULL AUTO_INCREMENT COMMENT '单据ID',
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
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='付款单/收款单';

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
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8;

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
INSERT INTO `bpayrow` VALUES ('106', '32', '622909116836651310', '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '8170.00', '8170.00', null);
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

-- ----------------------------
-- Table structure for `breceandpay`
-- ----------------------------
DROP TABLE IF EXISTS `breceandpay`;
CREATE TABLE `breceandpay` (
  `receandpay` int(9) NOT NULL AUTO_INCREMENT COMMENT '其它收支ID',
  `happendate` varchar(10) DEFAULT NULL COMMENT '发生日期',
  `bankcardid` int(9) NOT NULL COMMENT '银行卡ID',
  `receandpaytype` int(1) NOT NULL COMMENT '收支类型',
  `money` double(12,2) NOT NULL COMMENT '金额',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  `createtime` varchar(19) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`receandpay`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='其它收支表';

-- ----------------------------
-- Records of breceandpay
-- ----------------------------
INSERT INTO `breceandpay` VALUES ('1', '2013-02-18', '2', '1', '50.50', '今天收入50.5元', '2013-02-18 16:28:40');
INSERT INTO `breceandpay` VALUES ('2', '2013-02-18', '1', '2', '10.50', '钱包支出10.5', '2013-02-18 16:31:01');
INSERT INTO `breceandpay` VALUES ('3', '2013-02-18', '2', '2', '50.50', '支出50.5', '2013-02-18 16:44:32');
INSERT INTO `breceandpay` VALUES ('4', '2013-07-01', '2', '1', '120000.00', '初始资金', '2014-07-12 14:01:11');

-- ----------------------------
-- Table structure for `bsalary`
-- ----------------------------
DROP TABLE IF EXISTS `bsalary`;
CREATE TABLE `bsalary` (
  `salaryid` int(9) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `salarytype` int(1) DEFAULT NULL COMMENT '单据类型',
  `salaryname` varchar(64) DEFAULT NULL COMMENT '工资单名称',
  `salaryno` varchar(16) NOT NULL COMMENT '工资编号',
  `salarydate` varchar(10) DEFAULT NULL COMMENT '日期',
  `currflow` varchar(32) DEFAULT NULL COMMENT '当前流程',
  `maker` varchar(32) DEFAULT NULL COMMENT '制单人',
  `createtime` varchar(19) DEFAULT NULL COMMENT '创建日期',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`salaryid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bsalary
-- ----------------------------
INSERT INTO `bsalary` VALUES ('1', '1', '2013.02工资', 'GZD-2013-0001', '2013-03', '结束', 'ZHOUJD', '2013-03-11 16:04:32', '无');
INSERT INTO `bsalary` VALUES ('2', '3', '2012年终奖', 'GZD-2013-0002', '2013-02', '结束', 'ZHOUJD', '2013-03-11 16:41:27', '');
INSERT INTO `bsalary` VALUES ('7', '1', '2014年06月份工资单', 'GZD-20140728-001', '2014-06', '结束', 'ZHOUJD', '2014-07-28 21:06:51', '');
INSERT INTO `bsalary` VALUES ('8', '1', '2014年06月份工资单', 'GZD-20140728-002', '2014-06', '结束', 'ZHOUJD', '2014-07-28 22:38:07', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

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

-- ----------------------------
-- Table structure for `bsell`
-- ----------------------------
DROP TABLE IF EXISTS `bsell`;
CREATE TABLE `bsell` (
  `sellid` int(7) NOT NULL AUTO_INCREMENT COMMENT '销售单ID',
  `sellno` varchar(16) NOT NULL COMMENT '销售单编号',
  `selldate` varchar(10) DEFAULT NULL COMMENT '销售日期',
  `manuid` int(9) NOT NULL COMMENT '客户ID',
  `currflow` varchar(32) DEFAULT NULL COMMENT '当前流程',
  `maker` varchar(32) DEFAULT NULL COMMENT '制单人',
  `createtime` varchar(19) DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`sellid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='销售表';

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
  `planprice` double(12,2) DEFAULT '0.00' COMMENT '预算单价',
  `realprice` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '实际单价',
  `num` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '销售数量',
  `realsum` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '实际总价',
  `remarkrow` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`sellrowid`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8 COMMENT='销售行项表';

-- ----------------------------
-- Records of bsellrow
-- ----------------------------
INSERT INTO `bsellrow` VALUES ('18', '2', '1', '产品1', '2', '12.20', '12.20', '1.00', '12.20', null);
INSERT INTO `bsellrow` VALUES ('19', '2', '1', '产品1', '2', '12.20', '12.20', '2.00', '24.40', null);
INSERT INTO `bsellrow` VALUES ('33', '8', '2', '产品2', '1', '190.00', '190.00', '43.00', '8170.00', null);
INSERT INTO `bsellrow` VALUES ('34', '7', '2', '产品2', '1', '190.00', '190.00', '54.00', '10260.00', null);
INSERT INTO `bsellrow` VALUES ('35', '6', '2', '产品2', '1', '190.00', '190.00', '21.00', '3990.00', null);
INSERT INTO `bsellrow` VALUES ('36', '6', '3', '产品3', '1', '200.20', '200.20', '23.00', '4604.60', null);
INSERT INTO `bsellrow` VALUES ('37', '5', '1', '产品1', '2', '120.00', '120.00', '53.00', '6360.00', null);
INSERT INTO `bsellrow` VALUES ('38', '5', '2', '产品2', '1', '190.00', '190.00', '12.00', '2280.00', null);
INSERT INTO `bsellrow` VALUES ('39', '5', '3', '产品3', '1', '200.20', '200.20', '4.00', '800.80', null);
INSERT INTO `bsellrow` VALUES ('40', '4', '2', '产品2', '1', '190.00', '190.00', '33.00', '6270.00', null);
INSERT INTO `bsellrow` VALUES ('41', '4', '3', '产品3', '1', '200.20', '200.20', '44.00', '8808.80', null);
INSERT INTO `bsellrow` VALUES ('42', '4', '1', '产品1', '2', '120.00', '120.00', '77.00', '9240.00', null);
INSERT INTO `bsellrow` VALUES ('43', '3', '1', '产品1', '2', '120.00', '120.00', '11.00', '1320.00', null);
INSERT INTO `bsellrow` VALUES ('44', '3', '2', '产品2', '1', '190.00', '190.00', '22.00', '4180.00', null);
INSERT INTO `bsellrow` VALUES ('45', '3', '3', '产品3', '1', '200.20', '200.20', '33.00', '6606.60', null);
INSERT INTO `bsellrow` VALUES ('123', '10', '2', '产品2', '1', '190.00', '190.00', '60.00', '11400.00', null);
INSERT INTO `bsellrow` VALUES ('124', '10', '3', '产品3', '1', '200.20', '200.20', '30.00', '6006.00', null);
INSERT INTO `bsellrow` VALUES ('125', '10', '1', '产品1', '2', '120.00', '120.00', '42.00', '5040.00', null);

-- ----------------------------
-- Table structure for `btransferaccount`
-- ----------------------------
DROP TABLE IF EXISTS `btransferaccount`;
CREATE TABLE `btransferaccount` (
  `transferaccountid` int(9) NOT NULL AUTO_INCREMENT COMMENT '内部转账ID',
  `bankcardid` int(9) DEFAULT NULL COMMENT '银行卡ID',
  `transferbankcardid` int(9) DEFAULT NULL COMMENT '转入账号',
  `transfermoney` double(12,2) DEFAULT NULL COMMENT '转入金额',
  `transferremark` varchar(512) DEFAULT NULL COMMENT '转入备注',
  `createtime` varchar(19) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`transferaccountid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='内部转账表';

-- ----------------------------
-- Records of btransferaccount
-- ----------------------------
INSERT INTO `btransferaccount` VALUES ('6', '2', '1', '20.50', '转入钱包', '2013-02-17 16:19:44');
INSERT INTO `btransferaccount` VALUES ('7', '2', '1', '21.50', null, '2013-02-17 17:00:39');
INSERT INTO `btransferaccount` VALUES ('8', '2', '1', '8.00', '转入钱包', '2013-02-17 17:02:56');

-- ----------------------------
-- Table structure for `bwork`
-- ----------------------------
DROP TABLE IF EXISTS `bwork`;
CREATE TABLE `bwork` (
  `workid` int(9) NOT NULL AUTO_INCREMENT,
  `workmonth` varchar(7) NOT NULL COMMENT '月份',
  `staffid` int(9) DEFAULT NULL COMMENT '员工ID',
  PRIMARY KEY (`workid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bwork
-- ----------------------------
INSERT INTO `bwork` VALUES ('1', '2014-07', '2');
INSERT INTO `bwork` VALUES ('2', '2014-07', '3');
INSERT INTO `bwork` VALUES ('3', '2014-06', '2');
INSERT INTO `bwork` VALUES ('4', '2014-06', '3');

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
) ENGINE=InnoDB AUTO_INCREMENT=75232 DEFAULT CHARSET=utf8 COMMENT='考勤表';

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

-- ----------------------------
-- Table structure for `cbanktype`
-- ----------------------------
DROP TABLE IF EXISTS `cbanktype`;
CREATE TABLE `cbanktype` (
  `banktypeid` int(2) NOT NULL COMMENT '银行编号',
  `banktypename` varchar(32) DEFAULT NULL COMMENT '银行名称',
  PRIMARY KEY (`banktypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='银行表';

-- ----------------------------
-- Records of cbanktype
-- ----------------------------
INSERT INTO `cbanktype` VALUES ('1', '中国工商银行');
INSERT INTO `cbanktype` VALUES ('2', '中国建设银行');
INSERT INTO `cbanktype` VALUES ('3', '中国银行');
INSERT INTO `cbanktype` VALUES ('4', '中国农业银行');
INSERT INTO `cbanktype` VALUES ('5', '招商银行');
INSERT INTO `cbanktype` VALUES ('6', '兴业银行');
INSERT INTO `cbanktype` VALUES ('99', '其它');

-- ----------------------------
-- Table structure for `cmanutype`
-- ----------------------------
DROP TABLE IF EXISTS `cmanutype`;
CREATE TABLE `cmanutype` (
  `manutypeid` int(3) NOT NULL AUTO_INCREMENT COMMENT '类别ID',
  `manutypename` varchar(64) NOT NULL COMMENT '类别名称',
  PRIMARY KEY (`manutypeid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='供应商类别表';

-- ----------------------------
-- Records of cmanutype
-- ----------------------------
INSERT INTO `cmanutype` VALUES ('1', '供应商');
INSERT INTO `cmanutype` VALUES ('2', '客户');
INSERT INTO `cmanutype` VALUES ('3', '物流');

-- ----------------------------
-- Table structure for `creceandpaytype`
-- ----------------------------
DROP TABLE IF EXISTS `creceandpaytype`;
CREATE TABLE `creceandpaytype` (
  `receandpaytypeid` int(1) NOT NULL COMMENT '收支类型ID',
  `receandpaytypename` varchar(32) DEFAULT NULL COMMENT '收支类型名称',
  PRIMARY KEY (`receandpaytypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收支类型表';

-- ----------------------------
-- Records of creceandpaytype
-- ----------------------------
INSERT INTO `creceandpaytype` VALUES ('1', '收入');
INSERT INTO `creceandpaytype` VALUES ('2', '支出');

-- ----------------------------
-- Table structure for `csalarytype`
-- ----------------------------
DROP TABLE IF EXISTS `csalarytype`;
CREATE TABLE `csalarytype` (
  `salarytype` int(1) NOT NULL AUTO_INCREMENT COMMENT '类型编号',
  `salarytypename` varchar(32) DEFAULT NULL COMMENT '类型名称',
  PRIMARY KEY (`salarytype`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='员工工资类型表';

-- ----------------------------
-- Records of csalarytype
-- ----------------------------
INSERT INTO `csalarytype` VALUES ('1', '工资');
INSERT INTO `csalarytype` VALUES ('2', '过节费');
INSERT INTO `csalarytype` VALUES ('3', '年终奖');

-- ----------------------------
-- Table structure for `cstaffstatus`
-- ----------------------------
DROP TABLE IF EXISTS `cstaffstatus`;
CREATE TABLE `cstaffstatus` (
  `staffstatusid` int(1) NOT NULL COMMENT '员工状态ID',
  `staffstatusname` varchar(16) DEFAULT NULL COMMENT '员工状态名称',
  PRIMARY KEY (`staffstatusid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工状态表';

-- ----------------------------
-- Records of cstaffstatus
-- ----------------------------
INSERT INTO `cstaffstatus` VALUES ('1', '在职');
INSERT INTO `cstaffstatus` VALUES ('2', '离职');

-- ----------------------------
-- Table structure for `cstafftype`
-- ----------------------------
DROP TABLE IF EXISTS `cstafftype`;
CREATE TABLE `cstafftype` (
  `stafftypeid` int(1) NOT NULL COMMENT '员工类别ID',
  `stafftypename` varchar(16) DEFAULT NULL COMMENT '员工类别名称',
  PRIMARY KEY (`stafftypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工类别表';

-- ----------------------------
-- Records of cstafftype
-- ----------------------------
INSERT INTO `cstafftype` VALUES ('1', '正式员工');
INSERT INTO `cstafftype` VALUES ('2', '临时员工');

-- ----------------------------
-- Table structure for `cstatus`
-- ----------------------------
DROP TABLE IF EXISTS `cstatus`;
CREATE TABLE `cstatus` (
  `statusid` int(1) NOT NULL COMMENT '状态编号',
  `statusname` varchar(8) DEFAULT NULL COMMENT '状态名称',
  PRIMARY KEY (`statusid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='状态表';

-- ----------------------------
-- Records of cstatus
-- ----------------------------
INSERT INTO `cstatus` VALUES ('0', '禁用');
INSERT INTO `cstatus` VALUES ('1', '可用');

-- ----------------------------
-- Table structure for `cunit`
-- ----------------------------
DROP TABLE IF EXISTS `cunit`;
CREATE TABLE `cunit` (
  `unitid` int(3) NOT NULL AUTO_INCREMENT COMMENT '计量单位ID',
  `unitname` varchar(32) NOT NULL COMMENT '计量单位名称',
  `priority` int(2) DEFAULT '99' COMMENT '优先级（数值越小，优先级越高）',
  PRIMARY KEY (`unitid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='计量单位表';

-- ----------------------------
-- Records of cunit
-- ----------------------------
INSERT INTO `cunit` VALUES ('1', '只', '1');
INSERT INTO `cunit` VALUES ('2', '台', '2');
INSERT INTO `cunit` VALUES ('3', '个', '3');
INSERT INTO `cunit` VALUES ('4', '箱', '4');
INSERT INTO `cunit` VALUES ('5', '件', '5');

-- ----------------------------
-- Table structure for `cworkstatus`
-- ----------------------------
DROP TABLE IF EXISTS `cworkstatus`;
CREATE TABLE `cworkstatus` (
  `workstatus` int(9) NOT NULL AUTO_INCREMENT COMMENT '考勤状态ID',
  `workstatusname` varchar(16) DEFAULT NULL COMMENT '考勤状态名称',
  PRIMARY KEY (`workstatus`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cworkstatus
-- ----------------------------
INSERT INTO `cworkstatus` VALUES ('1', '正常');
INSERT INTO `cworkstatus` VALUES ('2', '迟到');
INSERT INTO `cworkstatus` VALUES ('3', '早退');
INSERT INTO `cworkstatus` VALUES ('4', '旷工');
INSERT INTO `cworkstatus` VALUES ('5', '请假');
INSERT INTO `cworkstatus` VALUES ('6', '放假');

-- ----------------------------
-- Table structure for `cyesorno`
-- ----------------------------
DROP TABLE IF EXISTS `cyesorno`;
CREATE TABLE `cyesorno` (
  `code` int(1) NOT NULL COMMENT '代码',
  `name` varchar(32) NOT NULL COMMENT '名称',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='是、否';

-- ----------------------------
-- Records of cyesorno
-- ----------------------------
INSERT INTO `cyesorno` VALUES ('0', '否');
INSERT INTO `cyesorno` VALUES ('1', '是');

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
  `remark` varchar(512) NOT NULL COMMENT '备注',
  PRIMARY KEY (`bankcardid`,`bankcardno`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='银行卡管理表';

-- ----------------------------
-- Records of sbankcard
-- ----------------------------
INSERT INTO `sbankcard` VALUES ('1', '00000', '无', '99', '钱包', '9579.54', '1', '此为钱包');
INSERT INTO `sbankcard` VALUES ('2', '6227001823550092014', '建设银行福州支行', '2', '林珊珊', '108732.88', '1', '');
INSERT INTO `sbankcard` VALUES ('3', '622909116836651310', '兴业银行福州支行', '6', '王建辉', '58118.08', '1', '');

-- ----------------------------
-- Table structure for `sbtype`
-- ----------------------------
DROP TABLE IF EXISTS `sbtype`;
CREATE TABLE `sbtype` (
  `btype` varchar(16) NOT NULL COMMENT '单据类型',
  `btypename` varchar(16) DEFAULT NULL COMMENT '单据类型名称',
  `relatetabname` varchar(64) DEFAULT NULL COMMENT '关联表',
  PRIMARY KEY (`btype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='单据类型表';

-- ----------------------------
-- Records of sbtype
-- ----------------------------
INSERT INTO `sbtype` VALUES ('CGD', '采购单', 'bbuy,bbuyrow');
INSERT INTO `sbtype` VALUES ('CPD', '产品单', 'sproduct,sproductrow');
INSERT INTO `sbtype` VALUES ('FKD', '付款单', 'bpay,bpayrow');
INSERT INTO `sbtype` VALUES ('GZD', '工资单', 'bsalary,bsalaryrow');
INSERT INTO `sbtype` VALUES ('JYD', '简易采购单', 'bbuy,bbuyrow');
INSERT INTO `sbtype` VALUES ('SKD', '收款单', 'bpay,bpayrow');
INSERT INTO `sbtype` VALUES ('WZD', '物资单', 'smaterial,smaterialrow');
INSERT INTO `sbtype` VALUES ('XSD', '销售单', 'bsell,bsellrow');
INSERT INTO `sbtype` VALUES ('YFD', '运费单', 'bpay,bpayrow');

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
-- Table structure for `sflow`
-- ----------------------------
DROP TABLE IF EXISTS `sflow`;
CREATE TABLE `sflow` (
  `flowid` int(9) NOT NULL AUTO_INCREMENT,
  `flowname` varchar(64) NOT NULL DEFAULT '',
  `btype` varchar(16) NOT NULL DEFAULT '',
  `priority` int(3) DEFAULT NULL,
  PRIMARY KEY (`flowid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sflow
-- ----------------------------
INSERT INTO `sflow` VALUES ('1', '申请', 'XXX', null);
INSERT INTO `sflow` VALUES ('2', '结束', 'XXX', null);

-- ----------------------------
-- Table structure for `slog`
-- ----------------------------
DROP TABLE IF EXISTS `slog`;
CREATE TABLE `slog` (
  `logid` int(9) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `logtype` varchar(20) NOT NULL COMMENT '操作类型',
  `operater` varchar(64) NOT NULL COMMENT '操作人ID',
  `operatetime` varchar(20) NOT NULL COMMENT '操作时间',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`logid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='日志表';

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

-- ----------------------------
-- Table structure for `smanu`
-- ----------------------------
DROP TABLE IF EXISTS `smanu`;
CREATE TABLE `smanu` (
  `manuid` int(4) NOT NULL AUTO_INCREMENT COMMENT '供应商ID',
  `manuname` varchar(64) DEFAULT NULL COMMENT '供应商名称',
  `manutypeid` int(2) DEFAULT NULL COMMENT '供应商类别',
  `statusid` int(1) DEFAULT NULL COMMENT '供应商状态',
  `createdate` varchar(20) DEFAULT NULL COMMENT '创建日期',
  `manucontact` varchar(64) DEFAULT NULL COMMENT '联系人',
  `manutel` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `manuemail` varchar(64) DEFAULT NULL COMMENT 'EMAIL',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`manuid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='供应商表';

-- ----------------------------
-- Records of smanu
-- ----------------------------
INSERT INTO `smanu` VALUES ('4', '供应商A', '1', '1', '2013-02-05', '周少华', '11111111', '', '备注a');
INSERT INTO `smanu` VALUES ('5', '客户A', '2', '1', '2013-02-21', '刘星', '22222222', 'b@yecoo.com', '备注B');
INSERT INTO `smanu` VALUES ('7', '物流A', '3', '1', '2013-02-21', '林长城', '33333333', '', '');
INSERT INTO `smanu` VALUES ('8', '供应商B', '1', '1', '2013-02-25', '供应商B', '00000', '', '');
INSERT INTO `smanu` VALUES ('9', '客户B', '2', '1', '2013-02-25', '无', '00000', '', '');
INSERT INTO `smanu` VALUES ('10', '物流B', '3', '1', '2013-02-25', '无', '00000', '', '');

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
  `priorityrow` int(2) DEFAULT NULL COMMENT '优先级',
  `remarkrow` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`manurowid`)
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=utf8 COMMENT='供应商账号表';

-- ----------------------------
-- Records of smanurow
-- ----------------------------
INSERT INTO `smanurow` VALUES ('182', '7', '工商银行泉州分行', '33333333', '林长城', '9', null);
INSERT INTO `smanurow` VALUES ('184', '8', '中国农业银行福建支行', '444444', '供应商B账户名称', '9', null);
INSERT INTO `smanurow` VALUES ('185', '10', '建设银行南安支行', '66666666', '物流B', '9', null);
INSERT INTO `smanurow` VALUES ('187', '9', '中国银行泉州分行', '2222222', '客户B', '1', null);
INSERT INTO `smanurow` VALUES ('189', '4', '建设银行泉州分行', '1111111111', '周少华', '1', null);
INSERT INTO `smanurow` VALUES ('190', '5', '中国银行泉州分行', '22222222', '刘星', '9', null);

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
  `createdate` varchar(10) DEFAULT NULL COMMENT '新增日期',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`materialid`),
  UNIQUE KEY `uni_smaterial_no` (`materialno`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of smaterial
-- ----------------------------
INSERT INTO `smaterial` VALUES ('1', '1010101', '物资A11', '5', '1', '0.22', '4', '2013-02-24', '物资A1一备注');
INSERT INTO `smaterial` VALUES ('4', '1020101', '物资B11', '8', '1', '33.30', '4', '2013-03-04', '');
INSERT INTO `smaterial` VALUES ('5', '1020102', '物资B12', '8', '2', '44.00', '8', '2013-03-04', '');
INSERT INTO `smaterial` VALUES ('6', '1010201', '物资A21', '6', '3', '43.20', '8', '2014-07-04', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=10132 DEFAULT CHARSET=utf8 COMMENT='模块表';

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
INSERT INTO `smodule` VALUES ('10107', '计量单位管理', '计量单位管理', '99', '/unit/list', '10106', 'Unit', 'unit_list');
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
INSERT INTO `spermission` VALUES ('1', 'Unit:view');
INSERT INTO `spermission` VALUES ('1', 'Unit:add');
INSERT INTO `spermission` VALUES ('1', 'Unit:edi');
INSERT INTO `spermission` VALUES ('1', 'Unit:delete');
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

-- ----------------------------
-- Table structure for `sproduct`
-- ----------------------------
DROP TABLE IF EXISTS `sproduct`;
CREATE TABLE `sproduct` (
  `productid` int(9) NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `productno` varchar(11) NOT NULL COMMENT '产品编码',
  `productname` varchar(64) DEFAULT NULL COMMENT '产品名称',
  `producttype` int(5) DEFAULT NULL COMMENT '产品类型',
  `unit` int(3) DEFAULT NULL COMMENT '计量单位',
  `realprice` double(12,2) NOT NULL COMMENT '实际单价',
  `createdate` varchar(10) DEFAULT NULL COMMENT '新增日期',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`productid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
-- Records of sproduct
-- ----------------------------
INSERT INTO `sproduct` VALUES ('1', '2010101', '产品1', '14', '2', '120.00', '2013-03-06', '产品一备注');
INSERT INTO `sproduct` VALUES ('2', '2010102', '产品2', '14', '1', '190.00', '2014-07-12', '');
INSERT INTO `sproduct` VALUES ('3', '2010103', '产品3', '14', '1', '200.20', '2014-07-12', '');
INSERT INTO `sproduct` VALUES ('5', '2010201', '产品8', '15', '1', '0.00', '2014-08-11', null);

-- ----------------------------
-- Table structure for `sproductrow`
-- ----------------------------
DROP TABLE IF EXISTS `sproductrow`;
CREATE TABLE `sproductrow` (
  `productrowid` int(9) NOT NULL AUTO_INCREMENT COMMENT '行项ID',
  `productid` int(9) DEFAULT NULL COMMENT '产品ID',
  `materialno` varchar(13) DEFAULT NULL COMMENT '物资编号',
  `materialname` varchar(64) DEFAULT NULL COMMENT '物资名称',
  `materialprice` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '物资单价',
  `materialnum` double(9,2) NOT NULL DEFAULT '0.00' COMMENT '物资数量',
  `materialsum` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '物资总价',
  `remarkrow` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`productrowid`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COMMENT='产品行项表';

-- ----------------------------
-- Records of sproductrow
-- ----------------------------
INSERT INTO `sproductrow` VALUES ('62', '2', 'WZD-2013-0001', '物资A11', '0.22', '22.00', '4.84', null);
INSERT INTO `sproductrow` VALUES ('63', '2', 'WZD-2013-0003', '物资B11', '33.30', '2.00', '66.60', null);
INSERT INTO `sproductrow` VALUES ('64', '2', 'WZD-2013-0004', '物资B12', '44.00', '1.00', '44.00', null);
INSERT INTO `sproductrow` VALUES ('65', '2', null, '运输成本', '22.00', '1.00', '22.00', null);
INSERT INTO `sproductrow` VALUES ('66', '2', null, '人力成本', '33.00', '1.00', '33.00', null);
INSERT INTO `sproductrow` VALUES ('67', '2', null, '利润', '21.00', '1.00', '21.00', null);
INSERT INTO `sproductrow` VALUES ('68', '3', 'WZD-2014-0001', '物资A21', '43.20', '2.00', '86.40', null);
INSERT INTO `sproductrow` VALUES ('69', '3', 'WZD-2013-0004', '物资B12', '44.00', '1.00', '44.00', null);
INSERT INTO `sproductrow` VALUES ('70', '3', null, '运输成本', '11.00', '1.00', '11.00', null);
INSERT INTO `sproductrow` VALUES ('71', '3', null, '人力成本', '22.00', '1.00', '22.00', null);
INSERT INTO `sproductrow` VALUES ('72', '3', null, '利润', '33.00', '1.00', '33.00', null);
INSERT INTO `sproductrow` VALUES ('73', '1', 'WZD-2013-0004', '物资四', '44.00', '1.00', '44.00', null);
INSERT INTO `sproductrow` VALUES ('74', '1', 'WZD-2013-0003', '物资三', '33.30', '2.00', '66.60', null);
INSERT INTO `sproductrow` VALUES ('75', '1', null, '运输成本', '1.00', '1.00', '1.00', null);
INSERT INTO `sproductrow` VALUES ('76', '1', null, '人力成本', '2.00', '1.00', '2.00', null);
INSERT INTO `sproductrow` VALUES ('77', '1', null, '利润', '3.00', '1.00', '3.00', null);

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
  UNIQUE KEY `u_sproduct_no` (`producttypeno`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

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

-- ----------------------------
-- Table structure for `srole`
-- ----------------------------
DROP TABLE IF EXISTS `srole`;
CREATE TABLE `srole` (
  `roleid` int(10) NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `rolename` varchar(128) NOT NULL COMMENT '角色名称',
  `priority` int(4) DEFAULT '99' COMMENT '优先级（数据越小，优先级越高）',
  PRIMARY KEY (`roleid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='角色表';

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
  `photo` varchar(64) DEFAULT NULL COMMENT '照片路径',
  PRIMARY KEY (`staffid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='员工表';

-- ----------------------------
-- Records of sstaff
-- ----------------------------
INSERT INTO `sstaff` VALUES ('2', '员工一', '1', '1', '11111111', '建设银行南安支行', '11111111', '员工一', '备注1', '53.00', null);
INSERT INTO `sstaff` VALUES ('3', '员工二', '1', '1', '22222222', '建设银行南安支行', '22222222', '员工二', '备注2', '63.00', null);
INSERT INTO `sstaff` VALUES ('4', '员工三', '1', '2', '33333333', '建设银行南安支行', '33333333', '员工三', '', null, null);

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
INSERT INTO `suser_role` VALUES ('LINCC', '2');
INSERT INTO `suser_role` VALUES ('ZH112014', '3');

-- ----------------------------
-- Procedure structure for `proc_initWork`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_initWork`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_initWork`(vmonth varchar(7))
BEGIN
		DECLARE imonthNum INT;
		DECLARE istaffid INT;
		DECLARE stop int default 0;
		DECLARE cursor_name CURSOR FOR SELECT staffid FROM sstaff WHERE staffstatus = '1';
		DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = 1;
		SET imonthNum = 0;
		
		SELECT DAY(DATE_ADD(DATE_ADD(CONCAT(vmonth,'-01'),INTERVAL 1 MONTH), INTERVAL -1 DAY)) INTO imonthNum;

		OPEN cursor_name;
		FETCH cursor_name INTO istaffid;
			WHILE stop <> 1 DO
				SET @mycnt = -1;
				INSERT INTO bwork(staffid, workdate)
					(SELECT istaffid, DATE_ADD(CONCAT(vmonth,'-01'),INTERVAL @mycnt :=@mycnt + 1 DAY) AS DAY FROM spermission LIMIT imonthNum);
				FETCH cursor_name INTO istaffid; 
			END WHILE;
		CLOSE cursor_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_initWorkByStaff`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_initWorkByStaff`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_initWorkByStaff`(vmonth varchar(7),istaffid int(11))
BEGIN
		DECLARE imonthNum INT;
		DECLARE iworkid INT;
		DECLARE stop int default 0;
		SET imonthNum = 0;

		INSERT INTO bwork(workmonth, staffid) VALUES (vmonth, istaffid);
		SELECT t.workid INTO iworkid FROM bwork t WHERE t.workmonth = vmonth AND t.staffid = istaffid;
		
		SELECT DAY(DATE_ADD(DATE_ADD(CONCAT(vmonth,'-01'),INTERVAL 1 MONTH), INTERVAL -1 DAY)) INTO imonthNum;

		SET @mycnt = -1;
		INSERT INTO bworkrow(workid, workdate)
			(SELECT iworkid, DATE_ADD(CONCAT(vmonth,'-01'),INTERVAL @mycnt :=@mycnt + 1 DAY) AS DAY FROM spermission LIMIT imonthNum);
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
-- Function structure for `func_getBanktypeName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getBanktypeName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getBanktypeName`(ibanktypeid int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vbanktypename VARCHAR(255);

    SELECT banktypename INTO vbanktypename FROM cbanktype WHERE banktypeid = ibanktypeid;

		return vbanktypename;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `func_getBtypeName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getBtypeName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getBtypeName`(vbtype varchar(16)) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vbtypename VARCHAR(255);

    SELECT btypename INTO vbtypename FROM sbtype WHERE btype = vbtype;

		return vbtypename;
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
-- Function structure for `func_getManutypeName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getManutypeName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getManutypeName`(imanutypeid int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vmanutypename VARCHAR(255);

    SELECT manutypename INTO vmanutypename FROM cmanutype WHERE manutypeid = imanutypeid;

		return vmanutypename;
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
-- Function structure for `func_getReceandpaytypeName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getReceandpaytypeName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getReceandpaytypeName`(ireceandpaytypeid int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vreceandpaytypename VARCHAR(255);

    SELECT receandpaytypename INTO vreceandpaytypename FROM creceandpaytype WHERE receandpaytypeid = ireceandpaytypeid;

		return vreceandpaytypename;
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
-- Function structure for `func_getSalarytypeName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getSalarytypeName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getSalarytypeName`(isalarytype int(1)) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vsalarytypename VARCHAR(255);

    SELECT salarytypename INTO vsalarytypename FROM csalarytype
			WHERE salarytype = isalarytype;

		return vsalarytypename;
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
-- Function structure for `func_getStaffstatusName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getStaffstatusName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getStaffstatusName`(istaffstatusid int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vstaffstatusname VARCHAR(255);

    SELECT staffstatusname INTO vstaffstatusname FROM cstaffstatus WHERE staffstatusid = istaffstatusid;

		return vstaffstatusname;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `func_getStafftypeName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getStafftypeName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getStafftypeName`(istafftypeid int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vstafftypename VARCHAR(255);

    SELECT stafftypename INTO vstafftypename FROM cstafftype WHERE stafftypeid = istafftypeid;

		return vstafftypename;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `func_getStatusName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getStatusName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getStatusName`(istatusid int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vstatusname VARCHAR(255);

    SELECT statusname INTO vstatusname FROM cstatus WHERE statusid = istatusid;

		return vstatusname;
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
-- Function structure for `func_getUnitName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getUnitName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getUnitName`(iunitid int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vunitname VARCHAR(255);

    SELECT unitname INTO vunitname FROM cunit WHERE unitid = iunitid;

		return vunitname;
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
