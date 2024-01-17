<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
 	body{
 		margin: 0px;
 		padding: 0px;
 	}
 	#myPage-left-nav{
 		position : fixed;
 		overflow : auto;
 		background-color: #EBDDCC;
 		height : 100vh;
 		width : 20%;
 		display: inline-block;
 		text-align: center;
 	}
 	#member-profile{
 		min-height: 250px;
 		padding: 20px 0px;
 	}
 	#member-profile img{
 		border-radius: 100%;
 		height: 120px; 
 	}
 	#profile-str{
 		margin: 10px 0px;
 	}
 	#profile-str-nick{
 		font-size: 1.2em;
 		font-weight: bold;
 	}
 	#profile-str-mail{
 		color : gray;
 	}
 	#member-profile img{
 		position: relative;
 	}
 	#member-profile span a{
 		position: absolute;
 		top: 180px;
 		right: 140px;
 		color: black;
 		font-size: 1.3em;
 	}
 	#myPage-menu a div{
 		text-align: left;
 		font-size: 1.3em;
 		font-weight: bold;
 		background-color: #382426;
 		color : #fff;
 		height: 50px;
 		line-height: 50px;
 		border: 1px solid;
 		padding: 0px 30px;
 	}
 	#myPage-menu a{
 		color : #fff;
 		text-decoration: none;
 	}
</style>
<div id="myPage-left-nav">
	<div><a href="${ctp}/damoa"><img src="${ctp}/data/images/다모아로고1.png" height="65px"></a></div>
	<div id="member-profile">
		<a href="${ctp}/member/profileUpdate" ><img src="${ctp}/data/member/${vo.profile}" width="120px" height="120px" id="profileChan"></a>
		<span><a href="${ctp}/member/profileChange" ><i class="fa-solid fa-square-pen"></i></a></span>
		<div id="profile-str">
			<div id="profile-str-nick">${vo.nickName}</div>
			<div id="profile-str-mail">${vo.email}</div>
		</div>
	</div>
	<div id="myPage-menu">
		<a href="${ctp}/member/myPage/myInfo"><div>개인정보 관리</div></a>
		<a href="${ctp}/member/ask/myAskList"><div>내 문의 내역</div></a>
	</div>
</div>