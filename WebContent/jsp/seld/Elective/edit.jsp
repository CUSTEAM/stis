<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="accordion" id="accordion2">	
	<div class="accordion-group">
		<div class="accordion-heading">
		<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse">課程名稱加選</a>
		</div>
		<div id="collapse" class="accordion-body collapse">
			<div class="accordion-inner">
			<div class="input-prepend control-group input-append">
				<span class="add-on">課程名稱</span>
				<input class="span6" id="cs" placeholder="輸入課程名稱片段如: 國, 國文, 國文一" name="cs" autocomplete="off" type="text" />
				<a id="a" class="btn" href="#stdInfo" data-toggle="modal" onClick="checkOutByName($('#cs').val())">尋找課程</a>
			</div>
			</div>
		</div>
	</div>

	<div class="accordion-group">
		<div class="accordion-heading">
		<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">日間課程加退選</a>
		</div>
		<div id="collapseOne" class="accordion-body collapse <c:if test="${myClass[0].begin<=10}">in</c:if>">
			<div class="accordion-inner" style="padding:0px;">		
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
						<c:if test="${a.nonSeld==0 && a.ClassNo != schedule.ClassNo}"><button type="submit" id="d${w}${c}" class="close" name="method:del" onClick="$('#Dtime_oid').val('${a.dtOid}')">退選</button></c:if>
						<script>$("#a${w}${c}").hide();</script>		
						<div>
						<small>${a.ClassName}</small><br>
						<span class="label <c:if test="${a.opt eq'必'}">label-important</c:if><c:if test="${a.opt eq'選'}">label-info</c:if><c:if test="${a.opt eq'通'}">label-success</c:if>">${a.opt}</span> ${a.chi_name}
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
		
	<div class="accordion-group">
		<div class="accordion-heading">
		<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo">夜間課程加退選</a>
		</div>
		<div id="collapseTwo" class="accordion-body collapse <c:if test="${myClass[0].begin>=11}">in</c:if>">
		
			<div class="accordion-inner" style="padding:0px;">		
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
						<span class="label <c:if test="${a.opt eq'必'}">label-important</c:if><c:if test="${a.opt eq'選'}">label-info</c:if><c:if test="${a.opt eq'通'}">label-success</c:if>">${a.opt}</span> ${a.chi_name}
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
<div class="alert alert-info">
<button type="button" class="close" data-dismiss="alert">&times;</button>
<strong>說明</strong> 預設課表參考目前已選課時段固定顯示，跨日、夜間修課請點選日間課程或夜間課程
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
		str=str+"<tr><td>編號</td><td>開課班級</td><td>課程名稱</td><td>教師</td><td nowrap>選別</td><td nowrap>學分</td><td nowrap>時數</td><td nowrap>已選/上限</td><td nowrap>型態</td>";
		if(cs!=null){str+="<td>時間</td>";}
		str+="<td></td></tr>";
		
		for(i=0; i<d.result.length; i++){
			ele="";
			nonSeld="";
			if(d.result[i].nonSeld==1)nonSeld="管制退選";
			if(d.result[i].elearning==1)ele="遠距";
			if(d.result[i].elearning==2)ele="輔助";
			if(d.result[i].elearning==3)ele="多媒體";
			str+="<tr><td>"+d.result[i].Oid+
			"</td><td nowrap><small>"+d.result[i].ClassName+
			"</small></td><td>"+d.result[i].chi_name+" <small><a href='/CIS/Print/teacher/SylDoc.do?Oid="+d.result[i].Oid+"'>大綱</a>"+" <a href='/CIS/Print/teacher/IntorDoc.do?Oid="+d.result[i].Oid+"'>簡介</a></small>"+
			"</td><td nowrap>"+d.result[i].cname+
			"</td><td nowrap>"+d.result[i].optName+
			"</td><td nowrap>"+d.result[i].credit+
			"</td><td>"+d.result[i].thour+
			"</td><td nowrap>"+d.result[i].seled+"/"+d.result[i].Select_Limit+
			"</td><td nowrap>"+ele+nonSeld+"</td>";
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