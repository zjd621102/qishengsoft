<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<div class="pageHeader">
	<form onsubmit="return divSearch(this, 'jbsxBox2product${curTime}');"
		action="<%=path%>/product/list/${form.map.producttype}" method="post"
		rel="pagerForm" id="fid">
		<input type="hidden" name="curTime" value="${curTime}" />
		<input type="hidden" name="map[producttype]" value="${form.map.producttype}" />
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						产品编码：
						<input type="text" name="map[productno]" style="width: 100px;"
							value="${form.map.productno}"/>
					</td>
					<td>
						产品名称：
						<input type="text" name="map[productname]" value="${form.map.productname}"
							style="width: 100px;"/>
					</td>
					<td>
						物资编码：
						<input type="text" name="map[materialtypeno]" value="${form.map.materialtypeno}"
							style="width: 100px;"/>
					</td>
					<td>
						买家：
						<input type="text" name="map[buyers]" value="${form.map.buyers}" style="width: 100px;"/>
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
			<shiro:hasPermission name="Product:add">
			<li>
				<a class="add" href="<%=path%>/product/add/${form.map.producttype}?curTime=${curTime}"
					target="dialog" rel="product_add" mask="true" width="1000" height="570">
					<span>新增产品</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Product:edi">
			<li>
				<a class="edit" href="<%=path%>/product/edi/{s_productid}?curTime=${curTime}"
					target="dialog" rel="product_edi" mask="true" width="1000" height="570">
					<span>修改产品</span>
				</a>
			</li>
			</shiro:hasPermission>
			<shiro:hasPermission name="Product:delete">
			<li>
				<a class="delete" href="<%=path%>/product/delete/{s_productid}?curTime=${curTime}"
					target="ajaxTodo" title="确定要删除吗?">
					<span>删除产品</span>
				</a>
			</li>
			</shiro:hasPermission>
		</ul>
	</div>
	<table class="table" style="width: 100%;" layoutH="144" rel="jbsxBox2product${curTime}">
		<thead>
			<tr>
				<th width="30px">序号</th>
				<th width="70px">产品编码</th>
				<th width="160px">产品名称</th>
				<th width="60px">产品类型</th>
				<!-- 
				<th width="60px">计量单位</th>
				-->
				<th width="60px">产品单价</th>
				<th width="60px">一件数量</th>
				<th width="200px">买家</th>
				<th width="40px">排序</th>
				<th>新增日期</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${productList}" var="bean" varStatus="vs">
			   	<tr target="s_productid" rel="${bean.map.productid}"
			   		ondblclick="$.bringBack({
			   		productid:'${bean.map.productid}',
			   		productno:'${bean.map.productno}',
					productname:'${bean.map.productname}',
					unit:'${bean.map.unit}',
					costprice:'${bean.map.costprice}',
					planprice:'${bean.map.realprice}',
					realprice:'${bean.map.realprice}',
					numofonebox:'${bean.map.numofonebox}'})"
			   	>
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.productno}</td>
			   		<td>${bean.map.productname}</td>
			   		<td>${bean.map.producttypename}</td>
			   		<!-- 
			   		<td>${bean.map.unitname}</td>
			   		-->
			   		<td>${bean.map.realprice}</td>
			   		<td>${bean.map.numofonebox}</td>
			   		<td>${bean.map.buyers}</td>
			   		<td>${bean.map.productsort}</td>
			   		<td>${bean.map.createdate}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>

	<div class="panelBar">
		<div class="pages">
			<span>显示</span>
			<select class="combox" name="numPerPage"
				onchange="navTabPageBreak({numPerPage:this.value}, 'jbsxBox2product${curTime}')" value="${numPerPage}">
				<option value="15" <c:if test="${numPerPage==15}">selected</c:if>>15</option>
				<option value="30" <c:if test="${numPerPage==30}">selected</c:if>>30</option>
				<option value="50" <c:if test="${numPerPage==50}">selected</c:if>>50</option>
				<option value="100" <c:if test="${numPerPage==100}">selected</c:if>>100</option>
			</select> <span>条，共${totalCount}条</span>
		</div>
		<div class="pagination" targetType="navTab" rel="jbsxBox2product${curTime}" totalCount="${totalCount}"
			numPerPage="${numPerPage}" pageNumShown="10" currentPage="${pageNum}">
		</div>
	</div>
	<form id="pagerForm" method="post" action="<%=path%>/${sn}/list/${form.map.producttype}">
		<input type="hidden" name="pageNum" value="${pageNum}" />
		<input type="hidden" name="numPerPage" value="${numPerPage}" />
	</form>
</div>