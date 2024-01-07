<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>계정 복구</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	#account-restore-container{
    		min-width: 100vw;
    		min-height: 100vh;
    		background-color: #eee;
			display: inline-block;
    	}
    	#account-restore-div{
			margin: 0 auto;
    		margin-top: 100px;
    		width: 800px;
    	}
    	#account-restore-div hr{
    		border: 0.5px solid black;
    	}
    	#account-restore-text-div{
    		height: 200px;
    	}
    	#account-restore-div #rogo-img{
    		text-align: center;
    		margin: 10px;
    	}
    	#restore-btn-div{
    		text-align: center;
    	}
    	#restore-btn {
    		display : inline-block;
    		width: 300px;
    		font-size : 18px;
    		height: 40px;
    		background-color: #990929;
    		line-height: 40px;
    		border: 1px solid;
    		font-weight: bold;
    		border-radius: 10px;
    	}
    	#restore-btn-div a{
    		color: #fff;
    		text-decoration: none;
    	}
    	#main-btn{
    		text-align: right;
    	}
    	#account-restore-demo-div{
    		height: 200px;
    		padding: 40px;
    		margin: 0 auto;
    		text-align: center;
    	}
    	#login-btn{
    		display : inline-block;
    		width: 300px;
    		font-size : 18px;
    		height: 40px;
    		background-color: #1E90FF;
    		line-height: 40px;
    		border: 1px solid;
    		font-weight: bold;
    		border-radius: 10px;
    	}
    	.restore-no{
    		border-style: solid;
			border-color: red;
			outline-color: red;
    	}
    	.form-check-str{
    		font-size: 12px;
    		color: red;
    		text-align: left;
    	}
    	.form-check-str-Ok{
    		font-size: 12px;
    		color: green;
    		text-align: left;
    	}
    	#account-restore-email-code{
    		height: 93px;
    	}
    	.form-check-code-str{
			font-size: 12px;
    		color: red;
    		text-align: left;
		}
		.form-check-code-str-Ok{
			font-size: 12px;
    		color: green;
    		text-align: left;
		}
    </style>
    <script>
    	'use strict'

    	let emailCheckOk = false;
    	let emailCodeCheckOk = false;
    	
    	let str = ''
       	let timerSw = 0;
    	let playTime = '';

       	// 타이머
       	let time = 180000;
       	let min = 3;
       	let sec = 60;
       	
       	function codeTimer(){
       		playTime=setInterval(function() {
       			time = time-1000;
       			min = time/(60*1000);
       			
       			if(sec > 0){ //sec=60 에서 1씩 빼서 출력해준다.
       				sec=sec-1;
       				// 초가 1~9일경우 앞에 0추가
       				if(sec.toString().length == 1){
   				    	$("#timer").html("남은시간 : "+Math.floor(min)+":0"+sec);
       				}
       				else{
   				    	$("#timer").html("남은시간 : "+Math.floor(min)+":"+sec);
       				}
       			}
       			if(sec == 0){
       				sec = 60;
   			    	$("#timer").html("남은시간 : "+Math.floor(min)+":00");
   			    	
   			    	// 3분이 지나면 메일코드 세션 삭제하러가기
   			    	if(min <=0){
   			    		clearInterval(playTime)
   			    		$.ajax({
   			    			url : "${ctp}/member/mailCodeDelete",
   			    			type : "post",
   			    			success :function(){
   			    				str = '인증번호가 만료되었습니다. 인증번호를 다시 발급받아 주세요.';
   			    				$("#demo_codeW").html(str);
   								$("#codeW").addClass("restore-no");	
   								$("#timer").html("시간초과");
   								$("#email").attr("readonly",false);
   								timerSw = 0;
   			    			},
   			    			error : function(){
   			    				alert("전송오류(restore.jsp)");
   			    			}
   			    		});
   			    	}
       			}
       		},1000);
       	}
    	

    	// 메일 유효성 검사
    	$(function() {
    		$("#email").on("keyup", emailCheck);
    	});
    	
    	function emailCheck(){
    		let email = $("#email").val();
    		let regEmail = /^[\w]+@[a-z]+\.[a-z]{2,3}$/
   			$("#demo_email").addClass("form-check-str");
    		$("#demo_email").removeClass("form-check-str-Ok");
    		
    		if(email.trim() == ""){
    			str = '이메일을 작성해주세요.';
    			$("#demo_email").html(str);
    			$("#email").addClass("restore-no");
    			emailCheckOk = false;
    		}
    		else if(!regEmail.test(email)){
    			str = '이메일 형식이 맞춰서 작성해주세요.';
    			$("#demo_email").html(str);
    			$("#email").addClass("restore-no");
    			emailCheckOk = false;
    		}
    		else {
    			str = '';
    			$("#demo_email").html(str);
    			$("#email").removeClass("restore-no");
    			emailCheckOk = true;
    		}
    	}
    	
    	// 메일 인증코드 전송전 가릴 부분
    	$(function() {
    		$("#spinner-border").hide();
    		$("#restore-mail-code-input").hide();
    	});
    	
    	// 메일 인증코드 전송(버튼 누를 시)
    	function codeMail(){
    		let email = $("#email").val();
    		
    		if(emailCheckOk == false){
    			$("#demo_email").addClass("form-check-str");
        		$("#demo_email").removeClass("form-check-str-Ok");
    			str = '이메일을 형식에 맞춰 작성 후 인증번호를 발급 받아주세요.';
    			$("#demo_email").html(str);
	   			$("#email").addClass("restore-no");
    		}
    		else if(timerSw == 1){
    			// 타이머가 끝나지 않았을 경우 (세션이 삭제 안된 경우) 코드입력 부분으로 포커스
    			$("#codeW").focus();
    		}
    		else {
    			// 이메일 전송을 누를 시에 타이머 <분,초> 설정 및 클래스 등 설정 (인증번호 전송을 여러번 눌렀을 시.. 초기화..)
	    		timerSw = 1; //타이머를 누를 시 스위치 1로 변환

    			time = 180000; //3분
    	    	min = 3;
    	    	sec = 60;
				str = '';
    			$("#demo_codeW").html(str);
	   			$("#codeW").removeClass("restore-no");
	   			
	    		$("#restore-mail-code-input").hide();
    			$("#spinner-border").show();
    			$("#timer").html("남은시간 : 3:00");
    			emailCodeCheckOk = false;
    			
    			$.ajax({
    				url : "${ctp}/member/emailCode",
    				type : "post",
    				data : {email : email},
    				success : function(res){
    					if(res == "1"){
    						$("#demo_email").addClass("form-check-str");
    			    		$("#demo_email").removeClass("form-check-str-Ok");
    						str = '존재하지 않는 메일입니다. 다시 확인해주세요.';
    		    			$("#demo_email").html(str);
    		    			$("#email").addClass("restore-no");
    		    			$("#spinner-border").hide();
    		    			emailCodeCheckOk = false;
    					}
    					else if(res == "2"){
							str = '입력하신 메일로 인증번호가 전송되었습니다.';
							$("#email").attr("readonly",true);
    		    			$("#demo_email").removeClass("form-check-str");
    		    			$("#demo_email").addClass("form-check-str-Ok");
    		    			$("#demo_email").html(str);
    		    			$("#email").removeClass("restore-no");
    		    			$("#spinner-border").hide();
    		    			$("#restore-mail-code-input").show();
    		    			emailCodeCheckOk = false;
    		    			codeTimer()
    					}
    				},
    				error : function(){
    					alert("전송오류(restore.jsp)")
   		    			$("#spinner-border").hide();
    				}
    			});
    		}
    	}
    	
    	// 메일 인증번호 확인
    	function codeCheckOk(){
    		let codeW = $("#codeW").val();
    		let query = {
   				codeW : codeW
    		}
    		
    		if(codeW.trim() == ""){
    			str = '인증번호를 입력해주세요.';
    			$("#demo_codeW").html(str);
    			$("#codeW").addClass("restore-no");
    			$("#codeW").focus();
    		}
    		else{
	    		$.ajax({
	    			url : "${ctp}/member/emailCodeOk",
	    			type : "post",
	    			data : query,
	    			success : function(res){
	    				if(res == "1"){
	    					clearInterval(playTime);
			    			$("#demo_codeW").removeClass("form-check-code-str");
			    			$("#demo_codeW").addClass("form-check-code-str-Ok");
	    					str = '메일인증 확인 되었습니다.';
			    			$("#demo_codeW").html(str);
			    			$("#codeW").removeClass("restore-no");
	    					$("#codeW").attr("readonly",true);
	    					$("#email").attr("readonly",true);
	    					emailCodeCheckOk = true;
	    				}
	    				else if(res == "2"){
	    					if(emailCodeCheckOk != true){
		    					str = '인증번호가 만료되었습니다. 인증번호를 다시 발급받아 주세요.';
				    			$("#demo_codeW").html(str);
				    			$("#codeW").addClass("restore-no");
				    			$("#codeW").focus();
				    			emailCodeCheckOk = false;
	    					}
	    				}
	    				else if(res == "3"){
	    					str = '인증번호를 다시 확인해주세요.';
			    			$("#demo_codeW").html(str);
			    			$("#codeW").addClass("restore-no");
			    			$("#codeW").focus();
			    			emailCodeCheckOk = false;
	    				}
	    			},
	    			error : function(){
	    				alert("전송오류(restore.jsp)");
	    			}
	    		});
    		}
    	}
       	
    	
    	$(function() {
    		$(".spinner-border").hide();
    		$("#login-btn").hide();
    		$("#restore-btn").show();
    	});
    	
    	function restoreOk(){
    		if(emailCheckOk != true){
    			str = '이메일을 확인해주세요.';
    			$("#demo_email").html(str);
    			$("#email").focus();
    			$("#email").addClass("restore-no");	
    			return false;
    		}
    		else if(emailCodeCheckOk != true){
    			str = '인증번호를 인증해주세요.';
    			$("#demo_email").html(str);
    			$("#email").focus();
    			$("#email").addClass("restore-no");	
    			$("#demo_email").addClass("form-check-str");
    			$("#demo_email").removeClass("form-check-str-Ok");
    			return false;
    		}
    		
    		$(".spinner-border").show();
    		$("#restore-btn").hide();
    		
    		let query = {
    			mid : '${mid}',
    			token : '${token}'
    		}
    		
    		$.ajax({
    			url : "${ctp}/member/restoreOk",
    			type : "post",
    			data : query,
    			success : function(res){
    				if(res == "1"){
    					//탈퇴 취소 성공
    					str += '회원님의 계정(<span style="color:red">${mid}</span>)은 탈퇴 취소 처리되었습니다.<br/>'
    					str += '정상적으로 로그인이 가능합니다.<br/>';
    					str += '다시 \'다모아\'를 찾아와 주셔서 감사합니다.';
    					$("#account-restore-demo-div").html(str);
    					
    					$(".spinner-border").hide();
    		    		$("#restore-btn").hide();
    		    		$("#login-btn").show();
    				}
    				else if(res == "2"){
    					str = '탈퇴 처리 중 문제가 발생하였습니다.<br/>'
    					$("#account-restore-demo-div").html(str);
    					$(".spinner-border").hide();
    		    		$("#login-btn").hide();
    		    		$("#restore-btn").show();
    				}
    			},
    			error : function(){
    				alert("전송오류(accountRestore.jsp)")
   		    		$("#login-btn").hide();
    				$(".spinner-border").hide();
    	    		$("#restore-btn").show();
    			}
    		});
    		
    	}
    </script>
