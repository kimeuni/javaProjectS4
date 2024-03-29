<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!-- 폰트어썸 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script>
<style>
	body{
		margin: 0px;
		padding: 0px;
		padding-top:120px;  
	}
	header {
		position: fixed;
		width: 100%;
		top: 0;
		left: 0;
		z-index: 999;
	}
	.lnb-inner, 
	.gnb-inner {
		transition: .5s;
	}
	.lnb-inner {
		background-color: white;
		height: 40px;
		line-height: 40px;
		/* overflow: hidden; */
	}
	.gnb-inner {
		background-color: white;
		height: 80px;
		line-height: 80px;
	}

	/* Active Class */
	header.act .lnb-inner {
		display : none;
		visibility : hidden;
		height: 0;
	}
	header.act .gnb-inner {
		/* background-color: #523329; */
		background-color: #5E5756;
		color: #fff;
		box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
		border-bottom-color: white;
	}
	header.act #header-search-span input[type="text"]{
		color: #fff;
        border-bottom: 0.7px solid white;
	}
	header.act #gnb-btm-nav-align span a:hover,header.act #header-search-span a:hover{
		color: #fff;
	}
	
	
	
	#header-btm-ul a:hover{
		color: pink;
	}
	#gnb-btm-nav-align span a:hover, #header-search-span a:hover{
		color: #000;
	}
	/* 1번째 nav(주메뉴) */
	#lnb-top-nav-size{
		max-width: 1200px;
		margin: 0 auto;
	}
	.header-top-ul{
		background-color: #fff;
		text-align: right;
	}
	.header-top-ul li {
		background-color: #fff;
		display: inline-block;
		padding: 5px 10px;
		position: relative;
		width: 120px;
		height: 40px;
		text-align: center;
	}
	.header-top-ul li a{
		text-decoration: none;
		color: black;
	}
	/* 1번째 nav(서브메뉴) */
	.header-top-ul li ul{
		display : none;
		position: absolute;
		top: 40px;
		right: 0;
		width: 122px;
		padding: 0px;
		border: 1px solid;
	}
	.header-top-ul li:hover ul{
		display: block;
	}
	.header-top-ul li ul li{
		padding : 0px;
		min-height: 40px;
		min-width: 120px;
	}
	#inner-alarm{
		width: 400px;
		height: 220px;
		overflow: auto;
	}
	#alarm-ul{
		width: 402px;
		height: 222px;
		position: absolute;
		top: 40px;
		right: -135px;
	}
	
	/* 2번째 nav */
	#gnb-btm-nav-size{
		max-width: 1200px;
		margin: 0 auto;
		font-size: 1.3em;
	}
	#gnb-btm-nav-align{
		height : 80px;
		line-height : 80px;
	}
	#header-btm-ul{
		height : 80px;
		display: inline-block;
		padding-left: 25px;
	}
	#header-btm-ul li {
		display: inline-block;
		padding: 0px 10px;
	}
	#header-search-span{
		display: inline-block;
		text-align: right;
		/* margin-left: 220px; */
	}
	#header-search-span input[type="text"]{
		border: none;
        width: 200px;
        height : 40px; 
        background-color: rgba(0,0,0,0);
        padding: 5px 0px;
        margin: 0px 5px;
        font-size : 0.8em;
        font-weight: bolder;
        outline: none;
        border-bottom: 0.7px solid black;
	}
	#gnb-btm-nav-align a {
		text-decoration: none;
	}
	#gub-ul-nav-div{
		display: inline-block;
		width: 780px;
		text-align: left;
	}
	.header-top-ul, .header-top-ul li{
		margin: 0;
	}
	.header-top-ul a{
		text-decoration: inherit;
	}
	#inner-alarm hr{
		margin: 3px 10px;
	}
	.alarm-hover:hover{
		background-color: #eee;
	}
</style>
<script>
	$(window).scroll(function() {
		if($(window).scrollTop() > 25) {
			$('header').addClass('act');
			$("#logo-img").attr("src","${ctp}/data/images/다모아로고2.png")
		} else {
			$('header').removeClass('act');
			$("#logo-img").attr("src","${ctp}/data/images/다모아로고1.png")
		}
	});
	
	function askInputOpen(){
		let url = "${ctp}/ask/askInput";
    	let winName = "1:1 문의하기";
    	let opt = "width=600px, height=850px, top=100px, left=500px " 
    	
   		childWindow = window.open(url,winName,opt)
	}
	
	// 메인 서치
	function mainSearch(){
		let str = $("#searchN").val()
		if(str.trim() == ""){
			alert("검색할 단어를 적어주세요.")
			$("#searchN").focus();
			return false
		}
		else{
			location.href="${ctp}/mainSearch?str="+searchN;
		}
	}
	
	$(function() {
		$("#searchN").on("keydown",function(e){
			if(e.keyCode == 13){
				mainSearch();
			}
		});
	});
