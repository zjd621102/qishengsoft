<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form
		<c:if test="${act=='backselect'}">
			onsubmit="return dwzSearch(this, 'dialog');"
		</c:if>
		<c:if test="${act!='backselect'}">
			onsubmit="return navTabSearch(this);"
		</c:if>
		action="<%=path%>/staff/list" method="post" rel="pagerForm" id="fid">
		<input type="hidden" name="act" value="${act}" />
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						员工名称：<input type="text" name="map[staffname]" style="width: 80px" value="${form.map.staffname}"/>
					</td>
					<td>
						员工状态：
						<st:select dictType="员工状态" name="map[staffstatus]" value="${form.map.staffstatus}"
							expStr="style='width: 80px;'" />
					</td>
					<td>
						月份：
						<input type="text" name="map[month]" style="width: 80px" value="${form.map.month}" class="date"
							dateFmt="yyyy-MM" readonly="readonly"/>
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
			<shiro:hasPermission name="Staff:add">
			<li>
				<a class="add" href="<%=path%>/staff/add" target="dialog" rel="staff_add" mask="true"
					width="500" height="500">
					<span>新增员工</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Staff:edi">
			<li>
				<a class="edit" href="<%=path%>/staff/edi/{s_staffid}" target="dialog" rel="staff_edi" mask="true"
					width="500" height="500">
					<span>修改员工</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Staff:delete">
			<li>
				<a class="delete" href="<%=path%>/staff/delete/{s_staffid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除员工</span>
				</a>
			</li>
			</shiro:hasPermission>
			<li>
				<a class="edit" href="<%=path%>/staff/edi_work/{s_staffid}?map[workmonth]=${form.map.month}" target="dialog" rel="staff_work" mask="true"
					width="800" height="500">
					<span>考勤情况</span>
				</a>
			</li>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="30px">序号</th>
				<th width="80px">员工名称</th>
				<th width="60px">员工类别</th>
				<th width="60px">员工状态</th>
				<th width="100px">联系电话</th>
				<th width="120px">工资开户银行</th>
				<th width="110px">工资银行账号</th>
				<th width="80px">工资帐户名称</th>
				<th width="70px">当月总工资</th>
				<th>优先级</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${staffList}" var="bean" varStatus="vs">
			   	<tr target="s_staffid" rel="${bean.map.staffid}"
			   		ondblclick="$.bringBack({
			   		staffid:'${bean.map.staffid}',
					staffname:'${bean.map.staffname}',
					planmoney:'${bean.map.monthsalary}'})"
			   	>
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.staffname}</td>
			   		<td>${bean.map.stafftypename}</td>
			   		<td>${bean.map.staffstatusname}</td>
			   		<td>${bean.map.tel}</td>
			   		<td>${bean.map.bank}</td>
			   		<td>${bean.map.accountno}</td>
			   		<td>${bean.map.accountname}</td>
			   		<td>${bean.map.monthsalary}</td>
			   		<td>${bean.map.priority}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>