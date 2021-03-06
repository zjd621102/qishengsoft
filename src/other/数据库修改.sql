
/**2016.07.31**/
CREATE TABLE `sfixings` (
  `fixingsid` int(6) NOT NULL AUTO_INCREMENT,
  `fixingsname` varchar(128) DEFAULT NULL COMMENT '配件名称',
  `description` varchar(512) DEFAULT NULL COMMENT '描述',
  `priority` int(3) DEFAULT NULL COMMENT '优先级',
  `parentid` int(10) DEFAULT NULL COMMENT '父级ID',
  `materialno` varchar(11) NOT NULL DEFAULT '0' COMMENT '物资编码',
  PRIMARY KEY (`fixingsId`)
);

BEGIN
    DECLARE vfixingsname VARCHAR(255);

    SELECT fixingsname INTO vfixingsname FROM sfixings WHERE fixingsid = ifixingsid;

		return vfixingsname;
END;

/**2016.04.22**/
ALTER TABLE `sstaff`
CHANGE COLUMN `photo` `overtimepay`  double(12,2) NULL DEFAULT NULL COMMENT '照片路径' AFTER `salary`;

/**2016.04.08**/
ALTER TABLE `sproducttype`
ADD COLUMN `ptprintname`  varchar(16) NULL COMMENT '别名' AFTER `manuname`;

/**2016.03.24**/
ALTER TABLE `bbuyrow` ADD COLUMN `sort`  float(4,1) NULL COMMENT '排序' AFTER `numofonebox`;