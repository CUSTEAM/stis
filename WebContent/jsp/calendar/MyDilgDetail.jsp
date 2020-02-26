<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>缺課列表</title>
<script>
	$(document).ready(function() {

		$('.help').popover("show");
		setTimeout(function() {
			$('.help').popover("hide");
		}, 10000);
		
		$(".collapse").collapse();
	});
</script>
</head>
<body>	
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">
<h4>缺課列表</h4>
	<div class="btn-group">
		<a class="btn btn-default" href="MyDilgAdd">檢視假單列表</a>
		<a href="MyCalendar" class="btn btn-danger">返回課表</a>
	</div>
	<div rel="popover" title="說明"
	data-content="缺課⅓標準由學務單位審查後標記於「成績查詢」, 本程式提供的警示計量圖表並不影響考試權益, 缺課⅓名單依相關單位最終公佈為準. 遠距課程的缺課記錄, 將於期末由遠距中心匯入"
	data-placement="right" class="help btn btn-warning">?</div>   		
</div>

<div class="row" style="width:100%">
	<div class="col-xs-12 col-md-6">
	  	<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">	
		
		<!-- div class="panel panel-custom-horrible-red"-->
		<div class="panel panel-primary">
			<div class="panel-heading" role="tab" id="heading">
			<h4 class="panel-title">
		    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#myCs" 
		    aria-expanded="true" aria-controls="myCs">全部記錄				
		    </a>
		    </h4>
		  	</div>
		  	<div class="panel-body" data-toggle="collapse" data-parent="#accordion" href="#myCs" 
		    aria-expanded="true" aria-controls="myCs">
	    	<p>
	    	<c:if test="${info.abs2>0||info.abs5>0||info.abs3>0||info.abs4>0}">		
			<c:if test="${info.abs2>0}">未請假: ${info.abs2}節,</c:if> 	
		 	<c:if test="${info.abs5>0}">遲到: ${info.abs5}節,</c:if>
		    <c:if test="${info.abs1>0}">重大傷病: ${info.abs1}節,</c:if>	
			<c:if test="${info.abs3>0}">病假: ${info.abs3}節,</c:if>
			<c:if test="${info.abs4>0}">事假: ${info.abs4}節,</c:if>	
			<c:if test="${info.abs6>0}">公假: ${info.abs6}節,</c:if>
			<c:if test="${info.abs7>0}">喪假: ${info.abs7}節,</c:if>
			<c:if test="${info.abs8>0}">婚假: ${info.abs8}節,</c:if>
		    </c:if>
	    	</p>   	
	    	
	    	<div class="progress">
		    	<div class="progress-bar 
		    	<c:if test="${info.abs2<=10}">progress-bar-success</c:if>
		    	<c:if test="${info.abs2<=20&&info.abs2>10}">progress-bar-info</c:if>
		    	<c:if test="${info.abs2<=30&&info.abs2>20}">progress-bar-warning</c:if>
		    	<c:if test="${info.abs2>35&&info.abs2>30}">progress-bar-danger</c:if>
		    	progress-bar-striped" 
		    	role="progressbar" aria-valuenow="<fmt:formatNumber value="${100-((info.abs2/45)*100)}" type="number"/>" aria-valuemin="0" aria-valuemax="100" style="width:<fmt:formatNumber value="${100-((info.abs2/45)*100)}" type="number"/>%">
				   <span class="sr-only">${info.abs2}/45節</span>
				</div>
			</div>
	    	<a class="btn btn-default">查看所有缺課記錄</a>
	  		</div>
		  	<div id="myCs" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="heading">
			    <div class="panel-body">
			   	<table class="table table-hover">
					<c:forEach items="${cs}" var="c">				
					<c:forEach items="${c.dilgs}" var="d">
					<tr>					
						<c:if test="${d.abs eq '2'}"><td nowrap>${d.date}, 第 ${d.cls}節</td><td nowrap><span class="label label-important">${d.name}</span></td></c:if>
						<c:if test="${d.abs eq '5'}"><td nowrap>${d.date}, 第 ${d.cls}節</td><td nowrap><span class="label label-warning">${d.name}</span></td></c:if>
						<c:if test="${d.abs ne '5'&&d.abs ne '2'}"><td nowrap>${d.date}, 第 ${d.cls}節</td><td nowrap><span class="label label-success">${d.name}</span></td></c:if>
						<td nowrap>
						<c:if test="${d.result==null&& d.abs ne 2 && d.abs ne 5}"><span class="label label-warning">審核中</span></c:if>
						<c:if test="${d.result eq '1'}"><span class="label label-info">已核准</span></c:if>
						<c:if test="${d.result eq '2'}"><span class="label label-inverse">請假未核准</span></c:if>
						</td>
						<td width="100%"></td>
					</tr>
					</c:forEach>
					</c:forEach>
				</table>
			    </div>
		  	</div>
		</div>		     
	</div>
  	
  	
  	
  	</div>
	
	
	<div class="col-xs-12 col-md-6">
	
	<div class="panel-group" id="accordion1" role="tablist" aria-multiselectable="true">		
	<c:forEach items="${cs}" var="c" varStatus="i">
	<div class="panel panel-primary">
		<div class="panel-heading" role="tab" id="heading${i.index}">
		<h4 class="panel-title">
	      <a role="button" data-toggle="collapse" data-parent="#accordion1" href="#collapse${i.index}" aria-expanded="true" aria-controls="collapse${i.index}">
	      ${c.cname}老師, <c:if test="${c.opt eq '1'}">必修</c:if><c:if test="${c.opt eq '2'}">選修</c:if><c:if test="${c.opt eq '3'}">通識</c:if>, ${c.credit}學分, ${c.thour}小時, <b>${c.chi_name}</b>
	      </a>
	    </h4>
	  	</div>
	  	<div class="panel-body" data-toggle="collapse" data-parent="#accordion1" href="#collapse${i.index}" aria-expanded="true" aria-controls="collapse${i.index}">
    	<p>
    	<fmt:formatNumber var="dilg" value="${c.dilg_period+c.elearn_dilg}" pattern="#00"/>
			<fmt:formatNumber var="thour" value="${c.thour*18/3}" pattern="#00"/>
			<c:if test="${thour==0}"><c:set var="thour" value="1"/></c:if>
			<fmt:formatNumber var="pro" value="${100-((dilg/thour)*100)}" pattern="#00"/>
    	</p>
    	
    	<div class="progress">			
			
			<c:if test="${pro>=90}">
			<div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="${pro}" aria-valuemin="0" aria-valuemax="100" style="width:${pro}%">
		    	<span class="sr-only">${((c.thour*18)/3)-c.dilg_period}/<fmt:formatNumber value="${(c.thour*18)/3}" type="number"/>節</span>
		  	</div>
		  	</c:if>
		  	
		  	<c:if test="${pro>=75&&pro<90}">
			<div class="progress-bar progress-bar-info progress-bar-striped" role="progressbar" aria-valuenow="${pro}" aria-valuemin="0" aria-valuemax="100" style="width:${pro}%">
		    	<span class="sr-only">${((c.thour*18)/3)-c.dilg_period}/<fmt:formatNumber value="${(c.thour*18)/3}" type="number"/>節</span>
		  	</div>
		  	</c:if>
		  	
		  	<c:if test="${pro>=50&&pro<75}">
			<div class="progress-bar progress-bar-warning progress-bar-striped" role="progressbar" aria-valuenow="${pro}" aria-valuemin="0" aria-valuemax="100" style="width:${pro}%">
		    	<span class="sr-only">${((c.thour*18)/3)-c.dilg_period}/<fmt:formatNumber value="${(c.thour*18)/3}" type="number"/>節</span>
		  	</div>
		  	</c:if>
		  	
		  	<c:if test="${pro<50}">
			<div class="progress-bar progress-bar-danger progress-bar-striped" role="progressbar" aria-valuenow="${pro}" aria-valuemin="0" aria-valuemax="100" style="width:${pro}%">
		    	<span class="sr-only">${((c.thour*18)/3)-c.dilg_period}/<fmt:formatNumber value="${(c.thour*18)/3}" type="number"/>節</span>
		  	</div>
		  	</c:if>
		  	
		</div>    	
    	<a class="btn btn-default">查看${c.dilg_period}節缺課記錄</a>
  		</div>
	  	<div id="collapse${i.index}" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="heading${i.index}">
		    <div class="panel-body">
		    <table class="table table-hover">
					
			<c:forEach items="${c.dilgs}" var="d">
			<tr>
				
				<c:if test="${d.abs eq '2'}"><td nowrap>${d.date}, 第 ${d.cls}節</td><td nowrap><span class="label label-important">${d.name}</span></td></c:if>
				<c:if test="${d.abs eq '5'}"><td nowrap>${d.date}, 第 ${d.cls}節</td><td nowrap><span class="label label-warning">${d.name}</span></td></c:if>
				<c:if test="${d.abs ne '5'&&d.abs ne '2'}"><td nowrap>${d.date}, 第 ${d.cls}節</td><td nowrap><span class="label label-success">${d.name}</span></td></c:if>
				
				<td nowrap>
				<c:if test="${d.result==null&& d.abs ne 2 && d.abs ne 5}"><span class="label label-warning">審核中</span></c:if>
				<c:if test="${d.result eq '1'}"><span class="label label-info">已核准</span></c:if>
				<c:if test="${d.result eq '2'}"><span class="label label-inverse">請假未核准</span></c:if>
				</td>
				<td width="100%"></td>
			</tr>
			</c:forEach>
			</table>
			<c:if test="${c.elearn_dilg>0}">遠距課程缺課時數: ${c.elearn_dilg}</c:if>
		    </div>
	  	</div>
	</div>
	</c:forEach>
	     
	</div>
	
	
	</div>
	
</div>
	




	

</body>
</html>