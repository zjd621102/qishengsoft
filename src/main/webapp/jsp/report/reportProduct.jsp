<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<script type="text/javascript">
﻿﻿$(function () {
    var categories = [${requestScope.titleStr}];
	$(document).ready(function () {
	    $('#reportProduct_div').highcharts({
	        chart: {
	            type: 'bar'
	        },
	        title: {
	            text: '综合产品报表'
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
	            bar: {
	                dataLabels: {
	                    enabled: true
	                }
	            }
	        },
	
	        tooltip: {
	            formatter: function () {
	            	return '<b>'+ this.point.category + '</b>：'+ Highcharts.numberFormat(Math.abs(this.point.y), 0);
	            }
	        },
	
	        series: [{
	            name: '销售额',
	            data: [${requestScope.dataStr}]
	        }, {
	            name: '利润',
	            data: [${requestScope.dataProfitStr}]
	        }]
	    });
	});
});
</script>
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);"
		action="<%=path%>/report/reportProduct" method="post"
		rel="product_report" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>日期从：<input type="text" class="date" readonly="readonly"
						name="map[dateFrom]" value="${form.map.dateFrom}" />
					</td>
					<td>至：<input type="text" class="date" readonly="readonly"
						name="map[dateTo]" value="${form.map.dateTo}" />
					</td>
					<td>
						排序：
						<select name="map[sort]">
							<option value="ASC" ${form.map.sort=="ASC"?"selected":""}>升序</option>
							<option value="DESC" ${form.map.sort=="DESC"?"selected":""}>降序</option>
						</select>
					</td>
					<td>
						数量从：<input type="text" name="map[limitFrom]" value="${form.map.limitFrom}" />开始
					</td>
					<td>
						获取数量：<input type="text" name="map[limitNum]" value="${form.map.limitNum}" />
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
	<div id="reportProduct_div"></div>
</div>