<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="${ctp}/js/woo.js"></script>
    <style>
    	section{
    		max-width: 1024px;
    		margin: 0 auto;
    	}
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
			border-radius: 10px;
			border-style: solid;
    	}
    	.form-check-str{
    		font-size: 12px;
    		color: red;
    		text-align: left;
    		margin-left : 50px;
    		margin-right: 50px;
    	}
    	.form-check-str-Ok{
    		font-size: 12px;
    		color: green;
    		text-align: left;
    		margin-left : 50px;
    		margin-right: 50px;
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
		.join-no{
			border-style: solid;
			border-color: red;
			outline-color: red; /* 클릭시 선 생기는 거 색 변경 */
		}
		#join-div #join-email-div input[type="button"],#join-div #join-address-div input[type="button"]{
			width: 100px;
			height: 45px;
			margin-top: 20px;
			background: #402F1D;
			color: #fff;
			font-size: 0.8em;
			border-radius: 10px;
			font-weight: bold;
		}
		#join-div #join-email-div .codeCheckBtn input[type="button"]{
			width: 80px;
			height: 45px;
			margin-top: 20px;
			background: #402F1D;
			color: #fff;
			font-size: 0.8em;
			border-radius: 10px;
			font-weight: bold;
		}
		#join-div #join-email-div input[type="text"],#join-div #join-address-div input[type="text"]{
			width: 300px;
			height: 45px;
			margin-top: 20px;
			padding: 0px 10px;
		}
		#spinner-border{
			margin: 20px 50px 0px 50px;
			width: 400px;
			text-align: center;
		}
		#join-div #join-mail-code-input input[type="text"]{
			width: 190px;
			height: 45px;
			margin-top: 20px;
			padding: 0px 10px;
		}
		#join-mail-code-input{
			text-align: left;
			padding: 0px 45px;
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
    	'use script'
    	let midCheckOk = false;
    	let pwdCheckOk = false;
    	let pwdOkCheckOk = false;
    	let nameCheckOk = false;
    	let nickNameCheckOk = false;
    	let emailCheckOk = false;
    	let emailCodeCheckOk = false;
    	
    	let str = '';
    	let timerSw = 0;

    	// 타이머
    	let time = 60000;
    	let min = 1;
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
								$("#codeW").addClass("join-no");	
								$("#timer").html("시간초과");
								$("#email").attr("readonly",false);
								timerSw = 0;
			    			},
			    			error : function(){
			    				alert("전송오류(join.jsp)");
			    			}
			    		});
			    	}
    			}
    		},1000);
    	}
    	
    	// 아이디
    	$(function() {
    		$("#mid").on("keyup", midCheck)
    		$("#mid").removeClass("join-no");
    	});
    	
    	function midCheck(){
    		let mid = $("#mid").val();
    		let ragMid = /^[\w]{5,16}$/; // 정규식
    		
    		if(mid.trim() == ""){
    			str = '아이디를 입력해주세요.';
				$("#demo_id").html(str);
				$("#mid").addClass("join-no");	
				midCheckOk = false;
    		}
    		else if(!ragMid.test(mid)){
    			str = '아이디는 5~16자의 영문 소문자,숫자와 특수기호(_)만 사용 가능합니다.';
				$("#demo_id").html(str);
				$("#mid").addClass("join-no");
				midCheckOk = false;
    		}
    		else{
	    		$.ajax({
					url : "${ctp}/member/midCheck",
					type : "post",
					data : {mid : mid},
					success : function(res){
						if(res == "1"){
							str = '존재하는 아이디 입니다.';
							$("#demo_id").html(str);
							$("#mid").addClass("join-no")
							midCheckOk = false;
						}
						else if(res == "2"){
							str = '';
							$("#demo_id").html(str);
							$("#mid").removeClass("join-no")
							midCheckOk = true;
						}
					},
					error : function(){
						console.log("전송오류 (join.jsp)");
					}
				});
    		}
    	}
    	
    	// 비밀번호
    	$(function() {
    		$("#pwd").on("keyup", pwdCheck);
    	});
    	
    	function pwdCheck(){
    		let pwd = $("#pwd").val();
    		let regPwd = /^(?=.*[a-zA-Z0-9])(?=.*[~!@#$%^&*()_+[\]{}?]).{8,16}$/;
    		
    		if(pwd.trim() == ""){
    			str = '비밀번호를 입력해주세요.';
    			$("#demo_pwd").html(str);
    			$("#pwd").addClass("join-no");
    			pwdCheckOk = false;
    		}
    		else if(!regPwd.test(pwd)){
    			str = '비밀번호는 8~16자의 영문 대소문자, 숫자,특수문자(~!@#$%^&*()_+[]{}?)를 각각 1자이상 포함되어야 합니다.'
    			$("#demo_pwd").html(str);
    			$("#pwd").addClass("join-no");
    			pwdCheckOk = false;
    		}
    		else{
				str = '';
				$("#demo_pwd").html(str);
				$("#pwd").removeClass("join-no");
				pwdCheckOk = true;
    		}
    	}
    	
    	// 비밀번호 확인
    	$(function() {
    		$("#pwdCk").on("keyup", pwdOkCheck);
    	});
    	
    	function pwdOkCheck(){
    		let pwdCk = $("#pwdCk").val();
    		let pwd = $("#pwd").val();
    		let regPwd = /^(?=.*[a-zA-Z0-9])(?=.*[~!@#$%^&*()_+[\]{}?]).{8,16}$/;
    		
    		if(pwdCk.trim() == ""){
    			str = '비밀번호를 입력해주세요.';
    			$("#demo_pwdCk").html(str);
    			$("#pwdCk").addClass("join-no");
    			pwdOkCheckOk = false;
    		}
    		else if(pwdCk != pwd){
    			str = '작성하신 비밀번호와 같지 않습니다.'
    			$("#demo_pwdCk").html(str);
    			$("#pwdCk").addClass("join-no");
    			pwdOkCheckOk = false;
    		}
    		else if(!regPwd.test(pwdCk)){
    			str = '작성하신 비밀번호와 같지 않습니다.'
    			$("#demo_pwdCk").html(str);
    			$("#pwdCk").addClass("join-no");
    			pwdOkCheckOk = false;
    		}
    		else{
				str = '';
				$("#demo_pwdCk").html(str);
				$("#pwdCk").removeClass("join-no");
				pwdOkCheckOk = true;
    		}
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
    			$("#name").addClass("join-no");
    			nameCheckOk = false;
    		}
    		else if(!regName.test(name)){
    			str = '성명은 2~10글자의 한글로만 사용 가능합니다.'
    			$("#demo_name").html(str);
    			$("#name").addClass("join-no");
    			nameCheckOk = false;
    		}
    		else{
				str = '';
				$("#demo_name").html(str);
				$("#name").removeClass("join-no");
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
    			$("#nickName").addClass("join-no");
    			nickNameCheckOk = false;
    		}
    		else if(!regNickName.test(nickName)){
    			str = '닉네임은 2~8글자의 영문대소문자 한글 숫자로만 사용 가능합니다.'
    			$("#demo_nickName").html(str);
    			$("#nickName").addClass("join-no");
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
    		    			$("#nickName").addClass("join-no");
    		    			nickNameCheckOk = false;
    					}
    					else if(res == "2"){
    						str = '';
    						$("#demo_nickName").html(str);
    		    			$("#nickName").removeClass("join-no");
    		    			nickNameCheckOk = true;
    					}
    				},
    				error : function(){
    					alert("전송오류(join.jsp)")
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
    			$("#email").addClass("join-no");
    			emailCheckOk = false;
    		}
    		else if(!regEmail.test(email)){
    			str = '이메일 형식이 맞춰서 작성해주세요.';
    			$("#demo_email").html(str);
    			$("#email").addClass("join-no");
    			emailCheckOk = false;
    		}
    		else {
    			str = '';
    			$("#demo_email").html(str);
    			$("#email").removeClass("join-no");
    			emailCheckOk = true;
    		}
    	}
    	
    	// 메일 인증코드 전송전 가릴 부분
    	$(function() {
    		$("#spinner-border").hide();
    		$("#join-mail-code-input").hide();
    	});
    	
    	// 메일 인증코드 전송(버튼 누를 시)
    	function codeMail(){
    		let email = $("#email").val();
    		
    		if(emailCheckOk == false){
    			$("#demo_email").addClass("form-check-str");
        		$("#demo_email").removeClass("form-check-str-Ok");
    			str = '이메일을 형식에 맞춰 작성 후 인증번호를 발급 받아주세요.';
    			$("#demo_email").html(str);
	   			$("#email").addClass("join-no");
    		}
    		else if(timerSw == 1){
    			// 타이머가 끝나지 않았을 경우 (세션이 삭제 안된 경우) 코드입력 부분으로 포커스
    			$("#codeW").focus();
    		}
    		else {
    			// 이메일 전송을 누를 시에 타이머 <분,초> 설정 및 클래스 등 설정 (인증번호 전송을 여러번 눌렀을 시.. 초기화..)
	    		timerSw = 1; //타이머를 누를 시 스위치 1로 변환

    			time = 60000; //3분
    	    	min = 1;
    	    	sec = 60;
				str = '';
    			$("#demo_codeW").html(str);
	   			$("#codeW").removeClass("join-no");
	   			
	    		$("#join-mail-code-input").hide();
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
    		    			$("#email").addClass("join-no");
    		    			$("#spinner-border").hide();
    		    			emailCodeCheckOk = false;
    					}
    					else if(res == "2"){
							str = '입력하신 메일로 인증번호가 전송되었습니다.';
							$("#email").attr("readonly",true);
    		    			$("#demo_email").removeClass("form-check-str");
    		    			$("#demo_email").addClass("form-check-str-Ok");
    		    			$("#demo_email").html(str);
    		    			$("#email").removeClass("join-no");
    		    			$("#spinner-border").hide();
    		    			$("#join-mail-code-input").show();
    		    			emailCodeCheckOk = false;
    		    			codeTimer()
    					}
    				},
    				error : function(){
    					alert("전송오류(join.jsp)")
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
    			$("#codeW").addClass("join-no");
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
			    			$("#codeW").removeClass("join-no");
	    					$("#codeW").attr("readonly",true);
	    					$("#email").attr("readonly",true);
	    					emailCodeCheckOk = true;
	    				}
	    				else if(res == "2"){
	    					str = '인증번호가 만료되었습니다. 인증번호를 다시 발급받아 주세요.';
			    			$("#demo_codeW").html(str);
			    			$("#codeW").addClass("join-no");
			    			$("#codeW").focus();
			    			emailCodeCheckOk = false;
	    				}
	    				else if(res == "3"){
	    					str = '인증번호를 다시 확인해주세요.';
			    			$("#demo_codeW").html(str);
			    			$("#codeW").addClass("join-no");
			    			$("#codeW").focus();
			    			emailCodeCheckOk = false;
	    				}
	    			},
	    			error : function(){
	    				alert("전송오류(join.jsp)");
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
    	function joinOk(){
    		let adr = $("#sample6_postcode").val();
    		
    		if(midCheckOk != true){
    			str = '아이디를 확인해주세요.';
    			$("#demo_id").html(str);
    			$("#mid").focus();
    			$("#mid").addClass("join-no");	
    			return false;
    		}
    		else if(pwdCheckOk != true){
    			str = '비밀번호를 확인해주세요.';
    			$("#demo_pwd").html(str);
    			$("#pwd").focus();
    			$("#pwd").addClass("join-no");	
    			return false;
    		}
    		else if(pwdOkCheckOk != true){
    			str = '비밀번호를 확인해주세요.';
    			$("#demo_pwdCk").html(str);
    			$("#pwdCk").focus();
    			$("#pwdCk").addClass("join-no");	
    			return false;
    		}
    		else if(nameCheckOk != true){
    			str = '성명을 확인해주세요.';
    			$("#demo_name").html(str);
    			$("#name").focus();
    			$("#name").addClass("join-no");	
    			return false;
    		}
    		else if(nickNameCheckOk != true){
    			str = '닉네임을 확인해주세요.';
    			$("#demo_nickName").html(str);
    			$("#nickName").focus();
    			$("#nickName").addClass("join-no");	
    			return false;
    		}
    		else if(emailCheckOk != true){
    			str = '이메일을 확인해주세요.';
    			$("#demo_email").html(str);
    			$("#email").focus();
    			$("#email").addClass("join-no");	
    			return false;
    		}
    		else if(emailCodeCheckOk != true){
    			str = '인증번호를 인증해주세요.';
    			$("#demo_email").html(str);
    			$("#email").focus();
    			$("#email").addClass("join-no");	
    			$("#demo_email").addClass("form-check-str");
    			$("#demo_email").removeClass("form-check-str-Ok");
    			return false;
    		}
    		else if(adr.trim() == ""){
    			str = '주소을 확인해주세요.';
    			$("#demo_address").html(str);
    			$("#sample6_postcode").focus();
    			$("#sample6_postcode").addClass("join-no");	
    			$("#sample6_address").addClass("join-no");	
    			return false;
    		}
    		else { 
    			// 전송전에 '주소'를 하나로 묶어서 전송처리 준비
            	let postcode = joinForm.postcode.value;
            	let roadAddress = joinForm.roadAddress.value;
            	let detailAddress = joinForm.detailAddress.value;
            	let extraAddress = joinForm.extraAddress.value;
            	joinForm.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
            	
            	joinForm.submit();
    		}
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<main>
	<section>
		<div id="join-div">
			<div><img src="${ctp}/data/images/다모아로고1.png" width="180px"></div>
			<h3>기본정보</h3>
			
			<form name="joinForm" method="post">
				<div>
					<input type="text" name="mid" id="mid" required placeholder="아이디(필수)" />
					<div id="demo_id" class="form-check-str"></div>
				</div>
				<div>
					<input type="password" name="pwd" id="pwd" required placeholder="비밀번호(필수)" />
					<div id="demo_pwd" class="form-check-str"></div>
				</div>
				<div>
					<input type="password" name="pwdCk" id="pwdCk" required placeholder="비밀번호 확인(필수)" />
					<div id="demo_pwdCk" class="form-check-str"></div>
				</div>
				<div>
					<input type="text" name="name" id="name" required placeholder="성명(필수)" />
					<div id="demo_name" class="form-check-str"></div>
				</div>
				<div>
					<input type="text" name="nickName" id="nickName" required placeholder="닉네임(필수)" />
					<div id="demo_nickName" class="form-check-str"></div>
				</div>
				<div id="join-email-div">
					<input type="text" name="email" id="email" required placeholder="이메일(필수)" />
					<input type="button" value="인증번호" class="codeCheckBtn" onclick="codeMail()"/>
					<div id="demo_email" class="form-check-str"></div>
					<div id="spinner-border">
						<div class="spinner-border"></div>
					</div>
					<div id="join-mail-code-input">
						<input type="text" name="codeW" id="codeW" placeholder="인증코드를 입력하세요." />
						<span class="codeCheckBtn">
							<input type="button" value="인증확인" onclick="codeCheckOk()"/>
						</span>
						<span id="timer"></span>
						<div id="demo_codeW" class="form-check-code-str"></div>
					</div>
				</div>
				<div id="join-address-div">
			        <input type="text" name="postcode" id="sample6_postcode" readonly placeholder="우편번호(필수)" >
		        	<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" />
	         	</div>
		        <input type="text" name="roadAddress" id="sample6_address" readonly placeholder="기본주소(필수)">
		        <div>
		        	<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소">
			        <div> 
			        	<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" />
			        </div>
			        <div id="demo_address" class="form-check-str"></div>
				</div>
				<div>
					<input type="radio" name="gender" id="gender1" checked value="남자"/><label for="gender1">남자</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
					<input type="radio" name="gender" id="gender2" value="여자"/><label for="gender2">여자</label>
				</div>
				<div>
					<input type="checkbox" id="adYN" name="adYN" value="Y"/>&nbsp;<label for="adYN"><span style="color:red;">(선택)</span> 정보/이벤트 메일 수신에 동의합니다.</label>
				</div>
				<div>
					<input type="button" value="회원가입" onclick="joinOk()" />
				</div>
				<input type="hidden" name="address" id="address" />
			</form>
		</div>
	</section>
</main>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>