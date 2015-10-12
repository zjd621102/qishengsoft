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

</script>

<div style="margin: 30px 0 0 30px;">
	<div>
		<button type="button" onclick="refreshProductList();">刷新产品列表</button>
	</div>
</div>