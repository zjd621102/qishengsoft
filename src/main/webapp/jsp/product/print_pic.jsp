<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/pub/include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>打印图标</title>
<style type="text/css">

body {
	margin: 0; padding: 0;
	font-family: '黑体';
	font-size: 14px;
}

table {
	margin: 0; padding: 0;
}

td {
	margin: 0; padding: 0;
}

.bjtd {
	width: 33%;
	height: 14.286%;
	background-image:url('<%=path%>/images/print_bj.png');
}

.secTab {
	width: 86%;
	height: 100%;
}

.picTab {
	width: 45%;
	height: 100%;
	float: left;
	text-align: right;
}

.picTab img {
	width: 80px;
}

.wordTab {
	width: 55%;
	height: 100%;
	font-weight: bolder;
	text-align: center;
}

.productName {
	color: blue;
}

.productNo {
	color: red;
}

.productType {
	color: red;
}

</style>
</head>
<body>
	<table style="width: 210mm; height: 297mm;" cellpadding="0" cellspacing="0">
		<%
		for(int i = 0; i <= 6; i++) {
		%>
		<tr>
			<%
			for(int j = 0; j <= 2; j++) {
			%>
			<td class="bjtd" align="center">
				<table class="secTab">
					<tr>
						<td style="width: 100%; height: 100%;">
							<table class="picTab">
								<tr>
									<td
										<c:if test="${not empty form.map.picPath}">
										style="background-position: 50% 46%; background-image:url('<%=path%>/resources/file/${form.map.picPath}'); background-repeat:no-repeat;"
										</c:if>
									>
									</td>
								</tr>
							</table>
							<table class="wordTab">
								<tr>
									<td>
										<div class="productName">${empty form.map.printname ? form.map.productname : form.map.printname}</div>
										<div class="productNo">${form.map.productno}</div>
										<div>${form.map.numofcase}只装</div>
										<div class="productType">${form.map.materialtype}</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
			<%
			}
			%>
		</tr>
		<%
		}
		%>
	</table>
</body>
</html>