</head>
<body>
	<div id="account-restore-container">
		<div id="account-restore-div">
		<div id="rogo-img"><img src="${ctp}/data/images/다모아로고1.png" height="65px"/></div>
			<h1>계정을 복구 하시겠습니까?</h1>
			<hr/>
			<div id="account-restore-text-div">
				회원님의 계정(<span style="color:red">${mid}</span>)은 <span style="color:red">${fn:substring(lastDate,0,10)}</span>에 탈퇴 처리 되었습니다.<br/><br/>
				계정을 실수 혹은 잘못 탈퇴하였을 경우를 위하여 <span style="color:red">30일 안으로 다시 로그인할 시, 계정 복구가 가능</span>합니다. <br/><br/>
				30일이 지나면 실수 혹은 잘못 탈퇴하였다더라도, 더이상 계정 <span style="color:red">복구가 불가능</span>합니다.<br/><br/>
				계정 복구를 원하실 경우 <span style="color:red">'탈퇴 취소'</span>를 클릭하면 탈퇴 절차를 중지하고 계정을 복구하게 됩니다.
			</div>
			<div id="account-restore-email-code">
				<div id="restore-email-div">
					<input type="text" name="email" id="email" required placeholder="이메일(필수)" />
					<input type="button" value="인증번호" class="codeCheckBtn" onclick="codeMail()"/>
					<div id="demo_email" class="form-check-str"></div>
					<div id="spinner-border">
						<div><img src="${ctp}/data/images/Spinner1.gif" height="40px"></div>
					</div>
					<div id="restore-mail-code-input">
						<input type="text" name="codeW" id="codeW" placeholder="인증코드를 입력하세요." />
						<span class="codeCheckBtn">
							<input type="button" value="인증확인" onclick="codeCheckOk()"/>
						</span>
						<span id="timer"></span>
						<div id="demo_codeW" class="form-check-code-str"></div>
					</div>
				</div>
			</div>
			<div id="account-restore-demo-div">
			</div>
			<div id="restore-btn-div">
				<a href="javascript:restoreOk()">
					<div id="restore-btn">탈퇴 취소</div>
				</a>
				<a href="${ctp}/member/login">
					<div id="login-btn">로그인하러 가기</div>
				</a>
				<div class="spinner-border"></div>
			</div>
			<hr/>
			<div id="main-btn"><a href="${ctp}/damoa">메인으로</a></div>
		</div>
	</div>
</body>
</html>