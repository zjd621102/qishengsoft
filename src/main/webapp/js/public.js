$(function(){
	$(".addRow").live("click",function(event){ //新增行
		var row_end = $("#IDEndRow");
		var row_copy = $("#IDCopyRow");
		var row_temp = row_copy.clone(true,true);
		row_temp.show();
		row_temp.insertBefore(row_end);
		
		addRowOther(); //其他操作
	});
	$(".delRow").live("click",function(event){ //删除行
		var row = $(event.target).parents("tr:first");
		$(row).remove();
	});
	$(".btnClear").live("click",function(event){ //清除字段
		var field = $(event.target).attr("suggestFields");
		var fields = field.split(",");
		var row = $(event.target).parents("tr:first");
		if(row.length == 0) {// 主表单清除
			row = $(event.target).parent().parent();
		}
		for(var i = 0; i < fields.length; i++){
			row.find("[name*='map["+fields[i]+"]']").val("");
		}
	});
});
function addRowOther() {
	
}
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
 * @param name1 相乘字段
 * @param name2 相乘字段
 * @param name3 赋值字段
 */
function setMultiply(name1, name2, name3) {
	$("input[name*='map[" + name1 + "]']").each(function() {
		var row = $(this).parents("tr:first");
		var realprice = row.find("[name*='map[" + name1 + "]']").val();
		var num = row.find("[name*='map[" + name2 + "]']").val();
		var realsum = multiply(realprice, num);
		row.find("[name*='map[" + name3 + "]']").val(realsum);
	});
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
 * 相减赋值
 * @param name1 相减字段
 * @param name2 被减字段
 * @param name3 赋值字段
 */
function setReduction(name1, name2, name3) {
	var val = $("input[name*='map[" + name1 + "]']").val()*1 - $("input[name*='map[" + name2 + "]']").val()*1;
	val = Math.round(val * 100) / 100;
	$("input[name*='map[" + name3 + "]']").val(val);
}
/**
 * 校验必填
 * @returns {Boolean}
 */
function checkRequiredField() {
	var b = true;
	$(".notnull").each(function() {
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
	if(bool) {
		bool = doBeforeSubmit();
	}
	
	return bool;
}

/**
 * 提交之前操作
 * @returns {Boolean}
 */
function doBeforeSubmit() {

	return true;
}

/**
 * 批量设置
 */
function batchSet(id1, name2) {
	$("[name='" + name2 + "']").val($("#" + id1).val());
}