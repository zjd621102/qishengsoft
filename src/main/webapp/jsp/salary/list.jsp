<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/salary/list" method="post" rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						工资单名称：
						<input type="text" name="map[salaryname]" maxlength="32"
							value="${form.map.salaryname}" style="width: 120px;"/>
						工资单编号：
						<input type="text" name="map[salaryno]" maxlength="17"
							value="${form.map.salaryno}" style="width: 120px;"/>
						当前流程：
						<st:select dictType="流程状态" name="map[currflow]" value="${form.map.currflow}"
						 expStr="style='width: 100px;'" />
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
			<shiro:hasPermission name="Salary:add">
			<li>
				<a class="add" href="<%=path%>/salary/add" target="dialog" rel="salary_add" mask="true"
					width="1000" height="500">
					<span>新增工资单</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Salary:edi">
			<li>
				<a class="edit" href="<%=path%>/salary/edi/{s_salaryid}" target="dialog" rel="salary_edi" mask="true"
					width="1000" height="500">
					<span>修改工资单</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Salary:delete">
			<li>
				<a class="delete" href="<%=path%>/salary/delete/{s_salaryid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除工资单</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="30px">序号</th>
				<th width="80px">工资单类型</th>
				<th width="150px">工资单名称</th>
				<th width="120px">工资单编号</th>
				<th width="80px">工资单日期</th>
				<th width="80px">工资单金额</th>
				<th width="60px">当前流程</th>
				<th width="60px">制单人</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${salaryList}" var="bean" varStatus="vs">
			   	<tr target="s_salaryid" rel="${bean.map.salaryid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.salarytypename}</td>
			   		<td>${bean.map.salaryname}</td>
			   		<td>${bean.map.salaryno}</td>
			   		<td>${bean.map.salarydate}</td>
			   		<td>${bean.map.allplanmoney}</td>
			   		<td>${bean.map.currflow}</td>
			   		<td>${bean.map.makername}</td>
			   		<td>${bean.map.createtime}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>