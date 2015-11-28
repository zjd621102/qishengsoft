<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<c:if test="${act=='excel'}">
<%
	response.setContentType("application/vnd.ms-excel;charset=GBK");
	String excelname=new String("日志列表.xls".getBytes("GBK"),"iso8859-1");
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
		<form onsubmit="return navTabSearch(this);" action="<%=path%>/log/list" method="post" rel="pagerForm" id="fid">
			<input type="hidden" name="act" id="act" />
			<div class="searchBar">
				<table class="searchContent" style="width: 80%">
					<tr>
						<td>
							操作类型：<input type="text" name="map[logtype]" value="${form.map.logtype}" size="10"/>
						</td>
						<td>
							操作人：<input type="text" name="map[operatername]" value="${form.map.operatername}" size="10"/>
						</td>
						<td>
							操作时间从：<input type="text" class="date" readonly="readonly" name="map[fromTime]"
								dateFmt="yyyy-MM-dd HH:mm:ss" value="${form.map.fromTime}" size="15" />
						</td>
						<td>
							至：<input type="text" class="date" readonly="readonly" name="map[toTime]"
								dateFmt="yyyy-MM-dd HH:mm:ss" value="${form.map.toTime}" size="15" />
						</td>
						<td>
							备注：<input type="text" name="map[remark]" value="${form.map.remark}"/>
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
</c:if>
<div class="pageContent">
	<c:if test="${act!='excel'}">
		<div class="panelBar">
			<ul class="toolBar">
				<shiro:hasPermission name="Log:edi">
				<li>
					<a class="edit" href="<%=path%>/log/edi/{s_logid}" target="dialog" rel="log_edi" height="330">
						<span>查看日志</span>
					</a>
				</li>
				<li class="line">line</li>
				</shiro:hasPermission>
				<li>
					<a class="icon" href="<%=path%>/log/list?act=excel" target="dwzExport" targetType="navTab"
				 		title="确实要导出这些记录吗?">
				 		<span>导出EXCEL</span>
				 	</a>
				</li>
			</ul>
		</div>
	</c:if>
	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr style="width: 1000px;">
				<c:if test="${act!='excel'}">
					<th width="3%">
						<input type="checkbox" group="ids" class="checkboxCtrl">
					</th>
				</c:if>
				<th width="30px">序号</th>
				<th width="100px">操作类型</th>
				<th width="80px">操作人</th>
				<th width="100px">IP</th>
				<th width="150px">操作时间</th>
				<th>备注</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${logList}" var="bean" varStatus="vs">
			   	<tr target="s_logid" rel="${bean.map.logid}">
			   		<c:if test="${act!='excel'}">
			   			<td>
			   				<input name="ids" value="${bean.map.logid}" type="checkbox">
			   			</td>
			   		</c:if>
			   		<td>${vs.index+1}</td>
			   		<td>
			   			<c:if test="${act!='excel'}"><!-- 会乱码 -->
			   				${bean.map.logtype}
			   			</c:if>
			   		</td>
			   		<td>${bean.map.operatername}</td> 
			   		<td>${bean.map.ip}</td>
			   		<td>${bean.map.operatetime}</td>
			   		<td>${bean.map.remark}</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
	<c:if test="${act!='excel'}">
		<jsp:include page="../pub/paged.jsp"></jsp:include>
	</c:if>
</div>