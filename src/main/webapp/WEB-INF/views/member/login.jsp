<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
<style>
	#login-div{
		max-width: 600px;
		border: 1px solid;
		margin: 0 auto;
		margin-top: 130px;
		margin-bottom: 130px;
		min-height: 400px;
		border-radius: 30px;
	}
	#login-inner-div{ 
		text-align:center;
		padding: 20px 70px;
	}
	#login-inner-div input[type="text"], #login-inner-div input[type="password"]{
		margin: 15px 0px;
		width: 450px;
		height : 50px;
		font-size : 1.2em;
		padding : 0px 20px;
		border-radius: 20px;
	}
	#login-save-checkbox{
		margin-right : 20px;
		text-align:right;
		font-size: 1.2em;
	}
	#login-inner-div input[type="button"]{
		margin: 15px 0px;
		width: 435px;
		height: 50px;
		background: #402F1D;
		color: #fff;
		font-size: 1.2em;
		border-radius: 10px;
		font-weight: bold;
	}
	#login-inner-div input[type="button"]:hover{
		background: #EBDDCC;
		border: 2px solid #402F1D;
		color: #402F1D;
		
	}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<main>
	<section>
		<div id="login-div">
			<div id="login-inner-div">
				<h2>회원 로그인</h2>
				<input type="text" name="mid" id="mid" required autofocus placeholder="아이디"/>
				<input type="password" name="pwd" id="pwd" placeholder="비밀번호" />
				<div id="login-save-checkbox">
					<input type="checkbox" name="idSave" id="idSave" value="save" /><label for="idSave">아이디 저장</label>
				</div>
				<input type="button" value="로그인" onclick="loginOk()"/>
				<div><a href=""><i class="fa-solid fa-key"></i> 아이디/비밀번호를 잊으셨나요?</a></div>
			</div>
		</div>
	</section>
</main>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>