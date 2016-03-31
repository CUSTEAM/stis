<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script>
$(document).ready(function() {		
	$(".collapse").collapse("toggle");
	
});
</script>





<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">  	
  	
  	<div class="panel panel-primary">
	    <div class="panel-heading" role="tab" id="headingH">
	      <h4 class="panel-title">
	        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseH" aria-expanded="true" aria-controls="collapseH">
			本程式說明
	        </a>
	      </h4>
	    </div>
		<div id="collapseH" class="panel-collapse collapse" role="tabpaneH" aria-labelledby="headingH">
			
			<ul class="list-group">
			<li class="list-group-item"><span class="label label-as-badge label-warning">1</span> 跨日/夜間修課請點選日/夜間課表查詢, 或直接以課程名稱查詢</li>
			<li class="list-group-item"><span class="label label-as-badge label-warning">2</span> 管制加/退選的規則是由各系或各部制權責單位設定, 程式按照其設定提供同學進行選課</li>
			<li class="list-group-item"><span class="label label-as-badge label-danger">3</span> 選課後的篩選工作由各部制權責單位決定是否進行, 若該單位決定採用第1階段選課, 表示該單位將執行人數過多的課程篩選</li>
			</ul>
			
	    </div>
  	</div>
  	
  	
  	
  	<div class="panel panel-primary">
	    <div class="panel-heading" role="tab" id="headingOne">
	      <h4 class="panel-title">
	        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
			課程名稱加選
	        </a>
	      </h4>
	    </div>
		<div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
			<div class="panel-body">
			<div class="input-group">
      			<div class="input-group-addon">課程名稱</div>
				<input class="form-control" id="cs" style="width:300px;"
				placeholder="輸入課程名稱片段如: 國, 國文, 國文一" name="cs" autocomplete="off" type="text" />
			<span class="input-group-btn">"
			<a id="a" class="btn btn-default" href="#stdInfo" data-toggle="modal" onClick="checkOutByName($('#cs').val())">尋找課程</a>
			</span>
			</div>
			</div>
	    </div>
  	</div>
  
  
	<div class="panel panel-primary">
	    <div class="panel-heading" role="tab" id="heading1">
	      <h4 class="panel-title">
	        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse1" aria-expanded="true" aria-controls="collapse1">
			依日間部排課時間表加選
	        </a>
	      </h4>
	    </div>
		<div id="collapse1" class="panel-collapse collapse <c:if test="${myClass[0].begin>10}">in</c:if>" role="tabpanel" aria-labelledby="heading1">
			<div class="panel-body">
			<table class="table table-bordered" style="margin:-1px;">
				<tr>
					<td></td>	
					<td width="14%" align="center">星期一</td>
					<td width="14%" align="center">星期二</td>
					<td width="14%" align="center">星期三</td>
					<td width="14%" align="center">星期四</td>
					<td width="14%" align="center">星期五</td>
					<td width="14%" align="center">星期六</td>
					<td width="14%" align="center">星期日</td>
				</tr>	
				<c:forEach begin="1" end="10" var="c">	
				<tr height="100">
					<td>${c}</td>		
					<c:forEach begin="1" end="7" var="w">		
					<td style="font-size:14px;" valign="middle" >
					<a id="a${w}${c}" class="close" href="#stdInfo" data-toggle="modal" onClick="checkOut(${w}, ${c}, null)">加選</a>
					<c:forEach items="${myClass}" var="a">			
						<c:if test="${a.week==w && (c>=a.begin && c<=a.end)}">						
						<c:if test="${a.nonSeld==1||(a.ClassNo == schedule.ClassNo && a.opt =='必')}"><button type="button" id="d${w}${c}" class="close" onClick="alert('依課務單位或系所規定, 此課程不可採用網路退選, 請至各部制課務單位辦理');">管制退選</button></c:if>
						<c:if test="${a.nonSeld==0 && !(a.ClassNo == schedule.ClassNo && a.opt=='必')}"><button type="submit" id="d${w}${c}" class="close" name="method:del" onClick="$('#Dtime_oid').val('${a.dtOid}')">退選</button></c:if>
						<script>$("#a${w}${c}").hide();</script>		
						<div>
						<small>${a.ClassName}</small><br>
						<span class="label label-as-badge <c:if test="${a.opt eq'必'}">label-danger</c:if><c:if test="${a.opt eq'選'}">label-info</c:if><c:if test="${a.opt eq'通'}">label-success</c:if>">${a.opt}</span> ${a.chi_name}
						<br>${a.credit}學分,${a.thour}時數<br>${a.cname}老師<br>${a.place}教室</div>			
						</c:if>			
					</c:forEach>
					</td>		
					</c:forEach>
				</tr>
				</c:forEach>
			</table>
			</div>
	    </div>
  	</div>
  	
  	
  	<div class="panel panel-primary">
	    <div class="panel-heading" role="tab" id="heading2">
	      <h4 class="panel-title">
	        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse2" aria-expanded="true" aria-controls="collapse2">
			依夜間部排課時間表加選
	        </a>
	      </h4>
	    </div>
		<div id="collapse2" class="panel-collapse collapse <c:if test="${myClass[0].begin<=10}">in</c:if>" role="tabpane2" aria-labelledby="heading2">
			<div class="panel-body">
			<table class="table table-bordered" style="margin:-1px;">
				<tr>
					<td></td>	
					<td width="14%" align="center">星期一</td>
					<td width="14%" align="center">星期二</td>
					<td width="14%" align="center">星期三</td>
					<td width="14%" align="center">星期四</td>
					<td width="14%" align="center">星期五</td>
					<td width="14%" align="center">星期六</td>
					<td width="14%" align="center">星期日</td>
				</tr>	
				<c:forEach begin="11" end="14" var="c">	
				<tr height="100">
					<td>${c}</td>		
					<c:forEach begin="1" end="7" var="w">		
					<td style="font-size:14px;" valign="middle" >
					<a id="a${w}${c}" class="close" href="#stdInfo" data-toggle="modal" onClick="checkOut(${w}, ${c}, null)">加選</a>
					<c:forEach items="${myClass}" var="a">
						<c:if test="${a.week==w && (c>=a.begin && c<=a.end)}">
						<c:if test="${a.nonSeld==1||(a.ClassNo == schedule.ClassNo && a.opt =='必')}"><button type="button" id="d${w}${c}" class="close" onClick="alert('依課務單位或系所規定, 此課程不可採用網路退選, 請至各部制課務單位辦理');">管制退選</button></c:if>
						<c:if test="${a.nonSeld==0 && a.ClassNo != schedule.ClassNo}"><button type="submit" id="d${w}${c}" class="close" name="method:del" onClick="$('#Dtime_oid').val('${a.dtOid}')">退選</button></c:if>
						<script>$("#a${w}${c}").hide();</script>		
						<div>
						<small>${a.ClassName}</small><br>
						<span class="label label-as-badge <c:if test="${a.opt eq'必'}">label-danger</c:if><c:if test="${a.opt eq'選'}">label-info</c:if><c:if test="${a.opt eq'通'}">label-success</c:if>">${a.opt}</span> ${a.chi_name}
						<br>${a.credit}學分,${a.thour}時數<br>${a.cname}老師<br>${a.place}教室</div>			
						</c:if>			
					</c:forEach>
					</td>		
					</c:forEach>
				</tr>
				</c:forEach>
			</table>
			</div>
	    </div>
  	</div>  	
