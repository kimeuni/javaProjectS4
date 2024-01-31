<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>임시 비밀번호 발급</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	section{
    		max-width: 1024px;
    		margin: 0 auto;
    	}
    	#pwdFind-div{
    		max-width: 500px;
			border: 1px solid;
			margin: 0 auto;
			margin-top: 80px;
			margin-bottom: 80px;
			min-height: 400px;
			border-radius: 30px;
			text-align: center;
			padding: 20px 10px;
    	}
    	#demo-pwdFind{
    		min-height: 25px;
    		text-align: left;
    		padding: 0px 65px;
    	}
    	.demo-pwdFind-str{
    		color: red;
    	}
    	.demo-pwdFind-str-ok{
    		color: green;
    	}
    	#pwdFind-div input[type="text"]{
    		border : 0px;
    		padding: 0px 10px;
    		width: 300px;
    		height: 38px;
    		background: rgba(0,0,0,0);
    		outline: none;
    	}
    	#pwdFind-mid{
    		margin : 0 auto;
    		margin-top : 25px;
    		margin-bottom : 20px;
    		width: 350px;
    		height: 40px;
    		border : 1px solid gray;
    		border-radius: 10px;
    		padding: 0px 10px;
    	}
    	#pwdFind-email{
    		margin : 0 auto;
    		margin-top : 25px;
    		width: 350px;
    		height: 40px;
    		border : 1px solid gray;
    		border-radius: 10px;
    		padding: 0px 10px;
    	}
    	#pwdFind-div input[type="button"]{
    		width: 380px;
			height: 45px;
			margin-top: 10px;
			margin-bottom: 20px;
			background: #402F1D;
			color: #fff;
			font-size: 1.2em;
			border-radius: 10px;
			font-weight: bold;
    	}
    	#move-jsp{
    		margin-top: 10px;
    		margin-bottom: 10px;
    	}
    	.spinner-border{
			margin-top: 10px;
			margin-bottom: 20px;
    		width: 45px; 
    		height: 45px; 
    	}
    </style>
    <script>
    	'use strict'
    	
    	let str = '';
    	
    	// 로딩화면 숨기기
    	$(function() {
	    	$(".spinner-border").hide();
    	});
    	
    	// 아이디 찾기
    	function pwdFind(){
    		let mid = $("#mid").val();
    		let email = $("#email").val();
    		
    		$("#demo-pwdFind").addClass("demo-pwdFind-str");
    		
    		if(mid.trim() == ""){
    			str = '아이디를 입력해주세요.';
    			$("#demo-pwdFind").html(str);
    			return false
    		}
    		else if(email.trim() == ""){
    			str = '이메일을 입력해주세요.';
    			$("#demo-pwdFind").html(str);
    			return false
    		}
    		else{
    			// 로딩 보이기, 버튼 감추기
    			$(".spinner-border").show();
        		$("#pwdFindBtn").hide();
    			
        		let query = {
        			mid : mid,
        			email, email
        		}
        		
    			$.ajax({
    				url : "${ctp}/member/pwdFind",
    				type : "post",
    				data : query,
    				success : function(res){
    					if(res == "1"){
				    		$("#demo-pwdFind").removeClass("demo-pwdFind-str");
				    		$("#demo-pwdFind").addClass("demo-pwdFind-str-ok");
    						str = '이메일을 확인해주세요.';
			    			$("#demo-pwdFind").html(str);
			    			$(".spinner-border").hide();
			        		$("#pwdFindBtn").show();
    					}
    					else if(res == "2"){
    						str = '아이디 혹은 이메일을 다시 확인해주세요.';
			    			$("#demo-pwdFind").html(str);
			    			$(".spinner-border").hide();
			        		$("#pwdFindBtn").show();
    					}
    				},
    				error : function(){
    					alert("전송오류(pwdFind.jsp)")
		    			$(".spinner-border").hide();
		        		$("#pwdFindBtn").show();
    				}
    			});
    		}
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<main>
	<section>
		<div id="pwdFind-div">
			<h3>임시 비밀번호 발급</h3> 
			<hr/>
			<form id="pwdFindForm" method="post">
				<div id="pwdFind-mid">
					<i class="fa-solid fa-user"></i>
					<input type="text" name="mid" id="mid" placeholder="아이디" required/>
				</div>
				<div id="pwdFind-email">
					<i class="fa-solid fa-envelope"></i>
					<input type="text" name="email" id="email" placeholder="이메일" required/>
				</div>
				<div id="demo-pwdFind" class="demo-pwdFind-str"></div>
				<input type="button" value="임시 비밀번호 발급" id="pwdFindBtn" onclick="pwdFind()"/>
				<div class="spinner-border"></div>
				<div style="text-align:left">
					<i class="fa-solid fa-check"></i>가입하신 이메일 주소로 임시 비밀번호를 발급해드립니다.<br/>
				</div>
				<div id="move-jsp">
					<a href="login">로그인</a> |
					<a href="idFind">아이디 찾기</a>
				</div>
			</form>
		</div>
	</section>
</main>    
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>