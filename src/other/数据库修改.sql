



/**2016.04.08**/
ALTER TABLE `sproducttype`
ADD COLUMN `ptprintname`  varchar(16) NULL COMMENT '别名' AFTER `manuname`;

/**2016.03.24**/
ALTER TABLE `bbuyrow` ADD COLUMN `sort`  float(4,1) NULL COMMENT '排序' AFTER `numofonebox`;