<%@ page import="com.yecoo.model.CodeTableForm"%>
<%@ page import="com.yecoo.util.DateUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/print.css" />
<script type="text/javascript" src="<%=path%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.jqprint-0.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/print.js"></script>
<script type="text/javascript" src="<%=path%>/js/public.js"></script>

<style>
	#martop {
		height: 15.1mm;/*****距页面顶部高*****/
	}
	
	#maintab {
		width: 196.9mm;/*****主界面宽*****/
		height: 266.7mm;/*****主界面高*****/
		margin: auto;
	}
	
	.padtd {
		width: 2mm;/**小格左右间距**/
		/**background-color: red;**/
	}
	
	.padtr {
		height: 0mm;/**小格上下间距**/
		/**background-color: yellow;**/
	}

	.maintd {
		text-align: center;
		width: 63.5mm;/*****小格宽*****/
		height: 38.1mm;/*****小格高*****/
		font-size: 21;
		font-weight: bolder;
		color: blue;
	}
	
	#printdiv {
		text-align: center;
	}
	
	table,table td,table th {
		border: 0px solid black;
		border-collapse: collapse;
	}
	
	.iscu {
		color: red;
	}
</style>

<div id="printdiv" align="center">
	<c:forEach begin="0" end="${pagenum-1}">
	<div style="width: 210mm; height: 297mm; text-align: center;">
	<div id="martop"></div>
	<table id="maintab">
		<tbody>
			<c:forEach begin="0" end="${boxRow-1}" varStatus="vs1">
			<tr>
				<c:forEach begin="0" end="${boxCol-1}" varStatus="vs2">
					<td class="maintd"></td>
					<c:if test="${!vs2.last}">
						<td class="padtd"></td>
					</c:if>
				</c:forEach>
			</tr>
			<c:if test="${!vs1.last}">
				<tr class="padtr">
					<c:forEach begin="0" end="${boxCol-1}" varStatus="vs2">
						<td></td>
						<c:if test="${!vs2.last}">
							<td class="padtd"></td>
						</c:if>
					</c:forEach>
				</tr>
			</c:if>
			</c:forEach>
	   	</tbody>
	</table>
	</div>
	</c:forEach>
</div>

<script type="text/javascript">
	var tdList = $(".maintd");
	
	var i = 0;
	<%
	String yy = new DateUtils().getNowTime("yy");
	String mm = new DateUtils().getNowTime("MM");
	String nowtime = (Integer.parseInt(yy) - 17) + mm;
	List<CodeTableForm> boxList = (List<CodeTableForm>) request.getAttribute("boxList");// 列表
	String htm = null;
	for(CodeTableForm codeTableForm : boxList) {
		htm = ("".equals(codeTableForm.getValue("producttypename"))?"":(codeTableForm.getValue("producttypename") + "<br>"))
			+ ("".equals(codeTableForm.getValue("printname"))?codeTableForm.getValue("productname"):(codeTableForm.getValue("printname"))) + "<br>"
			+ "<div class='iscu'>" + ("".equals(codeTableForm.getValue("iscu"))?"":(codeTableForm.getValue("iscu") + "<br>")) + "</div>"
			+ codeTableForm.getValue("numofonebox") + "只" + "<br>"
			+ "<span style='font-size: 9px;'>" + nowtime + "</span>";
	%>
		$(tdList[i++]).html("<%=htm%>");
	<%
	}
	%>
</script>