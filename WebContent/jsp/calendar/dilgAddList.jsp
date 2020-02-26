<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>網路假單申請</title>
<script>
function addOid(Oid, dOid){
	if($("#Oid"+Oid).val()==""){
		$("#Oid"+Oid).val(dOid);
	}else{
		$("#Oid"+Oid).val("");
	}
}

function showApp(filename){
    $.blockUI({ 
    	onOverlayClick: $.unblockUI,
        message: "<a href='/eis/getFtpFile?path=DilgImage&file="+filename+"'><img width='400' src='/eis/getFtpFile?path=DilgImage&file="+filename+"'/><br><button class='btn btn-default' type='button'>點選查看原始檔案</button></a>", 
        css: { 
        	top:  '100px',
        } 
    });
}

function GoFadeOut(Oid){		
   $("#app"+Oid).fadeOut('slow', function() {
	   $( location ).attr("href", "MyDilgAdd");
   });
}
	
function delDilg(Oid){
	$.get("delDilgApp", {Oid:Oid},			
		GoFadeOut(Oid)
	);
}

$(document).ready(function() {		
	$(".collapse").collapse("toggle");
	
});
</script>
</head>
<body>
<c:set var="now" value="<%=new Date()%>"/>
<c:set var="someday" />
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">		
		<h4>網路假單申請</h4>
		<div class="btn-group">
			<a class="btn btn-default" href="MyDilgDetail">檢視各課程缺課列表</a> 
			<a href="MyCalendar" class="btn btn-danger">返回課表</a>
		</div>		
	</div>
	<form action="MyDilgAdd" method="post">
		<div class="row">
  			<div class="col-xs-12 col-md-6">
				
				<c:if test="${empty abs && empty noabs}">
				<div class="panel panel-primary">
					<div class="panel-heading">未請假缺課列表</div>
					<div class="panel-body">
					  <p><b>沒有缺課，或所有缺課都已請假完成 :b</b></p>
					</div>
				</div>
				</c:if>
				<c:if test="${!empty abs}">				
				<div class="panel panel-primary">
					<div class="panel-heading">未請假缺課列表</div>
					<div class="panel-body">
					  <p><b>注意事項</b></p>
				  		<p>若有預先請假而到課，或是誤記的情況, 請儘速告知任課老師<b>立即</b>更正</p>
					</div>
					<table class="table">
						<thead>
							<tr>
								<th></th>
								<th>日期</th>
								<th nowrap>節次</th>
								<th>課程名稱</th>
							</tr>
						</thead>
						<c:forEach items="${abs}" var="a">
							<tr>
								<td><input type="checkbox"
									onClick="addOid(${a.Oid}, ${a.Dtime_oid})"> <input
									type="hidden" name="Oid" id="Oid${a.Oid}" value="">
									<input type="hidden" name="date" value="${a.date}">
									<input type="hidden" name="cls" value="${a.cls}"></td>
								<td nowrap>${a.date}</td>
								<td nowrap><span class="label label-danger">第${a.cls}節</span></td>
								<td width="100%">${a.chi_name}</td>
							</tr>
						</c:forEach>
						<tr>
							<td colspan="4">
								<button class="btn btn-danger" name="method:addDilg" type="submit">填寫假單</button>
							</td>
						</tr>
					</table>	
					</div>							
					</c:if>
					
					<c:if test="${!empty noabs}">
					<div class="panel panel-primary">
					<div class="panel-heading">逾期缺課列表</div>
					<div class="panel-body">
					  <p><b>注意事項</b></p>				  		
						<p>超過8日的誤記情況, 無法由任課老師修改，請至各部制學務單位申請</p>
					</div>
					<table class="table">
						<thead>
							<tr>
								<th></th>
								<th>日期</th>
								<th nowrap>節次</th>
								<th>課程名稱</th>
							</tr>
						</thead>
							
						<c:forEach items="${noabs}" var="a">
							<tr>
								<td><input type="checkbox" disabled /></td>
								<td nowrap>${a.date}</td>
								<td nowrap><span class="label label-default">第${a.cls}節</span></td>
								<td width="100%">${a.chi_name}</td>
							</tr>
						</c:forEach>
							
					</table>
				</div>
				</c:if>					
			</div>						
			<div class="col-xs-12 col-md-6">			
			<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
  				<c:forEach items="${apps}" var="a" varStatus="i">
  				<div class="panel panel-primary" id="app${a.Oid}">
    				<div class="panel-heading" role="tab" id="heading${i.index}">
      					<h4 class="panel-title">
        				<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse${i.index}" aria-expanded="true" aria-controls="collapse${i.index}">
          				<c:if test="${a.result ==null}"><span class="label label-as-badge label-info"><span class="glyphicon glyphicon-hourglass" aria-hidden="true"></span></span></c:if>
          				<c:if test="${a.result eq '1'}"><span class="label label-as-badge label-success"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></span></c:if>
          				<c:if test="${a.result eq '2'}"><span class="label label-as-badge label-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></span></c:if>
          				${a.absName}${fn:length(a.ds)}節
          				<c:if test="${a.result ==null}">審核中:${a.cname}</c:if> 
						<c:if test="${a.result eq '1'}">核准:${a.cname}</c:if> 
						<c:if test="${a.result eq '2'}">不核准:${a.cname}</c:if>
        				</a>						
      					</h4>
    				</div>
		    		<div id="collapse${i.index}" class="panel-collapse collapse <c:if test="${i.index!=0}">in</c:if>" role="tabpanel" aria-labelledby="heading${i.index}">
		      			<div class="panel-body">
		      			
		      			<c:if test="${!empty a.reason}"><div class="alert alert-warning">事由: ${a.reason}</div></c:if>									
						<c:if test="${!empty a.note}"><p>備註: ${a.note}</p></c:if>
						<c:if test="${!empty a.file}">		
						<p><button class="btn btn-default btn-mini" onClick="showApp('${a.file}')" type="button">檢視附件</button></p>
						</c:if>
						<table class="table">
						<c:forEach items="${a.ds}" var="s">
							<fmt:parseDate var="someday" value="${s.date}" type="DATE" pattern="yyyy-MM-dd"/>
							<tr><td>${s.date} 第${s.cls}節 </td></tr>
						</c:forEach>
						</table>
						<c:if test="${!empty a.reply}">
							<div class="alert alert-success">${a.reply}</div>
						</c:if>
     					<c:if test="${a.ds[0].earlier=='1'&&!a.over}">
							<input type="button" class="btn btn-danger btn-xs" onClick="delDilg(${a.Oid})"  value="刪除假單 (預)" />
						</c:if>
						
						<c:if test="${a.ds[0].earlier!='1'&&a.result==null&& someday>now}">
						<input type="button" class="btn btn-danger btn-xs" onClick="delDilg(${a.Oid})"  value="刪除假單" />
						</c:if>
		      			<c:if test="${someday<now}">於點名期間內可請任課老師勾選到課，過期請至各部制學務單位申請。</c:if>
		        		</div>
		    		</div>
  				</div>
  				</c:forEach>
  			</div>			
			</div>
		</div>
	</form>
</body>
</html>