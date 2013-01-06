<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<html>
	<head>
	<title>网站管理员登陆</title>
	<link href="<%=path%>/images/skin.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		body {
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
			background-color: #1D3647;
		}
		
		table {
			border-collapse: collapse;
		}
		th, td {
			padding: 0;
		}
	</style>
	<script>
		function correctPNG() {
			var arVersion = navigator.appVersion.split("MSIE")
			var version = parseFloat(arVersion[1])
			if ((version >= 5.5) && (document.body.filters)) {
				for ( var j = 0; j < document.images.length; j++) {
					var img = document.images[j]
					var imgName = img.src.toUpperCase()
					if (imgName.substring(imgName.length - 3, imgName.length) == "PNG") {
						var imgID = (img.id) ? "id='" + img.id + "' " : ""
						var imgClass = (img.className) ? "class='" + img.className
								+ "' " : ""
						var imgTitle = (img.title) ? "title='" + img.title + "' "
								: "title='" + img.alt + "' "
						var imgStyle = "display:inline-block;" + img.style.cssText
						if (img.align == "left")
							imgStyle = "float:left;" + imgStyle
						if (img.align == "right")
							imgStyle = "float:right;" + imgStyle
						if (img.parentElement.href)
							imgStyle = "cursor:hand;" + imgStyle
						var strNewHTML = "<span "
								+ imgID
								+ imgClass
								+ imgTitle
								+ " style=\""
								+ "width:"
								+ img.width
								+ "px; height:"
								+ img.height
								+ "px;"
								+ imgStyle
								+ ";"
								+ "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"
								+ "(src=\'" + img.src
								+ "\', sizingMethod='scale');\"></span>"
						img.outerHTML = strNewHTML
						j = j - 1
					}
				}
			}
		}
		window.attachEvent("onload", correctPNG);
	</script>
	</head>
	<body>
		<form action="<%=path%>/login" method="post">
			<table style="width: 100%;height: 166px;border: 0">
				<tr>
					<td height="42" valign="top">
						<table style="width: 100%;height: 42px;border: 0" class="login_top_bg">
							<tr>
								<td width="1%" height="21">&nbsp;</td>
								<td height="42">&nbsp;</td>
								<td width="17%">&nbsp;</td>
							</tr>
						</table></td>
				</tr>
				<tr>
					<td valign="top">
						<table style="width: 100%;height: 532px;border: 0" class="login_bg">
							<tr>
								<td width="49%" align="right">
									<table style="width: 91%;height: 532px;border: 0" class="login_bg2">
										<tr>
											<td height="138" valign="top">
												<table style="width: 89%;height: 427px;border: 0">
													<tr>
														<td height="149">&nbsp;</td>
													</tr>
													<tr>
														<td height="80" align="right" valign="top">
															<img src="<%=path%>/images/logo.png" width="279" height="68">
														</td>
													</tr>
													<tr>
														<td height="198" align="right" valign="top">
															<table style="width: 100%;border: 0">
																<tr>
																	<td width="35%">&nbsp;</td>
																	<td height="25" colspan="2" class="left_txt">
																		<p>1-地区商家信息网门户站建立的首选方案...</p>
																	</td>
																</tr>
																<tr>
																	<td>&nbsp;</td>
																	<td height="25" colspan="2" class="left_txt">
																		<p>2-一站通式的整合方式，方便用户使用...</p>
																	</td>
																</tr>
																<tr>
																	<td>&nbsp;</td>
																	<td height="25" colspan="2" class="left_txt">
																		<p>3-强大的后台系统，管理内容易如反掌...</p>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
								<td width="1%">&nbsp;</td>
								<td width="50%" valign="bottom">
									<table style="width: 100%;height: 59px;border: 0;">
										<tr>
											<td width="4%">&nbsp;</td>
											<td width="96%" height="38">
												<span class="login_txt_bt">登陆信息网后台管理</span>
											</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td height="21">
												<table style="width: 100%;height: 328px;border: 0;" id="table211">
													<tr>
														<td colspan="2" style="height: 164px;">
															<table style="width: 100%;height: 143px;border: 0;" id="table212">
																<tr>
																	<td width="13%" height="38" class="top_hui_text">
																		<span class="login_txt">管理员：&nbsp;&nbsp; </span>
																	</td>
																	<td height="38" colspan="2" class="top_hui_text">
																		<input id="userid" name="map[userid]" type="text" class="editbox4" value="zhoujd" size="20" />
																	</td>
																</tr>
																<tr>
																	<td width="13%" height="35" class="top_hui_text">
																		<span class="login_txt"> 密&nbsp;&nbsp;&nbsp;&nbsp;码： &nbsp;&nbsp; </span>
																	</td>
																	<td height="35" colspan="2" class="top_hui_text">
																		<input class="editbox4" type="password" size="21" id="passwd" name="map[passwd]" value="888888" />
																		<img src="<%=path%>/images/luck.gif" width="19" height="18"></img>
																	</td>
																</tr>
																<!-- 
																<tr>
																	<td width="13%" height="35">
																		<span class="login_txt">验证码：</span>
																	</td>
																	<td height="35" colspan="2" class="top_hui_text">
																		<input class="wenbenkuang" name="verifycode" type="text" value="" maxLength=4 size=10>
																	</td>
																</tr>
																-->
																<tr>
																	<td height="35">&nbsp;</td>
																	<td width="20%" height="35">
																		<input name="Submit" type="submit" class="button" id="Submit" value="登 陆">
																	</td>
																	<td width="67%" class="top_hui_text">
																		<input name="cs" type="button" class="button" id="cs" value="取 消" onClick="showConfirmMsg1()">
																	</td>
																</tr>
															</table>
															<br>
														</td>
													</tr>
													<tr>
														<td width="433" height="164" align="right" valign="bottom">
															<img src="<%=path%>/images/login-wel.gif" width="242" height="138">
														</td>
														<td width="57" align="right" valign="bottom">&nbsp;</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="20">
						<table style="width: 100%;border: 0;" class="login-buttom-bg">
							<tr>
								<td align="center">
									<span class="login-buttom-txt">Copyright&copy;2012-2012 www.yecoo.com</span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>