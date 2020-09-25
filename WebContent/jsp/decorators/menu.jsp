<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>$(function(){$('[data-submenu]').submenupicker();});</script>
<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="navbar-header">
			<button class="navbar-toggle" type="button" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/stis/MyCalendar">中華科技大學</a>
		</div>						
			<c:if test="${!empty userid}">
			<div class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
					<li class="dropdown">
					<a tabindex="0" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" data-submenu>學生資訊系統 <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="/stis/MyCalendar"><i class="icon-home" style="margin-top: 3px;"></i> 課表與課程資訊</a></li>
							<li class="divider"></li>										
							<li><a href="/stis/MyDilgAdd">線上請假</a></li>
							<li><a href="/stis/MyDilgDetail">課程缺課列表</a></li>							
							<li role="separator" class="divider"></li>
							<li class="dropdown"><a href="/stis/Elective"><i class="icon-book" styl與e="margin-top: 3px;"></i> 網路選課</a></li>
							<li><a href="/stis/MyScoreHist">成績與畢業門檻</a></li>
							
							<li class="dropdown"><a href="/pis/PubCsSearch">課程與教師留校時間</a></li>
							<li class="divider"></li>							
							<li class="dropdown-submenu">
							<a><i class="icon-calendar" style="margin-top: 5px;"></i> 其他功能</a>
								<ul class="dropdown-menu">
									<li class="dropdown"><a href="/stis/StdInfoEditor">學籍卡更新</a></li>
									<li class="dropdown"><a href="/CIS/Student/MyCsGroup.do">跨領域學程查詢</a></li>
									<!-- li><a href="/CIS/Student/MyOnlineServices4Reg.do">線上文件申請</a></li>
									
									<li><a href="/CIS/Student/AssessPaperReply.do">服務滿意度調查</a></li>									
									<li><a href="/CIS/Student/Documentation.do">學生手冊</a></li>
									<li class="dropdown"><a href="/CIS/Student/PhoneAndAddress.do">個人聯絡資料</a></li-->
									<!--li><a href="http://ap26.cust.edu.tw/ACIS">線上考試</a></li-->
									<li class="dropdown"><a href="/CIS/Individual/ChangePassword.do">更改密碼</a></li>
									<li class="dropdown"><a href="/stis/StdReaction">意見反映</a></li>	
								</ul>
							</li>
						</ul>
					</li>		
				</ul>				
				<ul class="nav navbar-nav navbar-right">
					<li><a href="/stis/ExamReg">語言中心考試報名</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">學習歷程檔案 <b class="caret"></b></a>
						<ul class="dropdown-menu">					
							<!-- li class="dropdown"><a href="/CIS/Portfolio/UcanLogin.do">UCAN職能平台</a></li-->
							<li class="dropdown"><a href="/CIS/Portfolio/SiteManager.do">網站管理</a></li>
							<li class="dropdown"><a href="/CIS/Portfolio/PageManager.do">文章管理</a></li>
							<li class="dropdown"><a href="/CIS/Portfolio/EPortfolioManager.do">學習歷程管理</a></li>
							<!--li class="dropdown"><a href="/CIS/Portfolio/DownloadPortfolio">我的電子履歷</a></li>
							<li class="dropdown"><a href="/CIS/Portfolio/EditVitae.do">編輯履歷表</a></li-->
							<li class="dropdown"><a href="/stis/ResumeManager">編輯履歷表</a></li>							
							<li class="dropdown"><a href="/CIS/Portfolio/REDirectory.do">數位歷程首頁</a></li>
							<li class="dropdown"><a href="/CIS/Portfolio/Joinparty.do">競賽報名</a></li>
							<li class="dropdown"><a href="/CIS/Portfolio/ListMyTeachers.do">任課教師列表</a></li>	
						</ul>
					</li>							
					<li id="xLogout" class="divider-vertical"></li>			
					<li id="xLogout"><a href="/stis/Logout">登出</a></li>
				</ul>
			</div>
			</c:if>			
		</div>
	
</nav>