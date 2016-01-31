/*
Navicat MySQL Data Transfer

Source Server         : 测试
Source Server Version : 50136
Source Host           : 121.41.5.235:3306
Source Database       : qishengsoft

Target Server Type    : MYSQL
Target Server Version : 50136
File Encoding         : 65001

Date: 2016-01-31 22:33:48
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
  `alldiscount` double(5,2) DEFAULT NULL COMMENT '折扣',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`buyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购表';

-- ----------------------------
-- Records of bbuy
-- ----------------------------
INSERT INTO `bbuy` VALUES ('107', 'CGD', '2016.01.29采购', 'CGD-20160129-001', 'XSD-20160129-001', '2016-01-29', '申请', 'TEST', '2016-01-29 23:04:26', '1.00', null);

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
  `discount` double(5,2) DEFAULT NULL COMMENT '折扣',
  `sum` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '总价',
  `manuid` int(9) DEFAULT NULL COMMENT '供应商ID',
  `manuname` varchar(64) DEFAULT NULL COMMENT '供应商名称',
  `manucontact` varchar(64) DEFAULT NULL COMMENT '联系人',
  `manutel` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `remarkrow` varchar(512) DEFAULT NULL COMMENT '备注',
  `numofonebox` varchar(9) DEFAULT NULL COMMENT '一件数量',
  PRIMARY KEY (`buyrowid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='采购行项表';

-- ----------------------------
-- Records of bbuyrow
-- ----------------------------
INSERT INTO `bbuyrow` VALUES ('1', '107', '1', '赛洛单孔（进）', '1', '13.50', '126.00', '1.00', '1701.00', '101', '顺兴', '罗静萍', '', null, null);
INSERT INTO `bbuyrow` VALUES ('2', '107', '2', '6号赛诺', '1', '4.20', '126.00', '1.00', '529.20', '102', '圣达手柄', '王仁忠', '86181866', null, null);

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
  `bankcardno` varchar(32) DEFAULT NULL COMMENT '银行卡卡号',
  `manuid` int(9) DEFAULT '0' COMMENT '供应商ID',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`payid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='付款单/收款单';

-- ----------------------------
-- Records of bpay
-- ----------------------------

-- ----------------------------
-- Table structure for `bpayrow`
-- ----------------------------
DROP TABLE IF EXISTS `bpayrow`;
CREATE TABLE `bpayrow` (
  `payrowid` int(9) NOT NULL AUTO_INCREMENT COMMENT '行项ID',
  `payid` int(9) NOT NULL COMMENT '单据ID',
  `bankcardno` varchar(32) DEFAULT NULL COMMENT '银行卡卡号',
  `manuid` int(9) DEFAULT NULL COMMENT '供应商ID',
  `plansum` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '应付金额',
  `realsum` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '实付金额',
  `remarkrow` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`payrowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bpayrow
-- ----------------------------

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

-- ----------------------------
-- Table structure for `bsalary`
-- ----------------------------
DROP TABLE IF EXISTS `bsalary`;
CREATE TABLE `bsalary` (
  `salaryid` int(9) NOT NULL COMMENT 'ID',
  `salarytype` int(1) DEFAULT NULL COMMENT '单据类型',
  `salaryname` varchar(64) DEFAULT NULL COMMENT '工资单名称',
  `salaryno` varchar(16) NOT NULL COMMENT '工资单编号',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bsalaryrow
-- ----------------------------

-- ----------------------------
-- Table structure for `bsell`
-- ----------------------------
DROP TABLE IF EXISTS `bsell`;
CREATE TABLE `bsell` (
  `sellid` int(7) NOT NULL COMMENT '销售单ID',
  `sellno` varchar(16) NOT NULL COMMENT '销售单编号',
  `selldate` varchar(10) DEFAULT NULL COMMENT '发货日期',
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
INSERT INTO `bsell` VALUES ('106', 'XSD-20160129-001', '2016-01-29', '103', '申请', 'TEST', '2016-01-29 23:00:10', '');

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
  `costprice` double(12,2) unsigned DEFAULT '0.00' COMMENT '成本单价',
  `planprice` double(12,2) unsigned DEFAULT '0.00' COMMENT '预算单价',
  `realprice` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '实际单价',
  `num` int(5) NOT NULL DEFAULT '0' COMMENT '销售数量',
  `boxnum` double(5,1) DEFAULT NULL COMMENT '件数',
  `numofonebox` int(3) DEFAULT NULL COMMENT '1件数量',
  `profit` double(12,2) DEFAULT '0.00' COMMENT '利润',
  `realsum` double(12,2) NOT NULL DEFAULT '0.00' COMMENT '实际总价',
  `sort` float(4,1) DEFAULT NULL COMMENT '排序',
  `remarkrow` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`sellrowid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='销售行项表';

-- ----------------------------
-- Records of bsellrow
-- ----------------------------
INSERT INTO `bsellrow` VALUES ('3', '106', '105', '赛洛单孔', null, '0.00', '33.00', '33.00', '126', '3.0', '42', '0.00', '4158.00', '5.0', null);

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

-- ----------------------------
-- Table structure for `bwork`
-- ----------------------------
DROP TABLE IF EXISTS `bwork`;
CREATE TABLE `bwork` (
  `workid` int(9) NOT NULL AUTO_INCREMENT,
  `workmonth` varchar(7) NOT NULL COMMENT '月份',
  `staffid` int(9) DEFAULT NULL COMMENT '员工ID',
  PRIMARY KEY (`workid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bwork
-- ----------------------------

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
  `salary` double(12,2) DEFAULT NULL COMMENT '工资',
  `othersalary` double(12,2) DEFAULT NULL COMMENT '其他工资',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`workrowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='考勤表';

-- ----------------------------
-- Records of bworkrow
-- ----------------------------

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
INSERT INTO `cdict` VALUES ('482', '产品类型', '2015-04-05 12:58:45', '');
INSERT INTO `cdict` VALUES ('765', '采购状态', '2015-05-13 16:26:19', null);
INSERT INTO `cdict` VALUES ('766', '销售状态', '2015-05-13 16:27:15', null);
INSERT INTO `cdict` VALUES ('1539', '产品材料类型', '2015-09-03 11:02:25', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8 COMMENT='字典行项表';

-- ----------------------------
-- Records of cdictrow
-- ----------------------------
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
INSERT INTO `cdictrow` VALUES ('120', '19', '中国建设银行', '1', '1', null);
INSERT INTO `cdictrow` VALUES ('121', '19', '中国工商银行', '2', '2', null);
INSERT INTO `cdictrow` VALUES ('122', '19', '中国银行', '3', '3', null);
INSERT INTO `cdictrow` VALUES ('123', '19', '中国农业银行', '4', '4', null);
INSERT INTO `cdictrow` VALUES ('124', '19', '招商银行', '5', '5', null);
INSERT INTO `cdictrow` VALUES ('125', '19', '兴业银行', '6', '6', null);
INSERT INTO `cdictrow` VALUES ('126', '19', '其它', '9', '9', null);
INSERT INTO `cdictrow` VALUES ('127', '19', '民生银行', '7', '7', null);
INSERT INTO `cdictrow` VALUES ('164', '10', '只', '1', '1', null);
INSERT INTO `cdictrow` VALUES ('165', '10', '盒', '2', '2', null);
INSERT INTO `cdictrow` VALUES ('166', '10', '个', '3', '3', null);
INSERT INTO `cdictrow` VALUES ('167', '10', '箱', '4', '4', null);
INSERT INTO `cdictrow` VALUES ('168', '10', '件', '5', '5', null);
INSERT INTO `cdictrow` VALUES ('169', '10', '斤', '6', '6', null);
INSERT INTO `cdictrow` VALUES ('170', '10', '套', '7', '7', null);
INSERT INTO `cdictrow` VALUES ('171', '10', '支', '8', '8', null);
INSERT INTO `cdictrow` VALUES ('172', '10', '对', '9', '9', null);
INSERT INTO `cdictrow` VALUES ('173', '10', '包', '10', '10', null);
INSERT INTO `cdictrow` VALUES ('174', '765', '申请', '申请', '1', null);
INSERT INTO `cdictrow` VALUES ('175', '765', '待付', '待付', '2', null);
INSERT INTO `cdictrow` VALUES ('176', '765', '结束', '结束', '3', null);
INSERT INTO `cdictrow` VALUES ('177', '766', '申请', '申请', '1', null);
INSERT INTO `cdictrow` VALUES ('178', '766', '发货', '发货', '2', null);
INSERT INTO `cdictrow` VALUES ('179', '766', '结束', '结束', '3', null);
INSERT INTO `cdictrow` VALUES ('180', '1539', '铜', '1', '1', null);
INSERT INTO `cdictrow` VALUES ('181', '1539', '锌', '2', '2', null);
INSERT INTO `cdictrow` VALUES ('182', '482', '淋浴', '01', '1', null);
INSERT INTO `cdictrow` VALUES ('183', '482', '二联', '02', '2', null);
INSERT INTO `cdictrow` VALUES ('184', '482', '三联', '03', '3', null);
INSERT INTO `cdictrow` VALUES ('185', '482', '面盆单孔', '04', '4', null);
INSERT INTO `cdictrow` VALUES ('186', '482', '菜盆单孔', '05', '5', null);
INSERT INTO `cdictrow` VALUES ('187', '482', '平咀', '06', '6', null);
INSERT INTO `cdictrow` VALUES ('188', '482', '尖咀', '07', '7', null);
INSERT INTO `cdictrow` VALUES ('189', '482', '网咀', '08', '8', null);
INSERT INTO `cdictrow` VALUES ('190', '482', '角阀', '09', '9', null);
INSERT INTO `cdictrow` VALUES ('191', '482', '面盆单冷', '10', '10', null);
INSERT INTO `cdictrow` VALUES ('192', '482', '菜盆单冷', '11', '11', null);
INSERT INTO `cdictrow` VALUES ('193', '482', '顶喷', '12', '12', null);
INSERT INTO `cdictrow` VALUES ('194', '482', '其他', '19', '19', null);
INSERT INTO `cdictrow` VALUES ('205', '21', '采购单', 'CGD', '1', null);
INSERT INTO `cdictrow` VALUES ('206', '21', '产品单', 'CPD', '2', null);
INSERT INTO `cdictrow` VALUES ('207', '21', '付款单', 'FKD', '3', null);
INSERT INTO `cdictrow` VALUES ('208', '21', '工资单', 'GZD', '4', null);
INSERT INTO `cdictrow` VALUES ('209', '21', '简易采购单', 'JYD', '5', null);
INSERT INTO `cdictrow` VALUES ('210', '21', '收款单', 'SKD', '6', null);
INSERT INTO `cdictrow` VALUES ('211', '21', '物资单', 'WZD', '7', null);
INSERT INTO `cdictrow` VALUES ('212', '21', '销售单', 'XSD', '8', null);
INSERT INTO `cdictrow` VALUES ('213', '21', '运费单', 'YFD', '9', null);

-- ----------------------------
-- Table structure for `cparameter`
-- ----------------------------
DROP TABLE IF EXISTS `cparameter`;
CREATE TABLE `cparameter` (
  `parameterid` int(4) NOT NULL AUTO_INCREMENT COMMENT '系统参数ID',
  `parametername` varchar(64) DEFAULT NULL COMMENT '系统参数名',
  `parametervalue` varchar(64) DEFAULT NULL COMMENT '系统参数值',
  `createtime` varchar(19) DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`parameterid`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cparameter
-- ----------------------------
INSERT INTO `cparameter` VALUES ('1', '是否打印隐藏', 'N', '2015-05-08 09:32:01', 'Y是，N否');
INSERT INTO `cparameter` VALUES ('3', '是否价格记忆', 'N', '2015-07-11 15:45:54', 'Y是，N否');
INSERT INTO `cparameter` VALUES ('7', '箱子行数', '7', '2015-12-27 09:27:48', '');
INSERT INTO `cparameter` VALUES ('6', '采购单显示物资特性', 'Y', '2015-10-20 20:30:54', '显示重量、标记');
INSERT INTO `cparameter` VALUES ('8', '箱子列数', '3', '2015-12-27 09:28:03', '');
INSERT INTO `cparameter` VALUES ('9', '是否记录日志', 'N', '2015-12-27 09:38:05', 'Y是，N否，登录一定保存日志');
INSERT INTO `cparameter` VALUES ('10', '利润百分点', '12', '2016-01-23 17:03:15', '');

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
INSERT INTO `cseq` VALUES ('107');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='银行卡管理表';

-- ----------------------------
-- Records of sbankcard
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='银行卡更改日志表';

-- ----------------------------
-- Records of sbankcard_log
-- ----------------------------

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
INSERT INTO `scompany` VALUES ('1', '岐盛卫浴', '周坚定', '福建省南安市东田镇', '059586211027', '059586211027', '362300', 'zjd621102@163.com', '');

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
  `ip` varchar(30) DEFAULT NULL COMMENT 'IP',
  `remark` text COMMENT '备注',
  PRIMARY KEY (`logid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='日志表';

-- ----------------------------
-- Records of slog
-- ----------------------------
INSERT INTO `slog` VALUES ('1', '登录', 'ADMIN', '2016-01-29 22:37:41', '121.207.59.67', '');
INSERT INTO `slog` VALUES ('2', '登录', 'TEST', '2016-01-29 22:38:25', '121.207.59.67', '');
INSERT INTO `slog` VALUES ('3', '登录', 'ADMIN', '2016-01-29 22:41:07', '121.207.59.67', '');
INSERT INTO `slog` VALUES ('4', '登录', 'TEST', '2016-01-29 22:43:11', '121.207.59.67', '');

-- ----------------------------
-- Table structure for `smanu`
-- ----------------------------
DROP TABLE IF EXISTS `smanu`;
CREATE TABLE `smanu` (
  `manuid` int(4) NOT NULL COMMENT '供应商ID',
  `manuname` varchar(64) DEFAULT NULL COMMENT '供应商名称',
  `manunamepy` varchar(16) DEFAULT NULL COMMENT '供应商名称拼音首字母',
  `manutypeid` int(2) DEFAULT NULL COMMENT '供应商类别',
  `statusid` int(1) DEFAULT NULL COMMENT '供应商状态',
  `createdate` varchar(20) DEFAULT NULL COMMENT '创建日期',
  `manucontact` varchar(64) DEFAULT NULL COMMENT '联系人',
  `manuphone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `manutel` varchar(32) DEFAULT NULL COMMENT '座机电话',
  `manuemail` varchar(64) DEFAULT NULL COMMENT 'EMAIL',
  `priority` int(3) DEFAULT '0' COMMENT '优先级',
  `referee` varchar(32) DEFAULT NULL COMMENT '推荐人',
  `relateuserid` varchar(64) DEFAULT NULL COMMENT '关联登录用户ID',
  `address` varchar(256) DEFAULT NULL COMMENT '地址',
  `istobuy` varchar(1) DEFAULT '0' COMMENT '是否加入采购单',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`manuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商表';

-- ----------------------------
-- Records of smanu
-- ----------------------------
INSERT INTO `smanu` VALUES ('101', '顺兴', 'SX', '1', '1', '2016-01-29 22:45:06', '罗静萍', '13805964080', '', '', '99', '', '', '水暖城2期20栋14号', '1', '');
INSERT INTO `smanu` VALUES ('102', '圣达手柄', 'SDSB', '1', '1', '2016-01-29 22:47:36', '王仁忠', '13599798998', '86181866', null, '99', null, null, '水暖城二期1幢16号', '1', null);
INSERT INTO `smanu` VALUES ('103', '张三', 'ZS', '2', '1', '2016-01-29 22:48:14', '张三', '', '', '', '1', '', '', '', '0', '');
INSERT INTO `smanu` VALUES ('104', '李四', 'LS', '2', '1', '2016-01-29 22:48:33', '李四', '', '', '', '2', '', '', '', '0', '');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商账号表';

-- ----------------------------
-- Records of smanurow
-- ----------------------------

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
  `price` double(12,3) DEFAULT NULL COMMENT '单价',
  `manuid` int(9) DEFAULT NULL COMMENT '供应商',
  `numofonebox` varchar(9) DEFAULT NULL COMMENT '一件数量',
  `usestock` varchar(1) DEFAULT NULL COMMENT '是否启用库存',
  `stock` double(12,2) DEFAULT NULL COMMENT '库存量',
  `alarmnum` double(12,2) DEFAULT NULL COMMENT '报警量',
  `createdate` varchar(19) DEFAULT NULL COMMENT '新增时间',
  `materialsort` int(2) DEFAULT NULL COMMENT '排序',
  `istobuy` varchar(1) DEFAULT '0' COMMENT '是否加入采购单',
  `statusid` int(1) DEFAULT NULL COMMENT '使用状态',
  `mark` varchar(16) DEFAULT NULL COMMENT '标志',
  `property` varchar(32) DEFAULT NULL COMMENT '属性',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`materialid`),
  UNIQUE KEY `uni_smaterial_no` (`materialno`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of smaterial
-- ----------------------------
INSERT INTO `smaterial` VALUES ('1', '1001001', '赛洛单孔（进）', '159', '1', '13.500', '101', '48', null, null, null, '2016-01-29 22:46:16', '50', '', '1', '进', '390g', '');
INSERT INTO `smaterial` VALUES ('2', '1002001', '6号赛诺', '160', '1', '4.200', '102', '', null, null, null, '2016-01-29 22:50:13', '50', '', '1', '', '', '');

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
  `statusid` int(1) DEFAULT NULL COMMENT '使用状态',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`materialtype`),
  UNIQUE KEY `u_smaterialtype_no` (`materialtypeno`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of smaterialtype
-- ----------------------------
INSERT INTO `smaterialtype` VALUES ('1', '1', '根节点', '99', null, '1', '1', null);
INSERT INTO `smaterialtype` VALUES ('159', '1001', '顺兴', '99', '1', '1-159', '1', '');
INSERT INTO `smaterialtype` VALUES ('160', '1002', '圣达手柄', '99', '1', '1-160', '1', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=10137 DEFAULT CHARSET=utf8 COMMENT='模块表';

-- ----------------------------
-- Records of smodule
-- ----------------------------
INSERT INTO `smodule` VALUES ('1', '根模块', '所有模块的根节点，不能删除', '1', '#', null, null, null);
INSERT INTO `smodule` VALUES ('101', '系统管理', '', '2', '', '1', 'Configs', '');
INSERT INTO `smodule` VALUES ('103', '其它管理', '其它管理-描述', '99', '', '1', 'Others', '');
INSERT INTO `smodule` VALUES ('10101', '用户管理', '用户管理-描述', '3', '/user/list', '101', 'User', 'user_list');
INSERT INTO `smodule` VALUES ('10102', '角色管理', '角色管理-描述', '2', '/role/list', '101', 'Role', 'role_list');
INSERT INTO `smodule` VALUES ('10105', '模块管理', '模块管理-描述', '1', '/module/tree', '101', 'Module', 'module_tree');
INSERT INTO `smodule` VALUES ('10106', '资料管理', '资料管理-描述', '3', '', '1', 'Datas', '');
INSERT INTO `smodule` VALUES ('10108', '公司信息管理', '公司信息管理', '5', '/company/edi/1', '10106', 'Company', 'company_edi');
INSERT INTO `smodule` VALUES ('10109', '供应商管理', '供应商管理', '3', '/manu/list?first=true', '10106', 'Manu', 'manu_list');
INSERT INTO `smodule` VALUES ('10110', '员工管理', '员工管理', '4', '/staff/list?first=true', '10106', 'Staff', 'staff_list');
INSERT INTO `smodule` VALUES ('10111', '财务管理', '财务管理', '4', '', '1', 'Finances', '');
INSERT INTO `smodule` VALUES ('10112', '银行卡管理', '银行卡管理', '99', '/bankcard/list?first=true', '10111', 'Bankcard', 'bankcard_list');
INSERT INTO `smodule` VALUES ('10113', '单据管理', '', '99', '/pay/list?first=true', '10111', 'Pay', 'pay_list');
INSERT INTO `smodule` VALUES ('10114', '物资管理', '', '5', '', '1', 'Materials', '');
INSERT INTO `smodule` VALUES ('10115', '物资类型管理', '', '1', '/materialtype/tree', '10114', 'Materialtype', 'materialtype_tree');
INSERT INTO `smodule` VALUES ('10116', '物资管理', '', '2', '/material/tree', '10114', 'Material', 'material_tree');
INSERT INTO `smodule` VALUES ('10117', '采购管理', '', '3', '/buy/list?first=true', '10114', 'Buy', 'buy_list');
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
INSERT INTO `smodule` VALUES ('10134', '待付列表', '', '4', '/buy/toPay', '10114', 'Buy', 'buy_toPay');
INSERT INTO `smodule` VALUES ('10135', '系统参数', '', '2', '/parameter/list', '10106', 'Parameter', 'parameter_list');
INSERT INTO `smodule` VALUES ('10136', '配置管理', '', '2', '/manage/list', '103', 'Manage', 'manage_list');

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
INSERT INTO `spermission` VALUES ('3', 'Pay:view');
INSERT INTO `spermission` VALUES ('3', 'Products:view');
INSERT INTO `spermission` VALUES ('3', 'Product:view');
INSERT INTO `spermission` VALUES ('3', 'Sell:view');
INSERT INTO `spermission` VALUES ('3', 'Sell:add');
INSERT INTO `spermission` VALUES ('3', 'ReportClient:view');
INSERT INTO `spermission` VALUES ('2631', 'Configs:view');
INSERT INTO `spermission` VALUES ('2631', 'User:view');
INSERT INTO `spermission` VALUES ('2631', 'User:add');
INSERT INTO `spermission` VALUES ('2631', 'User:edi');
INSERT INTO `spermission` VALUES ('2631', 'User:delete');
INSERT INTO `spermission` VALUES ('2631', 'Role:view');
INSERT INTO `spermission` VALUES ('2631', 'Role:add');
INSERT INTO `spermission` VALUES ('2631', 'Role:edi');
INSERT INTO `spermission` VALUES ('2631', 'Role:delete');
INSERT INTO `spermission` VALUES ('2631', 'Module:view');
INSERT INTO `spermission` VALUES ('2631', 'Module:add');
INSERT INTO `spermission` VALUES ('2631', 'Module:edi');
INSERT INTO `spermission` VALUES ('2631', 'Module:delete');
INSERT INTO `spermission` VALUES ('2631', 'Datas:view');
INSERT INTO `spermission` VALUES ('2631', 'Dict:view');
INSERT INTO `spermission` VALUES ('2631', 'Dict:add');
INSERT INTO `spermission` VALUES ('2631', 'Dict:edi');
INSERT INTO `spermission` VALUES ('2631', 'Dict:delete');
INSERT INTO `spermission` VALUES ('2631', 'Parameter:view');
INSERT INTO `spermission` VALUES ('2631', 'Parameter:add');
INSERT INTO `spermission` VALUES ('2631', 'Parameter:edi');
INSERT INTO `spermission` VALUES ('2631', 'Parameter:delete');
INSERT INTO `spermission` VALUES ('2631', 'Others:view');
INSERT INTO `spermission` VALUES ('2631', 'Log:view');
INSERT INTO `spermission` VALUES ('2631', 'Log:edi');
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
INSERT INTO `spermission` VALUES ('1', 'Parameter:view');
INSERT INTO `spermission` VALUES ('1', 'Parameter:add');
INSERT INTO `spermission` VALUES ('1', 'Parameter:edi');
INSERT INTO `spermission` VALUES ('1', 'Parameter:delete');
INSERT INTO `spermission` VALUES ('1', 'Manu:view');
INSERT INTO `spermission` VALUES ('1', 'Manu:add');
INSERT INTO `spermission` VALUES ('1', 'Manu:edi');
INSERT INTO `spermission` VALUES ('1', 'Manu:delete');
INSERT INTO `spermission` VALUES ('1', 'Staff:view');
INSERT INTO `spermission` VALUES ('1', 'Staff:add');
INSERT INTO `spermission` VALUES ('1', 'Staff:edi');
INSERT INTO `spermission` VALUES ('1', 'Staff:delete');
INSERT INTO `spermission` VALUES ('1', 'Company:view');
INSERT INTO `spermission` VALUES ('1', 'Company:add');
INSERT INTO `spermission` VALUES ('1', 'Company:edi');
INSERT INTO `spermission` VALUES ('1', 'Company:delete');
INSERT INTO `spermission` VALUES ('1', 'Finances:view');
INSERT INTO `spermission` VALUES ('1', 'Bankcard:view');
INSERT INTO `spermission` VALUES ('1', 'Bankcard:add');
INSERT INTO `spermission` VALUES ('1', 'Bankcard:edi');
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
INSERT INTO `spermission` VALUES ('1', 'Log:view');
INSERT INTO `spermission` VALUES ('1', 'Log:edi');
INSERT INTO `spermission` VALUES ('1', 'Manage:view');
INSERT INTO `spermission` VALUES ('2', 'Datas:view');
INSERT INTO `spermission` VALUES ('2', 'Manu:view');
INSERT INTO `spermission` VALUES ('2', 'Manu:add');
INSERT INTO `spermission` VALUES ('2', 'Manu:edi');
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
  `productid` int(9) NOT NULL COMMENT '产品ID',
  `productno` varchar(11) NOT NULL COMMENT '产品编码',
  `productname` varchar(64) DEFAULT NULL COMMENT '产品名称',
  `producttype` int(5) DEFAULT NULL COMMENT '产品类型',
  `unit` int(3) DEFAULT NULL COMMENT '计量单位',
  `costprice` double(12,2) DEFAULT NULL COMMENT '成本',
  `profit` double(12,2) DEFAULT NULL COMMENT '利润',
  `realprice` double(12,2) NOT NULL COMMENT '产品单价',
  `numofcase` int(3) DEFAULT '0' COMMENT '一盒数量',
  `numofonebox` int(3) DEFAULT '0' COMMENT '一箱数量',
  `createdate` varchar(19) DEFAULT NULL COMMENT '新增日期',
  `productsort` int(2) DEFAULT NULL COMMENT '排序',
  `buyers` varchar(256) DEFAULT NULL COMMENT '买家',
  `printname` varchar(64) DEFAULT NULL COMMENT '打印名',
  `statusid` int(1) DEFAULT NULL COMMENT '使用状态',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`productid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
-- Records of sproduct
-- ----------------------------
INSERT INTO `sproduct` VALUES ('105', 'BM20401', '赛洛单孔', '198', '1', '29.00', '4.00', '33.00', '2', '42', '2016-01-29 22:58:45', '50', '张三', '', '1', '');

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
  `sort` int(2) DEFAULT NULL COMMENT '排序',
  `remarkrow` varchar(512) DEFAULT NULL COMMENT '备注',
  `remarkshow` varchar(32) DEFAULT NULL COMMENT '采购备注',
  `productionshow` varchar(32) DEFAULT NULL COMMENT '生产备注',
  PRIMARY KEY (`productrowid`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 COMMENT='产品行项表';

-- ----------------------------
-- Records of sproductrow
-- ----------------------------
INSERT INTO `sproductrow` VALUES ('61', '105', '2', '1002001', '6号赛诺', '4.20', '1.00', '4.20', '1', null, '采购备注', null);
INSERT INTO `sproductrow` VALUES ('62', '105', '1', '1001001', '赛洛单孔（进）', '13.50', '1.00', '13.50', '2', null, null, null);
INSERT INTO `sproductrow` VALUES ('63', '105', null, null, '阀芯', '2.10', '1.00', '2.10', '3', null, null, null);
INSERT INTO `sproductrow` VALUES ('64', '105', null, null, '钢压盖', '0.25', '1.00', '0.25', '4', null, null, null);
INSERT INTO `sproductrow` VALUES ('65', '105', null, null, '装饰盖', '0.20', '1.00', '0.20', '5', null, null, null);
INSERT INTO `sproductrow` VALUES ('66', '105', null, null, '网咀', '0.30', '1.00', '0.30', '6', null, null, null);
INSERT INTO `sproductrow` VALUES ('67', '105', null, null, '高脚', '1.00', '1.00', '1.00', '7', null, null, null);
INSERT INTO `sproductrow` VALUES ('68', '105', null, null, '高脚帽', '1.20', '1.00', '1.20', '8', null, null, null);
INSERT INTO `sproductrow` VALUES ('69', '105', null, null, '高脚垫', '0.05', '1.00', '0.05', '9', null, null, null);
INSERT INTO `sproductrow` VALUES ('70', '105', null, null, '软管', '3.00', '1.00', '3.00', '10', null, null, '1号钢丝管');
INSERT INTO `sproductrow` VALUES ('71', '105', null, null, '内袋', '0.10', '1.00', '0.10', '11', null, null, null);
INSERT INTO `sproductrow` VALUES ('72', '105', null, null, '外袋', '0.20', '1.00', '0.20', '12', null, null, null);
INSERT INTO `sproductrow` VALUES ('73', '105', null, null, '盒子', '1.00', '1.00', '1.00', '13', null, null, null);
INSERT INTO `sproductrow` VALUES ('74', '105', null, null, '箱子', '0.20', '1.00', '0.20', '14', null, null, null);
INSERT INTO `sproductrow` VALUES ('75', '105', null, null, '其他费用', '1.70', '1.00', '1.70', '15', null, null, null);

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
  `statusid` int(1) DEFAULT NULL COMMENT '使用状态',
  `manuname` varchar(64) DEFAULT NULL COMMENT '所属客户',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`producttype`),
  UNIQUE KEY `u_sproducttype_no` (`producttypeno`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sproducttype
-- ----------------------------
INSERT INTO `sproducttype` VALUES ('1', '2', '根节点', '1', null, '1', '1', null, null);
INSERT INTO `sproducttype` VALUES ('192', 'BM', '八牧', '1', '1', '1-192', '1', '', '');
INSERT INTO `sproducttype` VALUES ('193', 'BM1', '铜', '1', '192', '1-192-193', '1', '', '');
INSERT INTO `sproducttype` VALUES ('194', 'BM2', '锌', '2', '192', '1-192-194', '1', '', '');
INSERT INTO `sproducttype` VALUES ('195', 'BM201', '淋浴', '1', '194', '1-192-194-195', '1', '', '');
INSERT INTO `sproducttype` VALUES ('196', 'BM202', '二联', '2', '194', '1-192-194-196', '1', '', '');
INSERT INTO `sproducttype` VALUES ('197', 'BM203', '三联', '3', '194', '1-192-194-197', '1', '', '');
INSERT INTO `sproducttype` VALUES ('198', 'BM204', '面盆单孔', '4', '194', '1-192-194-198', '1', '', '');
INSERT INTO `sproducttype` VALUES ('199', 'BM205', '菜盆单孔', '5', '194', '1-192-194-199', '1', '', '');
INSERT INTO `sproducttype` VALUES ('200', 'BM206', '平咀', '6', '194', '1-192-194-200', '1', '', '');
INSERT INTO `sproducttype` VALUES ('201', 'BM207', '尖咀', '7', '194', '1-192-194-201', '1', '', '');
INSERT INTO `sproducttype` VALUES ('202', 'BM208', '网咀', '8', '194', '1-192-194-202', '1', '', '');
INSERT INTO `sproducttype` VALUES ('203', 'BM209', '角阀', '9', '194', '1-192-194-203', '1', '', '');
INSERT INTO `sproducttype` VALUES ('204', 'BM210', '面盆单冷', '10', '194', '1-192-194-204', '1', '', '');
INSERT INTO `sproducttype` VALUES ('205', 'BM211', '菜盆单冷', '11', '194', '1-192-194-205', '1', '', '');

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
INSERT INTO `srole` VALUES ('1', '最高管理员', '1');
INSERT INTO `srole` VALUES ('2', '普通用户', '3');
INSERT INTO `srole` VALUES ('3', '客户', '4');
INSERT INTO `srole` VALUES ('2631', '管理员', '2');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工表';

-- ----------------------------
-- Records of sstaff
-- ----------------------------

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
  `ismanu` varchar(1) DEFAULT NULL COMMENT '是否客户：1是，其他否',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of suser
-- ----------------------------
INSERT INTO `suser` VALUES ('ADMIN', '最高管理员', 'c84258e9c39059a89ab77d846ddab909', null, '1', null);
INSERT INTO `suser` VALUES ('TEST', '测试', '098f6bcd4621d373cade4e832627b4f6', null, '1', null);

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
INSERT INTO `suser_role` VALUES ('ADMIN', '2631');
INSERT INTO `suser_role` VALUES ('TEST', '2');

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
		
		SELECT (IFNULL(SUM(a.salary), 0) + IFNULL(SUM(a.othersalary), 0)) INTO isum FROM bworkrow a, bwork b WHERE a.workid = b.workid AND b.staffid = istaffid AND b.workmonth = vworkmonth;

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
