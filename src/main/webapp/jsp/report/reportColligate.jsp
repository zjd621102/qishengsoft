<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<script type="text/javascript">
$(function () {
    $('#reportColligate_div').highcharts({
        chart: {
            type: 'line'
        },
        title: {
            text: '月度综合报表'
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
            },
            min: 0
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
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/report/reportColligate" method="post" rel="colligate_report" id="fid">
		<div class="searchBar">
			<table class="searchContent" style="width: 80%">
				<tr>
					<td>
						日期从
						<input type="text" class="date" readonly="readonly" name="map[dateFrom]"
						 value="${form.map.dateFrom}" style="width: 100px;" />
						&nbsp;&nbsp;至&nbsp;&nbsp;
						<input type="text" class="date" readonly="readonly" name="map[dateTo]"
						 value="${form.map.dateTo}" style="width: 100px;" />
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
	<div id="reportColligate_div"></div>
</div>