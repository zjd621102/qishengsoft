<%@ page import="com.yecoo.model.CodeTableForm"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/print.css" />
<script type="text/javascript" src="<%=path%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.jqprint-0.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/print.js"></script>
<script type="text/javascript" src="<%=path%>/js/public.js"></script>

<style>
	td {
		text-align: center;
		width: 70mm;
		height: 42.428mm;
		font-size: 27;
		font-weight: bolder;
		color: blue;
	}
	
	table,table td,table th {
		border: 0px solid black;
		border-collapse: collapse;
	}
	
	div {
		color: red;
	}
</style>

<div id="printdiv">
	<c:forEach begin="0" end="${pagenum-1}">
	<table style="width: 210mm; height: 297mm;">
		<tbody>
			<c:forEach begin="0" end="${boxRow-1}">
			<tr>
				<c:forEach begin="0" end="${boxCol-1}">
				<td></td>
				</c:forEach>
			</tr>
			</c:forEach>
	   	</tbody>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	var tdList = $("td");
	var i = 0;
	<%
	List<CodeTableForm> boxList = (List<CodeTableForm>) request.getAttribute("boxList");// 列表
	String htm = null;
	for(CodeTableForm codeTableForm : boxList) {
		htm = ("".equals(codeTableForm.getValue("producttypename"))?"":(codeTableForm.getValue("producttypename") + "<br>"))
			+ ("".equals(codeTableForm.getValue("printname"))?codeTableForm.getValue("productname"):(codeTableForm.getValue("printname"))) + "<br>"
			+ "<div>" + ("".equals(codeTableForm.getValue("iscu"))?"":(codeTableForm.getValue("iscu") + "<br>")) + "</div>"
			+ codeTableForm.getValue("numofonebox") + "只";
	%>
		$(tdList[i++]).html("<%=htm%>");
	<%
	}
	%>
</script>