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
    	}
    </style>
    <script>
    	'use strict'
    	
    	let str = ''
    	
    	$(function() {
    		$(".spinner-border").hide();
    		$("#login-btn").hide();
    		$("#restore-btn").show();
    	});
    	
    	function restoreOk(){
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