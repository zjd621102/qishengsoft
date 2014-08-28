<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return divSearch(this, 'jbsxBox2material');"
		action="<%=path%>/material/list/${form.map.materialtype}" method="post"
		rel="pagerForm" id="fid">
		<input type="hidden" name="map[materialtype]" value="${form.map.materialtype}" />
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						物资名称：<input type="text" name="map[materialname]" value="${form.map.materialname}"/>
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
			<shiro:hasPermission name="Material:add">
			<li>
				<a class="add" href="<%=path%>/material/add/${form.map.materialtype}" target="dialog" rel="material_add"
					mask="true" width="500" height="550">
					<span>新增物资</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Material:edi">
			<li>
				<a class="edit" href="<%=path%>/material/edi/{s_materialid}" target="dialog" rel="material_edi" mask="true"
					width="500" height="550">
					<span>修改物资</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Material:delete">
			<li>
				<a class="delete" href="<%=path%>/material/delete/{s_materialid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除物资</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="144" rel="jbsxBox2material">
		<thead>
			<tr>
				<th width="5%">序号</th>
				<th width="15%">物资编码</th>
				<th width="15%">物资名称</th>
				<th width="15%">物资类型</th>
				<th width="10%">计量单位</th>
				<th width="10%">单价</th>
				<th width="15%">供应商</th>
				<th width="15%">新增时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${materialList}" var="bean" varStatus="vs">
			   	<tr target="s_materialid" rel="${bean.map.materialid}"
			   		ondblclick="$.bringBack({
			   		materialid:'${bean.map.materialid}',
					materialno:'${bean.map.materialno}',
					materialname:'${bean.map.materialname}',
					unit:'${bean.map.unit}',
					price:'${bean.map.price}',
					manuid:'${bean.map.manuid}',
					manuname:'${bean.map.manuname}',
					manucontact:'${bean.map.manucontact}',
					manutel:'${bean.map.manutel}',
					materialprice:'${bean.map.price}'})"
			   	>
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.materialno}</td>
			   		<td>${bean.map.materialname}</td>
			   		<td>${bean.map.materialtypename}</td>
			   		<td>${bean.map.unitname}</td>
			   		<td>${bean.map.price}</td>
			   		<td>${bean.map.manuname}</td>
			   		<td>${bean.map.createdate}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>

	<div class="panelBar">
		<div class="pages">
			<span>显示</span>
			<select class="combox" name="numPerPage"
				onchange="navTabPageBreak({numPerPage:this.value}, 'jbsxBox2material')" value="${numPerPage}">
				<option value="15" <c:if test="${numPerPage==15}">selected</c:if>>15</option>
				<option value="30" <c:if test="${numPerPage==30}">selected</c:if>>30</option>
				<option value="50" <c:if test="${numPerPage==50}">selected</c:if>>50</option>
				<option value="100" <c:if test="${numPerPage==100}">selected</c:if>>100</option>
			</select> <span>条，共${totalCount}条</span>
		</div>
		<div class="pagination" targetType="navTab" rel="jbsxBox2material" totalCount="${totalCount}"
			numPerPage="${numPerPage}" pageNumShown="10" currentPage="${pageNum}">
		</div>
	</div>
	<form id="pagerForm" method="post" action="<%=path%>/${sn}/list/${form.map.materialtype}">
		<input type="hidden" name="pageNum" value="${pageNum}" />
		<input type="hidden" name="numPerPage" value="${numPerPage}" />
	</form>
</div>