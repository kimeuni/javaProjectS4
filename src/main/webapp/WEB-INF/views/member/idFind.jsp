<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	section{
    		max-width: 1024px;
    		margin: 0 auto;
    	}
    	#idFind-div{
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
    	#demo-idFind{
    		min-height: 25px;
    		text-align: left;
    		padding: 0px 65px;
    	}
    	.demo-idFind-str{
    		color: red;
    	}
    	.demo-idFind-str-ok{
    		color: green;
    	}
    	#idFind-div input[type="text"]{
    		border : 0px;
    		padding: 0px 10px;
    		width: 300px;
    		height: 38px;
    		background: rgba(0,0,0,0);
    		outline: none;
    	}
    	#idFind-name{
    		margin : 0 auto;
    		margin-top : 25px;
    		margin-bottom : 20px;
    		width: 350px;
    		height: 40px;
    		border : 1px solid gray;
    		border-radius: 10px;
    		padding: 0px 10px;
    	}
    	#idFind-email{
    		margin : 0 auto;
    		margin-top : 25px;
    		width: 350px;
    		height: 40px;
    		border : 1px solid gray;
    		border-radius: 10px;
    		padding: 0px 10px;
    	}
    	#idFind-div input[type="button"]{
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
    	function idFind(){
    		let name = $("#name").val();
    		let email = $("#email").val();
    		
    		$("#demo-idFind").addClass("demo-idFind-str");
    		
    		if(name.trim() == ""){
    			str = '성명을 입력해주세요.';
    			$("#demo-idFind").html(str);
    			return false
    		}
    		else if(email.trim() == ""){
    			str = '이메일을 입력해주세요.';
    			$("#demo-idFind").html(str);
    		}
    		else{
    			// 로딩 보이기, 버튼 감추기
    			$(".spinner-border").show();
        		$("#idFindBtn").hide();
    			
    			$.ajax({
    				url : "${ctp}/member/idFind",
    				type : "post",
    				data : {email : email},
    				success : function(res){
    					if(res == "1"){
				    		$("#demo-idFind").removeClass("demo-idFind-str");
				    		$("#demo-idFind").addClass("demo-idFind-str-ok");
    						str = '이메일을 확인해주세요.';
			    			$("#demo-idFind").html(str);
			    			$(".spinner-border").hide();
			        		$("#idFindBtn").show();
    					}
    					else if(res == "2"){
    						str = '존재하지 않는 이메일입니다. 다시 확인해주세요.';
			    			$("#demo-idFind").html(str);
			    			$(".spinner-border").hide();
			        		$("#idFindBtn").show();
    					}
    				},
    				error : function(){
    					alert("전송오류(idFind.jsp)")
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
		<div id="idFind-div">
			<h3>아이디 찾기</h3> 
			<hr/>
			<form id="idFindForm" method="post">
				<div id="idFind-name">
					<i class="fa-solid fa-user"></i>
					<input type="text" name="name" id="name" placeholder="성명" required/>
				</div>
				<div id="idFind-email">
					<i class="fa-solid fa-envelope"></i>
					<input type="text" name="email" id="email" placeholder="이메일" required/>
				</div>
				<div id="demo-idFind" class="demo-idFind-str"></div>
				<input type="button" value="아이디 찾기" id="idFindBtn" onclick="idFind()"/>
				<div class="spinner-border"></div>
				<div style="text-align:left">
					<i class="fa-solid fa-check"></i>가입하신 이메일 주소로 아이디를 찾을 수 있습니다.<br/>
					<i class="fa-solid fa-check"></i>아이디, 비밀번호 찾기가 어려울 경우 고객센터로 문의해주세요.
				</div>
				<div id="move-jsp">
					<a href="login">로그인</a> |
					<a href="pwdFind">비밀번호 발급</a>
				</div>
			</form>
		</div>
	</section>
</main>    
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>