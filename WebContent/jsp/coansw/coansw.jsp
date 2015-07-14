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
<script src="/eis/inc/js/jquery.js"></script>
<link rel="stylesheet" href="/eis/inc/css/bootstrap.css" />
<title>Insert title here</title>
<script type="text/javascript">
window.history.forward(1);
function chcr(id, que){	
	$("#btn"+id+"1").attr('class', 'btn btn-small');
	$("#btn"+id+"2").attr('class', 'btn btn-small');
	$("#btn"+id+"3").attr('class', 'btn btn-small');
	$("#btn"+id+"4").attr('class', 'btn btn-small');
	$("#btn"+id+"5").attr('class', 'btn btn-small');
	$("#q"+id).val(que);	
}
<c:if test="${empty cs}">
window.parent.$.unblockUI();
</c:if>
</script>
</head>
<body style="padding:20px;">
<form action="Coansw" method="post" class="form-horizontal">
<div class="alert">
<!-- >button type="button" class="close" onClick="window.parent.$.unblockUI()">&times;</button-->
<strong>教學評量${(pec.total-pec.edited+1)}/${pec.total}</strong> 
</div>
<c:if test="${!empty msg}"><div class="alert alert-danger">${msg}</div></c:if>
<input type="hidden" name="DtimeOid" value="${cs.Oid}"/>
<input type="hidden" name="SeldOid" value="${cs.SeldOid}"/>
<div class="progress progress-striped active">
<div class="bar" style="width: ${((pec.total-pec.edited+1)/pec.total)*100}%;"></div>
</div>
<table class="table">
	<tr>
		<td colspan="2"><h3>${cs.chi_name}, ${cs.cname}老師</h3></td>
	</tr>
	<c:forEach items="${cs.question}" var="q">
	<tr>
		<td nowrap >
		${q.question}
		<input type="hidden" name="ans" id="q${q.Oid}"/>
		<input type="hidden" name="bug" value="${q.debug}"/>
		<input type="hidden" name="Oid" value="${q.Oid}"/>
		</td>
		<td width="100%">
		<div class="btn-group" style="width:150px; float:left;">
		    <button type="button" id="btn${q.Oid}1" onClick="chcr(${q.Oid},1), $(this).addClass('btn-inverse');" class="btn btn-small">完全不認同</button>
		    <button type="button" id="btn${q.Oid}2" onClick="chcr(${q.Oid},2), $(this).addClass('btn-danger');" class="btn btn-small">有點不認同</button>
		    <button type="button" id="btn${q.Oid}3" onClick="chcr(${q.Oid},3), $(this).addClass('btn-warning');" class="btn btn-small">認同</button>
		    <button type="button" id="btn${q.Oid}4" onClick="chcr(${q.Oid},4), $(this).addClass('btn-info');" class="btn btn-small">有點認同</button>
		    <button type="button" id="btn${q.Oid}5" onClick="chcr(${q.Oid},5), $(this).addClass('btn-success');" class="btn btn-small">非常認同</button>
		</div>
		</td>
	</tr>
	</c:forEach>
</table>
<div class="btn-group">
	<a href="javascript:window.location.reload()" class="btn">重新填寫</a>
	<button class="btn btn-danger" name="method:save" type="submit">確認填寫</button>
</div>

<!-- button onClick="window.parent.$.unblockUI()">關閉</button-->
</form>
</body>
</html>