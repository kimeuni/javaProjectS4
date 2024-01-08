<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 등록</title>
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-notice-right-content{
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
    	#admin-notice-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 110px; 
    		margin-bottom: 60px; 
    	}
    	#admin-notice-menu{
    		margin: 0 auto;
    		width : 100%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#admin-notice-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#notice-title-input{
    		text-align: left;
    	}
    	#notice-title-input input[type="text"]{
    		width: 90%;
    		height: 40px;
    		margin-bottom: 20px;
    	}
    	#radio-btn-div{
    		margin: 20px 0px;
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
    </style>
    <script>
    	'use strict'
    	
    	let str = '';
    	
    	// 글자 수 체크
    	$(function() {
    		$("#title").on("keyup", titleStrCnt);
    	});
    	function titleStrCnt(){
    		let title = $("#title").val();
    		
    		str = '('+title.length+'/40)';
    		$("#demo-title-str-cnt").html(str);
    		
    		if(title.length > 40){
    			alert("제목은 최대 40글자까지 가능합니다.");
	    		str = '(40/40)';
	    		$("#demo-title-str-cnt").html(str);
    		}
    	}
    	
    	// 공지 등록하러 가기
    	function noticeInputOk(){
    		let title = $("#title").val();
    		let content = $("#CKEDITOR").val();
    		
    		if(title.trim() == ""){
    			alert("제목을 입력해주세요.");
    			$("#title").focus();
    			return false;
    		}
    		else if(content.trim() == ""){
    			alert("내용을 입력해주세요.");
    			$("#CKEDITOR").focus();
    			return false;
    		}
    		else{
    			
    		}
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-notice-container">
		<div id="admin-notice-right-content">
			<div id="top-menu-str">공지사항 등록</div>
			<div id="admin-notice-right-inner-content">
				<div id="admin-notice-menu">
					<div id="admin-notice-menu-str">공지사항 등록 <i class="fa-solid fa-pencil"></i></div>
					<form name="noticeForm" method="post">
						<div>
							<div id="notice-title-input">
								<input type="text" name="title" id="title" maxlength="40" required placeholder="제목을 입력하세요." />
								<span id="demo-title-str-cnt">(0/40)</span>
							</div>
						</div>
						<div>
							<textarea rows="6" name="content" id="CKEDITOR" required></textarea>
							<script>
					        CKEDITOR.replace("content",{
					        	height:400,
					        	filebrowserUploadUrl:"${ctp}/imageUpload", /* 파일(이미지 등) 업로드시에 매필경로[직접 만듬] */
					        	uploadUrl : "${ctp}/imageUpload" //여러개의 그림파일을 드래그&드롭해서 올릴 수 있다. //업로드 시키는 파일의 위치
					        });
					        </script>
						</div>
						<div id="radio-btn-div">
							<input type="radio" name="openSW" id="open" value="Y" checked />공개 &nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="openSW" id="close" value="N" />비공개
						</div>
						<div id="btn-div">
							<input type="button" value="공지 등록"  onclick="noticeInputOk()" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>