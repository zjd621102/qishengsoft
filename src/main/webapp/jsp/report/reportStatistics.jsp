<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ include file="/jsp/pub/include.jsp"%>
<script type="text/javascript">
	$(function() {
		// Set up the chart
		var chart = new Highcharts.Chart({
			chart : {
				renderTo : 'reportStatistics_div',
				type : 'column',
				margin : 75,
				options3d : {
					enabled : true,
					alpha : 5,
					beta : 5,
					depth : 50,
					viewDistance : 25
				}
			},
			title : {
				text : '综合统计报表'
			},
			xAxis : {
				categories : [${requestScope.types}],
				labels : {
					rotation : -45,
					align : 'right',
					style : {
						fontSize : '13px',
						fontFamily : 'Verdana, sans-serif'
					}
				}
			},
			yAxis : {
				min : 0,
				title : {
					text : '元'
				}
			},
			subtitle : {
				text : ''
			},
			plotOptions : {
				column : {
					depth : 25
				}
			},
			tooltip : {
				pointFormat : '<b>{point.y:.1f}</b>',
			},
			series : [ {
				name: ' ',
				data : [${requestScope.dataStr}],
				dataLabels : {
					enabled : true,
// 					rotation : -90,
	                color: 'blue',
// 					align : 'right',
					x : 4,
					y : 10,
					style : {
						fontSize : '13px',
						fontFamily : 'Verdana, sans-serif',
						textShadow : '0 0 0px black'
					}
				}
			} ]
		});

		// Activate the sliders
		$('#R0').on('change', function() {
			chart.options.chart.options3d.alpha = this.value;
			showValues();
			chart.redraw(false);
		});
		$('#R1').on('change', function() {
			chart.options.chart.options3d.beta = this.value;
			showValues();
			chart.redraw(false);
		});

		function showValues() {
			$('#R0-value').html(chart.options.chart.options3d.alpha);
			$('#R1-value').html(chart.options.chart.options3d.beta);
		}
		showValues();
	});
</script>
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);"
		action="<%=path%>/report/reportStatistics" method="post"
		rel="statistics_report" id="fid">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						日期从：
						<input type="text" class="date" readonly="readonly" name="map[dateFrom]"
						 value="${form.map.dateFrom}" style="width: 100px;" />
						至：
						<input type="text" class="date" readonly="readonly" name="map[dateTo]"
						 value="${form.map.dateTo}" style="width: 100px;" />
						材料类型：
						<st:select dictType="产品材料类型" name="map[materialtype]" value="${form.map.materialtype}"
						 expStr="style='width: 100px;'" />
						产品类型：
						<st:select dictType="产品类型" name="map[producttype]" value="${form.map.producttype}"
						 expStr="style='width: 100px;'" />
						客户名称
						<input type="text" maxlength="8" name="map[manuName]"
						 value="${form.map.manuName}" style="width: 100px;" />
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
	<div id="reportStatistics_div"></div>
</div>