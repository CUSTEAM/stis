<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>網路假單申請</title>
<script src="/eis/inc/js/plugin/bootstrap-typeahead.js"></script>
<script src="/eis/inc/js/plugin/bootstrap-fileupload.js"></script>
<script src="/eis/inc/js/plugin/jquery-ui.js"></script>
<link href="/eis/inc/css/jquery-ui.css" rel="stylesheet"/>
<link href="/eis/inc/css/bootstrap-fileupload.css" rel="stylesheet">
</head>
<body>
<form action="MyDilg" method="post" enctype="multipart/form-data">
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">
<h4>網路假單申請</h4>
	
		<!--  href="MyDilgDetail">缺課列表</a>
		<a href="MyDilgAdd">假單列表</a-->
		
	
			
    
    <!-- strong>請注意</strong>「日期」與「節次」，修改請按&nbsp;
    <input type="submit" name="method:resetCookie" value="返回課表" class="btn btn-info"/> &nbsp;或
    <a href="MyDilgAdd" class="btn btn-default">線上請假</a><br>
    	若按瀏覽器的<strong>「上一頁」</strong>點選的節次將會被保留-->
    </div>


	
    
    <div class="row">
    <div class="col-xs-12 col-md-6">
    
    
    
	<div class="panel panel-primary">
	<div class="panel-heading">日期與節次</div>
	<div class="panel-body">
	  <p><b>注意事項</b></p>
  		<p>請假若有到課, 請於課堂上告知任課老師<b>立即</b>銷假</p>
		<p>修改審核完成的假單內容, 請至學務單位申請</p>
	</div>
    
   	<ul class="list-group">
    <c:forEach items="${dilgs}" var="d">
    <li class="list-group-item">
    			${d.date}
    			<input type="hidden" name="Oid" value="${d.Oid}" />
    			<input type="hidden" name="date" value="${d.date}" />
    			<input type="hidden" name="cls" value="${d.cls}"/>
    		第 ${d.cls}節
    </li>	
    </c:forEach>
    </table>
    </div>
    </div> 
    <div class="col-xs-12 col-md-6">
    <div class="panel panel-primary">
	<div class="panel-heading">申請內容</div>
	
    <table class="table">
    	<tr>
    		<td nowrap>假別</td>
    		<td>
    		<select class="form-control" name="abs">
    			<option value="1">重大傷病住院</option>
    			<option value="3" selected>病假</option>
    			<option value="4">事假</option>
    			<option value="7">喪假</option>
    			<option value="8">婚假</option>
    			<option value="9">產假</option>
    			<option value="0">生理假</option>
    		</select>    		
    		</td>
    	</tr>
    	<tr>
    		<td nowrap>事由</td>
    		<td><input class="form-control" name="reason" type="text" placeholder="非必要欄位,可容納32個字"/></td>
    	</tr>
    	<tr>
    		<td nowrap>備註</td>
    		<td width="100%"><textarea class="form-control" name="note" placeholder="非必要欄位,可容納64個字"></textarea></td>
    	</tr>
    	<tr>
    		<td nowrap>附件</td>
    		<td>
    		
    		<div class="fileupload fileupload-new" data-provides="fileupload" style="float:left;">    		    
			<div class="input-group">	
				<div class="uneditable-input">
					<i class="icon-file fileupload-exists"></i> 
					<span class="fileupload-preview"></span>
				</div>	
				<span class="btn btn-file btn-info">					
					<span class="fileupload-new">選擇檔案</span>
					<span class="fileupload-exists">重選檔案 </span>
					<input type="file" name="file"/>
				</span>				
				<a href="#" class="btn fileupload-exists btn-info" data-dismiss="fileupload">取消</a>
			</div>
		</div>
    		
    		
    		
    		</td>
    	</tr>
    	<tr>
    		<td colspan="2">
    		<div class="btn-group" role="group" aria-label="...">
    		<input type="submit" id="login" name="method:addDilg" value="完成假單" class="btn btn-danger"/>
    		<a class="btn btn-default" href="MyCalendar">取消</a>
    		</div>
    		</td>
    	</tr>
    </table>
    </div>
    </div>
    </div>
   


</form>

</body>
</html>