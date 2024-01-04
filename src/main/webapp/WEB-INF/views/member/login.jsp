<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<style>
		section{
	   		max-width: 1024px;
			margin: 0 auto;
	   	}
		#login-div{
			max-width: 600px;
			border: 1px solid;
			margin: 0 auto;
			margin-top: 80px;
			margin-bottom: 80px;
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
		#demo-login-check{
			color: red;
			font-size: 12px;
			text-align: left;
		}
		.kakaoBtn{
			background-color: #fee500;
			min-width: 180px;
			padding: 10px 0px;
			vertical-align: middle; 
			border-radius: 20px;
			margin: 15px 0px;
		}
		#login-inner-div a{
			text-decoration: none;
			color: black;
			clear: both;
		}
		.hr-sect {
	        display: flex;
	        flex-basis: 100%;
	        align-items: center;
	        color: rgba(0, 0, 0, 0.35);
	        font-size: 12px;
	        margin: 8px 0px;
        }
        .hr-sect::before,
        .hr-sect::after {
	        content: "";
	        flex-grow: 1;
	        background: rgba(0, 0, 0, 0.35);
	        height: 1px;
	        font-size: 0px;
	        line-height: 0px;
	        margin: 0px 16px;
        }
        .spinner-border{
        	margin: 15px 0px;
        }
	</style>
	<script>
		'use strict'
		let str = '';
		
		$(function() {
			$(".spinner-border").hide();
			$(".kakaoBtn").show();
			$("#imsiPwdGo").hide();
		});
		
		$(function() {
			$("#mid").on("keydown", function(e) {
				if(e.keyCode == 13){
					loginOk();
				}
			});
		});
		$(function() {
			$("#pwd").on("keydown", function(e) {
				if(e.keyCode == 13){
					loginOk();
				}
			});
		});
		
		// 카카오 로그인을 위한 자바스크립트 앱키
		window.Kakao.init("feb7c4c19e6c057416316d3cdb528c05");
		
		function kakaoLogin(){
			// 카카오에 인증요청처리
			window.Kakao.Auth.login({
				scope: 'profile_nickname, account_email',
				success : function(autoObj){
					// api 요청
					window.Kakao.API.request({
						url : '/v2/user/me', //나의 정보 요청
						success : function(res){
							const kakao_account = res.kakao_account;
							location.href="${ctp}/member/kakaoLogin?nickName="+kakao_account.profile.nickname+"&email="+kakao_account.email+"&accessToken="+Kakao.Auth.getAccessToken();  
							$(".spinner-border").show();
							$(".kakaoBtn").hide();
							$("#imsiPwdGo").show();
						}
					});
				}
			});
		}
		
		
		function loginOk(){
			let mid = $("#mid").val();
			let pwd = $("#pwd").val();
			let idSave;
	    	if(document.getElementsByName("idSave")[0].checked) idSave = "save"; 
			
			if(mid.trim() == ""){
				str = '아이디를 입력해주세요.';
				$("#demo-login-check").html(str);
				return false
			}
			else if(pwd.trim() == ""){
				str = '비밀번호를 입력해주세요.';
				$("#demo-login-check").html(str);
				return false
			}
			else{
				let query = {
					mid : mid,
					pwd : pwd,
					idSave : idSave
				}
				
				$.ajax({
					url : "${ctp}/member/login",
					type : "post",
					data : query,
					success : function(res){
						if(res == "1"){
							str = '아이디 또는 비밀번호를 잘못 입력했습니다.<br/> 입력하신 내용을 다시 확인해주세요.';
							$("#demo-login-check").html(str);
						}
						else if(res == "2"){
							location.href='${ctp}/damoa';
						}
						else if(res == "3"){
							// 나중에 관리자 화면으로 이동하도록 주소 바꾸기
							location.href='${ctp}/damoa';
						}
					},
					error : function(){
						alert("전송오류(login.jsp)")
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
		<div id="login-div">
			<div id="login-inner-div">
				<h2>회원 로그인</h2>
				<input type="text" name="mid" id="mid" value="${cMid}" required autofocus placeholder="아이디"/>
				<input type="password" name="pwd" id="pwd" placeholder="비밀번호" />
				<div id="login-save-checkbox">
					<input type="checkbox" name="idSave" id="idSave" value="save" ${cMid!=null ? 'checked' : '' } /><label for="idSave">아이디 저장</label>
				</div>
				<div id="demo-login-check"></div>
				<input type="button" value="로그인" onclick="loginOk()"/>
				<div><a href="idFind"><i class="fa-solid fa-key"></i> 아이디/비밀번호를 잊으셨나요?</a></div>
				<div class="hr-sect">또는</div>
				<a href="javascript:kakaoLogin()"><div class="kakaoBtn"><img src="${ctp}/data/images/talk_pc.png">&nbsp;&nbsp;&nbsp;카카오 1초 로그인/회원가입</div></a>
				<div class="spinner-border"></div>
				<div id="imsiPwdGo" style="color:red">임시 비밀번호를 카카오 계정 메일로 전송중 입니다.<br/> 화면을 이동하지 말아주세요.</div>
			</div>
		</div>
	</section>
</main>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>