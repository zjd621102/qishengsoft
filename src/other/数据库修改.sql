

/**2016.04.22**/
ALTER TABLE `sstaff`
CHANGE COLUMN `photo` `overtimepay`  double(12,2) NULL DEFAULT NULL COMMENT '照片路径' AFTER `salary`;

/**2016.04.08**/
ALTER TABLE `sproducttype`
ADD COLUMN `ptprintname`  varchar(16) NULL COMMENT '别名' AFTER `manuname`;

/**2016.03.24**/
ALTER TABLE `bbuyrow` ADD COLUMN `sort`  float(4,1) NULL COMMENT '排序' AFTER `numofonebox`;