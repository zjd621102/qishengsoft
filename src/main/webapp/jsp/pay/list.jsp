<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/pay/list" method="post" rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						银行卡卡号：<input type="text" name="map[bankcardno]" size="30" maxlength="16"
							value="${form.map.bankcardno}"/>
					</td>
					<td>
						当前流程：
						<select name="map[currflow]" style="width: 184px;" class="required">
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
					width="500" height="500">
					<span>新增收付款单</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Pay:edi">
			<li>
				<a class="edit" href="<%=path%>/pay/edi/{s_payid}" target="dialog" rel="pay_edi" mask="true"
					width="500" height="500">
					<span>修改收付款单</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Pay:delete">
			<li>
				<a class="delete" href="<%=path%>/pay/delete/{s_payid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除收付款单</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="5%">序号</th>
				<th width="10%">单据类型</th>
				<th width="10%">报账日期</th>
				<th width="10%">供应商/客户</th>
				<th width="10%">银行卡卡号</th>
				<th width="10%">关联单号</th>
				<th width="10%">应付金额</th>
				<th width="10%">实付金额</th>
				<th width="10%">当前流程</th>
				<th width="15%">创建时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${payList}" var="bean" varStatus="vs">
			   	<tr target="s_payid" rel="${bean.map.payid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.btypename}</td>
			   		<td>${bean.map.paydate}</td>
			   		<td>${bean.map.manuname}</td>
			   		<td>${bean.map.bankcardno}</td>
			   		<td>${bean.map.relateid}</td>
			   		<td>${bean.map.planmoney}</td>
			   		<td>${bean.map.realmoney}</td>
			   		<td>${bean.map.currflow}</td>
			   		<td>${bean.map.createtime}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>