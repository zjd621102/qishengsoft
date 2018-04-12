<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/parameter/list" method="post" rel="pagerForm" id="fid">
		<input type="hidden" name="act" value="${act}" />
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						系统参数名称：
						<input type="text" name="map[parametername]" style="width: 70px;" maxlength="32"
							value="${form.map.parametername}"/>
					</td>
					<td>
						系统参数值：
						<input type="text" name="map[parametervalue]" style="width: 70px;" maxlength="32"
							value="${form.map.parametervalue}"/>
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
			<shiro:hasPermission name="Parameter:add">
			<li>
				<a class="add" href="<%=path%>/parameter/add" target="dialog" rel="parameter_add" mask="true"
					width="600" height="300">
					<span>新增系统参数</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Parameter:edi">
			<li>
				<a class="edit" href="<%=path%>/parameter/edi/{s_parameterid}" target="dialog" rel="parameter_edi" mask="true"
					width="600" height="300">
					<span>修改系统参数</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Parameter:delete">
			<li>
				<a class="delete" href="<%=path%>/parameter/delete/{s_parameterid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除系统参数</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="30px">序号</th>
				<th width="100px">系统参数名称</th>
				<th width="100px">系统参数值</th>
				<th width="120px">创建时间</th>
				<th>备注</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${parameterList}" var="bean" varStatus="vs">
			   	<tr target="s_parameterid" rel="${bean.map.parameterid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.parametername}</td>
			   		<td>${bean.map.parametervalue}</td>
			   		<td>${bean.map.createtime}</td>
			   		<td>${bean.map.remark}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>