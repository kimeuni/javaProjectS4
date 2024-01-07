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
 		/* border: 1px solid; */
 		padding: 0px 30px;
 	}
 	#admin-menu a{
 		color : #fff;
 		text-decoration: none;
 	}
 	#admin-member-menu a div{
 		padding-left: 50px;
 	}
</style>
<script>
	'use strict'
	
	$(function() {
		$("#admin-member-menu").hide();
	});
	
	function memberManagement(){
		$("#admin-member-menu").slideDown();
	}
</script>
<div id="admin-left-nav">
	<div><a href="${ctp}/damoa"><img src="${ctp}/data/images/다모아로고2.png" height="65px"></a></div>
	<div id="admin-menu">
		<a href="javascript:memberManagement()"><div class="admin-inner-menu">회원 관리&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-caret-down"></i></div></a>
		<div id="admin-member-menu">
			<a href="${ctp}/admin/memberList"><div class="admin-inner-menu"><i class="fa-solid fa-chevron-down"></i> 회원 리스트</div></a>
		</div>
		<a href=""><div class="admin-inner-menu">1:1 문의사항&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-caret-down"></i></div></a>
	</div>
</div>