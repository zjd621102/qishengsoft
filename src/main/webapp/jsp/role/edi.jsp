<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h2 class="contentTitle">修改角色</h2>
<form method="post" action="<%=path%>/role/add" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
	<input type="hidden" name="map[roleid]" value="${form.map.roleid}"/>
	<div class="pageFormContent" layoutH="97">
		<dl>
			<dt>角色名称：</dt>
			<dd>
				<input type="text" name="map[rolename]" class="required" size="30" maxlength="64" alt="请输入角色名称"
				 value="${form.map.rolename}"/>
			</dd>
			<dt>优先级：</dt>
			<dd>
				<input type="text" name="map[priority]" class="digits" size="30" maxlength="4"
				 value="${form.map.priority}"/>
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
						<span class="crud">全部</span>
						</span>
					</a>
				</div>
				<ul>
					<c:forEach var="m1" items="${moduleList}" varStatus="m1ind">
						<li ${fn:length(moduleList) == (m1ind.index + 1) ? "class='last'":""}>
							<div class="">
								<div class="indent"></div>
								${fn:length(m1.childrenList) != 0 ? "<div class='collapsable'></div>":"<div class='node'></div>" }
								<a href="#" class="permissionList">
									<span class="module_name">${m1.modulename}</span>
									<span class="inputValue">
									<input type="checkbox" name="map[permission]" value="${m1.sn}:view"/>
									<input type="checkbox" name="map[permission]" value="${m1.sn}:save"/>
									<input type="checkbox" name="map[permission]" value="${m1.sn}:edit"/>
									<input type="checkbox" name="map[permission]" value="${m1.sn}:delete"/>
									</span>
								</a>
							</div>
							<ul>
								<c:forEach var="m2" items="${m1.childrenList}" varStatus="m2ind">
									<li ${fn:length(m1.childrenList) == (m2ind.index + 1) ? "class='last'":""}>
										<div class="">
											<div class="indent"></div>
											<div class="line"></div>
											<div class="node"></div>
											<a href="#" class="permissionList">
												<span class="module_name">${m2.modulename}</span>
												<span class="inputValue">
													<input type="checkbox" name="map[permission]" value="${m2.sn}:view"/>
													<input type="checkbox" name="map[permission]" value="${m2.sn}:save"/>
													<input type="checkbox" name="map[permission]" value="${m2.sn}:edit"/>
													<input type="checkbox" name="map[permission]" value="${m2.sn}:delete"/>
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