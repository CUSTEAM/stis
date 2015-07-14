<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>成績查詢</title>
<script src="/eis/inc/js/plugin/bootstrap-typeahead.js"></script>
<script src="/eis/inc/js/plugin/bootstrap-fileupload.js"></script>
<script src="/eis/inc/js/plugin/json2.js"></script>
<link href="/eis/inc/css/wizard-step.css" rel="stylesheet"/>
<script>  
$(document).ready(function() {	
	
	$('.help').popover("show");
	setTimeout(function() {
		$('.help').popover("hide");
	}, 3000);
	//$('.threeone').popover("show");
    $(".collapse").collapse();
});
</script>  
</head>
<body>
<div class="alert">
<button type="button" class="close" data-dismiss="alert">&times;</button>
<strong>成績查詢</strong>
<a href="MyCalendar"class="btn">返回</a>
<div rel="popover" title="說明" data-content="點選學年學期檢視成績,修得總學分數與畢業資格由相關單位審核,所有成績資訊依相關單位最終留存為準" data-placement="right" class="help btn btn-warning">?</div>
</div>
<c:set var="now" value="<%=new java.util.Date()%>" />
<div class="accordion" id="years">
	
	<div class="accordion-group">
		<div class="accordion-heading">
			<p class="accordion-toggle" data-toggle="collapse" data-parent="#years" href="#collapseOne"><strong>本學期課程</strong>
			<button type="button" style="float:right;"class="btn btn-mini"><i style="margin-top:2px;" class="icon-eye-close"></i></i></button></p>
		</div>
		<div id="collapseOne" class="accordion-body collapse">
			<div class="accordion-inner">			
			<table class="table table-striped">
				<tr>
					<td nowrap>選別</td>
					<td nowrap>開課班級</td>
					<td nowrap>科目代碼</td>
					<td nowrap>科目名稱</td>
					<td nowrap>學分數</td>
					<td nowrap>每週時數</td>
					<td nowrap>期中成績</td>
					<td nowrap>學期成績</td>
					<td nowrap>備註</td>
				</tr>
				<c:set var="credit" value="0.0" />
				<c:set var="credit_pass" value="0.0" />
				<c:set var="hr" value="0" />
				<c:forEach items="${seld}" var="s">					
				<c:set var="credit" value="${credit+s.credit}" />
				<c:set var="hr" value="${hr+s.thour}" />				
				<tr>
					<td width="50">${s.OptName}</td>
					<td width="100" nowrap>${s.ClassName}</td>
					<td width="100">${s.cscode}</td>
					<td width="500">${s.chi_name}</td>
					
					<td width="80">${s.credit}</td>
					<td width="80">${s.thour}</td>
					<td width="80" nowrap>
					<c:if test="${now>=date_exam_mid_view}">
						<c:if test="${fn:indexOf(s.chi_name, '體育')<0}">
							<c:if test="${now>=date_exam_mid_view}"><p <c:if test="${s.realScore2<pa}">class="text-error"</c:if>>${s.realScore2}</p></c:if>						
						</c:if>										
						<c:if test="${fn:indexOf(s.chi_name, '體育')>=0}">
							<c:if test="${now>=date_exam_mid_view}">
								<font size="-2">平時${s.realScore2}, 學科${s.realScore3},術科${s.realScore1}</font>						
							</c:if>
						</c:if>	
					</c:if>						
					<c:if test="${now<date_exam_mid_view}"><fmt:formatDate value="${date_exam_mid_view}" pattern="M月d日"/>公佈</c:if>					
					</td>
					
					<c:if test="${s.graduate eq '0'}">
					<td width="80" nowrap>
						<c:if test="${now>=date_exam_fin_view}">
							<p <c:if test="${s.realScore<pa}">class="text-error"</c:if>>${s.realScore}</p>
						</c:if>							
						<c:if test="${now<date_exam_fin_view}"><fmt:formatDate value="${date_exam_fin_view}" pattern="M月d日"/>公佈</c:if>
					</td>
					</c:if>

					<c:if test="${s.graduate eq '1'}">
					<td width="80" nowrap>
						<c:if test="${now>=date_exam_grad_view}">
							<p <c:if test="${s.realScore<pa}">class="text-error"</c:if>>${s.realScore}</p>
						</c:if>							
						<c:if test="${now<date_exam_grad_view}"><fmt:formatDate value="${date_exam_grad_view}" pattern="M月d日"/>公佈</c:if>
					</td>
					</c:if>					
					<td nowrap>
					<c:if test="${s.status eq'1'}">					
					 <p class="text-error">缺課達⅓</p>
					</c:if>
					</td>
				</tr>
				</c:forEach>				
				<c:forEach items="${desds}" var="d">
				<tr>		
					<td>獎懲</td>
					<td colspan="8">${d.ddate}
					<c:if test="${!empty d.name1}">, ${d.name1} ${d.cnt1}次</c:if>
					<c:if test="${!empty d.name2}">, ${d.name2} ${d.cnt2}次</c:if></td>					
				</tr>
				</c:forEach>				
				<!--tr>
					<td colspan="9">本學期應修: ${credit}學分 
					<c:if test="${now>=date_score_end_view}">, 實得: ${credit_pass}學分 
						<c:if test="${(credit-credit_pass)>0}">,不及格: ${credit-credit_pass}學分</c:if>
					</c:if>
					</td>
				</tr-->
			</table>			
			</div>
		</div>
	</div>	
	<c:set var="credit" value="0.0" />
	<c:set var="credit1" value="0.0" />
	<c:set var="credit2" value="0.0" />
	<c:set var="credit3" value="0.0" />
	<c:forEach items="${scoreHist}" var="s">
	<div class="accordion-group">
		<div class="accordion-heading">
			<p class="accordion-toggle" data-toggle="collapse" data-parent="#years" href="#year${s.school_year}${s.school_term}">
			<c:set var="credit" value="${credit+s.tc}" />
			<c:set var="credit1" value="${credit1+s.c1}" />
			<c:set var="credit2" value="${credit2+s.c2}" />
			<c:set var="credit3" value="${credit3+s.c3}" />
			<strong>${s.school_year}學年第 ${s.school_term}學期</strong>, 
			應修 ${s.tc}學分,
			取得必修  ${s.c1},
			<c:if test="${s.c2>0}">選修 ${s.c2},</c:if>
			<c:if test="${s.c3>0}"> 通識 ${s.c3},</c:if>
			共取得 ${s.pc}學分
			<c:if test="${(s.tc-s.c1-s.c2-s.c3)>0}">, 不及格${s.tc-s.c1-s.c2-s.c3}學分</c:if>
			<button type="button" style="float:right;"class="btn btn-mini"><i style="margin-top:2px;" class="icon-eye-open"></i></i></button>	
			</p>
		</div>
		
		<div id="year${s.school_year}${s.school_term}" class="accordion-body collapse in">
			<div class="accordion-inner">			
			<table class="table table-striped">
				<tr>
					<td nowrap>選別</td>
					<td nowrap>開課班級</td>
					<td nowrap>科目代碼</td>
					<td nowrap>科目名稱</td>					
					<td nowrap>學分數</td>
					<td nowrap></td>
					<td nowrap>學期成績</td>
					<td nowrap>備註</td>
				</tr>
				<c:forEach items="${s.hist}" var="h">
				<tr>
					<td width="50" nowrap>${h.OptName}</td>
					<td width="100" nowrap>${h.ClassName}</td>
					<td width="100" nowrap>${h.cscode}</td>
					<td width="500">${h.chi_name}</td>
					
					<td width="80">${h.credit}</td>
					<td width="80"></td>
					<td width="80"><p <c:if test="${h.score<pa}">class="text-error"</c:if>>${h.score}</p></td>
					<td nowrap>${h.evgrName}</td>
				</tr>
				</c:forEach>	
				<c:forEach items="${s.desd}" var="d">
				<tr>		
					<td>獎懲</td>
					<td colspan="7">
					${d.ddate}
					<c:if test="${!empty d.name1}">, ${d.name1} ${d.cnt1}次</c:if>
					<c:if test="${!empty d.name2}">, ${d.name2} ${d.cnt2}次</c:if>
					</td>					
				</tr>
				</c:forEach>			
			</table>			
			</div>
		</div>
	</div>
	</c:forEach>	
	
	<div class="accordion-group">
		<div class="accordion-heading">
		<div class="accordion-toggle" data-toggle="collapse" data-parent="#years" href="#year">
		
		<p >
				<abbr title="HyperText Markup Language" class="initialism">共${fn:length(scoreHist)}學期</abbr> 應修 ${credit}學分, 必修取得  ${credit1}學分, 選修取得 ${credit2}學分,
				通識取得 ${credit3}學分, 共取得 ${credit1+credit2+credit3}學分, 不及格${credit-(credit1+credit2+credit3)}學分
			</p>	
			<c:if test="${!empty skill}">
			<table class="table">
			<tr>
				<td><span class="label label-info">已取得證照</span></td>
			</tr>
			<c:forEach items="${skill}" var="s">
			<tr>
				<td>${s.Name}, ${s.Level} - ${s.DeptName}</td>
			</tr>
			</c:forEach>
			</table>
			</c:if>
		
		</table>
		
		
		
		
		
		<button type="button" style="float:right;"class="btn btn-mini"><i style="margin-top:2px;" class="icon-eye-close"></i></i></button></p>
		</div>
		</div>		
		<div id="year" class="accordion-body collapse">
			<div class="accordion-inner">
			 <p class="text-error">修得總學分數與畢業資格由相關單位審核, 所有成績資訊依相關單位最終留存為準</p>
			</div>
		</div>
	</div>		
</div>
</body>
</html>