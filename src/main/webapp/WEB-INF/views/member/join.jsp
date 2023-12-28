<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	#join-div{
			max-width: 600px;
			border: 1px solid;
			margin: 0 auto;
			margin-top: 60px;
			margin-bottom: 60px;
			min-height: 400px;
			border-radius: 30px;
			text-align: center;
			padding: 30px 50px;
    	}
    	h3{
    		text-align: left;
    		margin-bottom: 10px;
    	}
    	#join-div input[type="text"] , #join-div input[type="password"]{
			width: 400px;
			height: 45px;
			margin-top: 20px;
			padding: 0px 10px;
    	}
    	.form-check-str{
    		font-size: 12px;
    		color: red;
    	}
    	#join-div input[type="radio"]{
			margin-top: 20px;
    	}
    	#join-div input[type="checkbox"]{
			margin-top: 20px;
    	}
    	#join-div input[type="button"]{
    		width: 400px;
			height: 45px;
			margin-top: 20px;
			background: #402F1D;
			color: #fff;
			font-size: 1.2em;
			border-radius: 10px;
			font-weight: bold;
    	}
    	#join-div input[type="button"]:hover{
			background: #EBDDCC;
			border: 2px solid #402F1D;
			color: #402F1D;
		}
    </style>
    <script>
    	'use script'
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<main>
	<section>
		<div id="join-div">
			<div><img src="${ctp}/data/images/다모아로고1.png" width="180px"></div>
			<h3>기본정보</h3>
			
			<div>
				<input type="text" name="mid" id="mid" required placeholder="아이디(필수)" />
				<div id="demo_id" class="form-check-str">dd</div>
			</div>
			<div>
				<input type="password" name="pwd" id="pwd" required placeholder="비밀번호(필수)" />
				<div id="demo_pwd" class="form-check-str">dd</div>
			</div>
			<div>
				<input type="password" name="pwdCk" id="pwdCk" required placeholder="비밀번호 확인(필수)" />
				<div id="demo_pwdCk" class="form-check-str">dd</div>
			</div>
			<div>
				<input type="text" name="name" id="name" required placeholder="성명(필수)" />
				<div id="demo_name" class="form-check-str">dd</div>
			</div>
			<div>
				<input type="text" name="nickName" id="nickName" required placeholder="닉네임(필수)" />
				<div id="demo_nickName" class="form-check-str">dd</div>
			</div>
			<div id="join-email-div">
				<input type="text" name="email" id="email" required placeholder="이메일(필수)" />
				<div id="demo_email" class="form-check-str">dd</div>
			</div>
			<div>
				<!-- 주소 -->
			</div>
			<div>
				<input type="radio" name="gender" id="gender1" checked value="남자"/><label for="gender1">남자</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<input type="radio" name="gender" id="gender2" value="여자"/><label for="gender2">여자</label>
			</div>
			<div>
				<input type="checkbox" id="adYN" name="adYN" value="Y"/>&nbsp;<label for="adYN"><span style="color:red;">(선택)</span> 정보/이벤트 메일 수신에 동의합니다.</label>
			</div>
			<div>
				<input type="button" value="회원가입" onclick="" />
			</div>
		</div>
	</section>
</main>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>