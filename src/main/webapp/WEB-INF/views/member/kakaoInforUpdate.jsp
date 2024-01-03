<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>정보수정</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="${ctp}/js/woo.js"></script>
    <style>
    	#kakao-infor-update-div{
    		min-width: 1024px;
    		margin: 0 auto;
    		margin-top: 100px;
    		text-align: center;
    	}
    	#kakao-infor-update{
    		margin: 0 auto;
    		width: 800px;
    		min-height: 500px; 
    		border: 1px solid; 
    		border-radius: 20px;
    		padding: 20px 30px;
    	}
    	.update-no{
			border-style: solid;
			border-color: red;
			outline-color: red; 
		}
		#kakao-infor-text{
			text-align: left;
			font-size: 18px;
		}
		#update-main-logo{
			margin-bottom: 10px;
		}
		#kakao-infor-text-sub{
			font-size: 14px;
			color : #5F49A6
		}
		#kakao-infor-update input[type="text"]{
			width: 600px;
			height: 35px;
			border-style: solid;
			border-radius: 10px;
			margin-top: 15px;
			padding: 0px 15px;
		}
		#demo_id, #demo_address{
			height: 15px;
			text-align: left;
			padding-left: 70px;	
			
		}
		#join-address-div{
			text-align : left;
			padding-left: 70px;	
		}
		#join-address-div input[type="text"]{
			width: 200px;
		}
		.form-check-str{
    		font-size: 12px;
    		color: red;
    	}
    </style>
    <script>
    	'use strict'
    	
    	let midCheckOk = true;
    	let str = '';
    	
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
    	
    	// 아이디
    	$(function() {
    		$("#mid").on("keyup", midCheck)
    		$("#mid").removeClass("update-no");
    	});
    	
    	function midCheck(){
    		let mid = $("#mid").val();
    		let ragMid = /^[\w]{5,16}$/; // 정규식
    		
    		if(mid.trim() == ""){
    			str = '아이디를 입력해주세요.';
				$("#demo_id").html(str);
				$("#mid").addClass("update-no");	
				midCheckOk = false;
    		}
    		else if(!ragMid.test(mid)){
    			str = '아이디는 5~16자의 영문 소문자,숫자와 특수기호(_)만 사용 가능합니다.';
				$("#demo_id").html(str);
				$("#mid").addClass("update-no");
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
							$("#mid").addClass("update-no")
							midCheckOk = false;
						}
						else if(res == "2"){
							str = '';
							$("#demo_id").html(str);
							$("#mid").removeClass("update-no")
							midCheckOk = true;
						}
					},
					error : function(){
						console.log("전송오류 (kakaoInforUpdate.jsp)");
					}
				});
    		}
    	}
    	
    	function kakaoInforUp(){
    		let mid = $("#mid").val();
    		let adr = $("#sample6_postcode").val();
    		
    		if(midCheckOk != true){
    			str = '아이디를 확인해주세요.';
    			$("#demo_id").html(str);
    			$("#mid").focus();
    			$("#mid").addClass("update-no");	
    			return false;
    		}
    		else if(adr.trim() == ""){
    			str = '주소을 확인해주세요.';
    			$("#demo_address").html(str);
    			$("#sample6_postcode").focus();
    			$("#sample6_postcode").addClass("update-no");	
    			$("#sample6_address").addClass("update-no");	
    			return false;
    		}
    		else { 
    			
    			// 전송전에 '주소'를 하나로 묶어서 전송처리 준비
            	let postcode = kakaoUpdateForm.postcode.value;
            	let roadAddress = kakaoUpdateForm.roadAddress.value;
            	let detailAddress = kakaoUpdateForm.detailAddress.value;
            	let extraAddress = kakaoUpdateForm.extraAddress.value;
            	kakaoUpdateForm.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
            	
            	kakaoUpdateForm.submit();
    		}
    	}
    </script>
</head>
<body>
    <div id="kakao-infor-update-div">
    	<div id="kakao-infor-update">
    		<div id="update-main-logo"><a href='${ctp}/damoa'><img src="${ctp}/data/images/다모아로고1.png" height="65px;"></a></div>
    		<div id="kakao-infor-text">
	    		안녕하세요. 다모아를 이용해주셔서 감사합니다. <br/>
	    		카카오로 첫 로그인시, 필수 입력 정보를 작성 후 이용이 가능합니다. <br/>
	    		양해 부탁드립니다. <br/><br/>
	    		<div id="kakao-infor-text-sub">
	    			<i class="fa-solid fa-check"></i> 변경한 정보를 통하여 일반 로그인도 가능합니다. <br/>
	    			<i class="fa-solid fa-check"></i> 아이디는 해당 페이지에서 변경 후, 수정이 불가능하오니 신중히 작성 부탁드립니다. <br/>
	    			<i class="fa-solid fa-check"></i> 그외의 정보는 마이페이지에서 수정 가능합니다. <br/>
	    			<i class="fa-solid fa-check"></i> 해당 화면에서 <span style="color:red">1.아이디 2.주소 3.성별 4.광고메일 우뮤</span> 수정 가능합니다. <br/>
	    		</div>
    		</div>
    		<hr/>
    		<form name="kakaoUpdateForm" method="post" action="${ctp}/member/kakaoInforUpdate">
	   			<div>
	    			<input type="text" name="mid" id="mid" value="${vo.mid}" required placeholder="아이디(필수)"/>
	    			<div id="demo_id" class="form-check-str"></div>
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
	   				<input type="button" value="정보 수정" onclick="kakaoInforUp()"/>
	   			</div>
	   			<input type="hidden" name="email" id="email" value="${vo.email}"/>
	   			<input type="hidden" name="address" id="address" />
    		</form>
    	</div>
    </div>
</body>
</html>