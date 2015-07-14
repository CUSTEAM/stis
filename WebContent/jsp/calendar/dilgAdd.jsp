<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/eis/inc/js/plugin/bootstrap-typeahead.js"></script>
<script src="/eis/inc/js/plugin/bootstrap-fileupload.js"></script>
<script src="/eis/inc/js/plugin/jquery-ui.js"></script>
<link href="/eis/inc/css/jquery-ui.css" rel="stylesheet"/>
<link href="/eis/inc/css/bootstrap-fileupload.css" rel="stylesheet">
</head>
<body>
<form action="MyDilg" method="post" enctype="multipart/form-data">
<div class="alert">

<div class="btn-group">
				<a class="btn" href="MyDilgDetail">缺課列表</a>
				<a class="btn" href="MyDilgAdd">假單列表</a>
			</div>
			<a href="MyCalendar" class="btn btn-danger">返回課表</a>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <strong>請注意</strong>「日期」與「節次」，修改請按&nbsp;
    <input type="submit" name="method:resetCookie" value="返回課表" class="btn btn-info"/> &nbsp;或
    <a href="MyDilgAdd" class="btn btn">線上請假</a><br>
    	若按瀏覽器的<strong>「上一頁」</strong>點選的節次將會被保留
    </div>



    <div class="container-fluid">
    <div class="row-fluid">
    <div class="span3">
    <table class="table table-striped table-bordered">
    	<tr>
    		<td>日期</td>
    		<td>節次</td>
    	</tr>
    <c:forEach items="${dilgs}" var="d">
    	<tr>
    		<td>
    			${d.date}
    			<input type="hidden" name="Oid" value="${d.Oid}" />
    			<input type="hidden" name="date" value="${d.date}" />
    			<input type="hidden" name="cls" value="${d.cls}"/>
    		</td>
    		<td>第 ${d.cls}節</td>
    	</tr>
    </c:forEach>
    </table>
     <table class="table table-bordered">
    	<tr>
    		<td>
    		    <ol>
			    	<li>預先請假若有到課, 請告知任課老師</li>
			    	<li>已審核假單若有到課, 同上</li>			    	
			    	<li>取消未審核假單, 請點選假單列表</li>
			    	<li>更改已審核假別, 請連絡學務單位</li>
			    </ol>
    		
    		</td>
    	</tr>
    </table>
    </div>
    <div class="span9">
    <table class="table table-striped table-bordered">
    	<tr>
    		<td>假別</td>
    		<td>
	    		<select name="abs">
	    			<option value="1">重大傷病住院</option>
	    			<option value="3" selected>病假</option>
	    			<option value="4">事假</option>
	    			<option value="7">喪假</option>
	    			<option value="8">婚假</option>
	    			<option value="9">產假</option>
	    		</select>    		
    		</td>
    	</tr>
    	<tr>
    		<td>事由</td>
    		<td><input class="span5" name="reason" type="text" placeholder="非必要欄位,可容納32個字"/></td>
    	</tr>
    	<tr>
    		<td>備註</td>
    		<td><textarea class="span5" name="note" placeholder="非必要欄位,可容納64個字"></textarea></td>
    	</tr>
    	<tr>
    		<td>附件</td>
    		<td>
    		
    		<div class="fileupload fileupload-new" data-provides="fileupload" style="float:left;">    		    
			<div class="input-append">			
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
    		<td colspan="2"><input type="submit" id="login" name="method:addDilg" value="完成假單" class="btn btn-danger"/></td>
    	</tr>
    </table>
    </div>
    </div>
    </div>


</form>

</body>
</html>