<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="expires" content="0">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="pragma" content="no-cache"> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/eis/inc/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="/eis/inc/bootstrap/css/bootstrap-theme.css" />
<link rel="stylesheet" href="/eis/inc/css/advance.css" />
<link href="/eis/inc/bootstrap/css/docs.min.css" rel="stylesheet"/>
<script src="/eis/inc/js/jquery.js"></script>
<script src="/eis/inc/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript">
window.history.forward(1);

<c:if test="${!empty QuestMap.reply}">
window.parent.$.unblockUI();</c:if>
</script>
</head>
<body style="padding:20px;">
<form action="QuestONE" method="post" class="form-horizontal">
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">
<!-- >button type="button" class="close" onClick="window.parent.$.unblockUI()">&times;</button-->
<h4>${QUESTitle}${QuestMap.reply}</h4> 
<p>${QUESTNote}</p>
</div>






<table class="table">
	<c:forEach items="${QUESTInfo}" var="q">
	<tr>
		<td nowrap >
		${q.value}
		<input type="hidden" name="ans" id="q${q.Oid}"/>
		</td>
		<td width="100%">
		<c:forEach items="${q.options}" var="o" varStatus="i">
		<label class="radio-inline"><input onClick="$('#q${q.Oid}').val(this.value)" type="radio" name="opt${q.Oid}" id="opt${q.Oid}" value="${i.index+1}">${o.value}</label>
		</c:forEach>
		</td>
	</tr>
	</c:forEach>
</table>

	
<button class="btn btn-danger" name="method:save" type="submit">送出問卷</button>


<!-- button onClick="window.parent.$.unblockUI()">關閉</button-->
</form>
</body>
</html>