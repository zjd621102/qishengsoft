<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>

<c:if test="${not empty fileList}">
<table class="table" style="width: 100%;">
	<thead>
		<tr>
			<th style="font-weight: bold;">
				附件列表
			</th>
		</tr>
	</thead>
	<c:forEach items="${fileList}" var="file" varStatus="status">
	<tr id="tr_file_${file.map.fileid}">
		<td>
			<a onclick="downloadFile('${file.map.fileid}')" style="color: #F57800; cursor: pointer;">【${file.map.filename}】</a>
			<a onclick="deleteFile('${file.map.fileid}')" style="color: #F57800; cursor: pointer;">【删除】</a>
		</td>
	</tr>
	</c:forEach>
</table>
</c:if>