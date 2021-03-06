<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<script type="text/javascript">
	// 修改排序的值
	function addRowOther() {
		$("[name='map[sordid]']:last").val($("#dictRowTbody tr").size()-3);
	}
</script>

<form method="post" action="<%=path%>/dict/edi" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);" style="margin-top: -10px;">
	<input type="hidden" name="map[dictid]" value="${form.map.dictid}" />
	<div class="pageFormContent" layoutH="42">
		<dl>
			<dt>字典类型：</dt>
			<dd>
				<input type="text" name="map[dicttype]" class="required" size="20" maxlength="32" value="${form.map.dicttype}"/>
			</dd>
		</dl>
		<dl>
			<dt>创建时间：</dt>
			<dd>
				<input type="text" name="map[createtime]" size="20" maxlength="19" readonly="readonly" value="${form.map.createtime}"/>
			</dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" size="20" maxlength="256" value="${form.map.remark}" />
			</dd>
		</dl>
		
		<div class="divider"></div>

		<table class="table" style="width: 100%;">
			<thead>
				<tr>
					<th width="30px">
						<a href="#" class="btnAdd addRow"></a>
					</th>
					<th width="30px">序号</th>
					<th width="120px">字典名称</th>
					<th width="60px">字典值</th>
					<th width="50px">排序</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody id="dictRowTbody">
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
						<input type="text" name="map[dictname]" class="required" style="width: 104px" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[dictvalue]" class="required" style="width: 48px" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[sordid]" class="required" style="width: 38px" value="1" maxlength="3" class="digits"/>
			   		</td>
			   		<td>
						<input type="text" name="map[rowremark]" style="width: 445px" maxlength="255"/>
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
							<input type="text" name="map[dictname]" class="required" maxlength="32" style="width: 104px"
								value="${bean.map.dictname}"/>
				   		</td>
			   		<td>
						<input type="text" name="map[dictvalue]" class="required" style="width: 48px" maxlength="32"
							value="${bean.map.dictvalue}"/>
			   		</td>
			   		<td>
						<input type="text" name="map[sordid]" class="required" style="width: 38px" maxlength="3" class="digits"
							value="${bean.map.sordid}"/>
			   		</td>
			   		<td>
						<input type="text" name="map[rowremark]" style="width: 445px" maxlength="255"
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