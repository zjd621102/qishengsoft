<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<!-- 有“销售:编辑”权限，才可修改客户名称 -->
<shiro:lacksPermission name="Sell:edi">
	<c:set var="changeManuname" value="readonly" scope="page" />
</shiro:lacksPermission>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/sell/list" method="post" rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						销售单编号：
						<input type="text" name="map[sellno]" size="12" maxlength="16"
							value="${form.map.sellno}"/>
					</td>
					<td>
						当前流程：
						<st:select dictType="流程状态" name="map[currflow]" value="${form.map.currflow}" expStr="style='width: 60px;'" />
					</td>
					<td>
						定单日期从：<input type="text" name="map[selldateFrom]" size="8" value="${form.map.selldateFrom}" class="date"/>
					</td>
					<td>
						至：<input type="text" name="map[selldateTo]" size="8" value="${form.map.selldateTo}" class="date"/>
					</td>
					<td>
						客户ID：
						<input type="text" name="map[manuid]" size="8" value="${form.map.manuid}"
							${changeManuname}/>
					</td>
					<td>
						产品编码：
						<input type="text" name="map[productno]" size="8" value="${form.map.productno}"/>
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
			<shiro:hasPermission name="Sell:add">
			<li>
				<a class="add" href="<%=path%>/sell/add" target="dialog" rel="sell_add" mask="true"
					width="1000" height="500">
					<span>新增销售单</span>
				</a>
			</li>
			</shiro:hasPermission>
			<!-- 编辑权限在编辑页面控制 -->
			<li>
				<a class="edit" href="<%=path%>/sell/edi/{s_sellid}" target="dialog" rel="sell_edi" mask="true"
					width="1000" height="500">
					<span>修改销售单</span>
				</a>
			</li>
			<shiro:hasPermission name="Sell:delete">
			<li>
				<a class="delete" href="<%=path%>/sell/delete/{s_sellid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除销售单</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="30px">序号</th>
				<th width="130px">销售单编号</th>
				<th width="80px">定单日期</th>
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