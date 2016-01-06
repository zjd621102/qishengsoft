<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<style>
	.unuse td {/***禁用的产品***/
		background-color: #FFCCFF;
	}
</style>

<div class="pageHeader">
	<form onsubmit="return divSearch(this, 'jbsxBox2material${curTime}');"
		action="<%=path%>/material/list/${form.map.materialtype}?curTime=${curTime}" method="post"
		rel="pagerForm" id="fid">
		<input type="hidden" name="curTime" value="${curTime}" />
		<input type="hidden" name="map[materialtype]" value="${form.map.materialtype}" />
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						物资编码：
						<input type="text" name="map[materialno]" value="${form.map.materialno}"
							style="width: 80px;"/>
						物资名称：
						<input type="text" name="map[materialname]" value="${form.map.materialname}"
							style="width: 80px;"/>
						使用状态：
						<st:select dictType="状态" name="map[statusid]" value="${form.map.statusid}"
						 expStr="style='width: 80px; margin-right: 15px;'" />
						标志：
						<input type="text" name="map[mark]" value="${form.map.mark}" style="width: 80px;"/>
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
				<a class="add" href="<%=path%>/material/add/${form.map.materialtype}?curTime=${curTime}"
					target="dialog" rel="material_add" mask="true" width="890" height="418">
					<span>新增物资</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Material:edi">
			<li>
				<a class="edit" href="<%=path%>/material/edi/{s_materialid}?curTime=${curTime}" target="dialog"
					rel="material_edi" mask="true" width="890" height="418">
					<span>修改物资</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Material:delete">
			<li>
				<a class="delete" href="<%=path%>/material/delete/{s_materialid}?curTime=${curTime}"
					target="ajaxTodo" title="确定要删除吗?">
					<span>删除物资</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="144" rel="jbsxBox2material${curTime}">
		<thead>
			<tr>
				<th width="30px">序号</th>
				<th width="60px">物资编码</th>
				<th width="120px">物资名称</th>
				<th width="60px">单价</th>
				<th width="60px">属性</th>
				<th width="50px">标志</th>
				<th width="70px">一件数量</th>
				<th width="80px">物资类型</th>
				<th width="80px">供应商</th>
				<th width="40px">排序</th>
				<th>新增时间</th>
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
					
					<c:if test="${bean.map.statusid == '0'}">
						class="unuse"
					</c:if>
			   	>
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.materialno}</td>
			   		<td>${bean.map.materialname}</td>
			   		<td>${bean.map.price}</td>
			   		<td>${bean.map.property}</td>
			   		<td>${bean.map.mark}</td>
			   		<td>${bean.map.numofonebox}</td>
			   		<td>${bean.map.materialtypename}</td>
			   		<td>${bean.map.manuname}</td>
			   		<td>${bean.map.materialsort}</td>
			   		<td>${bean.map.createdate}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>

	<div class="panelBar">
		<div class="pages">
			<span>显示</span>
			<select class="combox" name="numPerPage"
				onchange="navTabPageBreak({numPerPage:this.value}, 'jbsxBox2material${curTime}')" value="${numPerPage}">
				<option value="15" <c:if test="${numPerPage==15}">selected</c:if>>15</option>
				<option value="30" <c:if test="${numPerPage==30}">selected</c:if>>30</option>
				<option value="50" <c:if test="${numPerPage==50}">selected</c:if>>50</option>
				<option value="100" <c:if test="${numPerPage==100}">selected</c:if>>100</option>
			</select> <span>条，共${totalCount}条</span>
		</div>
		<div class="pagination" targetType="${empty targetType ? 'navTab' : targetType}" rel="jbsxBox2material${curTime}" totalCount="${totalCount}"
			numPerPage="${numPerPage}" pageNumShown="10" currentPage="${pageNum}">
		</div>
	</div>
	<form id="pagerForm" method="post" action="<%=path%>/${sn}/list/${form.map.materialtype}?curTime=${curTime}">
		<input type="hidden" name="pageNum" value="${pageNum}" />
		<input type="hidden" name="numPerPage" value="${numPerPage}" />
		<input type="hidden" name="act" value="${act}" />
	</form>
</div>