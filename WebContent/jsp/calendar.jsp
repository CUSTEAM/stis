<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<script>
function addAbs(ddate, oid){	
	//alert(getCookie(ddate));
	if(getCookie(ddate)==null){
		setCookie(ddate, oid, true, "/", null, null);
	}else{
		deleteCookie(ddate, "/", null );
	}	
}

//取cookie
function getCookie(name) {
    var start = document.cookie.indexOf( name + "=" );
    var len = start + name.length + 1;
    if ( ( !start ) && ( name != document.cookie.substring( 0, name.length ) ) ) {
        return null;
    }
    if ( start == -1 ) return null;
    var end = document.cookie.indexOf( ';', len );
    if ( end == -1 ) end = document.cookie.length;
    return unescape( document.cookie.substring( len, end ) );
}

//存
function setCookie(name, value, expires, path, domain, secure) {
	//alert(name+"="+value);
    var today = new Date();
    today.setTime(today.getTime());
    if (expires){
        expires=expires*1000*60*60; //預設1小時吧
    }
    var expires_date = new Date( today.getTime() + (expires) );    
    //採用escape 對ISO Latin對指定的字串編碼。所有的空格、標點符號、特殊文字以及其他非ASCII字串都將被轉化成%xx格式的字串編碼
    document.cookie = name+'='+escape( value ) +
    //document.cookie = name+'='+value+
    ((expires) ? ';expires='+expires_date.toUTCString() : '' ) + //expires.toGMTString()
    ((path) ? ';path=' + path : '' ) +
    ((domain) ? ';domain=' + domain : '' ) +
    ((secure) ? ';secure' : '' )+
    (';comment=shit')+
    (';version=1');
    
}
 
function deleteCookie( name, path, domain ) {
    if ( getCookie( name ) ) document.cookie = name + '=' +
            ( ( path ) ? ';path=' + path : '') +
            ( ( domain ) ? ';domain=' + domain : '' ) +
            ';expires=Thu, 01-Jan-1970 00:00:01 GMT';
}

