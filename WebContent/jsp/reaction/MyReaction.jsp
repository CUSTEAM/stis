<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>語言中心考試報名</title>
<link href="/eis/inc/css/wizard-step.css" rel="stylesheet"/>
<script>  
$(document).ready(function() {		
	$('#funbtn').popover("show");
	setTimeout(function() {
		$('#funbtn').popover("hide");
	}, 3000);
});
</script>  
</head>
<body>
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">
    <h4>意見反應</h4>
    <p> <a href="MyCalendar"class="btn btn-danger btn-xs">返回本學期課表</a></p>
</div>
<form action="ExamReg" method="post" class="form-horizontal">






</form>  

</body>
</html>