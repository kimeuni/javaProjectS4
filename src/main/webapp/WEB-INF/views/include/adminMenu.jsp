<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
 	body{
 		margin: 0px;
 		padding: 0px;
 	}
 	#admin-left-nav{
 		position : fixed;
 		overflow : auto;
 		background-color: #3E465B;
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
 	.admin-inner-menu{
 		text-align: left;
 		font-size: 1.3em;
 		font-weight: bold;
 		background-color: #0E0F37;
 		color : #fff;
 		height: 50px;
 		line-height: 50px;
 		padding: 0px 30px;
 	}
 	.admin-inner-menu-n{
 		text-align: left;
 		font-size: 1.3em;
 		font-weight: bold;
 		color : #fff;
 		height: 50px;
 		line-height: 50px;
 		padding: 0px 30px;
 	}
 	#admin-menu a{
 		color : #fff;
 		text-decoration: none;
 	}
 	#admin-member-inner-menu a div, #admin-board-inner-menu a div, #admin-notice-inner-menu a div, #admin-advertisement-inner-menu a div, #admin-ask-inner-menu a div{
 		padding-left: 50px;
 		font-size: 1.2em;
 	}
 	.admin-inner-menu-n:hover{
 		background-color: #0E0F37;
 	}
 	#damoa-logo-div{
 		margin-top: 20px;
 	}
