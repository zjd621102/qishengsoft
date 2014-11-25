<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<script type="text/javascript">
	$(function() {
		setTimeout(function() {
			changeValue();
		}, 100);
	});

	/**
	 * 重写提交之前操作
	 * @returns {Boolean}
	 */
	function doBeforeSubmit() {
		changeValue();
		return true;
	}
	 
	/**
	 * 修改值
	 */
	function changeValue() {
		setMultiply('materialprice', 'materialnum', 'materialsum');
		setAllSum('materialsum', 'costprice');
		setReduction('realprice', 'costprice', 'profit');
	}
	
	// 上传成功
	function uploadifySuccess(file, data, response) {
		if(response == true) {
			$.pdialog.reload("<%=path%>/product/edi/${form.map.productid}", {data:{}, dialogId:"product_edi", callback:null});
		} else {
			
		}
	}
	
	// 上传完成
	function uploadifyQueueComplete(file) {
		
	}
	
	// 删除文件
	function deleteFile(fileid) {
		$.get(
			"<%=path%>/file/deleteFile/" + fileid,
			function(data) {
				if(data == "true") {
					$.pdialog.reload("<%=path%>/product/edi/${form.map.productid}", {data:{}, dialogId:"product_edi", callback:null});
				} else {
					
				}
			}
		);
	}
	
	// 下载文件
	function downloadFile(fileid) {
		var _url = "<%=path%>/file/downloadFile/" + fileid;
		$("#downloadForm").attr("action", _url);
		$("#downloadForm")[0].submit();
	}
</script>

