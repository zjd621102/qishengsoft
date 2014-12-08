<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="com.yecoo.util.DateUtils"%>
<%@ page import="com.yecoo.model.CodeTableForm"%>
<%@ page import="com.yecoo.dao.ProductDaoImpl"%>
<%@ include file="/jsp/pub/include.jsp"%>

<%
String curTime = DateUtils.getNowDateTime("HHmmss");
CodeTableForm form2 = (CodeTableForm) request.getAttribute("form");

ProductDaoImpl productDaoImpl = new ProductDaoImpl();
%>
<div class="pageContent">
	<div class="tabs">
		<div class="tabsContent">
			<div>
				<div layoutH="10"
					style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC;
					line-height: 21px; background: #fff">
					<ul class="tree treeFolder expand">
						<li>
							<a href="<%=path%>/product/list/${form.map.producttype}?curTime=<%=curTime%>"
								target="ajax" rel="jbsxBox2product<%=curTime%>">
								${form.map.producttypename}
							</a>
							<%=productDaoImpl.tree(form2, path, curTime)%>
						</li>
					</ul>
				</div>
				<div id="jbsxBox2product<%=curTime%>" class="unitBox" style="margin-left: 246px;"></div>
			</div>
		</div>
	</div>
</div>