</style>
<script>
	'use strict'
	
	$(function() {
		$("#admin-member-inner-menu").hide();
		$("#admin-board-inner-menu").hide();
		$("#admin-notice-inner-menu").hide();
		$("#admin-advertisement-inner-menu").hide();
		$("#admin-ask-inner-menu").hide();
		$("#member-menu-up").hide();
		$("#board-menu-up").hide();
		$("#notice-menu-up").hide();
		$("#advertisement-menu-up").hide();
		$("#ask-menu-up").hide();
		if('${menuCk}' == '회원리스트' || '${menuCk}' == '회원검색리스트' || '${menuCk}' == '회원탈퇴신청'){
			$("#member-menu-down").hide();
			$("#member-menu-up").show();
			$("#admin-member-inner-menu").show();
		}
		else if('${menuCk}' == '공지작성' || '${menuCk}' == '공지관리' || '${menuCk}' == '이벤트작성' || '${menuCk}' == '자주하는질문작성' || '${menuCk}' == '자주하는질문관리'){
			$("#notice-menu-down").hide();
			$("#notice-menu-up").show();
			$("#admin-notice-inner-menu").show();
		}
		else if('${menuCk}' == '광고메일' || '${menuCk}' == '메인광고등록' || '${menuCk}' == '메인광고관리'){
			$("#advertisement-menu-down").hide();
			$("#advertisement-menu-up").show();
			$("#admin-advertisement-inner-menu").show();
		}
		else if('${menuCk}' == '답변대기' || '${menuCk}' == '답변완료'){
			$("#ask-menu-down").hide();
			$("#ask-menu-up").show();
			$("#admin-ask-inner-menu").show();
		}
	});
	
	function memberManagementDown(){
		$("#member-menu-down").hide();
		$("#member-menu-up").show();
		$("#admin-member-inner-menu").slideDown();
		
		$("#board-menu-down").show();
		$("#board-menu-up").hide();
		$("#admin-board-inner-menu").slideUp();
		
		$("#notice-menu-down").show();
		$("#notice-menu-up").hide();
		$("#admin-notice-inner-menu").slideUp();
		
		$("#advertisement-menu-down").show();
		$("#advertisement-menu-up").hide();
		$("#admin-advertisement-inner-menu").slideUp();
		
		$("#ask-menu-down").show();
		$("#ask-menu-up").hide();
		$("#admin-ask-inner-menu").slideUp();
	}
	
	function memberManagementUp(){
		$("#member-menu-down").show();
		$("#member-menu-up").hide();
		$("#admin-member-inner-menu").slideUp();
	}
	
	function boardManagementDown(){
		$("#member-menu-down").show();
		$("#member-menu-up").hide();
		$("#admin-member-inner-menu").slideUp();
		
		$("#board-menu-down").hide();
		$("#board-menu-up").show();
		$("#admin-board-inner-menu").slideDown();
		
		$("#notice-menu-down").show();
		$("#notice-menu-up").hide();
		$("#admin-notice-inner-menu").slideUp();
		
		$("#advertisement-menu-down").show();
		$("#advertisement-menu-up").hide();
		$("#admin-advertisement-inner-menu").slideUp();	
		
		$("#ask-menu-down").show();
		$("#ask-menu-up").hide();
		$("#admin-ask-inner-menu").slideUp();
	}
	
	function boardManagementUp(){
		$("#board-menu-down").show();
		$("#board-menu-up").hide();
		$("#admin-board-inner-menu").slideUp();
	}
	
	function noticeManagementDown(){
		$("#member-menu-down").show();
		$("#member-menu-up").hide();
		$("#admin-member-inner-menu").slideUp();
		
		$("#board-menu-down").show();
		$("#board-menu-up").hide();
		$("#admin-board-inner-menu").slideUp();
		
		$("#notice-menu-down").hide();
		$("#notice-menu-up").show();
		$("#admin-notice-inner-menu").slideDown();
		
		$("#advertisement-menu-down").show();
		$("#advertisement-menu-up").hide();
		$("#admin-advertisement-inner-menu").slideUp();	
		
		$("#ask-menu-down").show();
		$("#ask-menu-up").hide();
		$("#admin-ask-inner-menu").slideUp();
	}
	
	function noticeManagementUp(){
		$("#notice-menu-down").show();
		$("#notice-menu-up").hide();
		$("#admin-notice-inner-menu").slideUp();
	}
	
	function advertisementManagementDown(){
		$("#member-menu-down").show();
		$("#member-menu-up").hide();
		$("#admin-member-inner-menu").slideUp();
		
		$("#board-menu-down").show();
		$("#board-menu-up").hide();
		$("#admin-board-inner-menu").slideUp();
		
		$("#notice-menu-down").show();
		$("#notice-menu-up").hide();
		$("#admin-notice-inner-menu").slideUp();
		
		$("#advertisement-menu-down").hide();
		$("#advertisement-menu-up").show();
		$("#admin-advertisement-inner-menu").slideDown();
		
		$("#ask-menu-down").show();
		$("#ask-menu-up").hide();
		$("#admin-ask-inner-menu").slideUp();
	}
	
	function advertisementManagementUp(){
		$("#advertisement-menu-down").show();
		$("#advertisement-menu-up").hide();
		$("#admin-advertisement-inner-menu").slideUp();		
	}
	
	function askManagementDown(){
		$("#member-menu-down").show();
		$("#member-menu-up").hide();
		$("#admin-member-inner-menu").slideUp();
		
		$("#board-menu-down").show();
		$("#board-menu-up").hide();
		$("#admin-board-inner-menu").slideUp();
		
		$("#notice-menu-down").show();
		$("#notice-menu-up").hide();
		$("#admin-notice-inner-menu").slideUp();
		
		$("#advertisement-menu-down").show();
		$("#advertisement-menu-up").hide();
		$("#admin-advertisement-inner-menu").slideUp();
		
		$("#ask-menu-down").hide();
		$("#ask-menu-up").show();
		$("#admin-ask-inner-menu").slideDown();
	}
	
	function askManagementUp(){
		$("#ask-menu-down").show();
		$("#ask-menu-up").hide();
		$("#admin-ask-inner-menu").slideUp();
	}
