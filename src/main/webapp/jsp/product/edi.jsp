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
	$(function() {
		autoCom("[name='map[materialno]']:visible");
		
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
	
	// 重写上传成功
	function uploadifySuccess(file, data, response) {
		if(response == true) {
			$.pdialog.reload("<%=path%>/product/edi/${form.map.productid}", {data:{}, dialogId:"product_edi", callback:null});
		} else {
			
		}
	}
	
	// 修改排序的值
	function addRowOther() {
		$("[name='map[sort]']:last").val($("#productRowTbody tr").size()-3);
		autoCom("[name='map[materialno]']:visible");
	}
	
	function autoCom(obj) {
		setTimeout(function() {
			$(obj).autocomplete({
				source : function(request, response) {
					$.post(
						"<%=path%>/material/getMaterialsByKeyword",
						{keyword : request.term},
						function(data) {
							response($.map(data, function(item) {
			                    return {
			                        label: item.map.materialno + "　" + item.map.materialname,
			                        value: item.map.materialno,
			                        materialname: item.map.materialname,
			                        materialid: item.map.materialid,
			                        price: item.map.price,
			                        manuname: item.map.manuname
			                    }
			                }));
						},
						"json"
					);
				},
				minLength : 1,
				select : function(event, ui) {
					var row = $(this).parents("tr:first");
					row.find("[name='map[materialname]']").val(ui.item.materialname);
					row.find("[name='map[materialid]']").val(ui.item.materialid);
					row.find("[name='map[materialprice]']").val(ui.item.price);
					row.find("[name='map[manuname]']").val(ui.item.manuname);
				},
				open : function() {
					$(this).removeClass("ui-corner-all").addClass(
							"ui-corner-top");
				},
				close : function() {
					$(this).removeClass("ui-corner-top").addClass(
							"ui-corner-all");
				}
			});
		}, 100);
	}
	
	// 复制产品清单
	function copyDetail() {
		var _copyproductno = $("#copyproductno").val();
		if(_copyproductno != "") {
			$.post(
				"<%=path%>/product/copyDetail",
				{copyproductno: _copyproductno, productid: ${form.map.productid}},
				function(data) {
					if(data == "true") {// 复制成功
						$.pdialog.reload("<%=path%>/product/edi/${form.map.productid}",
								{data:{}, dialogId:"product_edi", callback:null});
					} else {// 复制失败
						
					}
				}
			);
		}			
	}
</script>

<form id="downloadForm" method="post"></form>
<form method="post" action="<%=path%>/product/edi" class="required-validate pageForm"
 onsubmit="return checkFormSubmit() && validateCallback(this, dialogAjaxDone);">
	<input type="hidden" name="map[productid]" value="${form.map.productid}"/>
	<input type="hidden" name="curTime" value="${curTime}"/>
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
			<dt>一盒数量：</dt>
			<dd>
				<input type="text" name="map[numofcase]" class="required digits" size="25" maxlength="999"
					value="${form.map.numofcase}"/>
			</dd>
		</dl>
		<dl>
			<dt>一件数量：</dt>
			<dd>
				<input type="text" name="map[numofonebox]" class="required digits" size="25" maxlength="999"
					value="${form.map.numofonebox}"/>
			</dd>
		</dl>
		<dl>
			<dt>排序：</dt>
			<dd>
				<input type="text" name="map[productsort]" class="digits" size="25" maxlength="99"
					value="${form.map.productsort}"/>
			</dd>
		</dl>
		<dl>
			<dt>买家：</dt>
			<dd>
				<input type="text" name="map[buyers]" size="25" maxlength="128"
					value="${form.map.buyers}"/>
			</dd>
		</dl>
		<dl>
			<dt>打印名：</dt>
			<dd>
				<input type="text" name="map[printname]" size="25" maxlength="32"
					value="${form.map.printname}"/>
			</dd>
		</dl>
		<dl>
			<dt></dt>
			<dd></dd>
		</dl>
		<dl>
			<dt>备注：</dt>
			<dd>
				<input type="text" name="map[remark]" size="88" maxlength="256"
					value="${form.map.remark}"/>
			</dd>
		</dl>
		
		<div class="divider"></div>

		<%@ include file="/jsp/pub/fileList.jsp"%>
		
		<div class="divider"></div>
		
		<table>
			<tr>
				<td>
					<h1 class="margin10px">产品清单</h1>
				</td>
				<td>
					<input type="text" id="copyproductno" style="width: 100px;" />
				</td>
				<td>
					<div class="button" style="margin-left: 5px;">
						<div class="buttonContent">
							<button type="button" onclick="copyDetail();">复制</button>
						</div>
					</div>
				</td>
				<td>
					<div class="button" style="margin-left: 4px;">
						<input id="fileInput" type="file" name="image" 
							uploaderOption="{
								height: 20,
								width: 65,
								swf:'<%=path%>/js/uploadify/scripts/uploadify.swf',
								uploader:'<%=path%>/file/uploadFile',
								formData:{pid:${form.map.productid}, btype: 'product'},
								buttonText:'上传附件',
								fileSizeLimit:'10240KB',
								auto:true,
								multi:false,
								onUploadSuccess:uploadifySuccess,
								onQueueComplete:uploadifyQueueComplete
							}"
						/>
					</div>
				</td>
				<td>
					<div class="button" style="margin-left: 4px;">
						<input id="fileInput2" type="file" name="image" 
							uploaderOption="{
								height: 20,
								width: 65,
								swf:'<%=path%>/js/uploadify/scripts/uploadify.swf',
								uploader:'<%=path%>/file/uploadFile',
								formData:{pid:${form.map.productid}, btype: 'product_cover'},
								buttonText:'上传封面',
								fileSizeLimit:'10240KB',
								auto:true,
								multi:false,
								onUploadSuccess:uploadifySuccess,
								onQueueComplete:uploadifyQueueComplete
							}"
						/>
					</div>
				</td>
				<td>
					<div class="button" style="margin-left: 5px;">
						<div class="buttonContent">
							<button type="button"
							 onclick="window.open('<%=path%>/product/edi/${form.map.productid}?act=print');">打印</button>
						</div>
					</div>
				</td>
			</tr>
		</table>

		<table class="table" style="width: 100%;">
			<thead>
				<tr style="text-align: center;">
					<th width="30px">
						<a href="#" class="btnAdd addRow"></a>
					</th>
					<th width="30px">序号</th>
					<th width="100px">物资编码</th>
					<th width="120px">物资名称</th>
					<th width="70px">物资单价</th>
					<th width="70px">物资数量</th>
					<th width="70px">物资总价</th>
					<th width="120px">供应商</th>
					<th width="50px">排序</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody id="productRowTbody">
				<tr>
					<td></td>
					<td></td>
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
						<input type="text" name="map[materialno]" style="width: 50%" maxlength="13"
							suggestFields="materialid,materialno,materialname,materialprice,manuname" />
						<a class="btnLook" href="<%=path%>/material/tree?act=backselect" lookupGroup="lookup" width="1200"></a>
						<a href="javascript:void(0);" class="btnClear"
						 suggestFields="materialid,materialno,materialname,materialprice,manuname"></a>
			   		</td>
			   		<td>
						<input type="text" name="map[materialname]" style="width: 94%" maxlength="32"/>
			   		</td>
			   		<td>
						<input type="text" name="map[materialprice]" style="width: 90%" maxlength="12" class="number"
							value="0.00" onblur="changeValue();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[materialnum]" style="width: 90%" maxlength="9" class="number"
							value="1" onblur="changeValue();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[materialsum]" style="width: 90%" maxlength="12" class="number"
							value="0.00" readonly="readonly"/>
			   		</td>
			   		<td>
						<input type="text" name="map[manuname]" style="width: 94%" maxlength="256"
							 readonly="readonly" class="readonly" />
			   		</td>
			   		<td>
						<input type="text" name="map[sort]" style="width: 84%" maxlength="2" class="number"
							value="9"/>
			   		</td>
			   		<td>
						<input type="text" name="map[remarkrow]" style="width: 98%" maxlength="256"/>
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
							<input type="text" name="map[materialno]" style="width: 50%" maxlength="13"
								suggestFields="materialid,materialno,materialname,materialprice,manuname"
								value="${bean.map.materialno}"/>
							<a class="btnLook" href="<%=path%>/material/tree" lookupGroup="lookup" width="1200"></a>
							<a href="javascript:void(0);" class="btnClear"
								suggestFields="materialid,materialno,materialname,materialprice,manuname"></a>
				   		</td>
				   		<td>
							<input type="text" name="map[materialname]" style="width: 94%" maxlength="32"
								value="${bean.map.materialname}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[materialprice]" style="width: 90%" maxlength="12"
								class="number" value="${bean.map.materialprice}"
								onblur="changeValue();"/>
				   		</td>
				   		<td>
							<input type="text" name="map[materialnum]" style="width: 90%" maxlength="9"
								class="number" value="${bean.map.materialnum}"
								onblur="changeValue();"/>
				   		</td>
				   		<td>
							<input type="text" name="map[materialsum]" style="width: 90%" maxlength="12"
								class="number" value="${bean.map.materialsum}" readonly="readonly"/>
				   		</td>
				   		<td>
							<input type="text" name="map[manuname]" style="width: 94%" maxlength="256"
								value="${bean.map.manuname}" readonly="readonly" class="readonly"/>
				   		</td>
				   		<td>
							<input type="text" name="map[sort]" style="width: 84%" maxlength="2"
								class="number" value="${bean.map.sort}"/>
				   		</td>
				   		<td>
							<input type="text" name="map[remarkrow]" style="width: 98%" maxlength="256"
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
			<li><div class="button"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
		</ul>
	</div>
</form>