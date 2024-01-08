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
    		position: fixed;
    		width: 100%;
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
    		margin-top: 110px; 
    		margin-bottom: 60px; 
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
    		margin-left: 23%;
    		font-size: 12px;
    	}
    	.update-no{
    		height: 20px;
    		color: red;
    		margin-left: 23%;
    	}
    	#myPage-pwdUpdate hr{
    		margin: 5px 0px;
    	}
    	#pwdBtn{
    		text-align: center;
    	}
    	#pwdBtn input[type="button"]{
    		margin-top : 15px;
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
    	
    	let str ='';
    	
    	// 공백일 시 나온 오류 문구 키보드 칠시 사라지도록 처리
    	$(function() {
    		$("#pwd").on("keyup",function() {
    			let pwd = $("#pwd").val();
    			if(pwd.trim() != ''){
	    			str = '';
	    			$("#demo-pwd").html(str);
    			}
    		});
    	});
    	$(function() {
    		$("#nPwd").on("keyup",function() {
    			let nPwd = $("#nPwd").val();
    			if(nPwd.trim() != ''){
	    			str = '';
	    			$("#demo-nPwd").html(str);
    			}
    		});
    	});
    	$(function() {
    		$("#nPwdCk").on("keyup",function() {
    			let nPwdCk = $("#nPwdCk").val();
    			if(nPwdCk.trim() != ''){
	    			str = '';
	    			$("#demo-nPwdCk").html(str);
    			}
    		});
    	});
    	
    	// 비밀번호 수정 처리
    	function pwdUpdateOk(){
    		let pwd = $("#pwd").val();
    		let nPwd = $("#nPwd").val();
    		let nPwdCk = $("#nPwdCk").val();
    		let regPwd = /^(?=.*[a-zA-Z0-9])(?=.*[~!@#$%^&*()_+[\]{}?]).{8,16}$/;
    		
    		if(pwd.trim() == ""){
    			str ='현재 비밀번호를 입력해주세요.';
    			$("#demo-pwd").html(str);
    		}
    		else if(nPwd.trim() == ""){
    			str ='새 비밀번호를 입력해주세요.';
    			$("#demo-nPwd").html(str);
    		}
    		else if(!regPwd.test(nPwd)){
    			str = '비밀번호는 8~16자의 영문 대소문자, 숫자,특수문자(~!@#$%^&*()_+[]{}?)를 각각 1자이상 포함되어야 합니다.'
   				$("#demo-nPwd").html(str);
    		}
    		else if(nPwdCk.trim() == ""){
    			str ='새 비밀번호 확인을 입력해주세요.';
    			$("#demo-nPwdCk").html(str);
    		}
    		else if(nPwd != nPwdCk){
    			str ='새 비밀번호화 비밀번호 확인이 일치하지 않습니다.';
    			$("#demo-nPwdCk").html(str);
    		}
    		else {
    			let query = {
    				pwd : pwd,
    				nPwd : nPwd,
    			}
    			
    			$.ajax({
    				url : "${ctp}/member/pwdUpdate",
    				type : "post",
    				data : query,
    				success : function(res){
    					if(res == "1"){
    						str ='현재 비밀번호가 일치하지 않습니다.';
    		    			$("#demo-pwd").html(str);
    					}
    					else if(res == "2"){
    						str ='현재 비밀번호와 새 비밀번호가 동일합니다.';
    		    			$("#demo-update-no").html(str);
    					}
    					else if(res == "3"){
    						alert("비밀번호가 변경되었습니다.")
    						location.reload();
    					}
    				},
    				error : function(){
    					alert("전송오류(pwdUpdate.jsp)");
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
					<div id="pwdBtn"><input type="button" value="비밀번호 변경" onclick="pwdUpdateOk()" /></div>
					<div id="demo-update-no" class="update-no"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>