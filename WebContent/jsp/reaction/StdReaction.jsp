<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>意見反應</title>
<script src="http://192.192.230.167/CIS/inc/js/plugin/ckeditor/ckeditor.js"></script>
<link href="/eis/inc/bootstrap/plugin/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet">
<script src="/eis/inc/bootstrap/plugin/bootstrap-fileinput/js/fileinput.min.js"></script>
<script src="/eis/inc/bootstrap/plugin/bootstrap-fileinput/js/fileinput_locale_zh-TW.js"></script>
<script src="/eis/inc/js/plugin/jquery.chained.min.js"></script>
<link href="/eis/inc/css/wizard-step.css" rel="stylesheet"/>
</head>
<body>  
<div class="bs-callout bs-callout-info">
<h4>意見反應</h4>
</div>
<form action="StdReaction" method="post" enctype="multipart/form-data">




<c:if test="${!empty myReaction}">
<div class="panel panel-primary">
	<div class="panel-heading">意見反應列表</div>
<table class="table">
	<tr>
		
		<th></th>
		<th>意見反應主題</th>
		<th nowrap>申請</th>
		<th nowrap>回覆</th>
	</tr>
	<c:forEach items="${myReaction}" var="a">
	<tr>
		<td width="1" nowrap>
		<c:if test="${empty a.edate}"><small><span class="label label-danger">未回覆</span></small></c:if>
		<c:if test="${!empty a.edate}"><small><span class="label label-default">已回覆</span></small></c:if>		
		</td>
		<td>
		<a href="#taskAppInfo" onClick="getTaskHist(${a.Oid});" data-toggle="modal">${a.title}</a>
		</td>
		<td width="100" nowrap>${fn:substring(a.sdate, 5, 10)}</td>
		<td width="100" nowrap>${fn:substring(a.edate, 5, 10)}</td>
	</tr>
	</c:forEach>
</table>
</div>

<!-- Modal -->
<div class="modal fade" id="taskAppInfo">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			  <h4 class="modal-title" id="modelTitle"></h4>
			</div>
			<div class="modal-body" id="appInfo">
			  <p>Loading..</p>
			</div>
			<div class="modal-footer">
			  <button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
			  
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</c:if>
<script>
function getTaskHist(Oid){
	//var files;
	$.ajax({
		  url: "/eis/getTaskInfo",
		  type: "get", //send it through get method
		  data:{ 		    
		    taskOid: Oid, 		    
		  },
		  success: function(data) {
			  d=data.list[0];
			  $("#modelTitle").text("# "+d.Oid+d.title);
			  /*if(d.edate!=null){
				  $("#modelTitle").text(d.cname+", 於 "+d.edate+"回覆");
				  $("#modelTitle").text("# "+d.Oid+d.title+" 已於 "+d.edate+"回覆");
			  }else{
				  $("#modelTitle").text(d.cname+", 處理中");
				  $("#modelTitle").text("# "+d.Oid+d.title+" 處理中");
			  }*/
			  
			  info="<blockquote><footer>"+d.sdate+"<cite title='Source Title'>"+d.TaskNote+"</cite></footer></blockquote>"
			  
			  info+="<p>";
			  if(d.files!=null){
				  info+="<div class='btn-group' role='group'>"
				  for(i=0; i<d.files.length; i++){
					  if(d.files[i]!=null){
						  info+="<a href='/eis/getFtpFile?path="+d.files[i].path+"&file="+d.files[i].file_name+"' class='btn btn-sm btn-default'>附件"+(i+1)+"</a>";
					  }					  
				  }	
				  info+="</div>"
			  }			  
			  info+="</p>";
			  $("#appInfo").html(info);	
			  if(d.edate!=null){
				  $("#appInfo").append("<blockquote><p>"+d.unitName+", "+d.cname+"於 "+d.edate+"回覆</p>"+d.feedback+"</footer></blockquote>");	
				  info="<p>";
				  if(d.bFiles!=null){
					  info+="&nbsp;<div class='btn-group' role='group'>"
					  for(i=0; i<d.bFiles.length; i++){
						  if(d.bFiles[i]!=null){
							  info+="<a href='/eis/getFtpFile?path="+d.bFiles[i].path+"&file="+d.bFiles[i].file_name+"' class='btn btn-sm btn-primary'>回件"+(i+1)+"</a>";
						  }					  
					  }	
					  info+="</div>"
				  }
				  info+="</p>";
				  $("#appInfo").append(info);	
				  
			  }else{
				  $("#appInfo").append("<blockquote><footer>處理中</footer> </blockquote>");	
			  }
			  
		  },
		  error: function(xhr) {
		    //Do Something to handle error
		  }
	});
}
</script>
<div class="panel panel-primary">
	<div class="panel-heading">建立意見反應</div>
<table class="table">
	<tr>
		<td>
		<p>
		<div class="input-group">
		<span class="input-group-addon">意見反應主題</span>
		<input class="form-control" type="text" name="title"/>
		</div>
		</p>
		<textarea name="note" id="note" rows='1'/></textarea>
		</td>
	</tr>
	<tr>
		<td>
		<div class="input-group">
		<span class="input-group-addon">回覆電子信箱</span>
		<input class="form-control" type="text" name="email" value="${Email}"/>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<label>附件</label>
		<small>點選「瀏覽檔案」後按住Ctrl鍵可選擇多個檔案</small>
		<input id="upload" name="fileUpload" multiple type="file" class="file-loading">
		</td>
	</tr>
	<tr>
		<td>
		<button onClick="javascript: return(confirm('送出後將同步通知院級、單位, 請再確認您輸入的內容')); void('')" name="method:save" style="width:100%;" class="btn btn-lg btn-danger">儲存並發送</button>
		</td>
	</tr>
</table>
</div>






</form>
<script>

CKEDITOR.replace("note", {
		toolbar: [
			['Bold','Italic','-','NumberedList','BulletedList','-','Link','Unlink' ],
			['FontSize','TextColor','BGColor']
		],height: 'auto'
});

/*CKEDITOR.replace("note",{
    height: '200px'
});*/

$(document).ready(function(){
	
	$("#upload").fileinput({
		//uploadUrl: "#",
		multiple: true,
		uploadAsync: false,
		maxFileCount: 10,
		//previewFileIcon: '<i class="fa fa-file"></i>',
		allowedPreviewTypes: null,
		language: "zh-TW",
		layoutTemplates: {
		    main1: "{preview}\n" +
		    "<div class=\'input-group {class}\'>\n" +
		    "   <div class=\'input-group-btn\'>\n" +
		    "       {browse}\n" +
		    //"       {upload}\n" +
		    "       {remove}\n" +
		    "   </div>\n" +
		    "   {caption}\n" +
		    "</div>"
		}
		//,previewFileType: ["doc", "docx", "xls", "xlsx", "pdf", "jpg", "txt"]
		//,allowedFileExtensions: ["doc", "docx", "xls", "xlsx", "pdf", "jpg", "txt"]
	});
	
	
	
});
</script>
</body>
</html>