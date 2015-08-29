<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="com.yecoo.util.DateUtils"%>
<%@ page import="com.yecoo.model.CodeTableForm"%>
<%@ page import="com.yecoo.dao.MaterialDaoImpl"%>
<%@ include file="/jsp/pub/include.jsp"%>

<%
String curTime = DateUtils.getNowDateTime("HHmmss");
CodeTableForm form2 = (CodeTableForm) request.getAttribute("form");

MaterialDaoImpl materialDaoImpl = new MaterialDaoImpl();
%>
<div class="pageContent">
	<div class="tabs">
		<div class="tabsContent">
			<div>
				<div layoutH="10"
					style="float: left; display: block; overflow: auto; width: 190px; border: solid 1px #CCC;
					line-height: 21px; background: #fff">
					<ul class="tree treeFolder expand">
						<li>
							<a href="<%=path%>/material/list/${form.map.materialtype}?act=${act}&curTime=<%=curTime%>&first=true"
								target="ajax" rel="jbsxBox2material<%=curTime%>">
								${form.map.materialtypename}
							</a>
							<%=materialDaoImpl.tree(form2, path, curTime)%>
						</li>
					</ul>
				</div>
				<div id="jbsxBox2material<%=curTime%>" class="unitBox" style="margin-left: 196px;"></div>
			</div>
		</div>
	</div>
</div>