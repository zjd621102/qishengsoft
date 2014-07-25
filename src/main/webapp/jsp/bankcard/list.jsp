<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/bankcard/list" method="post" rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						银行卡卡号：<input type="text" name="map[bankcardno]" size="30" value="${form.map.bankcardno}"/>
					</td>
					<td>
						是否可用：
						<select name="map[status]" style="width: 184px;">
							<option value=""></option>
							<c:forEach items="${statusList}" var="status">
								<option value="${status.map.statusid}"
									${status.map.statusid==form.map.status?"selected":""}
								>
									${status.map.statusname}
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
			<shiro:hasPermission name="bankcard:add">
			<li>
				<a class="add" href="<%=path%>/bankcard/add" target="dialog" rel="bankcard_add" mask="true"
					width="500" height="500">
					<span>新增银行卡</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="bankcard:edi">
			<li>
				<a class="edit" href="<%=path%>/bankcard/edi/{s_bankcardid}" target="dialog" rel="bankcard_edi" mask="true"
					width="500" height="500">
					<span>修改银行卡</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="bankcard:delete">
			<li>
				<a class="delete" href="<%=path%>/bankcard/delete/{s_bankcardid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除银行卡</span>
				</a>
			</li>
			</shiro:hasPermission>
			<li class="line">line</li>
			<shiro:hasPermission name="bankcard:other">
			<li>
				<a class="edit" href="<%=path%>/bankcard/transferAccount/{s_bankcardid}" target="dialog"
					rel="bankcard_transferAccount" mask="true" width="500" height="500">
					<span>内部转账</span>
				</a>
			</li>
			<li>
				<a class="edit" href="<%=path%>/bankcard/transferAccount_list" target="dialog"
					rel="bankcard_transferAccount_list" mask="true" width="1000" height="500">
					<span>转账列表</span>
				</a>
			</li>
			<li class="line">line</li>
			<li>
				<a class="edit" href="<%=path%>/bankcard/receandpay/{s_bankcardid}" target="dialog"
					rel="bankcard_receandpay" mask="true" width="500" height="500">
					<span>其它收支</span>
				</a>
			</li>
			<li>
				<a class="edit" href="<%=path%>/bankcard/receandpay_list" target="dialog"
					rel="bankcard_receandpay_list" mask="true" width="1000" height="500">
					<span>其它收支列表</span>
				</a>
			</li>
			<li>
				<a class="edit" href="<%=path%>/bankcard/transaction_list" target="dialog"
					rel="bankcard_transaction_list" mask="true" width="1000" height="500">
					<span>交易列表</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="10%">序号</th>
				<th width="15%">银行卡卡号</th>
				<th width="15%">开户银行名称</th>
				<th width="15%">银行类型</th>
				<th width="15%">账户名称</th>
				<th width="15%">金额</th>
				<th width="15%">是否可用</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${bankcardList}" var="bean" varStatus="vs">
			   	<tr target="s_bankcardid" rel="${bean.map.bankcardid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.bankcardno}</td>
			   		<td>${bean.map.bankname}</td>
			   		<td>${bean.map.banktypename}</td>
			   		<td>${bean.map.accountname}</td>
			   		<td>${bean.map.money}</td>
			   		<td>${bean.map.statusname}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>