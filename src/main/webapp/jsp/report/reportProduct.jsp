<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<script type="text/javascript">
﻿﻿$(function () {
    $('#reportProduct_div').highcharts({
        chart: {
            type: 'pie',
            options3d: {
                enabled: true,
                alpha: 45,
                beta: 0
            }
        },
        title: {
            text: '综合产品报表'
        },
        tooltip: {
            pointFormat: '<b>{series.name}: {point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                depth: 35,
                dataLabels: {
                    enabled: true,
                    formatter: function() {
                        return '<b>'+ this.point.name +'</b>: '+ this.y +' 元';
                    }
                }
            }
        },
        series: [{
            type: 'pie',
            name: '百分比',
            data: [${requestScope.dataStr}]
        }]
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