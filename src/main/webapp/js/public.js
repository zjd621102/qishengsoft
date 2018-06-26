
var sSystemPath = "/" + location.pathname.split("/")[1] + "/";

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
		
		delRowOther(); //其他操作
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

function delRowOther() {
	
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
 * @param obj 	所在行的对象
 */
function setMultiply(name1, name2, name3, obj) {
	if(obj) {// 当前行
		var row = $(obj).parents("tr:first");
		var realprice = row.find("[name*='map[" + name1 + "]']").val();
		var num = row.find("[name*='map[" + name2 + "]']").val();
		var realsum = multiply(realprice, num);
		row.find("[name*='map[" + name3 + "]']").val(realsum);
	} else {// 所有行
		$("input[name*='map[" + name1 + "]']").each(function() {
			var row = $(this).parents("tr:first");
			var realprice = row.find("[name*='map[" + name1 + "]']").val();
			var num = row.find("[name*='map[" + name2 + "]']").val();
			var realsum = multiply(realprice, num);
			row.find("[name*='map[" + name3 + "]']").val(realsum);
		});
	}
}
/**
 * 相加所有值
 * @param name1 相加的字段
 * @param name2 赋值字段
 */
function setAllSum(name1, name2, name3) {
	
	var nameid = "";
	if(typeof(name3) != "undefined") {
		nameid = "#" +　name3 + " ";
	}
	var allsum = 0.00;
	$(nameid + "input[name*='map[" + name1 + "]']").each(function(){
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
 * @param id1	设置值ID
 * @param name2	
 */
function batchSet(id1, name2) {
	$("[name='" + name2 + "']").val($("#" + id1).val());
}

/**
 * 通过编号打开单据
 * @param path		项目路径
 * @param billNo 	单据编号
 */
function openBillByNo(path, billNo) {
	
	if(billNo == "") {
		return;
	}
	
	$.post(
		path + "/getUrlByNo/" + billNo,
		function(url) {
			
			url = path +　url;
			var dlgId = "_blank";
			var title = " ";
			var options = {width:1000,height:500,mask:true};
			
			$.pdialog.open(url, dlgId, title, options);
		}
	);
}

/**********************附件上传Begin**********************/

/**
 * 上传成功
 * @param file
 * @param data
 * @param response
 */
function uploadifySuccess(file, data, response) {
	if(response == true) {
		alert("上传成功，请重新打开");
	} else {
		alert("上传失败");
	}
}

/**
 * 上传完成
 * @param file		上传的文件
 */
function uploadifyQueueComplete(file) {
	
}

/**
 * 删除文件
 * @param fileid	文件ID
 */
function deleteFile(fileid) {
	$.get(
		sSystemPath + "/file/deleteFile/" + fileid,
		function(data) {
			if(data == "true") {
				$("#tr_file_" + fileid).remove();
			} else {
				alert("删除失败");
			}
		}
	);
}

/**
 * 下载文件
 * @param fileid	文件ID
 */
function downloadFile(fileid) {
	var _url = sSystemPath + "/file/downloadFile/" + fileid;
	$("#downloadForm").attr("action", _url);
	$("#downloadForm")[0].submit();
}

/**********************附件上传End**********************/