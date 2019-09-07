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

//查询利润
function queryProfit() {

	var sellno = $("#sellno").val();
	var currflow = $("#currflow").val();
	var selldateFrom = $("#selldateFrom").val();
	var selldateTo = $("#selldateTo").val();
	
	$.post(
		"<%=path%>/manage/queryProfit",
		{sellno : sellno, currflow : currflow, selldateFrom : selldateFrom, selldateTo : selldateTo},
		function(data) {
			if(data != null && data != "") {// 成功
				$("#profit").val(data);
			} else {// 失败
				$("#profit").val("查无结果");
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
	<br/>
	<br/>
	<div>
		<button type="button" onclick="queryProfit();">我要查询利润</button>
		单据编号：<input type="text" id="sellno" maxlength="16" style="width: 110px;" />
		当前流程：<st:select dictType="销售状态" id="currflow" expStr="style='width: 84px;'" />
		发货日期从<input type="text" id="selldateFrom" style="width: 80px;" class="date" />	
		至<input type="text" id="selldateTo" style="width: 80px;" value="" class="date" />
		利润：<input type="text" id="profit" style="width: 80px;" readonly="readonly" />
	</div>
	<br/>
	<br/>
	<div>
		账户金额：<input type="text" style="width: 80px;" value="${zhje}" readonly="readonly" />
		单据已收款：<input type="text" style="width: 80px;" value="${djysk}" readonly="readonly" />
		销售已收款：<input type="text" style="width: 80px;" value="${xsysk}" readonly="readonly" />
		采购已付款：<input type="text" style="width: 80px;" value="${cgysk}" readonly="readonly" />
		合计：<input type="text" style="width: 80px;" value="${hj}" readonly="readonly" />
	</div>
	<!-- 
	<div style="margin-top: 10px;">
		<button type="button" onclick="refreshProductMaterial();">刷新产品物资</button>
		旧物资编码：<input type="text" id="materialno_old" size="10"/>
		新物资编码：<input type="text" id="materialno_new" size="10" />
	</div>
	<div style="margin-top: 10px;">
		<button type="button" onclick="window.open('<%=path%>/fixings/fixingsList');">配件列表</button>
	</div>
	-->
</div>