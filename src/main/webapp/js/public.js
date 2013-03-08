$(function(){
	$(".addRow").live("click",function(event){ //新增行
		var row_end = $("#IDEndRow");
		var row_copy = $("#IDCopyRow");
		var row_temp = row_copy.clone(true,true);
		row_temp.show();
		row_temp.insertBefore(row_end);
	});
	$(".delRow").live("click",function(event){ //删除行
		var row = $(event.target).parent().parent().parent();
		$(row).remove();
	});
	$(".btnClear").live("click",function(event){ //清除字段
		var field = $(event.target).attr("suggestFields");
		var fields = field.split(",");
		var obj = $(event.target).parent().parent().parent();
		for(var i = 0; i < fields.length; i++){
			obj.find("input[name*='map["+fields[i]+"]']").val("");
		}
	});
});
/**
 * 乘
 * @param dou1
 * @param dou2
 * @returns {Number}
 */
function multiply(dou1, dou2) {
	return Math.round(dou1 * dou2 * 100) / 100;
}
/**
 * 赋值相乘的值
 * @param obj
 * @param name1 相乘字段
 * @param name2 相乘字段
 * @param name3 赋值字段
 */
function setMultiply(obj, name1, name2, name3) {
	var row = $(obj).parent().parent().parent();
	var realprice = row.find("input[name*='map[" + name1 + "]']").val();
	var num = row.find("input[name*='map[" + name2 + "]']").val();
	var realsum = multiply(realprice, num);
	row.find("input[name*='map[" + name3 + "]']").val(realsum);
}
/**
 * 相加所有值
 * @param name1 相加的字段
 * @param name2 赋值字段
 */
function setAllSum(name1, name2) {
	var allsum = 0.00;
	$("input[name*='map[" + name1 + "]']").each(function(){
		allsum += $(this).val()*1;
	});
	allsum = Math.round(allsum * 100) / 100;
	if(name2) {
		$("input[name*='map[" + name2 + "]']").val(allsum);
	}
	return allsum;
}
/**
 * 校验必填
 * @returns {Boolean}
 */
function checkRequiredField() {
	var b = true;
	$(".notnull").each(function(){
		if($(this).is(":visible") && $(this).val()=="") {
			alertMsg.error($(this).attr("alt") + "不能为空");
			b = false;;
		}
	});
	return b;
}
/**
 * 提交校验
 * @returns {Boolean}
 */
function checkFormSubmit() {
	var bool = true;
	
	bool = checkRequiredField();
	return bool;
}