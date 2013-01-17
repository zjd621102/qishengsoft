/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : qishengsoft

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2013-01-17 16:17:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `smodule`
-- ----------------------------
DROP TABLE IF EXISTS `smodule`;
CREATE TABLE `smodule` (
  `moduleid` int(10) NOT NULL AUTO_INCREMENT COMMENT '模块ID',
  `modulename` varchar(64) NOT NULL COMMENT '模块名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `priority` int(3) DEFAULT NULL COMMENT '优先级（数值越小，优先级越高）',
  `url` varchar(128) DEFAULT NULL COMMENT '模块地址 ',
  `parentid` int(10) DEFAULT NULL COMMENT '父级ID',
  `sn` varchar(32) DEFAULT NULL COMMENT '授权名称',
  `rel` varchar(32) DEFAULT NULL COMMENT '页面标识',
  PRIMARY KEY (`moduleid`)
) ENGINE=InnoDB AUTO_INCREMENT=10106 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of smodule
-- ----------------------------
INSERT INTO `smodule` VALUES ('1', '根模块', '所有模块的根节点，不能删除', '1', '#', null, null, null);
INSERT INTO `smodule` VALUES ('101', '系统管理', '系统管理-描述', '1', '/user/list', '1', 'Config', '');
INSERT INTO `smodule` VALUES ('103', '其它管理', '其它管理-描述', '1', '/user/list', '1', 'Other', null);
INSERT INTO `smodule` VALUES ('10101', '用户管理', '用户管理-描述', '99', '/user/list', '101', 'User', 'user_list');
INSERT INTO `smodule` VALUES ('10102', '角色管理', '角色管理-描述', '99', '/role/list', '101', 'Role', 'role_list');
INSERT INTO `smodule` VALUES ('10105', '模块管理', '模块管理-描述', '99', '/module/tree', '101', 'Module', 'module_tree');

-- ----------------------------
-- Table structure for `spermission`
-- ----------------------------
DROP TABLE IF EXISTS `spermission`;
CREATE TABLE `spermission` (
  `roleid` int(10) NOT NULL COMMENT '角色ID',
  `permission` varchar(255) NOT NULL COMMENT '资源代码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of spermission
-- ----------------------------
INSERT INTO `spermission` VALUES ('2', 'Other:view');
INSERT INTO `spermission` VALUES ('1', 'Config:view');
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
INSERT INTO `spermission` VALUES ('1', 'Other:view');

-- ----------------------------
-- Table structure for `srole`
-- ----------------------------
DROP TABLE IF EXISTS `srole`;
CREATE TABLE `srole` (
  `roleid` int(10) NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `rolename` varchar(128) NOT NULL COMMENT '角色名称',
  `priority` int(4) DEFAULT '99' COMMENT '优先级（数据越小，优先级越高）',
  PRIMARY KEY (`roleid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of srole
-- ----------------------------
INSERT INTO `srole` VALUES ('1', '管理员', '1');
INSERT INTO `srole` VALUES ('2', '普通用户', '2');
INSERT INTO `srole` VALUES ('3', '游客', '3');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of suser
-- ----------------------------
INSERT INTO `suser` VALUES ('LINCC', '林长城', '46cc468df60c961d8da2326337c7aa58', '18979578121', '1', '2013-01-01');
INSERT INTO `suser` VALUES ('ZH112014', '张红', '21218cca77804d2ba1922c33e0151105', '18979172171', '1', '2013-01-01');
INSERT INTO `suser` VALUES ('ZH112208', '张宏', '21218cca77804d2ba1922c33e0151105', '18979576017', '1', '2012-12-06');
INSERT INTO `suser` VALUES ('ZH112732', '张宏', '21218cca77804d2ba1922c33e0151105', '18979172207', '1', null);
INSERT INTO `suser` VALUES ('ZHD103272', '朱宏东', '21218cca77804d2ba1922c33e0151105', '18979372566', '1', null);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of suser_role
-- ----------------------------
INSERT INTO `suser_role` VALUES ('ZHOUJD', '1');
INSERT INTO `suser_role` VALUES ('LINCC', '2');
INSERT INTO `suser_role` VALUES ('LINCC', '3');

-- ----------------------------
-- Function structure for `func_getModuleName`
-- ----------------------------
DROP FUNCTION IF EXISTS `func_getModuleName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_getModuleName`(`imoduleid` int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE vmodulename VARCHAR(255);

    #AN ITEM IS IN-STOCK IF THERE ARE EITHER NO ROWS IN THE rental TABLE
    #FOR THE ITEM OR ALL ROWS HAVE return_date POPULATED

    SELECT modulename INTO vmodulename
    FROM smodule
    WHERE moduleid = imoduleid;

		return vmodulename;
END
;;
DELIMITER ;
