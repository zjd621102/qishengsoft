<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/pay/list" method="post" rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						当前流程：
						<select name="map[currflow]" style="width: 184px;">
							<option value=""></option>
							<c:forEach items="${currflowList}" var="currflow">
								<option value="${currflow.map.flowname}"
									${currflow.map.flowname==form.map.currflow?"selected":""}
								>
									${currflow.map.flowname}
								</option>
							</c:forEach>
						</select>
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
			<shiro:hasPermission name="Pay:add">
			<li>
				<a class="add" href="<%=path%>/pay/add" target="dialog" rel="pay_add" mask="true"
					width="1300" height="500">
					<span>新增发票</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Pay:edi">
			<li>
				<a class="edit" href="<%=path%>/pay/edi/{s_payid}" target="dialog" rel="pay_edi" mask="true"
					width="1300" height="500">
					<span>修改发票</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Pay:delete">
			<li>
				<a class="delete" href="<%=path%>/pay/delete/{s_payid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除发票</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="5%">序号</th>
				<th width="20%">单据类型</th>
				<th width="20%">发票日期</th>
				<th width="20%">关联单号</th>
				<th width="10%">当前流程</th>
				<th width="10%">实付金额</th>
				<th width="15%">创建时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${payList}" var="bean" varStatus="vs">
			   	<tr target="s_payid" rel="${bean.map.payid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.btypename}</td>
			   		<td>${bean.map.paydate}</td>
			   		<td>${bean.map.relateno}</td>
			   		<td>${bean.map.currflow}</td>
			   		<td>${bean.map.allrealsum}</td>
			   		<td>${bean.map.createtime}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>