</script>
	<header>
		<div class="lnb-inner">
			<div id="lnb-top-nav-size">
				<!-- 비로그인 시 -->
				<c:if test="${sMid == null}">  
					<ul class="header-top-ul">
						<li><a href="${ctp}/member/login">로그인</a></li>
						<li><a href="${ctp}/member/join">회원가입</a></li>
					</ul>
				</c:if>
				<!-- 로그인 시 -->
				<c:if test="${sMid != null}">
					<ul class="header-top-ul">
						<li>
							<i class="fa-solid fa-user"></i>${sNickName}님
							<ul>
								<c:if test="${sMid == 'admin'}"><li><a href="${ctp}/admin/adminMain">관리자메뉴</a></li></c:if>
								<li><a href="${ctp}/member/myPage?flag=myPg">마이페이지</a></li>
								<li><a href="javascript:askInputOpen()">1:1문의</a></li>
								<li><a href="${ctp}/member/logout">로그아웃</a></li>
							</ul>
						</li>
						<li>
							<i class="fa-solid fa-bell"></i>알림
							<ul id="alarm-ul">
								<li id="inner-alarm">
									알림
									<hr/>
									<c:if test="${!empty likeAlarm}">
										<c:forEach var="like" items="${likeAlarm }">
											<c:set var="img" value="${fn:split(like.imgs,'/') }" />
											<div class="alarm-hover">
												<a href="${ctp}/used/usedContent?idx=${like.usedIdx}&flag=alarm">
													<div class="text-left pl-2">내 상품 찜 알림</div>
													<div style="display: flex; font-size: 0.7em; margin: 0px;padding: 0px">
														<div style="display: flex; width: 80%">
															<div>내 <${like.title}> 상품이 ${like.likeCnt}건의 새로운 찜을 받았습니다.</div>
														</div>
														<div style="display: flex; width: 20%; justify-content: center">
															<img src="${ctp}/data/used/${img[0]}" height="50px" width="50px">
														</div>
													</div>
												</a>
											</div>
										</c:forEach>
									</c:if>
									<c:if test="${!empty foAlarm}">
										<c:forEach var="fo" items="${foAlarm }">
											<c:set var="img" value="${fn:split(fo.imgs,'/') }" />
											<div class="alarm-hover">
												<a href="${ctp}/used/usedContent?idx=${fo.usedIdx}&flag=alarm">
													<div class="text-left pl-2">팔로우 중인 유저 상품</div>
													<div style="display: flex; font-size: 0.7em; margin: 0px;padding: 0px">
														<div style="display: flex; width: 80%">
															<div>내가 팔로우중인 <${fo.nickName}>님이 <${fo.title }>상품을 올렸습니다.</div>
														</div>
														<div style="display: flex; width: 20%; justify-content: center">
															<img src="${ctp}/data/used/${img[0]}" height="50px" width="50px">
														</div>
													</div>
												</a>
											</div>
										</c:forEach>
									</c:if>
								</li>
							</ul>
						</li>
						<li>
							<i class="fa-solid fa-cart-shopping"></i>내상점
							<ul>
								<li><a href="${ctp}/used/usedInput">상품 판매</a></li>
								<li><a href="${ctp}/used/usedStore?mid=${sMid}">내상점</a></li>
								<li><a href="${ctp}/used/usedStoreLike?mid=${sMid}">찜목록</a></li>
								<li><a href="${ctp}/used/usedStoreManagement?mid=${sMid}">상점관리</a></li>
							</ul>
						</li>
						<li>
							<a href="${ctp}/chat/chatContent"><i class="fa-solid fa-comment"></i>채팅</a>
						</li>
					</ul>
				</c:if>
			</div>
		</div>
		<!-- 움직였을 때 같이 내려오는 헤더 -->
		<div class="gnb-inner">
			<div id="gnb-btm-nav-size">
				<div id="gnb-btm-nav-align">
					<div style="display: flex;">
						<div style="display: flex;">
							<c:if test="${damoa == null }">
								<div><a href="http://localhost:9090/javaProjectS4/"><img src="${ctp}/data/images/다모아로고1.png" height="60px" id="logo-img"></a></div>
							</c:if>
							<c:if test="${damoa != null }">
								<div><a href="http://localhost:9090/javaProjectS4/"><img src="${ctp}/data/images/다모아로고1.png" style="margin-top: 11px" height="60px" id="logo-img"></a></div>
							</c:if>
						</div>
						<div style="display: flex;">
							<nav id="gub-ul-nav-div">
								<ul id="header-btm-ul">
									<li><a href="${ctp}/used/usedMain">중고거래</a></li>
									<li><a href="${ctp}/community/communityMain">커뮤니티</a></li>
									<li><a href="${ctp}/board/noticeList">공지사항</a></li>
								</ul>
							</nav>
						</div>
						<%-- 
						<div style="display: flex;">
							<div id="header-search-span">
					            <input type="text" name="searchN" id="searchN" value="${search}"  />
					            <a href="javascript:mainSearch()" style="padding: 10px;"><i class="fa-solid fa-magnifying-glass" ></i></a>
				            </div>
						</div>
						 --%>
					</div>
				</div>
			</div>
		</div>
	</header>