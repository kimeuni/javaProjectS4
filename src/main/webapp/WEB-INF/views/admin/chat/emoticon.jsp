<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이모티콘 관리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-main-right-content{
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
    	#admin-main-right-inner-content{
    		margin: 0 auto;
    		width: 100%;
    		margin-top: 80px; 
    		margin-bottom: 20px; 
    	}
    	#admin-main-menu{
    		margin: 0 auto;
    		width : 75%;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#admin-main-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#img-url-div{
    		text-align: left;
    		padding-left: 30px;
    	}
    	#file-btns-div {
    		margin: 15px 0px;
    	}
    	#file-btns-div b{
    		height: 25px;
    		width: 70px;
    		border: 1px solid;
    		padding: 10px;
    		cursor: pointer;
    		background-color: #fff;
    		margin-right: 10px;
    	}
    	#file-btns-div a{
    		color: gray;
    		text-decoration: none;
    	}
    	#file-btns-div input[type="file"]{
    		position : absolute;
    		height: 1px;
    		width: 1px;
    		margin: -1px;
    		overflow: hidden;
    	}
    	.file-btn-div{
    		display: inline-block;
    	}
    	#mainImg-demo{
    		margin: 10px 0px;
    	}
    	#img-url-div input[type="button"]{
    		width: 350px;
    		height : 35px;
    		background-color: #eee;
    		border: 1px solid gray;
    		font-weight: bold;
    		margin-top: 15px;
    	}
    	.f-d{
    		display: flex;
    	}
    	.emotiocon-ul-li-container ul{
    		margin: 0px;
    		padding: 0px;
    		list-style: none;
    	}
    	.emotiocon-ul-li-container ul li{
    		margin: 15px;
    	}
    	.emoticon-t-ul{
    		position: relative;
    	}
    	.emoticon-b-ul{
    		position: absolute;
    		top: 0px;
    		right: 0px;
    	}
    	.f-w{
    		flex-wrap: wrap;
    	}
    </style>
    <script>
    	'use strict'
    	
    	
    	$(function() {
    		let img = $("#img").val();
    		if(img == ""){
	   			$("#showImg").attr("src", '${ctp}/data/advertisement/이미지선택.png');
    		}
    	});
    
	    // 선택한 이미지 화면에 출력 (미리보기)
	    function imgCheck(e){
	    	if(e.files && e.files[0]){
	    		let reader = new FileReader();
				reader.onload = function(e){
					document.getElementById("showImg").src = e.target.result;
				}
				reader.readAsDataURL(e.files[0]);
			}
	    }
	    

	    // 이모티콘 등록
	    function emoticonInput(){
	    	let img = document.getElementById("img").value;
	  		
	    	if(img.trim() == ""){
	    		alert("이미지를 등록해주세요.");
	    		return false;
	    	}
	  		else if(img.trim() != "") {
		    	let ext = img.substring(img.lastIndexOf(".")+1).toLowerCase();
		    	let maxSize = 1024 * 1024 * 10;
		    	let fileSize = document.getElementById("img").files[0].size;
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
		    		chatForm.submit();
		    	}
	  		}
	    }
    	
	    // 이미지 지우기
	    function emoticonDelBtn(idx,img){
	    	let ans = confirm("이모티콘을 삭제하시겠습니까?");
	    	if(ans){
	    		let query = {
	    			idx : idx,
	    			img : img
	    		}
	    		$.ajax({
	    			url : "${ctp}/admin/emoticonDel",
	    			type : "post",
	    			data : query,
	    			success : function(res){
	    				if(res == "1") {
	    					alert("삭제되었습니다.");
	    					location.reload();
	    				}
	    				else if(res == "2") alert("삭제에 실패하였습니다.")
	    			},
	    			error : function(){
	    				alert("전송오류(emoticon.jsp)")
	    			}
	    		});
	    	}
	    }
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-main-container">
		<div id="admin-main-right-content">
			<div id="top-menu-str">이모티콘 관리</div>
			<div id="admin-main-right-inner-content">
				<div id="admin-main-menu">
					<div id="admin-main-menu-str">채팅 이모티콘 등록 및 관리 <i class="fa-solid fa-file-pen"></i></div>
					<div class="text-left">
						<hr/>
							1. 이모티콘은 <span style="color: red">1:1 비율</span>에 맞춰서 등록해주시기 바랍니다.
						<hr/>
					</div>
					<form name="chatForm" method="post" enctype="multipart/form-data" >
						<div id="img-url-div">
							<div id="file-btns-div">
								<div class="file-btn-div">
									<label for="img">
										<b>사진 등록</b>
									</label>
									<input type="file" name="img" id="img" onchange="imgCheck(this)" />
								</div>
								<div class="file-btn-div">
									<a href="javascript:location.reload()">
										<b>삭제</b>
									</a>
								</div>
							</div>
							<div id="img-demo">
								<img id="showImg" width="320px" height="320px">
							</div>
							<div>
								<input type="button" value="이모티콘 등록" onclick="emoticonInput()"/>
							</div>
						</div>
					</form>
					<hr/>
					<h2>등록된 이모티콘 목록</h2>
					<hr/>
					<div class="emotiocon-ul-li-container">
						<div class="f-d f-w">
							<c:forEach var="emoVO" items="${emoVOS }">
								<ul class="emoticon-t-ul">
									<li> <img src="${ctp}/data/emoticon/${emoVO.img}" width="200px" height="200px">
										<ul class="emoticon-b-ul">
											<li>
												<input type="button" value="x" id="emoticonDel${emoVO.idx}" name="emoticonDel${emoVO.idx}" onclick="emoticonDelBtn('${emoVO.idx}','${emoVO.img }')" />
											</li>
										</ul>
									</li>
								</ul>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>