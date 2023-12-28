<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		overflow: hidden;
	}
	.gnb-inner {
		background-color: white;
		height: 80px;
		line-height: 80px;
	}

	/* Active Class */
	header.act .lnb-inner {
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
	header.act .gnb-inner a:hover{
		color: #fff;
	}
	
	
	
	.gnb-inner a:hover{
		color: #000;
	}
	/* 1번째 nav */
	#lnb-top-nav-size{
		max-width: 1200px;
		margin: 0 auto;
	}
	.header-top-ul{
		text-align: right;
	}
	.header-top-ul li {
		display: inline-block;
		padding: 5px 10px;
	}
	.header-top-ul li a{
		text-decoration: none;
		color: black;
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
	}
	#header-btm-ul li {
		display: inline-block;
		padding: 0px 10px;
	}
	#header-search-span{
		text-align: right;
		margin-left: 330px;
	}
	#header-search-span input[type="text"]{
		border: none;
        width: 200px;
        height : 40px; 
        background-color: rgba(0,0,0,0);
        padding: 5px 0px;
        margin: 0px 5px;
        font-weight: bolder;
        outline: none;
        border-bottom: 0.7px solid black;
	}
	#gnb-btm-nav-align a {
		text-decoration: none;
	}
</style>
<script>
	$(window).scroll(function() {
		if($(window).scrollTop() > 50) {
			$('header').addClass('act');
		} else {
			$('header').removeClass('act');
		}
	});
</script>
	<header>
		<div class="lnb-inner">
			<div id="lnb-top-nav-size">
				<!-- 비로그인 시 -->
				<c:if test="${sMid == null}">  
					<ul class="header-top-ul">
						<li><a href="${ctp}/member/login">로그인</a></li>
						<li><a href="">회원가입</a></li>
					</ul>
				</c:if>
				<!-- 로그인 시 -->
				<c:if test="${sMid != null}">
					<ul class="header-top-ul">
						<li><a href="">${sNickName}님</a></li>
						<li><a href=""><i class="fa-regular fa-bell" title="알림"></i></a></li>
					</ul>
				</c:if>
			</div>
		</div>
		<!-- 움직였을 때 같이 내려오는 헤더 -->
		<div class="gnb-inner">
			<div id="gnb-btm-nav-size">
				<div id="gnb-btm-nav-align">
					<span>로고</span>
					<ul id="header-btm-ul">
						<li><a href="">중고거래</a></li>
						<li><a href="">커뮤니티</a></li>
						<li><a href="">모아모아</a></li>
						<li><a href="">공지사항</a></li>
						<li><a href="">문의사항</a></li>
					</ul>
					<span id="header-search-span">
			            <input type="text" name="searchN" id="searchN" value="${search}"  />
			            <a href="javascript:mainSearch()" style="padding: 10px;"><i class="fa-solid fa-magnifying-glass" ></i></a>
		            </span>
				</div>
			</div>
		</div>
	</header>