<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>정보 수정</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="${ctp}/js/woo.js"></script>
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
    	#myPage-infoUpdate{
    		margin: 0 auto;
    		width : 75%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: left;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#myPage-infoUpdate-str{
    		font-size: 1.2em;
    		color : gray;
    		margin-bottom: 20px;
    	}
    	.info-str{
    		display: inline-block;
    		width: 22%;
    		margin-top: 20px;
    	}
    	.info-input{
    		display: inline-block;
    		width: 70%;
    		margin-top: 20px;
    	}
    	.info-input input[type="text"]{
    		width: 300px;
    		height: 35px;
    	}
    	.form-check-str{
    		font-size: 12px;
    		color: red;
    		text-align: left;
    		margin-left : 22%;
    		height: 20px;
    	}
    	.form-check-str-Ok{
    		font-size: 12px;
    		color: green;
    		text-align: left;
    		margin-left : 22%;
    	}
    	.infoUpdate{
			border-style: solid;
			border-color: red;
			outline-color: red;
		}
		#spinner-border{
			margin-top : 20px;
			width: 100%;
			text-align: center;
		}
		.form-check-code-str{
			font-size: 12px;
    		color: red;
    		text-align: left;
    		height: 20px;
		}
		.form-check-code-str-Ok{
			font-size: 12px;
    		color: green;
    		text-align: left;
		}
		#sample6_postcode, #codeW{
			width: 150px;
		}
		#info-update-btn input[type="button"]{
			margin-top : 15px;
			width: 300px;
			height: 50px;
			background: #402F1D;
			color: #fff;
			font-size: 1.2em;
			border-radius: 10px;
			font-weight: bold;
		}
		#info-update-btn{
			text-align: center;
		}
    </style>
    <script>
    	'use strict'
    	
    	let nameCheckOk = true;
    	let nickNameCheckOk = true;
    	let emailCheckOk = true;
    	let emailCodeCheckOk = false;
    	
    	let str = '';
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
								$("#codeW").addClass("infoUpdate-no");	
								$("#timer").html("시간초과");
								$("#email").attr("readonly",false);
								timerSw = 0;
			    			},
			    			error : function(){
			    				alert("전송오류(infoUpdate.jsp)");
			    			}
			    		});
			    	}
    			}
    		},1000);
    	}
    	
    	// 성명
    	$(function() {
    		$("#name").on("keyup", nameCheck);
    	});
    	
    	function nameCheck(){
    		let name = $("#name").val();
    		let regName = /^[가-힣]{2,10}$/;
    		
    		if(name.trim() == ""){
    			str = '성명을 입력해주세요.';
    			$("#demo_name").html(str);
    			$("#name").addClass("infoUpdate-no");
    			nameCheckOk = false;
    		}
    		else if(!regName.test(name)){
    			str = '성명은 2~10글자의 한글로만 사용 가능합니다.'
    			$("#demo_name").html(str);
    			$("#name").addClass("infoUpdate-no");
    			nameCheckOk = false;
    		}
    		else{
				str = '';
				$("#demo_name").html(str);
				$("#name").removeClass("infoUpdate-no");
				nameCheckOk = true;
    		}
    	}
    	
    	// 닉네임
    	$(function() {
    		$("#nickName").on("keyup", nickNameCheck);
    	});
    	
    	function nickNameCheck(){
    		let nickName = $("#nickName").val();
    		let regNickName = /^[a-zA-Z가-힣0-9]{2,8}$/
    		
    		if(nickName.trim() == ""){
    			str = '닉네임을 입력해주세요.';
    			$("#demo_nickName").html(str);
    			$("#nickName").addClass("infoUpdate-no");
    			nickNameCheckOk = false;
    		}
    		else if(!regNickName.test(nickName)){
    			str = '닉네임은 2~8글자의 영문대소문자 한글 숫자로만 사용 가능합니다.'
    			$("#demo_nickName").html(str);
    			$("#nickName").addClass("infoUpdate-no");
    			nickNameCheckOk = false;
    		}
    		else{
    			$.ajax({
    				url : "${ctp}/member/nickNameCheck",
    				type : "post",
    				data : {nickName : nickName},
    				success : function(res){
    					if(res == "1"){
    						str = '존재하는 닉네임입니다.';
    						$("#demo_nickName").html(str);
    		    			$("#nickName").addClass("infoUpdate-no");
    		    			nickNameCheckOk = false;
    					}
    					else if(res == "2"){
    						str = '';
    						$("#demo_nickName").html(str);
    		    			$("#nickName").removeClass("infoUpdate-no");
    		    			nickNameCheckOk = true;
    					}
    					else if(res == "3"){
    						str = '현재 닉네임과 동일합니다.(수정을 원할 시 변경해주세요.)';
    						$("#demo_nickName").html(str);
    		    			$("#nickName").removeClass("infoUpdate-no");
    		    			nickNameCheckOk = true;
    					}
    				},
    				error : function(){
    					alert("전송오류(infoUpdate.jsp)")
    				}
    			});
    		}
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
    			$("#email").addClass("infoUpdate-no");
    			emailCheckOk = false;
    		}
    		else if(!regEmail.test(email)){
    			str = '이메일 형식이 맞춰서 작성해주세요.';
    			$("#demo_email").html(str);
    			$("#email").addClass("infoUpdate-no");
    			emailCheckOk = false;
    		}
    		else {
    			str = '';
    			$("#demo_email").html(str);
    			$("#email").removeClass("infoUpdate-no");
    			emailCheckOk = true;
    		}
    	}
    	
    	// 메일 인증코드 전송전 가릴 부분
    	$(function() {
    		$("#spinner-border").hide();
    		$("#infoUpdate-mail-code-input").hide();
    	});
    	
    	// 메일 인증코드 전송(버튼 누를 시)
    	function codeMail(){
    		let email = $("#email").val();
    		
    		if(emailCheckOk == false){
    			$("#demo_email").addClass("form-check-str");
        		$("#demo_email").removeClass("form-check-str-Ok");
    			str = '이메일을 형식에 맞춰 작성 후 인증번호를 발급 받아주세요.';
    			$("#demo_email").html(str);
	   			$("#email").addClass("infoUpdate-no");
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
	   			$("#codeW").removeClass("infoUpdate-no");
	   			
	    		$("#infoUpdate-mail-code-input").hide();
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
    		    			$("#email").addClass("infoUpdate-no");
    		    			$("#spinner-border").hide();
    		    			emailCodeCheckOk = false;
    					}
    					else if(res == "2"){
							str = '입력하신 메일로 인증번호가 전송되었습니다.';
							$("#email").attr("readonly",true);
    		    			$("#demo_email").removeClass("form-check-str");
    		    			$("#demo_email").addClass("form-check-str-Ok");
    		    			$("#demo_email").html(str);
    		    			$("#email").removeClass("infoUpdate-no");
    		    			$("#spinner-border").hide();
    		    			$("#infoUpdate-mail-code-input").show();
    		    			emailCodeCheckOk = false;
    		    			codeTimer()
    					}
    				},
    				error : function(){
    					alert("전송오류(infoUpdate.jsp)")
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
    			$("#codeW").addClass("infoUpdate-no");
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
			    			$("#codeW").removeClass("infoUpdate-no");
	    					$("#codeW").attr("readonly",true);
	    					$("#email").attr("readonly",true);
	    					emailCodeCheckOk = true;
	    				}
	    				else if(res == "2"){
	    					if(emailCodeCheckOk != true){
		    					str = '인증번호가 만료되었습니다. 인증번호를 다시 발급받아 주세요.';
				    			$("#demo_codeW").html(str);
				    			$("#codeW").addClass("infoUpdate-no");
				    			$("#codeW").focus();
				    			emailCodeCheckOk = false;
	    					}
	    				}
	    				else if(res == "3"){
	    					str = '인증번호를 다시 확인해주세요.';
			    			$("#demo_codeW").html(str);
			    			$("#codeW").addClass("infoUpdate-no");
			    			$("#codeW").focus();
			    			emailCodeCheckOk = false;
	    				}
	    			},
	    			error : function(){
	    				alert("전송오류(infoUpdate.jsp)");
	    			}
	    		});
    		}
    	}
    	
    	// 클릭시, 우편번호 들어가기
    	$(function() {
    		$("#sample6_postcode").on("click", function() {
    			sample6_execDaumPostcode()
    		});
    	});
    	$(function() {
    		$("#sample6_address").on("click", function() {
    			sample6_execDaumPostcode()
    		});
    	});
    	
    	
    	// 회원가입하기
    	function infoUpdateOk(){
    		let adr = $("#sample6_postcode").val();
    		
    		if(nameCheckOk != true){
    			str = '성명을 확인해주세요.';
    			$("#demo_name").html(str);
    			$("#name").focus();
    			$("#name").addClass("infoUpdate-no");	
    			return false;
    		}
    		else if(nickNameCheckOk != true){
    			str = '닉네임을 확인해주세요.';
    			$("#demo_nickName").html(str);
    			$("#nickName").focus();
    			$("#nickName").addClass("infoUpdate-no");	
    			return false;
    		}
    		else if(emailCheckOk != true){
    			str = '이메일을 확인해주세요.';
    			$("#demo_email").html(str);
    			$("#email").focus();
    			$("#email").addClass("infoUpdate-no");	
    			return false;
    		}
    		else if(emailCodeCheckOk != true){
    			str = '인증번호를 인증해주세요.';
    			$("#demo_email").html(str);
    			$("#email").focus();
    			$("#email").addClass("infoUpdate-no");	
    			$("#demo_email").addClass("form-check-str");
    			$("#demo_email").removeClass("form-check-str-Ok");
    			return false;
    		}
    		else if(adr.trim() == ""){
    			str = '주소를 확인해주세요.';
    			$("#demo_address").html(str);
    			$("#sample6_postcode").focus();
    			$("#sample6_postcode").addClass("infoUpdate-no");	
    			$("#sample6_address").addClass("infoUpdate-no");	
    			return false;
    		}
    		else { 
    			let name = $("#name").val();
    			let nickName = $("#nickName").val();
    			let email = $("#email").val();
    			
    			// 전송전에 '주소'를 하나로 묶어서 전송처리 준비
            	let postcode = $("#sample6_postcode").val();
            	let roadAddress = $("#sample6_address").val();
            	let detailAddress = $("#sample6_detailAddress").val();
            	let extraAddress = $("#sample6_extraAddress").val();
            	let address = postcode + "/" + roadAddress + "/ " + detailAddress + "/" + extraAddress;
            	
            	let query = {
            		name : name,
            		nickName : nickName,
            		email : email,
            		address : address
            	}
            	$.ajax({
            		url : "${ctp}/member/infoUpdateOk",
            		type : "post",
            		data : query,
            		success : function(res){
            			if(res == "1"){
            				alert("정보가 수정되었습니다.")
            				location.reload();
            			}
            			else if(res == "2"){
            				alert("정보 수정에 실패하였습니다.");
            				location.reload();
            			}
            		},
            		error : function(){
            			alert("전송오류(infoUpdate.jsp)");
            		}
            	});
    		}
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/myPageMenu.jsp" />
	<div id="myPage-container">
		<div id="myPage-right-content">
			<div id="top-menu-str">${menuStr}</div>
			<div id="myPage-right-inner-content">
				<div id="myPage-infoUpdate">
					<div id="myPage-infoUpdate-str">정보 수정 <i class="fa-solid fa-pen"></i></div>
					<div>
						<div class="info-str">아이디</div>
						<div class="info-input">${vo.mid }</div>
					</div>
					<div>
						<div class="info-str">성명</div>
						<div class="info-input"><input type="text" name="name" id="name" value="${vo.name}" placeholder="성명(필수)"></div>
						<div id="demo_name" class="form-check-str"></div>
					</div>
					<div>
						<div class="info-str">닉네임</div>
						<div class="info-input"><input type="text" name="nickName" id="nickName" value="${vo.nickName}" placeholder="닉네임(필수)"></div>
						<div id="demo_nickName" class="form-check-str"></div>
					</div>
					<div id="infoUpdate-email-div">
						<div class="info-str">이메일</div>
						<div class="info-input">
							<input type="text" name="email" id="email" value="${vo.email}" required placeholder="이메일(필수)" />
							<input type="button" value="인증번호" class="codeCheckBtn" onclick="codeMail()"/>
						</div>
						<div id="demo_email" class="form-check-str"></div>
						<div id="spinner-border">
							<div class="spinner-border"></div>
						</div>
						<div class="info-str">인증번호</div>
						<div id="infoUpdate-mail-code-input" class="info-input">
							<input type="text" name="codeW" id="codeW" placeholder="인증코드를 입력하세요." />
							<span class="codeCheckBtn">
								<input type="button" value="인증확인" onclick="codeCheckOk()"/>
							</span>
							<span id="timer"></span>
							<div id="demo_codeW" class="form-check-code-str"></div>
						</div>
					</div>
		         	<c:set var="adrs" value="${fn:split(vo.address,'/')}"></c:set>
					<div id="infoUpdate-address-div">
						<div class="info-str">주소</div>
						<div class="info-input">
					        <input type="text" name="postcode" id="sample6_postcode" value="${adrs[0]}" readonly placeholder="우편번호(필수)" >
				        	<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" />
						</div>
		         	</div>
					<div class="info-str"></div>
			        <div class="info-input">
			        	<input type="text" name="roadAddress" id="sample6_address" value="${adrs[1]}" readonly placeholder="기본주소(필수)">
			        	<input type="text" name="detailAddress" id="sample6_detailAddress" value="${adrs[2]==' '? '' : adrs[2]}" placeholder="상세주소">
			        	<input type="text" name="extraAddress" id="sample6_extraAddress" value="${adrs[3]}" placeholder="참고항목" />
					</div>
			        <div id="demo_address" class="form-check-str"></div>
					<div>
						<div class="info-str">성별</div>
						<div class="info-input">${vo.gender}</div>
					</div>
					<div id="info-update-btn"><input type="button" value="정보 수정" onclick="infoUpdateOk()"/></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>