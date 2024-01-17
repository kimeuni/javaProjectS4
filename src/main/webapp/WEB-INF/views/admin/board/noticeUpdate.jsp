<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 수정</title>
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
    		width: 90%;
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    		display: inline-block;
    	}
    	#back-btn{
    		width: 80px;
    		background-color: #fff;
    		border : 1px solid #315eb2;
    		color: #315eb2;
    		font-weight: bold;
    		height: 27px;
    		line-height : 27px;
    		display: inline-block;
    		border-radius: 5px;
    		margin-right: 10px;
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
    	.notice-flex-div{
    		display: flex;
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
    	function noticeUpdateOk(){
    		let title = $("#title").val();
    		let content = CKEDITOR.instances.CKEDITOR.getData();
    		let openSw;
	    	if(document.getElementsByName("openSw")[0].checked) openSw = "Y"; 
	    	else if(document.getElementsByName("openSw")[1].checked) openSw = "N"; 
	    	
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
    			let query = {
    				idx : ${vo.idx},
    				nickName : '${sNickName}',
    				title : title,
    				content : content,
    				openSw : openSw
    			}
    			
    			$.ajax({
    				url : "${ctp}/admin/noticeUpdate",
    				type : "post",
    				data : query,
    				success : function(res){
    					if(res == "1"){
    						alert("공지사항이 수정되었습니다.");
    						location.href='${ctp}/admin/noticeManagement';
    					}
    					else if(res == "2"){
    						alert("공지사항 수정에 실패하였습니다.");
    						location.href='${ctp}/admin/noticeUpdate';
    					}
    				},
    				error : function(){
    					alert("전송 오류(noticeUpdate.jsp)")
    				}
    			});
    		}
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-notice-container">
		<div id="admin-notice-right-content">
			<div id="top-menu-str">공지사항 수정</div>
			<div id="admin-notice-right-inner-content">
				<div id="admin-notice-menu">
					<div class="notice-flex-div">
						<div id="admin-notice-menu-str">공지사항 수정 <i class="fa-solid fa-pencil"></i></div>
						<a href="${ctp}/admin/noticeManagement"><div id="back-btn">돌아가기</div></a>
					</div>
					<div>
						<div id="notice-title-input">
							<input type="text" name="title" id="title" maxlength="40" value="${vo.title}" required placeholder="제목을 입력하세요." />
							<span id="demo-title-str-cnt">(${fn:length(vo.title)}/40)</span>
						</div>
					</div>
					<div>
						<textarea rows="6" name="content" id="CKEDITOR" required>${vo.content}</textarea>
						<script>
				        CKEDITOR.replace("content",{
				        	height:400,
				        	filebrowserUploadUrl:"${ctp}/imageUpload",
				        	uploadUrl : "${ctp}/imageUpload" 
				        });
				        </script>
					</div>
					<div id="radio-btn-div">
						<input type="radio" name="openSw" id="open" value="Y" ${vo.openSw == 'Y'? 'checked' : ''}/>공개 &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="openSw" id="close" value="N" ${vo.openSw == 'N'? 'checked' : ''} />비공개
					</div>
					<div id="btn-div">
						<input type="button" value="공지 수정"  onclick="noticeUpdateOk()" />
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>