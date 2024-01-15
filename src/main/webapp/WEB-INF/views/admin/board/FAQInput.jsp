<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자주하는 질문 등록</title>
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-FAQ-right-content{
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
    		background-color: #fff;
			height: 50px;
			color: #000;
			font-weight: bold;
			font-size: 1.5em;
			padding-left: 30px;
			line-height: 50px;
			border-bottom: 1px solid;
			box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
    	}
    	#admin-FAQ-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 110px; 
    		margin-bottom: 60px; 
    	}
    	#admin-FAQ-menu{
    		margin: 0 auto;
    		width : 100%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#admin-FAQ-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#FAQ-title-input{
    		text-align: left;
    		display: inline-block;
    		width: 86%;
    	}
    	#FAQ-category-div{
    		text-align: left;
    		display: inline-block;
    		width: 13%;
    	}
    	#FAQ-category-div select{
    		height: 40px;
    	}
    	#FAQ-title-input input[type="text"]{
    		width: 86%;
    		height: 40px;
    		margin-bottom: 20px;
    	}
    	#btn-div input[type="button"]{
    		height: 40px;
    		border: 1px solid gray;
    		width: 450px;
    		border-radius: 5px;
    		text-align: center;
    		background-color: #315eb2;
    		color: #fff;
    		font-weight: bold;
    	}
    	#FAQ-answer-div{
    		margin-bottom: 20px;
    	}
    </style>
    <script>
    	'use strict'
    	
    	let str = '';
    	
    	// 글자 수 체크
    	$(function() {
    		$("#question").on("keyup", titleStrCnt);
    	});
    	function titleStrCnt(){
    		let question = $("#question").val();
    		
    		str = '('+question.length+'/40)';
    		$("#demo-question-str-cnt").html(str);
    		
    		if(question.length > 40){
    			alert("제목은 최대 40글자까지 가능합니다.");
	    		str = '(40/40)';
	    		("#question").val().substring(0,40);
	    		$("#demo-question-str-cnt").html(str);
    		}
    	}
    	
    	
    	// 공지 등록하러 가기
    	function FAQInputOk(){
    		let category = $("#category").val();
    		let question = $("#question").val();
    		let answer = $("#answer").val();
	    	
    		if(category.trim() == ""){
    			alert("카테고리를 선택해주세요.");
    			return false;
    		}
    		else if(question.trim() == ""){
    			alert("질문을 입력해주세요.");
    			$("#question").focus();
    			return false;
    		}
    		else if(answer.trim() == ""){
    			alert("답변을 입력해주세요.");
    			$("#answer").focus();
    			return false;
    		}
    		else{
    			let query = {
   					category : category,
   					question : question,
   					answer : answer
    			}
    			
    			$.ajax({
    				url : "${ctp}/admin/FAQInput",
    				type : "post",
    				data : query,
    				success : function(res){
    					if(res == "1"){
    						alert("자주하는 질문이 등록되었습니다.");
    						location.reload();
    					}
    					else if(res == "2"){
    						alert("자주하는 질문이 등록에 실패하였습니다.");
    						location.reload();
    					}
    				},
    				error : function(){
    					alert("전송 오류(FAQInput.jsp)")
    				}
    			});
    		}
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-FAQ-container">
		<div id="admin-FAQ-right-content">
			<div id="top-menu-str">자주하는 질문 등록</div>
			<div id="admin-FAQ-right-inner-content">
				<div id="admin-FAQ-menu">
					<div id="admin-FAQ-menu-str">자주하는 질문 등록 <i class="fa-solid fa-pencil"></i></div>
					<div>
						<div id="FAQ-category-div">
							<select name="category" id="category">
								<option value="">카테고리 선택</option>
								<option value="채팅">채팅</option>
								<option value="알림">알림</option>
								<option value="검색">검색</option>
								<option value="계정/로그인">계정/로그인</option>
								<option value="기타">기타</option>
							</select>
						</div>
						<div id="FAQ-title-input">
							<input type="text" name="question" id="question" maxlength="40" required placeholder="질문을 입력하세요." />
							<span id="demo-question-str-cnt">(0/40)</span>
						</div>
					</div>
					<div id="FAQ-answer-div">
						<textarea rows="15" name="answer" id="answer" required class="form-control" ></textarea>
					</div>
					<div id="btn-div">
						<input type="button" value="자주하는 질문 등록"  onclick="FAQInputOk()" />
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>