</script>
<div id="admin-left-nav">
	<div id="damoa-logo-div"><a href="${ctp}/damoa"><img src="${ctp}/data/images/다모아로고2.png" height="65px"></a></div>
	<hr/>
	<div id="admin-menu">
		<div>
			<a href="${ctp}/admin/adminMain"><div class="admin-inner-menu-n">메인 대시보드</div></a>
		</div>
		<div id="member-menu-down">
			<a href="javascript:memberManagementDown()"><div class="admin-inner-menu-n"><i class="fa-solid fa-chevron-right"></i> 회원 관리</div></a>
		</div>
		<div id="member-menu-up">
			<a href="javascript:memberManagementUp()"><div class="admin-inner-menu"><i class="fa-solid fa-angle-down"></i> 회원 관리</div></a>
		</div>
		<div id="admin-member-inner-menu">
			<a href="${ctp}/admin/memberList"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> 회원 리스트</div></a>
			<a href="${ctp}/admin/memberUserDel"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> 회원 탈퇴 신청</div></a>
			<a href="${ctp}/admin/memberReport"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> 회원 신고 관리</div></a>
		</div>
		<div id="board-menu-down">
			<a href="javascript:boardManagementDown()"><div class="admin-inner-menu-n"><i class="fa-solid fa-chevron-right"></i> 게시물 관리</div></a>
		</div>
		<div id="board-menu-up">
			<a href="javascript:boardManagementUp()"><div class="admin-inner-menu"><i class="fa-solid fa-angle-down"></i> 게시판 관리</div></a>
		</div>
		<div id="admin-board-inner-menu">
			<a href="${ctp}/admin/memberList"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> 신고 관리</div></a>
		</div>
		<div id="notice-menu-down">
			<a href="javascript:noticeManagementDown()"><div class="admin-inner-menu-n"><i class="fa-solid fa-chevron-right"></i> 공지 관리</div></a>
		</div>
		<div id="notice-menu-up">
			<a href="javascript:noticeManagementUp()"><div class="admin-inner-menu"><i class="fa-solid fa-angle-down"></i> 공지 관리</div></a>
		</div>
		<div id="admin-notice-inner-menu">
			<a href="${ctp}/admin/noticeInput"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> 공지 작성</div></a>
			<a href="${ctp}/admin/noticeManagement"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> 공지 관리</div></a>
			<a href="${ctp}/admin/eventInput"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> 이벤트 등록</div></a>
			<a href="${ctp}/admin/noticeManagement"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> 이벤트 관리</div></a>
			<a href="${ctp}/admin/FAQInput"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> FAQ 등록</div></a>
			<a href="${ctp}/admin/FAQManagement"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> FAQ 관리</div></a>
		</div>
		<div id="advertisement-menu-down">
			<a href="javascript:advertisementManagementDown()"><div class="admin-inner-menu-n"><i class="fa-solid fa-chevron-right"></i> 광고 관리</div></a>
		</div>
		<div id="advertisement-menu-up">
			<a href="javascript:advertisementManagementUp()"><div class="admin-inner-menu"><i class="fa-solid fa-angle-down"></i> 광고 관리</div></a>
		</div>
		<div id="admin-advertisement-inner-menu">
			<a href="${ctp}/admin/mailInput"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> 광고메일 전송</div></a>
			<a href="${ctp}/admin/mailManagement"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> 광고메일 관리</div></a>
			<a href="${ctp}/admin/advertisementInput"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> 메인화면 광고 등록</div></a>
			<a href="${ctp}/admin/advertisementManagement"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> 메인화면 광고 관리</div></a>
		</div>
		<div id="ask-menu-down">
			<a href="javascript:askManagementDown()"><div class="admin-inner-menu-n"><i class="fa-solid fa-chevron-right"></i> 문의 관리</div></a>
		</div>
		<div id="ask-menu-up">
			<a href="javascript:askManagementUp()"><div class="admin-inner-menu"><i class="fa-solid fa-angle-down"></i> 문의 관리</div></a>
		</div>
		<div id="admin-ask-inner-menu">
			<a href="${ctp}/admin/askStatusNo"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> 답변대기 문의</div></a>
			<a href="${ctp}/admin/askStatusYes"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> 완료 문의 삭제</div></a>
		</div>
		<div >
			<a href="${ctp}/admin/delTitleInput"><div class="admin-inner-menu-n">탈퇴 목록 등록</div></a>
		</div>
		<div>
			<a href="${ctp}/admin/imsiImgDelete"><div class="admin-inner-menu-n">임시파일 삭제</div></a>
		</div>
		<div>
			<a href="${ctp}/admin/adminMain"><div class="admin-inner-menu-n">통계</div></a>
		</div>
	</div>
</div>