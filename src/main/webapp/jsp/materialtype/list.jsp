<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return divSearch(this, 'jbsxBox2materialtype');"
		action="<%=path%>/materialtype/list/${form.map.parent}" method="post"
		rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						物资类型名称：
						<input type="text" name="map[materialtypename]" value="${form.map.materialtypename}" />
					</td>
					<td>
						物资类型编码：
						<input type="text" name="map[materialtypeno]" value="${form.map.materialtypeno}" />
					</td>
				</tr>
			</table>
			<div class="subBar">
				<ul>
					<li>
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="submit">查询</button>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</form>
</div>
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<shiro:hasPermission name="Materialtype:add">
			<li>
				<a class="add"
					href="<%=path%>/materialtype/add/${form.map.parent}" target="dialog"
					rel="materialtype_add" mask="true" width="520" height="350">
					<span>新增物资类型</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Materialtype:edi">
			<li>
				<a class="edit" href="<%=path%>/materialtype/edi/{s_materialtype}"
					target="dialog" rel="materialtype_edi" mask="true" width="520"
					height="350">
					<span>修改物资类型</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Materialtype:delete">
			<li>
				<a class="delete" href="<%=path%>/materialtype/delete/{s_materialtype}"
					target="ajaxTodo" title="确定要删除吗?">
					<span>删除物资类型</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="144">
		<thead>
			<tr>
				<th width="10%">序号</th>
				<th width="15%">物资类型编码</th>
				<th width="20%">物资类型名称</th>
				<th width="10%">优先级</th>
				<th width="20%">父物资类型名称</th>
				<th width="25%">备注</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${materialtypeList}" var="bean" varStatus="vs">
				<tr target="s_materialtype" rel="${bean.map.materialtype}">
					<td>${vs.index+1}</td>
					<td>${bean.map.materialtypeno}</td>
					<td>${bean.map.materialtypename}</td>
					<td>${bean.map.priority}</td>
					<td>${bean.map.parentname}</td>
					<td>${bean.map.remark}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<!-- 
	<div class="panelBar">
		<div class="pages">
			<span>显示</span>
			<select class="combox" name="numPerPage"
				onchange="navTabPageBreak({numPerPage:this.value}, 'jbsxBox2materialtype')" value="${numPerPage}">
				<option value="15" <c:if test="${numPerPage==15}">selected</c:if>>15</option>
				<option value="30" <c:if test="${numPerPage==30}">selected</c:if>>30</option>
				<option value="50" <c:if test="${numPerPage==50}">selected</c:if>>50</option>
				<option value="100" <c:if test="${numPerPage==100}">selected</c:if>>100</option>
			</select> <span>条，共${totalCount}条</span>
		</div>
		<div class="pagination" targetType="${empty targetType ? 'navTab' : targetType}" rel="jbsxBox2materialtype" totalCount="${totalCount}"
			numPerPage="${numPerPage}" pageNumShown="10" currentPage="${pageNum}">
		</div>
	</div>
	-->
	<form id="pagerForm" method="post" action="<%=path%>/${sn}/list/${form.map.parent}">
		<input type="hidden" name="pageNum" value="${pageNum}" />
		<input type="hidden" name="numPerPage" value="${numPerPage}" />
		<input type="hidden" name="act" value="${act}" />
	</form>
</div>