<form id="downloadForm" method="post"></form>
<form method="post" action="<%=path%>/product/edi" class="required-validate pageForm"
 onsubmit="return checkFormSubmit() && validateCallback(this, dialogAjaxDone);">
	<input type="hidden" name="map[productid]" value="${form.map.productid}"/>
	<div class="pageFormContent" layoutH="52">
		<dl>
			<dt>产品编码：</dt>
			<dd>
				<input type="text" name="map[productno]" class="required" size="25" maxlength="17"
					value="${form.map.productno}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>产品名称：</dt>
			<dd>
				<input type="text" name="map[productname]" class="required" size="25" maxlength="32"
					value="${form.map.productname}"/>
			</dd>
		</dl>
		<dl>
			<dt>产品类型：</dt>
			<dd>
				<input type="hidden" name="map[producttype]" value="${form.map.producttype}"/>
				<input type="text" name="map[producttypename]" size="25" value="${form.map.producttypename}"
					 readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>计量单位：</dt>
			<dd>
				<st:select dictType="计量单位" name="map[unit]" value="${form.map.unit}" expStr="style='width: 184px;' class='required'" />
			</dd>
		</dl>
		<dl>
			<dt>成本单价：</dt>
			<dd>
				<input type="text" name="map[costprice]" class="required number" size="25" maxlength="12"
					value="${form.map.costprice}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>利润：</dt>
			<dd>
				<input type="text" name="map[profit]" class="required number" size="25" maxlength="12"
					value="${form.map.profit}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>产品单价：</dt>
			<dd>
				<input type="text" name="map[realprice]" class="required number" size="25" maxlength="12"
					value="${form.map.realprice}" onchange="changeValue();"/>
			</dd>
		</dl>
		<dl>
			<dt>新增时间：</dt>
			<dd>
				<input type="text" name="map[createdate]" class="required" size="25" maxlength="19"
					value="${form.map.createdate}" readonly="readonly"/>
			</dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" size="88" maxlength="256"
					value="${form.map.remark}"/>
			</dd>
		</dl>
		<dl>
			<dt></dt>
			<dd></dd>
		</dl>
		<dl>
			<dt>
				<input id="testFileInput" type="file" name="image" 
					uploaderOption="{
						height: 20,
						width: 50,
						swf:'<%=path%>/js/uploadify/scripts/uploadify.swf',
						uploader:'<%=path%>/file/uploadFile',
						formData:{pid:${form.map.productid}, btype: 'product'},
						buttonText:'上传',
						fileSizeLimit:'10240KB',
						auto:true,
						multi:false,
						onUploadSuccess:uploadifySuccess,
						onQueueComplete:uploadifyQueueComplete
					}"
				/>
			</dt>
			<dd>

			</dd>
		</dl>
		<table class="table" style="width: 100%;">
			<c:forEach items="${fileList}" var="file" varStatus="status">
			<tr>
				<td>
					<a onclick="downloadFile('${file.map.fileid}')" style="color: #F57800; cursor: pointer;">【${file.map.filename}】</a>
					<a onclick="deleteFile('${file.map.fileid}')" style="color: #F57800; cursor: pointer;">【删除】</a>
				</td>
			</tr>
			</c:forEach>
		</table>
		
		<div class="divider"></div>
		
		<h1 class="margin10px">产品清单（成本单价=人力成本+其他成本+配件成本）</h1>

		<table class="table" style="width: 100%;">
			<thead>
				<tr>
					<th width="5%">
						<a href="#" class="btnAdd addRow"></a>
					</th>
					<th width="5%">序号</th>
					<th width="20%">物资编码</th>
					<th width="20%">物资名称</th>
					<th width="10%">物资单价</th>
					<th width="10%">物资数量</th>
					<th width="10%">物资总价</th>
					<th width="20%">备注</th>
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
					<td></td>
					<td></td>
				</tr>
			   	<tr id="IDCopyRow" style="display:none">
					<td>
						<input type="hidden" name="map[productrowid]"/>
						<a href="#" class="btnDel delRow" onclick="changeValue();"></a>
					</td>
			   		<td></td>
			   		<td>
			   			<input type="hidden" name="map[materialid]"/>
						<input type="text" name="map[materialno]" style="width: 75%" maxlength="13"
							suggestFields="materialid,materialno,materialname,materialprice"
							readonly="readonly"/>
						<a class="btnLook" href="<%=path%>/material/tree" lookupGroup="lookup" width="1200"></a>
						<a href="javascript:void(0);" class="btnClear" suggestFields="materialid,materialno,materialname,materialprice"></a>
			   		</td>
			   		<td>
						<input type="text" name="map[materialname]" style="width: 96%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[materialprice]" style="width: 93%" maxlength="12" class="number"
							value="0.00" onblur="changeValue();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[materialnum]" style="width: 93%" maxlength="9" class="number"
							value="1" onblur="changeValue();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[materialsum]" style="width: 92%" maxlength="12" class="number"
							value="0.00" readonly="readonly"/>
			   		</td>
			   		<td>
						<input type="text" name="map[remarkrow]" style="width: 96%" maxlength="256"/>
			   		</td>
			   	</tr>
				<c:forEach items="${productrowList}" var="bean" varStatus="vs">
				   	<tr>
						<td>
							<input type="hidden" name="map[productrowid]" value="${bean.map.productrowid}"/>
							<a href="#" class="btnDel delRow" onclick="changeValue();"></a>
						</td>
				   		<td>${vs.index+1}</td>
				   		<td>
				   			<input type="hidden" name="map[materialid]" value="${bean.map.materialid}"/>
							<input type="text" name="map[materialno]" style="width: 75%" maxlength="13"
								suggestFields="materialid,materialno,materialname,materialprice"
								value="${bean.map.materialno}" readonly="readonly"/>
							<a class="btnLook" href="<%=path%>/material/tree" lookupGroup="lookup" width="1200"></a>
							<a href="javascript:void(0);" class="btnClear"
								suggestFields="materialid,materialno,materialname,materialprice"></a>
				   		</td>
				   		<td>
							<input type="text" name="map[materialname]" style="width: 96%" maxlength="32"
								value="${bean.map.materialname}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[materialprice]" style="width: 93%" maxlength="12"
								class="number" value="${bean.map.materialprice}"
								onblur="changeValue();"/>
				   		</td>
				   		<td>
							<input type="text" name="map[materialnum]" style="width: 93%" maxlength="9"
								class="number" value="${bean.map.materialnum}"
								onblur="changeValue();"/>
				   		</td>
				   		<td>
							<input type="text" name="map[materialsum]" style="width: 92%" maxlength="12"
								class="number" value="${bean.map.materialsum}" readonly="readonly"/>
				   		</td>
				   		<td>
							<input type="text" name="map[remarkrow]" style="width: 96%" maxlength="256"
								value="${bean.map.remarkrow}"/>
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