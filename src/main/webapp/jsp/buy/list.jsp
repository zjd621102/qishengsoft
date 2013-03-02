<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/buy/list" method="post" rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						采购单名称：
						<input type="text" name="map[buyname]" size="30" maxlength="32"
							value="${form.map.buyname}"/>
					</td>
					<td>
						采购单编号：
						<input type="text" name="map[buyno]" size="30" maxlength="13"
							value="${form.map.buyno}"/>
					</td>
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
			<shiro:hasPermission name="buy:add">
			<li>
				<a class="add" href="<%=path%>/buy/add" target="dialog" rel="buy_add" mask="true"
					width="1300" height="500">
					<span>新增采购单</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="buy:edi">
			<li>
				<a class="edit" href="<%=path%>/buy/edi/{s_buyid}" target="dialog" rel="buy_edi" mask="true"
					width="1300" height="500">
					<span>修改采购单</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="buy:delete">
			<li>
				<a class="delete" href="<%=path%>/buy/delete/{s_buyid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除采购单</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="10%">序号</th>
				<th width="10%">单据类型</th>
				<th width="20%">采购单名称</th>
				<th width="10%">采购编号</th>
				<th width="10%">采购日期</th>
				<th width="10%">当前流程</th>
				<th width="10%">制单人</th>
				<th width="20%">创建时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${buyList}" var="bean" varStatus="vs">
			   	<tr target="s_buyid" rel="${bean.map.buyid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.btypename}</td>
			   		<td>${bean.map.buyname}</td>
			   		<td>${bean.map.buyno}</td>
			   		<td>${bean.map.buydate}</td>
			   		<td>${bean.map.currflow}</td>
			   		<td>${bean.map.makername}</td>
			   		<td>${bean.map.createtime}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>