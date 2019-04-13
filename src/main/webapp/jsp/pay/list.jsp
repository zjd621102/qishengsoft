<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<!-- 客户不可修改客户名称 -->
<c:if test="${userSessionInfo.map.ismanu == '1'}">
	<c:set var="changeManuname" value="readonly" scope="page" />
</c:if>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/pay/list" method="post" rel="pagerForm" id="fid"
		 class="required-validate">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td style="width: 20%;">
						单据ID：
						<input type="text" name="map[payid]" value="${form.map.payid}"
						 class="number" style="width: 70px;"/>
					</td>
					<td style="width: 20%;">
						当前流程：
						<st:select dictType="流程状态" name="map[currflow]" value="${form.map.currflow}"
						 expStr="style='width: 70px;'" />
					</td>
					<td style="width: 20%;">
						供应商：
						<input type="text" name="map[manuname]" value="${form.map.manuname}" 
							style="width: 70px;" ${changeManuname}/>
					</td>
					<td style="width: 20%;">
						单据日期：
						<input type="text" name="map[paydateFrom]" style="width: 80px;"
						 value="${form.map.paydateFrom}" class="date"/>
					</td>
					<td style="width: 20%;">
						至：
						<input type="text" name="map[paydateTo]" style="width: 80px;"
						 value="${form.map.paydateTo}" class="date"/>
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
					width="800" height="500">
					<span>新增单据</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Pay:edi">
			<li>
				<a class="edit" href="<%=path%>/pay/edi/{s_payid}" target="dialog" rel="pay_edi" mask="true"
					width="800" height="500">
					<span>修改单据</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Pay:delete">
			<li>
				<a class="delete" href="<%=path%>/pay/delete/{s_payid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除单据</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="30px">序号</th>
				<th width="50px">单据ID</th>
				<th width="60px">单据类型</th>
				<th width="80px">单据日期</th>
				<th width="100px">应付(${totalPlanSum})</th>
				<th width="100px">实付(${totalRealSum})</th>
				<th width="100px">待付(${unPaySum})</th>
				<th width="60px">当前流程</th>
				<th>供应商</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${payList}" var="bean" varStatus="vs">
			   	<tr target="s_payid" rel="${bean.map.payid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.payid}</td>
			   		<td>${bean.map.btypename}</td>
			   		<td>${bean.map.paydate}</td>
			   		<td>${bean.map.allplansum}</td>
			   		<td>${bean.map.allrealsum}</td>
			   		<td>${bean.map.unpaysum}</td>
			   		<td>${bean.map.currflow}</td>
			   		<td>${bean.map.manuname}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>