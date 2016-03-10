<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>

<script type="text/javascript">

	$().ready(function() {
		setTimeout(function() {
			setAllSum_work();
		}, 100);
	});

	// 修改操作方式
	function changeAction(act) {
		if(act=="save") {// 保存
			$('#staff_work_form').attr("action","<%=path%>/staff/edi_work");
		 	$('#staff_work_form').attr("onsubmit","return validateCallback(this, dialogAjaxDone);");
		} else {// 查询
		 	$('#staff_work_form').attr("action","<%=path%>/staff/edi_work/${form.map.staffid}");
			$('#staff_work_form').attr("onsubmit", "return dwzSearch(this, 'dialog');");
		}
	}
	
	// 批量设置
	function allSet() {
		$("[name='map[workstatus]']").val("1");
		
// 		batchSet('salary', 'map[salary]');
		$("[name='map[salary]'][value='']").val($("#salary").val());
		
		$("[name='map[othersalary]'][value='']").val("0");
		setAllSum_work();
	}
	
	// 清空
	function clearClick(obj) {
		var tr = $(obj).parent().parent().parent();
		$(tr).find("[name='map[workstatus]']").val("");// 考勤状态
		$(tr).find("[name='map[salary]']").val("0");// 工资
		setAllSum_work();
	}
	
	/**
	 * 计算工资
	 */
	function setAllSum_work() {
		var allsum = 0.00;
		
		$("input[name*='map[salary]']").each(function(){
			allsum += $(this).val()*1;
		});
		$("input[name*='map[othersalary]']").each(function(){
			allsum += $(this).val()*1;
		});
		
		allsum = Math.round(allsum * 100) / 100;
		$("input[name*='map[allsalary]']").val(allsum);
		
		return allsum;
	}
</script>

<form method="post" action="<%=path%>/staff/edi_work/${form.map.staffid}" class="required-validate pageForm"
 onsubmit="return validateCallback(this, dialogAjaxDone);" id="staff_work_form">
	<input type="hidden" name="map[workid]" value="${form.map.workid}"/>
	<input type="hidden" name="map[staffid]" value="${form.map.staffid}"/>

	<h1 class="margin10px"></h1>
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					员工名称：
					<input type="text" name="map[staffname]" value="${form.map.staffname}" size="12" readonly="readonly"/>
				</td>
				<td>
					月份：
					<input type="text" name="map[workmonth]" class="required date" dateFmt="yyyy-MM" size="12"
						value="${form.map.workmonth}" readonly="readonly" />
				</td>
				<td>
					工资：
					<input type="text" id="salary" size="12" value="${form.map.salary}"/>
				</td>
			</tr>
		</table>
		<div class="subBar">
			<ul>
				<li>
					<div class="buttonActive">
						<div class="buttonContent">
							<button type="submit" onclick="changeAction('search')">查询</button>
						</div>
					</div>
				</li>
				<li>
					<div class="buttonActive">
						<div class="buttonContent">
							<button type="submit" onclick="changeAction('save')">保存</button>
						</div>
					</div>
				</li>
				<li>
					<div class="buttonActive">
						<div class="buttonContent">
							<button type="button" onclick="allSet()">
								批量设置</button>
						</div>
					</div>
				</li>
				<li>
					<div class="buttonActive">
						<div class="buttonContent">
							<button type="button" class="close">关闭</button>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
	
	<h1 class="margin10px">考勤清单</h1>

	<table class="table" style="width: 100%;" layoutH="138">
		<thead>
			<tr>
				<th width="30px">序号</th>
				<th width="40px">操作</th>
				<th width="80px">考勤日期</th>
				<!-- 
				<th width="60px">上班时间</th>
				<th width="60px">下班时间</th>
				<th width="80px">考勤状态</th>
				 -->
				<th width="60px">工资</th>
				<th width="60px">其他工资</th>
				<th>备注</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td></td>
				<td></td>
				<!-- 
				<td></td>
				<td></td>
				<td></td>
				 -->
				<td style="font-size: 13px; font-weight: bold; color: red;">
					合计：
				</td>
				<td>
					<input type="text" name="map[allsalary]" style="width: 47px" class="number"
						value="" readonly="readonly"/>
				</td>
				<td></td>
				<td></td>
			</tr>
			<c:forEach items="${workrowList}" var="bean" varStatus="vs">
			   	<tr>
			   		<td>${vs.index+1}</td>
			   		<td align="center">
			   			<a href="javascript:void(0);" class="btnClear" onclick="clearClick(this);"></a>
			   		</td>
			   		<td>
						<input type="hidden" name="map[workrowid]" value="${bean.map.workrowid}"/>
						<input type="text" name="map[workdate]" style="width: 65px" maxlength="10"
							value="${bean.map.workdate}"/>
			   		</td>
			   		<%-- 
			   		<td>
						<input type="text" name="map[starttime]" class="date" dateFmt="HH:mm" style="width: 48px"
							value="${bean.map.starttime}" readonly="readonly"/>
			   		</td>
			   		<td>
						<input type="text" name="map[endtime]" class="date" dateFmt="HH:mm" style="width: 46px"
							value="${bean.map.endtime}" readonly="readonly"/>
			   		</td>
			   		<td>
			   			<st:select dictType="考勤状态" name="map[workstatus]" value="${bean.map.workstatus}"
			   			 expStr="style='width: 71px;'" />
			   		</td>
			   		 --%>
			   		<td>
						<input type="text" name="map[salary]" style="width: 47px" maxlength="12"
							class="number" value="${bean.map.salary}"
							onchange="setAllSum_work();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[othersalary]" style="width: 47px" maxlength="12"
							class="number" value="${bean.map.othersalary}"
							onchange="setAllSum_work();"/>
			   		</td>
			   		<td>
						<input type="text" name="map[remark]" style="width: 380px" maxlength="256"
							value="${bean.map.remark}"/>
			   		</td>
			   	</tr>
		   	</c:forEach>
	   	</tbody>
	</table>
</form>