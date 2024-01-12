<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인화면 광고 등록</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-adInput-right-content{
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
    	#admin-adInput-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 110px; 
    		margin-bottom: 60px; 
    	}
    	#admin-adInput-menu{
    		margin: 0 auto;
    		width : 100%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#admin-adInput-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    </style>
    <script>
    	'use strict'
    	
    	$(function() {
    		let mainImg = $("#mainImg").val();
    		if(mainImg == ""){
	   			$("#mainImge").attr("src", '${ctp}/data/advertisement/이미지선택.png');
    		}
    	});
    
	    // 선택한 이미지 화면에 출력 (미리보기)
	    function imgCheck(e){
	    	if(e.files && e.files[0]){
	    		let reader = new FileReader();
				reader.onload = function(e){
					document.getElementById("mainImge").src = e.target.result;
				}
				reader.readAsDataURL(e.files[0]);
			}
	    }
	    
	    // 광고 등록
	    function mainAdInput(){
	    	let mainImg = document.getElementById("mainImg").value;
	    	let url = document.getElementById("url").value;
	  		
	    	if(mainImg.trim() == ""){
	    		alert("이미지를 등록해주세요.");
	    		return false;
	    	}
	  		else if(url.trim() == ""){
	  			alert("url 주소를 입력해주세요.");
	  			return false;
	  		}
	  		else if(mainImg.trim() != "") {
	  			alert("들어옴")
		    	let ext = mainImg.substring(mainImg.lastIndexOf(".")+1).toLowerCase();
		    	let maxSize = 1024 * 1024 * 10;
		    	let fileSize = document.getElementById("mainImg").files[0].size;
		  		// 업로드 가능한 확장명 파일
		  		if(ext != 'jpg' && ext != 'gif'&& ext != 'png' && ext != 'jpeg'){
					alert("업로드 가능한 파일은 'jpg/gif/png/jpeg'만 가능합니다.")
					return false;
				}
				// 파일 용량 체크
				else if(fileSize > maxSize) {
					alert("업로드할 파일의 최대용량은 10MByte입니다.");
					return false;
				}
		    	else {
		    		adForm.submit();
		    	}
	  		}
	    }
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-adInput-container">
		<div id="admin-adInput-right-content">
			<div id="top-menu-str">메인화면 광고 등록</div>
			<div id="admin-adInput-right-inner-content">
				<div id="admin-adInput-menu">
					<div id="admin-adInput-menu-str">메인화면 광고 등록 <i class="fa-solid fa-pencil"></i></div>
					<hr/>
						<div style="text-align: left">
							1. 메인 광고 이미지는 <span style="color: red">가로 320px 세로 320px로 고정</span>되어 보입니다. 비율 혹은 크기를 맞춰서 등록해주세요. <br/>
							2. 등록 시, <span style="color: red">화면 공개유무는 자동으로 '비공개'</span>로 올라갑니다. <span style="color: red">메인화면 광고 관리에서 메인에 띄울 광고를 '공개'설정</span> 해주세요.
						</div>
					<hr/>
					<form name="adForm" method="post" enctype="multipart/form-data" >
						<div>
							<div>
								<input type="file"  name="mainImg" id="mainImg" onchange="imgCheck(this)" />
								<div>메인광고 이미지 미리보기</div>
								<div id="mainImg-demo">
									<img id="mainImge" width="120px" height="120px">
								</div>
							</div>
							<div>
								<input type="url" name="url" id="url" required placeholder="url을 입력하세요(필수)"/>
							</div>
							<div>
								<input type="button" value="메인화면 광고 등록" onclick="mainAdInput()"/>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>