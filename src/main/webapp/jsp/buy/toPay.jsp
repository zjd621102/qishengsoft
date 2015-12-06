<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<c:if test="${act=='excel'}">
<%
	response.setContentType("application/vnd.ms-excel;charset=GBK");
	String excelname=new String("待付列表.xls".getBytes("GBK"),"iso8859-1");
	response.setHeader("Content-disposition","inline; filename="+excelname);
%>
<style type="text/css">
	td {
		border-right: thin solid #DADCDD;
		border-bottom: thin solid #DADCDD;
		mso-number-format:'\@';
	}
	
	table {
		border: thin hidden #DADCDD;
		text-align: center;
	}
</style>
</c:if>

<c:if test="${act!='excel'}">
	<div class="pageHeader">
		<form onsubmit="return navTabSearch(this);" action="<%=path%>/buy/toPay" method="post" rel="pagerForm" id="fid">
			<div class="searchBar">
				<table class="searchContent">
					<tr>
						<td style="width: 25%;">
							采购日期从：<input type="text" name="map[buydateFrom]" size="8" value="${form.map.buydateFrom}" class="date"/>
						</td>
						<td>
							至：<input type="text" name="map[buydateTo]" size="8" value="${form.map.buydateTo}" class="date"/>
						</td>
						<td>
							供应商名称：
							<input type="text" name="map[manuname]" size="14" value="${form.map.manuname}"/>
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
</c:if>
<div class="pageContent">
	<c:if test="${act!='excel'}">
		<div class="panelBar">
			<ul class="toolBar">
				<li>
					<a class="icon" href="<%=path%>/buy/toPay?act=excel" target="dwzExport" targetType="navTab"
				 		title="确实要导出这些记录吗?">
				 		<span>导出EXCEL</span>
				 	</a>
				</li>
			</ul>
		</div>
	</c:if>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="40px;">序号</th>
				<th width="120px;">供应商名称</th>
				<th width="80px">联系人</th>
				<th width="100px">手机号码</th>
				<th width="100px">电话</th>
				<th width="150px;">待付金额（${totalSum}）</th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${buyList}" var="bean" varStatus="vs">
			   	<tr target="s_buyid" rel="${bean.map.buyid}">
			   		<td>${vs.index+1}</td>
			   		<td>${bean.map.manuname}</td>
			   		<td>${bean.map.manucontact}</td>
			   		<td><a href="wtai://wp/mc;${bean.map.manuphone}">${bean.map.manuphone}</a></td>
			   		<td><a href="wtai://wp/mc;${bean.map.manutel}">${bean.map.manutel}</a></td>
			   		<td>${bean.map.sum}</td>
			   		<td></td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<c:if test="${act!='excel'}">
		<div class="panelBar">
			<div class="pages">
				<span>显示</span> <select class="combox" name="numPerPage"
					onchange="navTabPageBreak({numPerPage:this.value})" value="${numPerPage}">
					<option value="15" <c:if test="${numPerPage==15}">selected</c:if>>15</option>
					<option value="30" <c:if test="${numPerPage==30}">selected</c:if>>30</option>
					<option value="50" <c:if test="${numPerPage==50}">selected</c:if>>50</option>
					<option value="100" <c:if test="${numPerPage==100}">selected</c:if>>100</option>
				</select> <span>条，共${totalCount}条</span>
			</div>
			<div class="pagination" targetType="${empty targetType ? 'navTab' : targetType}" totalCount="${totalCount}"
				numPerPage="${numPerPage}" pageNumShown="10" currentPage="${pageNum}">
			</div>
		</div>
		<form id="pagerForm" method="post" action="<%=path%>/${sn}/toPay">
			<input type="hidden" name="pageNum" value="${pageNum}" />
			<!--【必须】value="1"可以写死-->
			<input type="hidden" name="numPerPage" value="${numPerPage}" />
		</form>
	</c:if>
</div>