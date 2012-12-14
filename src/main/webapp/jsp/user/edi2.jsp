<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
%>

<body>
	<div class="pageContent">
		<form method="post" action="<%=path%>/user/edi"
			class="pageForm required-validate"
			onsubmit="return validateCallback(this, navTabAjaxDone);">
			<p>
				<input type="text" name="orgLookup.id" value="${orgLookup.id}" />
				<input type="text" class="required" name="orgLookup.orgName"
					value="" suggestFields="orgNum,orgName"
					suggestUrl="<%=path%>/jsp/pub/jsonSelect.jsp"
					lookupGroup="orgLookup" />
			</p>
	</div>
</body>