</div>
<input type="hidden" name="Dtime_oid" id="Dtime_oid">
<script>
function checkOut(week, begin){	
	$.get("getCourse?term=${schedule.term}&level=${schedule.level}&week="+week+"&begin="+begin+"&a"+Math.floor(Math.random()*999),
		function(d){		
			write(d, week, begin, null);
		}, "json");	
}

function checkOutByName(cs){	
	$.get("getCourseByName?term=${schedule.term}&level=${schedule.level}&cs="+cs+"&a"+Math.floor(Math.random()*999),
		function(d){			
			write(d, null, null, cs);
		}, "json");	
}

function write(d, week, begin, cs){	
	var str;
	var ele;
	str="";		
	$("#info").html("");
	if(d.result.length>0){
		
		str=str+"<table class='table table-bordered'>";
		str=str+"<tr><td>編號</td><td>開課班級</td><td>課程名稱</td><td>教師</td><td nowrap>選別</td><td nowrap>學分</td><td nowrap>時數</td><td nowrap>已選</td><td nowrap>型態</td>";
		if(cs!=null){str+="<td>時間</td>";}
		str+="<td></td></tr>";
		
		for(i=0; i<d.result.length; i++){
			ele="";
			nonSeld="";
			if(d.result[i].nonSeld==1)nonSeld="管制退選<br>";
			if(d.result[i].elearning==1)ele="遠距";
			if(d.result[i].elearning==2)ele="輔助";
			if(d.result[i].elearning==3)ele="多媒體";
			str+="<tr><td>"+d.result[i].Oid+
			"</td><td nowrap><small>"+d.result[i].ClassName+
			"</small></td><td>"+d.result[i].chi_name+" <br><small><a href='/CIS/Print/teacher/SylDoc.do?Oid="+d.result[i].Oid+"'>大綱</a>"+" <a href='/CIS/Print/teacher/IntorDoc.do?Oid="+d.result[i].Oid+"'>簡介</a></small>"+
			"</td><td nowrap>"+d.result[i].cname+
			"</td><td nowrap>"+d.result[i].optName+
			"</td><td nowrap>"+d.result[i].credit+
			"</td><td>"+d.result[i].thour+
			"</td><td nowrap>"+d.result[i].seled+"/"+d.result[i].Select_Limit+
			"</td><td nowrap><small>"+nonSeld+ele+"</small></td>";
			
			
			if(cs!=null){str+="<td nowrap><small>週"+d.result[i].week+","+d.result[i].begin+"~"+d.result[i].end+"</small></td>";}
			str+="<td nowrap><button name='method:add' class='btn btn-small btn-danger' onClick='$(\"#Dtime_oid\").val(\""+d.result[i].Oid+"\")'>加選</button></td></tr>";
		}
		str+="</table>";
	}else{
		if(cs==null){
			str="週"+week+"第"+begin+"節無適合課程";
		}else{
			str="沒有符合您的"+str+"課程"
		}		
	}
	if(cs==null){
		$("#title").text("週"+week+"第"+begin+"節");
	}else{
		$("#title").text(cs+"查詢結果");
	}	
	$("#info").append(str);
}

</script>