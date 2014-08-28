<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<h1 class="margin10px">字典信息</h1>
<form method="post" action="<%=path%>/dict/edi" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);">
	<input type="hidden" name="map[dictid]" value="${form.map.dictid}" />
	<div class="pageFormContent" layoutH="88">
		<dl>
			<dt>字典类型：</dt>
			<dd>
				<input type="text" name="map[dicttype]" class="required" size="30" maxlength="32" value="${form.map.dicttype}"/>
			</dd>
		</dl>
		<dl>
			<dt>创建时间：</dt>
			<dd>
				<input type="text" name="map[createtime]" size="30" maxlength="19" readonly="readonly" value="${form.map.createtime}"/>
			</dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" size="30" maxlength="256" value="${form.map.remark}" />
			</dd>
		</dl>
		
		<div class="divider"></div>

		<table class="table" style="width: 100%;">
			<thead>
				<tr>
					<th width="4%">
						<a href="#" class="btnAdd addRow"></a>
					</th>
					<th width="4%">序号</th>
					<th width="20%">字典名称</th>
					<th width="20%">字典值</th>
					<th width="10%">排序</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			   	<tr id="IDCopyRow" style="display:none">
					<td>
						<input type="hidden" name="map[dictrowid]" />
						<a href="#" class="btnDel delRow"></a>
					</td>
			   		<td></td>
			   		<td>
						<input type="text" name="map[dictname]" class="required" style="width: 96%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[dictvalue]" class="required" style="width: 96%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[sordid]" class="required" style="width: 92%" value="1" maxlength="3" class="digits"/>
			   		</td>
			   		<td>
						<input type="text" name="map[rowremark]" style="width: 98%" maxlength="255"/>
			   		</td>
			   	</tr>
				<c:forEach items="${dictrowList}" var="bean" varStatus="vs">
				   	<tr>
						<td>
							<input type="hidden" name="map[dictrowid]" value="${bean.map.dictrowid}"/>
							<a href="#" class="btnDel delRow"></a>
						</td>
				   		<td>${vs.index+1}</td>
				   		<td>
							<input type="text" name="map[dictname]" class="required" maxlength="32" style="width: 96%"
								value="${bean.map.dictname}"/>
				   		</td>
			   		<td>
						<input type="text" name="map[dictvalue]" class="required" style="width: 96%" maxlength="32"
							value="${bean.map.dictvalue}"/>
			   		</td>
			   		<td>
						<input type="text" name="map[sordid]" class="required" style="width: 92%" maxlength="3" class="digits"
							value="${bean.map.sordid}"/>
			   		</td>
			   		<td>
						<input type="text" name="map[rowremark]" style="width: 98%" maxlength="255"
							value="${bean.map.rowremark}"/>
			   		</td>
				   	</tr>
			   	</c:forEach>
			   	<tr id="IDEndRow"></tr>
		   	</tbody>
		</table>
	</div>
	
	<div class="formBar">
		<ul>
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
		</ul>
	</div>
</form>