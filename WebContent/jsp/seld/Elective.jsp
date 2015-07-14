<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>網路選課</title>
<script src="/eis/inc/js/plugin/bootstrap-typeahead.js"></script>
<script src="/eis/inc/js/plugin/jquery.knob.js"></script>
<link href="/eis/inc/css/wizard-step.css" rel="stylesheet"/>
<style>
    body .modal {
    /* new custom width */
    width: 90%;
    /* must be half of the width, minus scrollbar on the left (30px) */
    margin-left: -45%;
}
</style>
</head>
<body>
<c:if test="${empty schedule}">
<div class="alert alert-danger alert-block fade in">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	<h4 class="alert-heading">目前非選課期間</h4>
	<p>選課期間及相關規則請查詢各部制課務單位公告</p>
	<p><a class="btn btn-danger" href="MyCalendar">返回</a> <a class="btn" href="#stdInfo" data-toggle="modal" onClick="getSeldHist('${userid}')">加退選歷程</a></p>
</div>
</c:if>

<form action="Elective" method="post" onSubmit="return(confirm('部份特殊情況下執行後依規定不可恢復\n確定執行加退選?')); void('')">
<!-- Modal -->
<div id="stdInfo" class="modal hide fade " tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
<h3 id="title"></h3>
</div>
<div class="modal-body" id="info"></div>
<div class="modal-footer">
<button class="btn" data-dismiss="modal" aria-hidden="true">關閉</button>
</div>
</div>
<c:if test="${!empty schedule}">
<div class="alert alert-block fade in">	
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	<table>
		<tr>
			<td>
			<input readonly class="knob" data-displayInput="true" data-step="0.5" data-min="0" data-max="${schedule.max}" value="${mycredit}" 
			<c:if test="${(schedule.max-mycredit)<2}">data-fgColor="#b94a48"</c:if> data-height="100" data-width="100"/>
			</td>
			<td>
			<h4 class="alert-heading">第${schedule.term}學期, 第${schedule.level}階段選課</h4>
			<p>本學期學分上限 ${schedule.max}學分, 下限 ${schedule.min}學分<br>已選 ${fn:length(myClass)}門課程, ${mycredit}學分, 每週 ${mythour}時數</p>
			<p><a class="btn btn-danger" href="MyCalendar">返回課表</a> <a class="btn" href="#stdInfo" data-toggle="modal" onClick="getSeldHist('${userid}')">加退選歷程</a></p>
			</td>
		</tr>
	</table>
</div>
<%@ include file="Elective/edit.jsp"%></td>
</c:if>
</form>
<script>
$(".knob").knob();    
function getSeldHist(stdNo){    	
    var str;
    $.get("/eis/getSeldHist?stdNo="+stdNo+"&"+Math.floor(Math.random()*999),
    function(d){    		
   		str="<table class='table table-bordered table-hover'>";    		
   		$("#info").html("");
   		if(d.list.length>0){
   			for(i=0; i<d.list.length; i++){				
   				str=str+"<tr><td nowrap>"+d.list[i].ClassName+"</td><td nowrap>"+d.list[i].chi_name+"</td><td>"+d.list[i].edate.replace("T", " ")+"</td><td nowrap width='50'>"+d.list[i].cname+"</td>";
   				if(d.list[i].type=='A'){
   					str=str+"<td class='text-success'>加選</td></tr>";
   				}else{
   					str=str+"<td class='text-error'>退選</td></tr>";
   				}
   			}
   		}else{
   			str=str+"<tr><td>無加退選記錄</td></tr>";
   		}
   		str=str+"</table>";   		
   		$("#title").text(stdNo);
   		$("#info").append(str);    		
    }, "json");	
}
</script>

</body>
</html>