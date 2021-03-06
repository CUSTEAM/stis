<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>成績查詢</title>
<script src="/eis/inc/js/plugin/bootstrap-typeahead.js"></script>
<script src="/eis/inc/js/plugin/bootstrap-fileupload.js"></script>
<script src="/eis/inc/js/plugin/json2.js"></script>
<link href="/eis/inc/css/wizard-step.css" rel="stylesheet"/>
<style>
.alert-purple { border-color: #694D9F;background: #694D9F;color: #fff; }
.alert-info-alt { border-color: #B4E1E4;background: #81c7e1;color: #fff; }
.alert-danger-alt { border-color: #B63E5A;background: #E26868;color: #fff; }
.alert-warning-alt { border-color: #F3F3EB;background: #E9CEAC;color: #fff; }
.alert-success-alt { border-color: #19B99A;background: #20A286;color: #fff; }
.alert-default-alt { border-color: #aaaaaa; background: #cccccc;color: #fff; }
.glyphicon { margin-right:10px; }
.alert a {color: gold;}
</style>
<script>  
$(document).ready(function() {		
    $(".collapse").collapse();
});
</script>  
</head>
<body>
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">
<button type="button" class="close" data-dismiss="alert">&times;</button>
<h4><b>成績查詢</b></h4> 
<small>
<table >
	<tr>
	<td style="padding:3px;"><span class="label label-as-badge label-danger">1</span> 成績公佈日期由權責單位設定 </td>
	<td style="padding:3px;"><span class="label label-as-badge label-warning">2</span> 各項資格審查依相關單位認定為準</p></td>
	</tr>
	<tr>
	<td style="padding:3px;"><span class="label label-as-badge label-success">3</span> 已取得證照以各系填報為準</td>
	<td style="padding:3px;"><span class="label label-as-badge label-info">4</span> 各學年成績與獎懲以相關單位公佈為準</td>
	</tr>
</table>
</small>
</div>
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="credit" value="0.0" />
<c:set var="credit1" value="0.0" />
<c:set var="credit2" value="0.0" />
<c:set var="credit3" value="0.0" />	
<div class="row">
	 
	<div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">  
  		<c:if test="${gradresu.practice eq'Y'}">
  		<div class="alert alert-info-alt alert-dismissable">
  		<div style="font-size:12px; z-index:10;position:absolute; right:30px; top:10px;">註 <span class="label label-as-badge label-warning">2</span></div>
  		<center>
  		<h1><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></h1>
		<strong>實習</strong>取得
		</center>
		</div>
		</c:if>
		<c:if test="${gradresu.practice ne'Y'}">
  		<div class="alert alert-info alert-dismissable">
  		<div style="font-size:12px; z-index:10;position:absolute; right:30px; top:10px;">註 <span class="label label-as-badge label-warning">2</span></div>
	 	<center>
  		<h1><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span></h1>
		<strong>實習</strong>未取得
		</center>
		</div>
		</c:if>
		
  	</div>
  	

  	<div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
  		<c:if test="${gradresu.certificate eq'Y'}">
  		<div class="alert alert-success-alt alert-dismissable">
  		<div style="font-size:12px; z-index:10;position:absolute; right:30px; top:10px;">註 <span class="label label-as-badge label-warning">2</span></div>
  		<center>
  		<h1><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></h1>
		<strong>證照</strong>取得
		</center>
		</div>
		</c:if>
		<c:if test="${gradresu.certificate ne'Y'}">
		<div class="alert alert-success alert-dismissable">
		<div style="font-size:12px; z-index:10;position:absolute; right:30px; top:10px;">註 <span class="label label-as-badge label-warning">2</span></div>
  		<center>
  		<h1><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span></h1>
		<strong>證照</strong>未取得
		</center>
		</div>
		</c:if>
  	</div>
	
	
	
	<div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
	<c:if test="${gradresu.language eq'Y'}">
	 	<div class="alert alert-danger-alt alert-dismissable">
	 	<div style="font-size:12px; z-index:10;position:absolute; right:30px; top:10px;">註 <span class="label label-as-badge label-warning">2</span></div>
	 	<center>
  		<h1><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></h1>
		<strong>語言門檻</strong>通過
		</center>
		</div>
	</c:if>
	<c:if test="${gradresu.language ne'Y'}">
	 	<div class="alert alert-danger-alt alert-dismissable">
	 	<div style="font-size:12px; z-index:10;position:absolute; right:30px; top:10px;">註 <span class="label label-as-badge label-warning">2</span></div>
	 	<center>
  		<h1><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span></h1>
		<strong>語言門檻</strong>未通過
		</center>
		</div>
	</c:if>	
	</div>
	
	
	
	<!-- div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
	<c:if test="${gradresu.pass eq'Y'}">
	 	<div class="alert alert-default-alt alert-dismissable">
	 	<div style="font-size:12px; z-index:10;position:absolute; right:30px; top:10px;">註 <span class="label label-as-badge label-warning">2</span></div>
	 	<center>
  		<h1><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></h1>
		<strong>畢業資格</strong>取得
		</center>
		</div>
	</c:if>
	<c:if test="${gradresu.pass ne'Y'}">
	 	<div class="alert alert-default-alt alert-dismissable">
	 	<div style="font-size:12px; z-index:10;position:absolute; right:30px; top:10px;">註 <span class="label label-as-badge label-warning">2</span></div>
	 	<center>
  		<h1><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span></h1>
		<strong>畢業資格</strong>未取得
		</center>
		</div>
	</c:if>	
	</div-->
	
	
	
	
	  
</div>

<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">  
	<div class="panel panel-primary">	    
	    <div class="panel-heading " role="tab" id="heading">
	      <h4 class="panel-title">
	        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse" aria-expanded="true" aria-controls="collapse">
	        	本學期課程 <div style="float:right;">註 <span class="label label-as-badge label-danger">1</span></div>
	        </a>
	      </h4>
	    </div>
	    <!-- div class="panel-body">
	  	<p><b>注意事項</b></p>
  		<p><span class="label label-as-badge label-warning">1</span> 部份科目的瀏覽日期由各部制權責單位特別設定, 程式依其設定顯示資料</p>
		<p><span class="label label-as-badge label-danger">2</span> 學分總數與畢業資格由相關單位審核, 所有成績資訊依相關單位留存為準</p>
		</div-->
		<div id="collapse" class="panel-collapse collapse" role="tabpane2" aria-labelledby="heading">
			
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
					
					
					
					<c:if test="${!empty s.exam_mid_view}">
					<!-- 期中特殊課程 -->
					<c:if test="${now>=s.exam_mid_view}">
						<c:if test="${fn:indexOf(s.chi_name, '體育')<0}">
							<c:if test="${now>=date_exam_mid_view}"><p <c:if test="${s.realScore2<pa}">class="text-error"</c:if>>${s.realScore2}</p></c:if>						
						</c:if>										
						<c:if test="${fn:indexOf(s.chi_name, '體育')>=0}">
							<c:if test="${now>=date_exam_mid_view}">
								<font size="-2">平時${s.realScore2}, 學科${s.realScore3},術科${s.realScore1}</font>						
							</c:if>
						</c:if>	
					</c:if>						
					<c:if test="${now<s.exam_mid_view}"><fmt:formatDate value="${s.exam_mid_view}" pattern="M月d日"/>公佈</c:if>
					</c:if>
					
					<c:if test="${empty s.exam_mid_view}">
					<!-- 期中普通課程-->
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
					</c:if>
					</td>
					
					<c:if test="${!empty s.exam_fin_view}">
					<!-- 期末特殊課程 -->					
					<td width="80" nowrap>
						<c:if test="${now>=s.exam_fin_view}">
							<c:if test="${s.status ne'1'}"><p <c:if test="${s.realScore<pa}">class="text-error"</c:if>>${s.realScore}</p></c:if>
							<c:if test="${s.status eq'1'}"><p class="text-error">0</p></c:if>
						</c:if>							
						<c:if test="${now<s.exam_fin_view}"><fmt:formatDate value="${s.exam_fin_view}" pattern="M月d日"/>公佈</c:if>
					</td>					
					</c:if>					
					<c:if test="${empty s.exam_fin_view}">
					<!-- 期末一般課程 -->
					<c:if test="${s.graduate eq '0'}">
					<td width="80" nowrap>
						<c:if test="${now>=date_exam_fin_view}">
							<c:if test="${s.status ne'1'}"><p <c:if test="${s.realScore<pa}">class="text-error"</c:if>>${s.realScore}</p></c:if>
							<c:if test="${s.status eq'1'}"><p class="text-error">0</p></c:if>
						</c:if>							
						<c:if test="${now<date_exam_fin_view}"><fmt:formatDate value="${date_exam_fin_view}" pattern="M月d日"/>公佈</c:if>
					</td>
					</c:if>
					<c:if test="${s.graduate eq '1'}">
					<td width="80" nowrap>
						<c:if test="${now>=date_exam_grad_view}">
							<c:if test="${s.status ne'1'}"><p <c:if test="${s.realScore<pa}">class="text-error"</c:if>>${s.realScore}</p></c:if>
							<c:if test="${s.status eq'1'}"><p class="text-error">0</p></c:if>
						</c:if>							
						<c:if test="${now<date_exam_grad_view}"><fmt:formatDate value="${date_exam_grad_view}" pattern="M月d日"/>公佈</c:if>
					</td>
					</c:if>						
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
    <c:forEach items="${scoreHist}" var="s" varStatus="i">
    <c:if test="${(s.school_year+s.school_year+s.school_term)ne(school_year+school_year+school_term)}">    
    <div class="panel panel-primary">
	    <div class="panel-heading" role="tab" id="heading${i.index}">
	      <h4 class="panel-title">
	        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse${i.index}" aria-expanded="true" aria-controls="collapse${i.index}">
			${s.school_year}學年第 ${s.school_term}學期 <button type="button" class="btn btn-default btn-xs">點選查看</button>
			<div style="float:right;">註 <span class="label label-as-badge label-success">3</span></div>
	        </a>
	      </h4>
	    </div>
	    <div class="panel-body">
		  <p class="accordion-toggle" data-toggle="collapse" data-parent="#years" href="#year${s.school_year}${s.school_term}">
			<c:set var="credit" value="${credit+s.tc}" />
			<c:set var="credit1" value="${credit1+s.c1}" />
			<c:set var="credit2" value="${credit2+s.c2}" />
			<c:set var="credit3" value="${credit3+s.c3}" />
			取得${s.pc}學分,
			必修  ${s.c1},
			<c:if test="${s.c2>0}">選修 ${s.c2},</c:if>
			<c:if test="${s.c3>0}"> 通識 ${s.c3},</c:if>			
			<c:if test="${(s.tc-s.c1-s.c2-s.c3)>0}">, 不及格${s.tc-s.c1-s.c2-s.c3}</c:if>
			學分
			
			</p>
		</div>
		<div id="collapse${i.index}" class="panel-collapse collapse in" role="tabpane2" aria-labelledby="heading${i.index}">
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
    </c:if>
    </c:forEach>
    
    <div class="panel panel-primary">
	    <div class="panel-heading" role="tab" id="headingt">
	      <h4 class="panel-title">
	        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapset" aria-expanded="true" aria-controls="collapset">
			${fn:length(scoreHist)}個學期中的學分取得概況
			<div style="float:right;">註 <span class="label label-as-badge label-success">3</span></div>
	        </a>
	      </h4>
	    </div>
		<div id="collapset" class="panel-collapse collapse" role="tabpanet" aria-labelledby="headingt">
			<div class="panel-body">
			取得 ${credit1+credit2+credit3}學分, 必修  ${credit1}學分, 選修 ${credit2}學分, 通識 ${credit3}學分
			</div>
	    </div>
  	</div>
  	<c:if test="${!empty skill}">
  	<div class="panel panel-primary">
	    <div class="panel-heading" role="tab" id="headingp">
	      <h4 class="panel-title">
	        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapsep" aria-expanded="true" aria-controls="collapsep">已取得證照</a>
	        <div style="float:right;">註 <span class="label label-as-badge label-info">4</span></div>
	      </h4>
	    </div>
		<div id="collapsep" class="panel-collapse collapse" role="tabpanep" aria-labelledby="headingp">
			<table class="table">
			<c:forEach items="${skill}" var="s">
			<tr>
				<td>${s.Name}, ${s.Level} - ${s.DeptName}</td>
			</tr>
			</c:forEach>
			</table>
	    </div>
  	</div>
  	</c:if>
</div>
</body>
</html>