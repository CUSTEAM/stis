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
		}, 3000);

		$("input[name='beginDate']").change(function() {
			//alert($("#beginDate").val());
			$("#endDate").val($("#beginDate").val());
		});
	});
</script>
</head>
<body>	
<div class="alert alert-warning">
<strong>缺課列表</strong>
	<div class="btn-group">
		<a class="btn" href="MyDilgAdd">檢視假單列表</a>
		<a href="MyCalendar" class="btn btn-danger">返回課表</a>
	</div>
	<div rel="popover" title="說明"
	data-content="缺課⅓標準由學務單位審查後標記於「成績查詢」, 此處顯示資料不影響考試權益, 缺課⅓名單依相關單位最終公佈為準"
	data-placement="right" class="help btn btn-warning">?</div>   		
</div>	
	
	<div class="accordion" id="myCs">	
		<div class="accordion-group">
			<div class="accordion-heading">
				<div class="accordion-toggle" data-toggle="collapse" data-parent="#myCs" href="#collapseOne">				
				<table>
					<tr>					
						<td width="350">全部記錄</td>
						<td nowrap width="390">
						<c:if test="${info.abs2>0||info.abs5>0||info.abs3>0||info.abs4>0}">
						<p>累計
						<c:if test="${info.abs2>0}">未請假或未核准(曠課): ${info.abs2}節,</c:if> 	
					 	<c:if test="${info.abs5>0}">遲到: ${info.abs5}節,</c:if>
					    <c:if test="${info.abs1>0}">重大傷病: ${info.abs1}節,</c:if>	
						<c:if test="${info.abs3>0}">病假: ${info.abs3}節,</c:if>
						<c:if test="${info.abs4>0}">事假: ${info.abs4}節,</c:if>	
						<c:if test="${info.abs6>0}">公假: ${info.abs6}節,</c:if>
						<c:if test="${info.abs7>0}">喪假: ${info.abs7}節,</c:if>
						<c:if test="${info.abs8>0}">婚假: ${info.abs8}節,</c:if>						
						</p>
					    </c:if>
						</td>
						<td nowrap style="padding:10px;">						
						<div class="btn btn-small">查看細節</div>						
						</td>
					</tr>
				</table>
				
				</div>
			</div>
			<div id="collapseOne" class="accordion-body collapse out">
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
	
	
			
		
		
	<c:forEach items="${cs}" var="c">
	<div class="accordion-group">			
		<div class="accordion-heading">
			<div class="accordion-inner" data-toggle="collapse" data-parent="#myCs" href="#cs${c.Oid}"> 				
			<fmt:formatNumber var="dilg" value="${c.dilg_period+c.elearn_dilg}" pattern="#00"/>
			<fmt:formatNumber var="thour" value="${c.thour*18/3}" pattern="#00"/>
			<c:if test="${thour==0}"><c:set var="thour" value="1"/></c:if>
			<fmt:formatNumber var="pro" value="${100-((dilg/thour)*100)}" pattern="#00"/>
			<table>
				<tr>					
					<td width="350">${c.chi_name}</td>						
					<td nowrap width="100">${c.cname}老師</td>
					<td nowrap width="60">
					<c:if test="${c.opt eq '1'}">必修</c:if>
					<c:if test="${c.opt eq '2'}">選修</c:if>
					<c:if test="${c.opt eq '3'}">通識</c:if>
					</td>
					<td nowrap width="60">${c.credit}學分</td>
					<td nowrap width="60">${c.thour}時數</td>
					<td width="100"><br>						    			
					<div class="progress">
						<c:if test="${pro>=90}"><div class="bar bar-success" style="width:${pro}%" nowrap>${((c.thour*18)/3)-c.dilg_period}/<fmt:formatNumber value="${(c.thour*18)/3}" type="number"/>節</div></c:if>
						<c:if test="${pro>=75&&pro<90}"><div class="bar bar-info" style="width:${pro}%" nowrap>${((c.thour*18)/3)-c.dilg_period}/<fmt:formatNumber value="${(c.thour*18)/3}" type="number"/>節</div></c:if>
						<c:if test="${pro>=50&&pro<75}"><div class="bar bar-warning" style="width:${pro}%" nowrap>${((c.thour*18)/3)-c.dilg_period}/<fmt:formatNumber value="${(c.thour*18)/3}" type="number"/>節</div></c:if>
						<c:if test="${pro<50}"><div class="bar bar-danger" style="width:${pro}%" nowrap>${((c.thour*18)/3)-c.dilg_period}/<fmt:formatNumber value="${(c.thour*18)/3}" type="number"/>節</div></c:if>
				    </div>					    
					</td>
					<td nowrap style="padding:10px;">						
					<div class="btn btn-small">查看全部${c.dilg_period}節</div>	
					<c:if test="${c.status eq'1'}">
					<abbr title="缺曠結算後因被標記為⅓缺課,暫以0分計算" class="initialism">⅓</abbr>
					</c:if>					
					</td>
				</tr>
			</table>
			</div>
		</div>
	
		<div id="cs${c.Oid}" class="accordion-body collapse">				
			<div class="accordion-inner">
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
			<c:if test="${c.elearn_dilg>0}">遠距課程缺課時數: <span class="label label-important">${c.elearn_dilg}</span></c:if>
			
			</div>
		</div>	
	</div>
	</c:forEach>
			
			
			
	</div>
</div>
<div class="alert alert-danger">
	<p><strong>遠距課程缺課時數</strong>於期末由遠距教學系統匯入</p>
</div>
</body>
</html>