<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h2 class="contentTitle">修改角色</h2>
<form method="post" action="<%=path%>/role/edi" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
	<input type="hidden" name="map[roleid]" value="${form.map.roleid}"/>
	<div class="pageFormContent" layoutH="97">
		<dl>
			<dt>角色名称：</dt>
			<dd>
				<input type="text" name="map[rolename]" class="required" size="30" maxlength="64" alt="请输入角色名称"
				 value="${form.map.rolename}"/>
			</dd>
		</dl>
		<dl>
			<dt>优先级：</dt>
			<dd style="width: 65%;">
				<input type="text" name="map[priority]" class="required digits" size="30" min="1" max="99" value="${form.map.priority}"/>
				<span class="info">&nbsp;&nbsp;默认:99</span>
			</dd>
		</dl>
		<div class="divider"></div>
		<ul class="treeCustom">
			<li>
				<div class="">
					<div class="first_collapsable"></div>
					<a href="#" class="permissionList">
						<span class="module_name">根模块</span>
						<span style="float: right;">
							<span class="crud">读取</span>
							<span class="crud">创建</span>
							<span class="crud">修改</span>
							<span class="crud">删除</span>
						</span>
					</a>
				</div>
				<ul>
					<c:forEach var="m1" items="${moduleList}" varStatus="m1ind">
						<li ${fn:length(moduleList) == (m1ind.index + 1) ? "class='last'":""}>
							<div class="">
								<div class="indent"></div>
								${fn:length(m1.map.childrenList) != 0 ? "<div class='collapsable'></div>":"<div class='node'></div>" }
								<a href="#" class="permissionList">
									<span class="module_name">${m1.map.modulename}</span>
									<span class="inputValue">
									<c:set var="str" value="${m1.map.sn}:view"></c:set>
									<input type="checkbox" name="map[permission]" value="${m1.map.sn}:view"
									 ${fn:contains(form.map.permission,str) ? "checked=\"checked\"" : ""} />
									<c:set var="str" value="${m1.map.sn}:save"></c:set>
									<input type="checkbox" name="map[permission]" value="${m1.map.sn}:save"
									 ${fn:contains(form.map.permission,str) ? "checked=\"checked\"" : ""} />
									<c:set var="str" value="${m1.map.sn}:edit"></c:set>
									<input type="checkbox" name="map[permission]" value="${m1.map.sn}:edit"
									 ${fn:contains(form.map.permission,str) ? "checked=\"checked\"" : ""} />
									<c:set var="str" value="${m1.map.sn}:delete"></c:set>
									<input type="checkbox" name="map[permission]" value="${m1.map.sn}:delete"
									 ${fn:contains(form.map.permission,str) ? "checked=\"checked\"" : ""} />
									</span>
								</a>
							</div>
							<ul>
								<c:forEach var="m2" items="${m1.map.childrenList}" varStatus="m2ind">
									<li ${fn:length(m1.map.childrenList) == (m2ind.index + 1) ? "class='last'":""}>
										<div class="">
											<div class="indent"></div>
											<div class="line"></div>
											<div class="node"></div>
											<a href="#" class="permissionList">
												<span class="module_name">${m2.map.modulename}</span>
												<span class="inputValue">
													<c:set var="str" value="${m2.map.sn}:view"></c:set>
													<input type="checkbox" name="map[permission]" value="${m2.map.sn}:view"
													 ${fn:contains(form.map.permission,str) ? "checked=\"checked\"" : ""} />
													<c:set var="str" value="${m2.map.sn}:save"></c:set>
													<input type="checkbox" name="map[permission]" value="${m2.map.sn}:save"
													 ${fn:contains(form.map.permission,str) ? "checked=\"checked\"" : ""} />
													<c:set var="str" value="${m2.map.sn}:edit"></c:set>
													<input type="checkbox" name="map[permission]" value="${m2.map.sn}:edit"
													 ${fn:contains(form.map.permission,str) ? "checked=\"checked\"" : ""} />
													<c:set var="str" value="${m2.map.sn}:delete"></c:set>
													<input type="checkbox" name="map[permission]" value="${m2.map.sn}:delete"
													 ${fn:contains(form.map.permission,str) ? "checked=\"checked\"" : ""} />
												</span>
											</a>
										</div>
									</li>
								</c:forEach>
							</ul>
						</li>
					</c:forEach>		
				</ul>
			</li>
		</ul>
	</div>	
	
	<div class="formBar">
		<ul>
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
		</ul>
	</div>
</form>