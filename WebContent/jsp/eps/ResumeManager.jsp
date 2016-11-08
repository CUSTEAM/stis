<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>建立個人履歷表</title>
<link href="/eis/inc/css/jquery-ui.css" rel="stylesheet"/>
<link href="/eis/inc/css/wizard-step.css" rel="stylesheet"/>
<link href="/eis/inc/bootstrap/plugin/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet">

<script src="/eis/inc/js/plugin/bootstrap-typeahead.js"></script>
<script src="/eis/inc/bootstrap/plugin/bootstrap-fileinput/js/fileinput.min.js"></script>
<script src="/eis/inc/bootstrap/plugin/bootstrap-fileinput/js/fileinput_locale_zh-TW.js"></script>

  
</head>
<body>
<div class="bs-callout bs-callout-warning" id="callout-helper-pull-navbar">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	<strong>建立個人履歷表</strong>
</div>
<div class="wizard-steps">
	<div><a href="#"><span>1</span> 下載格式</a></div>
	<div><a href="#"><span>2</span> 依格式編輯資料</a></div>
	<div><a href="#"><span>3</span> 上傳</a></div>
</div><br><br>
<form action="ResumeManager" method="post" enctype="multipart/form-data">







<c:if test="${!empty myRes}">
<div class="panel panel-primary">
	<div class="panel-heading">檢視履歷表</div>
	<table class="table">
		<tr>
			<td>
			<a class="btn btn-link btn-lg btn-block" href="/eis/getFtpFile?path=resume&file=${myRes}"><span class="glyphicon glyphicon-cloud-download" aria-hidden="true"></span> 下載我的履歷表</a>
			</td>
		</tr>
	</table>
</div>


</c:if>

  	
<div class="panel panel-primary">
	<c:if test="${empty myRes}"><div class="panel-heading">建立履歷表</div></c:if>
	<c:if test="${!empty myRes}"><div class="panel-heading">更新履歷表</div></c:if>
	<table class="table">
		<tr>
			<td>
			<a class="btn btn-link btn-lg btn-block" href="http://192.192.230.167/CIS/resume.doc"><span class="glyphicon glyphicon-cloud-download" aria-hidden="true"></span> 下載格式</a>	<br>			    
			<input name="file" type="file" data-show-upload="false"
			id="upload" class="file file-loading "/><br>
			<script>
			$("#upload").fileinput({
				multiple: false,
				
			    language: "zh-TW",
			    uploadUrl: "",
			    allowedFileExtensions: ["doc", "docx"]
			});
			</script>				
			<button class="btn btn-primary btn-lg btn-block" id="saveTxtFile" name="method:save" type="submit"><span class="glyphicon glyphicon-cloud-upload" aria-hidden="true"></span>上傳</button> 
			</td>
		</tr>
	</table>
</div>








</form>

</body>
</html>