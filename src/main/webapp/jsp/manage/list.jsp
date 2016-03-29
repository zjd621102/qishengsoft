<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<script type="text/javascript">

// 刷新产品列表
function refreshProductList() {
	$.post(
		"<%=path%>/manage/refreshProductList",
		{},
		function(data) {
			if(data == "true") {// 成功
				alertMsg.correct('操作成功')
			} else {// 失败
				alertMsg.error('操作失败');
			}
		}
	);
}

//刷新产品物资
function refreshProductMaterial() {

	var materialno_old = $("#materialno_old").val();
	var materialno_new = $("#materialno_new").val();
	
	$.post(
		"<%=path%>/manage/refreshProductMaterial",
		{materialno_old : materialno_old, materialno_new : materialno_new},
		function(data) {
			if(data == "true") {// 成功
				alertMsg.correct('操作成功')
			} else {// 失败
				alertMsg.error('操作失败');
			}
		}
	);
}

</script>

<div style="margin: 30px 0 0 30px;">
	<div>
		<button type="button" onclick="refreshProductList();">刷新产品列表</button>
	</div>
	<div style="margin-top: 10px;">
		<button type="button" onclick="refreshProductMaterial();">刷新产品物资</button>
		旧物资编码：<input type="text" id="materialno_old" size="10"/>
		新物资编码：<input type="text" id="materialno_new" size="10" />
	</div>
</div>