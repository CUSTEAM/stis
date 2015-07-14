<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>假單列表</title>
<script>
$(document).ready(function() {
	$('#funbtn').popover("show");
	setTimeout(function() {
		$('#funbtn').popover("hide");
	}, 0);
});
	function GoFadeOut(Oid){		
	   $("#del"+Oid).fadeOut('slow', function() {
		   //callback
	   });
	}
	
	function delDilg(Oid){
		$.get("delDilgApp", {Oid:Oid},			
			GoFadeOut(Oid)
		);
	}
	
	function showApp(filename){
        $.blockUI({ 
        	onOverlayClick: $.unblockUI,
            message: "<a href='/eis/getFtpFile?path=DilgImage&file="+filename+"'><img src='/eis/getFtpFile?path=DilgImage&file="+filename+"'/></a>", 
            css: { 
            	top:  '100px',
            } 
        });
	}
</script>
</head>
<body>
<div class="alert">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	<strong>假單列表</strong>&nbsp;
	<div class="btn-group">
		<a class="btn" href="MyDilgDetail">檢視各課程缺課列表</a>
		<a href="MyCalendar" class="btn btn-danger">返回課表</a>
	</div>
</div>

<div class="alert alert-danger">
缺課發生當天後申請及導師已審核假單不可刪除, 預先請假若導師已審核請告知任課老師更改點名記錄為到課即可
<div id="funbtn" rel="popover" title="為什麼當天後不可刪除?" data-content="假單在線上申請時, 當天的點名單上已註明為請假, 假設同學在審核前將假單刪除, 老師無法查覺並重新開啟當日點名單記錄缺課" data-placement="bottom" class="btn">?</div>
</div>

<table id="del${d.Oid}" class="table table-striped table-bordered">
	<td></td>
	<td>假別</td>
	<td>附件</td>
	<td>審核者</td>
	<td>日期節次</td>
	<c:forEach items="${dilgs}" var="d">
	<tr>
		<td width="100">
		<input type="button" class="btn btn-danger" <c:if test="${d.over&&result==null}">disabled</c:if> onClick="delDilg(${d.Oid})"  value="刪除" />
		</td>
		<td width="100">
		<select name="abs" disabled>
   			<option <c:if test="${d.abs eq '1'}">selected</c:if> value="1">重大傷病住院</option>
   			<option <c:if test="${d.abs eq '3'}">selected</c:if> value="3" selected>病假</option>
   			<option <c:if test="${d.abs eq '4'}">selected</c:if> value="4">事假</option>
   			<option <c:if test="${d.abs eq '6'}">selected</c:if> value="6">公假</option>
   			<option <c:if test="${d.abs eq '7'}">selected</c:if> value="7">喪假</option>
   			<option <c:if test="${d.abs eq '8'}">selected</c:if> value="8">婚假</option>
   			<option <c:if test="${d.abs eq '9'}">selected</c:if> value="9">產假</option>
   		</select>
		</td>
		<td nowrap>
		<c:if test="${!empty d.file}">		
		<button class="btn btn-info" onClick="showApp('${d.file}')">附件</button>
		</c:if>
		</td>
		<td width="100" nowrap>		
		<c:if test="${d.result ==null}"><span class="label label-warning">審核中:${d.cname}</span></c:if>
		<c:if test="${d.result eq '1'}"><span class="label label-success">核准:${d.cname}</span></c:if>		
		<c:if test="${d.result eq '2'}"><span class="label label-important">不核准:${d.cname}</span></c:if>
		</td>
		<td width="100%">
		<c:forEach items="${d.ds}" var="s">
		<span class="label label-info">${s.date} 第${s.cls}節</span>
		</c:forEach>
		</td>
	</tr>
	<c:if test="${d.reply!=''}">
	<tr>
		<td colspan="5">${d.reply}</td>
	</tr>
	</c:if>
	</c:forEach>
</table>
</body>
</html>