
/**清空表**/
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
TRUNCATE TABLE sbankcard_log;
TRUNCATE TABLE sfile;
TRUNCATE TABLE slog;
TRUNCATE TABLE smanu;
TRUNCATE TABLE smanurow;
TRUNCATE TABLE sproduct;
TRUNCATE TABLE sproductrow;
TRUNCATE TABLE sstaff;

/**删除数据**/
UPDATE cseq SET seq = 100;
DELETE FROM smaterialtype WHERE materialtype <> '1';
DELETE FROM sproducttype WHERE producttype <> '1';
DELETE FROM suser WHERE userid <> 'ZZ';
DELETE FROM suser_role WHERE userid <> 'ZZ';