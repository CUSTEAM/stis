<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
<div class="alert">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <strong>語言中心考試報名</strong> 
    <a href="MyCalendar"class="btn">返回</a>
    <div id="funbtn" rel="popover" title="說明" 
    data-content="點選「報名」報名，報名後點選「取消」取消報名" 
    data-placement="right" class="btn btn-warning">?</div>
    </div>

<form action="ExamReg" method="post" class="form-horizontal">
<input type="hidden" name="Oid" value="${exam.Oid}">
<div class="wizard-steps">
  	<div><a href="#"><span>1</span> 瀏覽考試資訊</a></div>
  	<div><a href="#"><span>2</span> 點選報名場次梯次</a></div>
  	<div><a href="#"><span>3</span> 確認報名資料</a></div>
</div>

<c:if test="${empty exams}">
<table class="table table-hover">
	<thead>
    	<tr class="success">
	        <th nowrap>目前沒有開放報名的考試</th>
	    </tr>
	</thead>
</table>
</c:if>


<c:if test="${!empty exams}">
<input type="hidden" id="level" name="level"/><input type="hidden" id="no" name="no">
<table class="table table-hover">
	<thead>
    	<tr class="success">
	        <th nowrap>場次資訊</th>
	        <th nowrap>梯次</th>
	        <th nowrap>場次</th>
	        <th nowrap>報名期間</th>
	        <th nowrap>考試期間</th>
	        <th nowrap>名額資訊</th>
	        <th nowrap>1年級</th>
	        <th nowrap>2年級</th>
	        <th nowrap>3年級</th>
	        <th nowrap>4年級</th>
	        <th></th>
      	</tr>
    </thead>
    <tbody class="control-group info">    
    <c:set var="now"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" /></c:set>
	<c:forEach items="${exams}" var="e">
		<tr>
	        <td nowrap>${e.note}</td>
	        <td nowrap>${e.level}</td>
	        <td nowrap>${e.no}</td>
	        <c:set var="begin"><fmt:formatDate value="${e.sign_begin}" pattern="yyyy-MM-dd HH:mm:ss" /></c:set>
	        <c:set var="end"><fmt:formatDate value="${e.sign_end}" pattern="yyyy-MM-dd HH:mm:ss" /></c:set>
	        <td nowrap class="text-info"><fmt:formatDate value="${e.sign_begin}" pattern="M月d日  HH:mm"/> 至 <fmt:formatDate value="${e.sign_end}" pattern="M月d日  HH:mm"/></td>	
	        
	        <td nowrap class="text-error"><fmt:formatDate value="${e.exam_begin}" pattern="M月d日  HH:mm"/>開始, ${e.time}分鐘</td>
	        <td></td>
	        <td nowrap>${e.cnt1} / ${e.grad1}</td>
	        <td nowrap>${e.cnt2} / ${e.grad2}</td>
	        <td nowrap>${e.cnt3} / ${e.grad3}</td>
	        <td nowrap>${e.cnt4} / ${e.grad4}</td>
	        <td width="100%" nowrap><input type="hidden" id="Oid${e.Oid}" name="Oids" />
	        <c:if test="${now>=begin&&now<end}">
		        <c:if test="${e.regdate==null}">
		        	<button class="btn btn-small" name="method:sign" onClick="$('#level').val('${e.level}'),$('#no').val('${e.no}')" type="submit">報名</button>
		        </c:if>		        
		        <c:if test="${e.regdate !=null}">
		        	<button class="btn btn-danger btn-small" name="method:cancel" onClick="$('#level').val('${e.level}'),$('#no').val('${e.no}')" type="submit">取消</button>
		        <span class="label label-inverse">${fn:substring(e.regdate, 5, 16)} 已報名</span>
		        </c:if>
	        </c:if>
	        <c:if test="${now<begin||now>end}">非報名期間</c:if>
	        </td>
      	</tr>     
	</c:forEach>
	</tbody>
</table>
</c:if>
</form>  

</body>
</html>