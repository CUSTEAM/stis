<%@ page session="false" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<title>中華科技大學</title>

<script src="/eis/inc/js/plugin/jquery.cookie.js"></script>
<!--script src="http://maps.google.com/maps/api/js?sensor=true"></script-->
<!--script src="https://www.google.com/jsapi"></script-->
<!--script src="/eis/inc/js/plugin/hello.min.js"></script-->
<script>

$(document).ready(function () {	  	
  	//記住帳號
    $('#remember').change(function(){
        this.checked ? 
        $.cookie("loginusername",$("#username").val(), {expires:999, path: "/"}) : 
        $.removeCookie('loginusername', { path:'/' });
    });
    
});

$.get("/tis/Logout", null, null);
$.get("/stis/Logout", null, null);
$.get("/CIS/Logout.do", null, null);
$.get("/eis/Logout", null, null);
$.get("/sais/Logout", null, null);
$.get("/sris/Logout", null, null);
$.get("/eis/Logout", null, null);
$.get("/csis/Logout", null, null);

$.getJSON('http://gd.geobytes.com/GetCityDetails?callback=?', function(d){
	//ipin=JSON.stringify(d, null, 2);	
	$("#remote").val(d.geobytesremoteip);
	$("#real").val(d.geobytesipaddress);
}).error(function(){ 
	$("#remote").val("error");
	$("#real").val("error");
})
</script>
</head>
<body>

<div class="container">
	<div class="row">
		<div class=".col-md-3 .col-md-offset-4">
		  <div class="page-header">
  <h1>中華科技大學 <small>資訊系統</small></h1>
</div>
		</div>		
	</div>
    <div class="row">
    
        <div class="col-md-4">
        
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">登入</h3>
                </div>
                <div class="panel-body">
                    <form role="form" action="ap.cust.edu.tw/stis/TalkLogin" method="post" class="form-signin">
                        <fieldset>
                            <div class="form-group">
                                <input class="form-control" placeholder="學號或教職員帳號" name="username" id="username" autofocus>
                            </div>
                            <div class="form-group">
                                <input class="form-control" placeholder="密碼" name="password" type="password" >
                            </div>
                            <div class="checkbox">
                                <label>
                                	<input type="checkbox" <c:if test="${cookie['loginusername'].value!=null}">checked</c:if> id="remember" value="remember">記住帳號
                                </label>
                            </div>
                            <!-- Change this to a button or input when using this as a form -->
                  
                            <input type="submit" id="login" name="method:login" value="登入" class="btn btn-danger"/>
                            <a href="ReSetPassword">忘記密碼</a>
                        </fieldset>
                        <input type="hidden" name="remoteaddress" id="remote"/>
                        <input type="hidden" name="ipaddress" id="real"/>
                    </form>
                </div>
            </div>
        </div>
        
        
        <div class="col-md-4">
        <h2>學生登入方式</h2>
			<p>帳號為同學的學號</p>
			<p>密碼預設為同學的身分證字號</p>
			<p>當顯示無此帳號時，請檢查輸入的資料是否正確，英文字母不區分大小寫</p>
			<p>若仍顯示無此帳號時，請洽教務單位確認學籍資料</p>
        </div>
        <div class="col-md-4">
        <h2>教職員登入方式</h2>
			<p>帳號預設為同仁身分證號，可在登入後立即修改帳號</p>
			<p>密碼預設為同仁生日，例如生日為88年8月18日，密碼即為880818</p>
			<p>當顯示無此帳號時，請檢查輸入的資料是否正確，英文字母不區分大小寫</p>
			<p>若仍顯示無此帳號時，請洽人事單位確認人事資料</p>
        </div>
    </div>
</div>

<!--script>
$.getJSON("http://192.192.230.35/services/pub/GetIp?callback=?", function (data) {
    //alert("Your ip: " + data.ip+", mac: "+data.mac);
    $("#ip").val(data.ip);
    $("#mac").val(data.mac);
});
</script-->
</body>
</html>