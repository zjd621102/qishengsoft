<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<script type="text/javascript">
﻿﻿$(function () {
    var categories = [${requestScope.titleStr}];
	$(document).ready(function () {
	    $('#reportMaterial_div').highcharts({
	        chart: {
	            type: 'bar'
	        },
	        title: {
	            text: '综合物资报表'
	        },
	        subtitle: {
	            text: '${form.map.dateFrom} 至 ${form.map.dateTo}'
	        },
	        xAxis: [{
	            categories: categories,
	            reversed: false,
	            labels: {
	                step: 1
	            }
	        }, { // mirror axis on right side
	            opposite: true,
	            reversed: false,
	            categories: categories,
	            linkedTo: 0,
	            labels: {
	                step: 1
	            }
	        }],
	        yAxis: {
	            title: {
	                text: null
	            },
	            labels: {
	                formatter: function () {
	                    return this.value;
	                }
	            },
	            min: 0
// 	            ,max: 40000
	        },
	
	        plotOptions: {
	            series: {
	                stacking: 'normal'
	            }
	        },
	
	        tooltip: {
	            formatter: function () {
	            	return '<b>'+ this.point.category + '</b>：'+ Highcharts.numberFormat(Math.abs(this.point.y), 0);
	            }
	        },
	
	        series: [ {
	            name: '物资',
	            data: [${requestScope.dataStr}]
	        }]
	    });
	});
});
</script>
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);"
		action="<%=path%>/report/reportMaterial" method="post"
		rel="material_report" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						日期从：
						<input type="text" class="date" readonly="readonly" name="map[dateFrom]"
						 value="${form.map.dateFrom}" style="width: 70px;" />
					</td>
					<td>
						至：
						<input type="text" class="date" readonly="readonly" name="map[dateTo]"
						 value="${form.map.dateTo}" style="width: 70px;" />
					</td>
					<td>
						供应商：
						<input type="text" name="map[manuname]" value="${form.map.manuname}" style="width: 100px;" />开始
					</td>
					<td>
						排序：
						<select name="map[sort]" style="width: 70px;">
							<option value="ASC" ${form.map.sort=="ASC"?"selected":""}>升序</option>
							<option value="DESC" ${form.map.sort=="DESC"?"selected":""}>降序</option>
						</select>
					</td>
					<td>
						数量从：
						<input type="text" name="map[limitFrom]" value="${form.map.limitFrom}"
						 style="width: 70px;" />开始
					</td>
					<td>
						获取数量：
						<input type="text" name="map[limitNum]" value="${form.map.limitNum}"
						 style="width: 70px;" />
					</td>
				</tr>
			</table>
			<div class="subBar">
				<ul>
					<li>
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="submit">查询</button>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</form>
</div>
<div class="pageContent">
	<div id="reportMaterial_div"></div>
</div>