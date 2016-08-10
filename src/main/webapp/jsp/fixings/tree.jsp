<%@page import="com.yecoo.model.CodeTableForm"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<%!
public String tree(CodeTableForm form, String path) {
	if (form.getValue("childrenList")==null || ((List<CodeTableForm>) form.getValue("childrenList")).isEmpty()) {
		return "";
	}
	StringBuffer buffer = new StringBuffer();
	buffer.append("<ul>" + "\n");
	for (Object obj : (List) form.getValue("childrenList")) {
		CodeTableForm o = (CodeTableForm) obj;
		buffer.append("<li><a href=\"" + path + "/fixings/list/"
				+ o.getValue("fixingsid")
				+ "\" target=\"ajax\" rel=\"jbsxBox2fixings\">"
				+ o.getValue("fixingsname") + "</a>" + "\n");
		buffer.append(tree(o, path));
		buffer.append("</li>" + "\n");
	}
	buffer.append("</ul>" + "\n");
	return buffer.toString();
}
%>
<%
CodeTableForm form2 = (CodeTableForm) request.getAttribute("form");
%>
<div class="pageContent">
	<div class="tabs">
		<div class="tabsContent">
			<div>
				<div layoutH="10"
					style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
					<ul class="tree treeFolder expand">
						<li>
							<a href="<%=path%>/fixings/list/${form.map.fixingsid}"
								target="ajax" rel="jbsxBox2fixings">
								${form.map.fixingsname}
							</a>
							<%=tree(form2, path)%>
						</li>
					</ul>
				</div>
				<div id="jbsxBox2fixings" class="unitBox" style="margin-left: 246px;"></div>
			</div>
		</div>
	</div>
</div>