function listCookie(){
	
	var strCookie=document.cookie; 
	var arrCookie=strCookie.split("; "); 
	var date, abs, dot;
	for(var i=0;i<arrCookie.length;i++){ 
		
		dot=arrCookie[i].indexOf(",")
		abs=arrCookie[i].substring(dot+1, dot+2);
		date=arrCookie[i].substring(0,dot);
		
		if(date.search("-")>0){
			document.getElementById("abshit").innerHTML=document.getElementById("abshit").innerHTML+
			"<input type='text' name='ddate' value='"+date+"'/>"+
			"<input type='text' name='abs' value='"+abs+"'/><br>";
		}		
		//document.getElementById('loadMsg').style.width=document.body.scrollWidth+1024;
		document.getElementById('loadMsg').style.height=document.body.scrollHeight+8192;
		document.getElementById('loadMsg').style.display="inline";	
	} 	
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



	<div style="padding:5px;">
	
		
		<div class="btn-group">
			<a class="btn" href="/csis/TimeTable?student_no=${userid}">我的課表</a>
			<a class="btn" href="MyCalendar?weekday=${weekday[0]}">上週</a> 
			<a class="btn" href="MyCalendar">本週</a> 
			<a class="btn" href="MyCalendar?weekday=${weekday[8]}">下週</a>
		</div>
		<!--div class="btn-group">
		<a class="btn" href="MyDilgDetail">缺課列表</a>
		<a class="btn" href="MyDilgList">假單列表</a>
		</div-->
		
		
		<a class="btn btn-danger" href="MyDilg">填寫假單</a>		
		<button id="funbtn" rel="popover" data-content="課表畫面提供簡易請假功能,勾選節次後按下「填寫假單」可跨週多選並預先請假,全部缺曠請點選「缺席與請假」顯示完整缺曠記錄" data-placement="right" type="button" class="btn">?</button>
		
	</div>	
	

	<table class="table table-bordered table table-striped">
		<tr>
			<td></td>
			<td width="14%" nowrap>${viewday[1]} 星期一</td>
			<td width="14%" nowrap>${viewday[2]} 星期二</td>
			<td width="14%" nowrap>${viewday[3]} 星期三</td>
			<td width="14%" nowrap>${viewday[4]} 星期四</td>
			<td width="14%" nowrap>${viewday[5]} 星期五</td>
			<td width="14%" nowrap>${viewday[6]} 星期六</td>
			<td width="14%" nowrap>${viewday[7]} 星期日</td>
		</tr>
		<c:set var="beginClass" value="1"/>
		<c:if test="${allClass[0].begin>=10}"><c:set var="beginClass" value="11"/></c:if>
		<c:forEach begin="${beginClass}" end="14" var="c">
		<tr height="75">
		<td class="hairLineTdF">${c}</td>		
		<c:forEach begin="1" end="7" var="w">		
		<td class="hairLineTdF" style="font-size:14px;" valign="middle">		
		<fmt:parseDate var="setNow" value="${weekday[w]}" type="DATE" pattern="yyyy-MM-dd"/>
		<fmt:parseDate var="begin" value="${school_term_begin}" type="DATE" pattern="yyyy-MM-dd"/>
		<fmt:parseDate var="end" value="${school_term_end}" type="DATE" pattern="yyyy-MM-dd"/>
		
		
		
		
		<c:if test="${setNow.getTime()>=begin.getTime()&&setNow.getTime()<=end.getTime()}">		
			<c:forEach items="${allClass}" var="ac">				
			<c:if test="${ac.week==w && (c>=ac.begin && c<=ac.end)}">			
			<div id="a${w}${c}" style="cursor:pointer; width:100%;">
			${ac.chi_name}<br>
			<a href="/CIS/Print/teacher/SylDoc.do?Oid=${ac.dOid}">大綱</a>-<a href="/CIS/Print/teacher/IntorDoc.do?Oid=${ac.dOid}">簡介</a>-<a href="/stis/MyScoreHist">成績</a>
			<br>${ac.cname}老師<br>${ac.place}教室<br>			
			<c:set var="chk" value="false" />			
			<c:forEach items="${abs}" var="a">											
				<c:if test="${a.date==weekday[w]&&a.cls==c}">
				<c:set var="chk" value="true" />					
				<c:if test="${a.abs=='1'}"><span class="label label-success">重大傷病</span></c:if>					
				<c:if test="${a.abs=='3'}"><span class="label label-success">病假</span></c:if>	
				<c:if test="${a.abs=='4'}"><span class="label label-success">事假</span></c:if>	
				<c:if test="${a.abs=='5'}"><span class="label label-warning">遲到</span></c:if>	
				<c:if test="${a.abs=='6'}"><span class="label label-success">公假</span></c:if>	
				<c:if test="${a.abs=='7'}"><span class="label label-success">喪假</span></c:if>	
				<c:if test="${a.abs=='8'}"><span class="label label-success">婚假</span></c:if>	
				<c:if test="${a.abs=='9'}"><span class="label label-success">產假</span></c:if>				
				<c:if test="${a.result==null&& a.abs ne 2 && a.abs ne 5}"><span class="label label-warning">審核中</span></c:if>
				<c:if test="${a.result eq '1'}"><span class="label label-info">已核准</span></c:if>
				<c:if test="${a.result eq '2'}"><span class="label label-inverse">請假未核准</span></c:if>				
				<c:if test="${a.abs=='2'}">
				<span class="label label-important">缺課</span>					
				<label class="checkbox inline">
				
				<c:if test="${setNow.getTime()<=date_rollcall_end.getTime()}">
					<c:if test="${((now.getTime()-setNow.getTime())<777600000)}">			
					<script>
					if(getCookie("${weekday[w]}"+"&"+"${c}")!=null){
						document.write("<input type=checkBox checked  onClick=\"addAbs('${weekday[w]}&${c}', '${ac.dOid}');\" /> 請假");
					}else{
						document.write("<input type=checkBox onClick=\"addAbs('${weekday[w]}&${c}', '${ac.dOid}');\" /> 請假");
					}
					</script>
					</c:if>
				</c:if>
				
				</label>					
				</c:if>	
				</c:if>				
			</c:forEach>
			<c:if test="${setNow.getTime()<=date_rollcall_end.getTime()}">
				<c:if test="${now<=setNow &&chk eq false}">
				<label class="checkbox inline">
				<script>
				if(getCookie("${weekday[w]}"+"&"+"${c}")!=null){
					document.write("<input type=checkBox checked  onClick=\"addAbs('${weekday[w]}&${c}', '${ac.dOid}');\" /> 請假");
				}else{
					document.write("<input type=checkBox onClick=\"addAbs('${weekday[w]}&${c}', '${ac.dOid}');\" /> 請假");
				}
				</script>
				</label>
				</c:if>	
			</c:if>
			</div>			
			</c:if>			
			</c:forEach>
		</c:if>
		</td>		
		</c:forEach>
	</tr>
	</c:forEach>
</table>

</body>
</html>