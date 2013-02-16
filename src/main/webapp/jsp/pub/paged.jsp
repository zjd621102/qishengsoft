<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
%>

<div class="panelBar">
	<div class="pages">
		<span>显示</span> <select class="combox" name="numPerPage"
			onchange="navTabPageBreak({numPerPage:this.value})"
			value="${numPerPage}">
			<option value="15"
				<c:if test="${numPerPage==15}">
	   					selected
	   				</c:if>>15</option>
			<option value="30"
				<c:if test="${numPerPage==30}">
	   					selected
	   				</c:if>>30</option>
			<option value="50"
				<c:if test="${numPerPage==50}">
	   					selected
	   				</c:if>>50</option>
			<option value="100"
				<c:if test="${numPerPage==100}">
	   					selected
	   				</c:if>>100</option>
		</select> <span>条，共${totalCount}条</span>
	</div>
	<div class="pagination" targetType="navTab" totalCount="${totalCount}"
		numPerPage="${numPerPage}" pageNumShown="10" currentPage="${pageNum}">
	</div>
</div>
<form id="pagerForm" method="post" action="<%=path%>/${sn}/list">
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<!--【必须】value="1"可以写死-->
	<input type="hidden" name="numPerPage" value="${numPerPage}" />
	<!--【可选】每页显示多少条-->
	<!--<input type="hidden" name="orderField" value="xxx" />【可选】查询排序-->
	<!--<input type="hidden" name="orderDirection" value="asc" />【可选】升序降序-->
	<!--【可选】其它查询条件，业务有关，有什么查询条件就加什么参数。也可以在searchForm上设置属性rel="pagerForm"，js框架会自动把searchForm搜索条件复制到pagerForm中
			<input type="hidden" name="name" value="xxx" />
      		<input type="hidden" name="status" value="active" />
      		-->
</form>