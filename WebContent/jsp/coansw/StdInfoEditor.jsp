<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="expires" content="0">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="pragma" content="no-cache"> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


</head>
<body style="padding:20px;">
<form action="StdInfoEditor" method="post" class="form-horizontal">
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">
<!-- >button type="button" class="close" onClick="window.parent.$.unblockUI()">&times;</button-->
<h4><b>學籍資料更新</b></h4> 
<p>本程式依照相關單位辦理調查統計工作，各項題目及選項由相關單位制定。</p>
</div>
<input type="hidden" name="Oid" value="${si.Oid}" />

<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingOne">
      <h4 class="panel-title">
        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
          族群別  (具原住民族籍)
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne" role="button" data-toggle="popover" data-trigger="focus" title="Dismissible popover" data-content="And here's some amazing content. It's very engaging. Right?">
      <div class="panel-body" >
        <div class="form-group col-xs-12 floating-label-form-group controls">
                    <label for="AborigineCode">您的身份</label>
                    <select name="AborigineCode" id="AborigineCode" class="form-control">
						<option value="">無</option>
						<c:forEach items="${CODE_ABORIGINE}" var="d">
							<option <c:if test="${si.AborigineCode eq d.code}">selected</c:if> value="${d.code}">${d.Name}</option>
						</c:forEach>
					</select>
                    <p class="help-block text-danger"></p>
                </div>
                
                
                <div class="form-group col-xs-12 floating-label-form-group controls">
                    <label for="AborigineCode_f">父親的身份</label> 
                    <select name="AborigineCode_f" id="AborigineCode_f" class="form-control">
						<option value="">無</option>
						<c:forEach items="${CODE_ABORIGINE}" var="d">
							<option <c:if test="${si.AborigineCode_f eq d.code}">selected</c:if> value="${d.code}">${d.Name}</option>
						</c:forEach>
					</select>
                    <p class="help-block text-danger"></p>
                </div>
                
                <div class="form-group col-xs-12 floating-label-form-group controls">
                    <label for="AborigineCode_m">母親的身份</label> 
                    <select name="AborigineCode_m" id="AborigineCode_m" class="form-control">
						<option value="">無</option>
						<c:forEach items="${CODE_ABORIGINE}" var="d">
							<option <c:if test="${si.AborigineCode_m eq d.code}">selected</c:if> value="${d.code}">${d.Name}</option>
						</c:forEach>
					</select>
                    <p class="help-block text-danger"></p>
                </div>
                
                
                <p class="help-block text-danger"><button name="method:save" type="submit" class="btn btn-success">儲存</button></p> 
      
      </div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingTwo">
      <h4 class="panel-title">
        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
          	第一代大學生
        </a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingTwo">
      <div class="panel-body">
        <div class="form-group col-xs-12 floating-label-form-group controls">
                    <label for="Education_f">請問您父親(或主要照顧您的男性監護人)的最高學歷是</label> 
                    <select name="Education_f" id="Education_f" class="form-control">						
						<option <c:if test="${si.Education_f eq '1'}">selected</c:if> value="1">小學畢業或沒上過學</option>
						<option <c:if test="${si.Education_f eq '2'}">selected</c:if> value="2">國中畢業</option>
						<option <c:if test="${si.Education_f eq '3'}">selected</c:if> value="3">高中職畢業</option>
						<option <c:if test="${si.Education_f eq '4'}">selected</c:if> value="4">大學或專科畢業</option>
						<option <c:if test="${si.Education_f eq '5'}">selected</c:if> value="5">研究所畢業</option>
						<option <c:if test="${si.Education_f eq '6'}">selected</c:if> value="6">不知道</option>					
					</select>
                    <p class="help-block text-danger"></p>
                </div>
                
               <div class="form-group col-xs-12 floating-label-form-group controls">
                   <label for="Education_m">請問您母親(或主要照顧您的女性監護人)的最高學歷是</label> 
                   <select name="Education_m" id="Education_m" class="form-control">
					<option <c:if test="${si.Education_m eq '1'}">selected</c:if> value="1">小學畢業或沒上過學</option>
						<option <c:if test="${si.Education_m eq '2'}">selected</c:if> value="2">國中畢業</option>
						<option <c:if test="${si.Education_m eq '3'}">selected</c:if> value="3">高中職畢業</option>
						<option <c:if test="${si.Education_m eq '4'}">selected</c:if> value="4">大學或專科畢業</option>
						<option <c:if test="${si.Education_m eq '5'}">selected</c:if> value="5">研究所畢業</option>
						<option <c:if test="${si.Education_m eq '6'}">selected</c:if> value="6">不知道</option>
					</select>
                   <p class="help-block text-danger"></p>
               </div>
               
               <div class="form-group col-xs-12 floating-label-form-group controls">
                   <label for="FirstCollegeStd">是否為家族第一代大學生:家族三代(學生之曾祖父母、祖父母及父母)皆無人上大專</label>
                   <select name="FirstCollegeStd" id="FirstCollegeStd" class="form-control">
					<option <c:if test="${si.FirstCollegeStd eq '0'}">selected</c:if> value="0">否</option>
					<option <c:if test="${si.FirstCollegeStd eq '1'}">selected</c:if> value="1">是</option>
				</select>
                   <p class="help-block text-danger"></p>
               </div>  
               
               <p class="help-block text-danger"><button name="method:save" type="submit" class="btn btn-success">儲存</button></p>      
      </div>
    </div>
  </div>
  <br>
  <button name="method:save" type="submit" class="btn btn-danger">全部儲存</button>
  <!-- div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingThree">
      <h4 class="panel-title">
        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
          Collapsible Group Item #3
        </a>
      </h4>
    </div>
    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
      <div class="panel-body">
        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
      </div>
    </div>
  </div-->
</div>
</form>
</body>
</html>