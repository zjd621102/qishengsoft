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
		action="<%=path%>/manu/list" method="post" rel="pagerForm" id="fid">
		<input type="hidden" name="act" value="${act}" />
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						供应商名称：
						<input type="text" name="map[manuname]" size="12" maxlength="32"
							value="${form.map.manuname}"/>
					</td>
					<td>
						供应商类别：
						<st:select dictType="供应商类别" name="map[manutypeid]" value="${form.map.manutypeid}"
						 expStr="style='width: 92px;'" />
					</td>
					<td>
						供应商状态：
						<st:select dictType="状态" name="map[statusid]" value="${form.map.statusid}"
						 expStr="style='width: 92px;'" />
					</td>
					<td>
						推荐人：
						<input type="text" name="map[referee]" size="12" maxlength="16"
						 value="${form.map.referee}"/>
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
			<shiro:hasPermission name="manu:add">
			<li>
				<a class="add" href="<%=path%>/manu/add" target="dialog" rel="manu_add" mask="true"
					width="1000" height="500">
					<span>新增供应商</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="manu:edi">
			<li>
				<a class="edit" href="<%=path%>/manu/edi/{s_manuid}" target="dialog" rel="manu_edi" mask="true"
					width="1000" height="500">
					<span>修改供应商</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="manu:delete">
			<li>
				<a class="delete" href="<%=path%>/manu/delete/{s_manuid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除供应商</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="3%">序号</th>
				<th width="20%">供应商名称</th>
				<th width="10%">供应商类别</th>
				<th width="10%">供应商状态</th>
				<th width="15%">创建时间</th>
				<th width="15%">联系人</th>
				<th width="15%">联系电话</th>
				<th width="8%">推荐人</th>
				<th width="4%">优先级</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${manuList}" var="bean" varStatus="vs">
			   	<tr target="s_manuid" rel="${bean.map.manuid}"
			   		ondblclick="$.bringBack({
			   		manuid:'${bean.map.manuid}',
					manuname:'${bean.map.manuname}',
					manubankname:'${bean.map.manubankname}',
					manubankcardno:'${bean.map.manubankcardno}',
					manuaccountname:'${bean.map.manuaccountname}'})"
			   	>
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.manuname}</td>
			   		<td>${bean.map.manutypename}</td>
			   		<td>${bean.map.statusname}</td>
			   		<td>${bean.map.createdate}</td>
			   		<td>${bean.map.manucontact}</td>
			   		<td>${bean.map.manutel}</td>
			   		<td>${bean.map.referee}</td>
			   		<td>${bean.map.priority}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>