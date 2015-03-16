<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/dict/list" method="post" rel="pagerForm" id="fid">
		<input type="hidden" name="act" value="${act}" />
		<div class="searchBar">
			<table class="searchContent" style="width: 120px">
				<tr>
					<td>
						字典类型：
						<input type="text" name="map[dicttype]" style="width: 120px;" maxlength="32"
							value="${form.map.dicttype}"/>
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
			<shiro:hasPermission name="Dict:add">
			<li>
				<a class="add" href="<%=path%>/dict/add" target="dialog" rel="dict_add" mask="true"
					width="1000" height="500">
					<span>新增字典</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Dict:edi">
			<li>
				<a class="edit" href="<%=path%>/dict/edi/{s_dictid}" target="dialog" rel="dict_edi" mask="true"
					width="1000" height="500">
					<span>修改字典</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Dict:delete">
			<li>
				<a class="delete" href="<%=path%>/dict/delete/{s_dictid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除字典</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="30px">序号</th>
				<th width="100px">字典类型</th>
				<th width="120px">创建时间</th>
				<th>备注</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${dictList}" var="bean" varStatus="vs">
			   	<tr target="s_dictid" rel="${bean.map.dictid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.dicttype}</td>
			   		<td>${bean.map.createtime}</td>
			   		<td>${bean.map.remark}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>