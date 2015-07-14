<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>線上請假</title>
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
        message: "<a href='/eis/getFtpFile?path=DilgImage&file="+filename+"'><img src='/eis/getFtpFile?path=DilgImage&file="+filename+"'/></a>", 
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
		<strong>線上請假</strong>&nbsp;
		<div class="btn-group">
			<a class="btn" href="MyDilgDetail">檢視各課程缺課列表</a> 
			<a href="MyCalendar" class="btn btn-danger">返回課表</a>
		</div>
		<div id="funbtn" rel="popover" title="說明"
			data-content="勾選缺課節次再按下「填寫假單」可以多選"
			data-placement="right" class="btn">?</div>
	</div>


	<form action="MyDilgAdd" method="post">


		<div class="row-fluid">
			<div class="span6">
				<h4>未請假缺課列表</h4>
				<c:if test="${empty abs && empty noabs}">沒有缺課，或所有缺課都已請假完成 :b</c:if>
				
				
				<div class="accordion" id="myApps1">
					<c:if test="${!empty abs}">
						<div class="accordion-group">
							<div class="accordion-heading">
								<div class="accordion-toggle" data-toggle="collapse" data-parent="#myApps1" href="#dilgs">
									<b>期限內線上申請</b>
								</div>
							</div>
							<div id="dilgs" class="accordion-body collapse in">
								<div class="accordion-inner">
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
												<td nowrap><span class="label label-info">第${a.cls}節</span></td>
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
							</div>
						</div>
					</c:if>
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					<c:if test="${!empty noabs}">
					<div class="accordion-group">
						<div class="accordion-heading">
							<div class="accordion-toggle" data-toggle="collapse" data-parent="#myApps1" href="#over">
								<b>逾期假單</b>
							</div>
						</div>
						<div id="over" class="accordion-body collapse in">
							<div class="accordion-inner">
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
											<td nowrap><span class="label">第${a.cls}節</span></td>
											<td width="100%">${a.chi_name}</td>
										</tr>
									</c:forEach>
										
								</table>
							</div>
						</div>
					</div>
					</c:if>
					
					
					
					
					
					
					
					
				</div>
				
				
				
			</div>
					
						
			<div class="span6">
			
			<h4>假單列表</h4>
			<c:if test="${empty apps}">沒有假單申請</c:if>
				<div class="accordion" id="myApps">
					<c:forEach items="${apps}" var="a" varStatus="i">
						<div id="app${a.Oid}" class="accordion-group">
							<div class="accordion-heading">
								<div class="accordion-toggle" data-toggle="collapse"
									data-parent="#myApps" href="#app${i.index}">

									<table>
										<tr>
											<td valign="top" nowrap>${a.absName}${fn:length(a.ds)}節</td>
											<td valign="top">
											<c:if test="${a.result ==null}">
												<span class="label label-warning">審核中:${a.cname}</span>
											</c:if> 
											<c:if test="${a.result eq '1'}">
												<span class="label label-success">核准:${a.cname}</span>
											</c:if> 
											<c:if test="${a.result eq '2'}">
												<span class="label label-important">不核准:${a.cname}</span>
											</c:if>
											</td>
											<td valign="top">
											<div class="btn-group">
												<button type="button" class="btn btn-mini">查看假單內容</button>
												<c:if test="${a.ds[0].earlier=='1'&&!a.over}">
												<input type="button" class="btn btn-danger btn-mini" onClick="delDilg(${a.Oid})"  value="刪除" />
												</c:if>
												
												<c:if test="${a.ds[0].earlier!='1'&&a.result==null}">
												<input type="button" class="btn btn-danger btn-mini" onClick="delDilg(${a.Oid})"  value="刪除" />
												</c:if>
											</div>
											</td>
										</tr>
									</table>
								</div>
							</div>
							<div id="app${i.index}"
								class="accordion-body collapse <c:if test="${!empty a.reply}">in</c:if>">
								<div class="accordion-inner">
									<c:if test="${!empty a.reason}"><p>事由: ${a.reason}</p></c:if>									
									<c:if test="${!empty a.note}"><p>備註: ${a.note}</p></c:if>
									<c:if test="${!empty a.file}">		
									<p><button class="btn btn-info btn-mini" onClick="showApp('${a.file}')" type="button">附件</button></p>
									</c:if>
									
									<c:forEach items="${a.ds}" var="s">
										<span class="label label-info">${s.date} 第${s.cls}節</span>
									</c:forEach>
									
									<c:if test="${!empty a.reply}">
										<div style="margin-top: 10px;" class="alert alert-error">${a.reply}</div>
									</c:if>
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