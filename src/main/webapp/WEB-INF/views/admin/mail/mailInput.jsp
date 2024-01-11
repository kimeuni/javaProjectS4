<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>광고메일 전송</title>
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-mail-right-content{
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
    	#admin-mail-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 80px; 
    		margin-bottom: 30px; 
    	}
    	#admin-mail-menu{
    		margin: 0 auto;
    		width : 100%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#admin-mail-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#mail-title-input{
    		text-align: left;
    	}
    	#mail-title-input input[type="text"]{
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
    	#content-div{
    		margin-bottom: 20px;
    	}
    </style>
    <script>
    	'use strict'
    	
    	let str = '';
    	
    	$(function() {
    		$(".spinner-border").hide();
    		$("#mail-input-btn").show();
    	});
    	
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
    	function mailInputOk(){
    		let title = $("#title").val();
    		let content = CKEDITOR.instances.CKEDITOR.getData();
	    	
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
    			$(".spinner-border").show();
    			$("#mail-input-btn").hide();
    			
    			let query = {
    				title : title,
    				content : content,
    			}
    			
    			$.ajax({
    				url : "${ctp}/admin/mailInput",
    				type : "post",
    				data : query,
    				success : function(res){
    					if(res == "2"){
    						alert("메일이 전송 되었습니다.");
    						location.reload();
    					}
    					else if(res == "1"){
    						alert("메일 전송에 실패하였습니다.");
    						location.reload();
    					}
    				},
    				error : function(){
    					alert("전송 오류(mailInput.jsp)")
    				}
    			});
    		}
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-mail-container">
		<div id="admin-mail-right-content">
			<div id="top-menu-str">광고메일 전송</div>
			<div id="admin-mail-right-inner-content">
				<div id="admin-mail-menu">
					<div id="admin-mail-menu-str">광고메일 전송 <i class="fa-solid fa-pencil"></i></div>
					<hr/>
						<div style="text-align: left">
							1. <span style="color : red">광고/이벤트 수신 동의</span>한 계정에 한하여 전송되는 이메일 입니다.<br/>
							2. 동일한 이메일로 여러개의 계정을 만들었다 하여도 해당 계정에는 메일이 <span style="color : red">1개만 전송</span>됩니다.<br/>
							3. 광고 메일로 전송한 이미지의 크기는 <span style="color : red">가로: 650px 세로: 800px로 고정</span>되오니, 크기를 맞춰서 이미지를 넣어주시기 바랍니다.
						</div>
					<hr/>
					<div>
						<div id="mail-title-input">
							<input type="text" name="title" id="title" maxlength="40" required placeholder="제목을 입력하세요." />
							<span id="demo-title-str-cnt">(0/40)</span>
						</div>
					</div>
					<div id="content-div">
						<textarea rows="6" name="content" id="CKEDITOR" required></textarea>
						<script>
				        CKEDITOR.replace("content",{
				        	height:400,
				        	filebrowserUploadUrl:"${ctp}/imageUpload",
				        	uploadUrl : "${ctp}/imageUpload" 
				        });
				        </script>
					</div>
					<div id="btn-div">
						<input type="button" value="광고메일 전송" id="mail-input-btn"  onclick="mailInputOk()" />
						<div class="spinner-border"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>