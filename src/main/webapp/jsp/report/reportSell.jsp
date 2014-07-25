<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<script type="text/javascript">
$(function () {
    $('#reportSell_div').highcharts({
        chart: {
            type: 'line'
        },
        title: {
            text: '月度客户报表'
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: [${requestScope.monthStr}]
        },
        yAxis: {
            title: {
                text: '元'
            }
        },
        tooltip: {
            enabled: false,
            formatter: function() {
                return '<b>'+ this.series.name +'</b><br/>'+this.x +': '+ this.y +'元';
            }
        },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: true
                },
                enableMouseTracking: false
            }
        },
        series: [${requestScope.dataArray}]
    });
});
</script>
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/report/reportSell" method="post" rel="sell_report" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						销售日期从：<input type="text" class="date" readonly="readonly" name="map[selldateFrom]" value="${form.map.selldateFrom}" />
					</td>
					<td>
						至：<input type="text" class="date" readonly="readonly" name="map[selldateTo]" value="${form.map.selldateTo}" />
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
	<div id="reportSell_div"></div>
</div>