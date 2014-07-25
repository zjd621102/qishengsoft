<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return divSearch(this, 'jbsxBox2producttype');"
		action="<%=path%>/producttype/list/${form.map.parent}" method="post"
		rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						产品类别名称：
						<input type="text" name="map[producttypename]" value="${form.map.producttypename}" />
					</td>
					<td>
						产品类别编码：
						<input type="text" name="map[producttypeno]" value="${form.map.producttypeno}" />
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
			<shiro:hasPermission name="Producttype:add">
			<li>
				<a class="add"
					href="<%=path%>/producttype/add/${form.map.parent}" target="dialog"
					rel="producttype_add" mask="true" width="500" height="500">
					<span>新增产品类别</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Producttype:edi">
			<li>
				<a class="edit" href="<%=path%>/producttype/edi/{s_producttype}"
					target="dialog" rel="producttype_edi" mask="true" width="500"
					height="500">
					<span>修改产品类别</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Producttype:delete">
			<li>
				<a class="delete" href="<%=path%>/producttype/delete/{s_producttype}"
					target="ajaxTodo" title="确定要删除吗?">
					<span>删除产品类别</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="144">
		<thead>
			<tr>
				<th width="10%">序号</th>
				<th width="15%">产品类别编码</th>
				<th width="20%">产品类别名称</th>
				<th width="10%">优先级</th>
				<th width="20%">父产品类别名称</th>
				<th width="25%">备注</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${producttypeList}" var="bean" varStatus="vs">
				<tr target="s_producttype" rel="${bean.map.producttype}">
					<td>${vs.index+1}</td>
					<td>${bean.map.producttypeno}</td>
					<td>${bean.map.producttypename}</td>
					<td>${bean.map.priority}</td>
					<td>${bean.map.parentname}</td>
					<td>${bean.map.remark}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<form id="pagerForm" method="post" action="<%=path%>/producttype/list/${form.map.parent}"></form>
</div>