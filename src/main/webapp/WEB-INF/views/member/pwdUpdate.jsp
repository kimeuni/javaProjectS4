<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 변경</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#myPage-right-content{
    		min-height : 100vh;
    		background-color: #eee;
    		margin-left : 20%;
    		display: inline-block;
    		width: 80%;
    		height : 100%;
    	}
    	#top-menu-str{
    		background-color: #5E5756;
			height: 50px;
			color: #fff;
			font-weight: bold;
			font-size: 1.5em;
			padding-left: 30px;
			line-height: 50px;
    	}
    	#myPage-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 60px; 
    	}
    	#myPage-pwdUpdate{
    		margin: 0 auto;
    		width : 75%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: left;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#myPage-pwdUpdate-str{
    		font-size: 1.2em;
    		color : gray;
    		margin-bottom: 20px;
    	}
    	.pwd-str{
    		display: inline-block;
    		width: 22%;
    		margin-top: 20px;
    	}
    	.pwd-input{
    		display: inline-block;
    		width: 70%;
    		margin-top: 20px;
    	}
    	.pwd-input input[type="password"]{
    		width: 300px;
    		height: 35px;
    	}
    	.check-no{
    		height: 20px;
    		color: red;
    	}
    	#myPage-pwdUpdate hr{
    		margin: 5px 0px;
    	}
    	#pwdBtn{
    		text-align: center;
    	}
    	#pwdBtn input[type="button"]{
    		margin: 15px 0px;
			width: 435px;
			height: 50px;
			background: #402F1D;
			color: #fff;
			font-size: 1.2em;
			border-radius: 10px;
			font-weight: bold;
    	}
    </style>
    <script>
    	'use strict'
    	
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/myPageMenu.jsp" />
	<div id="myPage-container">
		<div id="myPage-right-content">
			<div id="top-menu-str">${menuStr}</div>
			<div id="myPage-right-inner-content">
				<div id="myPage-pwdUpdate">
					<div id="myPage-pwdUpdate-str">비밀번호 변경 <i class="fa-solid fa-lock"></i><c:if test="${sMid == 'admin'}"> <span style="color:red">(관리자는 비밀번호 변경 불가)</span></c:if></div>
					<div>
						<div class="pwd-str">현재 비밀번호</div>
						<div class="pwd-input"><input type="password" name="pwd" id="pwd" placeholder="현재 비밀번호"></div>
						<div id="demo-pwd" class="check-no"></div>
					</div>
					<hr/>
					<div>
						<div class="pwd-str">새 비밀번호</div>
						<div class="pwd-input"><input type="password" name="nPwd" id="nPwd" placeholder="새 비밀번호"></div>
						<div id="demo-nPwd" class="check-no"></div>
					</div>
					<div>
						<div class="pwd-str">새 비밀번호 확인</div>
						<div class="pwd-input"><input type="password" name="nPwdCk" id="nPwdCk" placeholder="새 비밀번호 확인"></div>
						<div id="demo-nPwdCk" class="check-no"></div>
					</div>
					<div id="pwdBtn"><input type="button" value="비밀번호 변경" onclick="" /></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>