<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/buy/list" method="post" rel="pagerForm" id="fid">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<!-- 
					<td style="width: 25%;">
						采购单编号：
						<input type="text" name="map[buyno]" style="width: 110px;" maxlength="16"
							value="${form.map.buyno}"/>
					</td>
					-->
					<td style="width: 25%;">
						当前流程：
						<st:select dictType="采购状态" name="map[currflow]" value="${form.map.currflow}"
						 expStr="style='width: 116px;'" />
					</td>
					<td style="width: 25%;">
						采购日期：<input type="text" name="map[buydateFrom]" style="width: 113px;" value="${form.map.buydateFrom}" class="date"/>
					</td>
					<td>
						&#12288;&#12288;&#12288;至：<input type="text" name="map[buydateTo]"  style="width: 113px;" value="${form.map.buydateTo}" class="date"/>
					</td>
					<td>
						供应商名称：
						<input type="text" name="map[manuname]" style="width: 110px;" value="${form.map.manuname}"/>
					</td>
				</tr>
				<tr>
					<td style="width: 25%;">
						物资名称：
						<input type="text" name="map[materialname]" style="width: 110px;" maxlength="16"
							value="${form.map.materialname}"/>
					</td>
					<td>
						物资编码：
						<input type="text" name="map[materialno]" style="width: 110px;" value="${form.map.materialno}"/>
					</td>
					<td style="width: 25%;">
						单据类型：
						<select name="map[btype]" style="width: 116px;">
							<option value=""></option>
							<c:forEach items="${btypeList}" var="btype">
								<option value="${btype.map.dictvalue}"
									${btype.map.dictvalue==form.map.btype?"selected":""}
								>
									${btype.map.dictname}
								</option>
							</c:forEach>
						</select>
					</td>
					<td>
						采购单名称：
						<input type="text" name="map[buyname]" style="width: 110px;" value="${form.map.buyname}"/>
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
			<shiro:hasPermission name="Buy:add">
			<li>
				<a class="add" href="<%=path%>/buy/add" target="dialog" rel="buy_add" mask="true"
					width="1000" height="500">
					<span>新增采购单</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Buy:edi">
			<li>
				<a class="edit" href="<%=path%>/buy/edi/{s_buyid}" target="dialog" rel="buy_edi" mask="true"
					width="1000" height="500">
					<span>修改</span>
				</a>
			</li>
			<li>
				<a class="edit" href="<%=path%>/buy/edi/{s_buyid}?act=print" target="openwin">
					<span>查看</span>
				</a>
			</li>
			<li>
				<a class="edit" href="<%=path%>/buy/edi/{s_buyid}?act=print_barter" target="openwin">
					<span>换货模式</span>
				</a>
			</li>
			<li>
				<a class="edit" href="<%=path%>/buy/merge" target="selectedTodo" rel="ids" title="确实要合并这些记录吗?">
					<span>合并</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Buy:delete">
			<li>
				<a class="delete" href="<%=path%>/buy/delete/{s_buyid}" target="ajaxTodo" title="确定要删除吗?">
					<span>删除</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Buy:edi">
				<li>
					<a class="delete" href="<%=path%>/buy/end" target="selectedTodo" rel="ids"
				 	 title="确实要结束这些采购单吗?">
				 		<span>批量结束</span>
				 	</a>
				</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="158">
		<thead>
			<tr>
				<th width="30px;">
					<input type="checkbox" group="ids" class="checkboxCtrl">
				</th>
				<th width="30px;">序号</th>
				<th width="60px">单据类型</th>
				<th width="120px">采购单名称</th>
				<th width="125px">采购编号</th>
				<th width="80px">采购日期</th>
				<th width="155px">采购金额（${totalSum}）</th>
				<th width="60px">当前流程</th>
				<th width="60px">制单人</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${buyList}" var="bean" varStatus="vs">
			   	<tr target="s_buyid" rel="${bean.map.buyid}">
		   			<td>
			   			<c:if test="${bean.map.currflow == '申请'}">
		   				<input name="ids" value="${bean.map.buyid}" type="checkbox">
		   				</c:if>
		   			</td>
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.btypename}</td>
			   		<td>${bean.map.buyname}</td>
			   		<td>${bean.map.buyno}</td>
			   		<td>${bean.map.buydate}</td>
			   		<td>${bean.map.allsum}</td>
			   		<td>${bean.map.currflow}</td>
			   		<td>${bean.map.makername}</td>
			   		<td>${bean.map.createtime}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<jsp:include page="../pub/paged.jsp"></jsp:include>
</div>