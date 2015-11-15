<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<!-- 客户不可修改客户名称 -->
<c:if test="${userSessionInfo.map.ismanu == '1'}">
	<c:set var="changeManuname" value="readonly" scope="page" />
</c:if>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/sell/list" method="post" rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td style="width: 25%;">
						单据编号：
						<input type="text" name="map[sellno]" maxlength="16" style="width: 110px;"
							value="${form.map.sellno}"/>
					</td>
					<td style="width: 25%;">
						当前流程：
						<st:select dictType="销售状态" name="map[currflow]" value="${form.map.currflow}"
						 expStr="style='width: 114px;'" />
					</td>
					<td style="width: 25%;">
						发货日期：
						<input type="text" name="map[selldateFrom]" style="width: 110px;"
						 value="${form.map.selldateFrom}" class="date"/>
					</td>
					<td>
						至：
						<input type="text" name="map[selldateTo]" style="width: 110px;"
						 value="${form.map.selldateTo}" class="date"/>
					</td>
				</tr>
				<tr>
					<td>
						产品编码：
						<input type="text" name="map[productno]" style="width: 110px;"
						 value="${form.map.productno}"/>
					</td>
					<td>
						产品名称：
						<input type="text" name="map[productname]" style="width: 110px;"
						 value="${form.map.productname}"/>
					</td>
					<td>
						客户名称：
						<input type="text" name="map[manuname]" style="width: 110px;"
						 value="${form.map.manuname}" ${changeManuname}/>
					</td>
					<td></td>
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
			<shiro:hasPermission name="Sell:add">
			<li>
				<a class="add" href="<%=path%>/sell/add" target="dialog" rel="sell_add" mask="true"
					width="1000" height="500">
					<span>新增销售单</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Sell:edi">
			<li>
				<a class="edit" href="<%=path%>/sell/edi/{s_sellid}" target="dialog" rel="sell_edi" mask="true"
					width="1000" height="500">
					<span>修改销售单</span>
				</a>
			</li>
			</shiro:hasPermission>
			<li>
				<a class="edit" href="<%=path%>/sell/edi/{s_sellid}?act=print" target="openwin">
					<span>查看销售单</span>
				</a>
			</li>
			<shiro:hasPermission name="Sell:other">
			</shiro:hasPermission>
			<shiro:hasPermission name="Sell:delete">
			<li>
				<a class="delete" href="<%=path%>/sell/delete/{s_sellid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除销售单</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="158">
		<thead>
			<tr>
				<th width="30px">序号</th>
				<th width="130px">销售单编号</th>
				<th width="80px">发货日期</th>
				<th width="70px">客户名称</th>
				<th width="60px">当前流程</th>
				<th width="60px">制单人</th>
				<th width="145px">销售金额（${totalSum}）</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${sellList}" var="bean" varStatus="vs">
			   	<tr target="s_sellid" rel="${bean.map.sellid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.sellno}</td>
			   		<td>${bean.map.selldate}</td>
			   		<td>${bean.map.manuname}</td>
			   		<td>${bean.map.currflow}</td>
			   		<td>${bean.map.makername}</td>
			   		<td>${bean.map.allrealsum}</td>
			   		<td>${bean.map.createtime}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>