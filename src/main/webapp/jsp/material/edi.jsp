<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<style>
	/***********重写上传文件按钮样式Begin***********/
	.uploadify-button {
	 	background-color: transparent; 
	 	background-image: -webkit-linear-gradient(bottom, transparent 0%, transparent 100%);
		background-image: -webkit-gradient(
			linear,
			left bottom,
			left top,
			color-stop(0, transparent),
			color-stop(1, transparent)
		);
	 	border: 0 solid #808080;
	}
	.uploadify:hover .uploadify-button {
	 	background-color: transparent; 
	 	background-image: -webkit-linear-gradient(top, transparent 0%, transparent 100%);
		background-image: -webkit-gradient(
			linear,
			left bottom,
			left top,
			color-stop(0, transparent),
			color-stop(1, transparent)
		);
	}
	/***********重写上传文件按钮样式End***********/
</style>

<script type="text/javascript">
	// 重写上传成功
	function uploadifySuccess(file, data, response) {
		if(response == true) {
			$.pdialog.reload("<%=path%>/material/edi/${form.map.materialid}", {data:{}, dialogId:"material_edi", callback:null});
		} else {
			
		}
	}
</script>

<div class="pageContent">
	<form id="downloadForm" method="post"></form>
	<form method="post" action="<%=path%>/material/edi" class="required-validate pageForm"
	 onsubmit="return validateCallback(this, dialogAjaxDone);">
		<input type="hidden" name="map[materialid]" value="${form.map.materialid}"/>
		<input type="hidden" name="curTime" value="${curTime}"/>
		<div class="pageFormContent" layoutH="54">
			<dl>
				<dt>物资编码：</dt>
				<dd>
					<input type="text" name="map[materialno]" class="required" size="25" maxlength="17"
						value="${form.map.materialno}" readonly="readonly"/>
				</dd>
			</dl>
			<dl>
				<dt>物资名称：</dt>
				<dd>
					<input type="text" name="map[materialname]" class="required" size="25" maxlength="32"
						value="${form.map.materialname}"/>
				</dd>
			</dl>
			<dl>
				<dt>物资类型：</dt>
				<dd>
					<input type="hidden" name="map[materialtype]" value="${form.map.materialtype}"/>
					<input type="text" name="map[materialtypename]" size="25" value="${form.map.materialtypename}"
						 readonly="readonly"/>
				</dd>
			</dl>
			<dl>
				<dt>计量单位：</dt>
				<dd>
					<st:select dictType="计量单位" name="map[unit]" value="${form.map.unit}"
						expStr="style='width: 184px;' class='required number'" />
				</dd>
			</dl>
			<dl>
				<dt>单价：</dt>
				<dd>
					<input type="text" name="map[price]" class="required number" size="25" maxlength="12"
						value="${form.map.price}"/>
				</dd>
			</dl>
			<dl>
				<dt>供应商：</dt>
				<dd>
					<input type="hidden" name="map[manuid]" value="${form.map.manuid}"/>
					<input type="text" name="map[manuname]" value="${form.map.manuname}"
						size="25" suggestFields="manuid,manuname" readonly="readonly"/>
					<a class="btnLook" href="<%=path%>/manu/list?act=backselect&map[manutypeid]=1" lookupGroup="manuLookup"
						width="1000" height="500">查找带回</a>
					<a href="javascript:void(0);" class="btnClear" suggestFields="manuid,manuname"></a>
				</dd>
			</dl>
			<dl>
				<dt>启用库存：</dt>
				<dd>
					<st:select dictType="是否" name="map[usestock]" value="${form.map.usestock}" expStr="style='width: 184px;'" />
				</dd>
			</dl>
			<dl>
				<dt>库存量：</dt>
				<dd>
					<input type="text" name="map[stock]" class="required number" size="25" maxlength="12"
						value="${form.map.stock}"/>
				</dd>
			</dl>
			<dl>
				<dt>报警量：</dt>
				<dd>
					<input type="text" name="map[alarmnum]" class="required number" size="25" maxlength="12"
						value="${form.map.alarmnum}"/>
				</dd>
			</dl>
			<dl>
				<dt>新增时间：</dt>
				<dd>
					<input type="text" name="map[createdate]" size="25" maxlength="19"
						value="${form.map.createdate}" readonly="readonly"/>
				</dd>
			</dl>
			<dl>
				<dt>排序：</dt>
				<dd>
					<input type="text" name="map[materialsort]" class="digits" size="25" maxlength="99"
						value="${form.map.materialsort}"/>
				</dd>
			</dl>
			<dl>
				<dt></dt>
				<dd></dd>
			</dl>
			<dl>
				<dt>备注：</dt>
				<dd>
					<textarea name="map[remark]" cols="90" rows="5" maxlength="256">${form.map.remark}</textarea>
				</dd>
			</dl>
			
			<div class="divider" style="padding-top: 70px;"></div>
			
			<%@ include file="/jsp/pub/fileList.jsp"%>
		</div>
		
		<div class="formBar">
			<ul>
				<li>
					<div class="button">
						<input id="fileInput" type="file" name="image" 
							uploaderOption="{
								height: 20,
								width: 40,
								swf:'<%=path%>/js/uploadify/scripts/uploadify.swf',
								uploader:'<%=path%>/file/uploadFile',
								formData:{pid:${form.map.materialid}, btype: 'material'},
								buttonText:'上传',
								fileSizeLimit:'10240KB',
								auto:true,
								multi:false,
								onUploadSuccess:uploadifySuccess,
								onQueueComplete:uploadifyQueueComplete
							}"
						/>
					</div>
				</li>
				<li><div class="button"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>