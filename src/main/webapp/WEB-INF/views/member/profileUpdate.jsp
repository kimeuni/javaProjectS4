<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>프로필 변경</title>
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
    	#file-btns-div{
    		vertical-align: middle;
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
    	#profile-img-div img{
    		border-radius: 100%;
    		width: 150px;
    		height: 150px;
    		margin-bottom: 25px;
    	}
    	#ok-no-btn{
    		text-align: center;
    	}
    	#ok-no-btn #ok-btn{
    		width: 80px;
    		margin: 0px 15px;
    		height: 25px;
    		background: #402F1D;
			color: #fff;
    	}
    	#ok-no-btn #no-btn{
    		width: 80px;
    		margin: 0px 15px;
    		height: 25px;
    		background-color: #fff;
    		border: 1px solid gray;
    	}
    </style>
    <script>
    	'use strict'
    	
    	$(function() {
    		let profile = $("#profile").val();
    		if(profile == ""){
	   			$("#profileImg").attr("src", '${ctp}/data/member/${vo.profile}');
    		}
    	});
    	

	    // 선택한 이미지 화면에 출력 (미리보기)
	    function imgCheck(e){
	    	if(e.files && e.files[0]){
	    		let reader = new FileReader();
				reader.onload = function(e){
					document.getElementById("profileImg").src = e.target.result;
				}
				reader.readAsDataURL(e.files[0]);
			}
	    }
	    
	    // 프로필 등록
	    function profileUpdateOk(){
	    	let profile = document.getElementById("profile").value;
	  		
	    	if(profile.trim() == ""){
	    		alert("이미지를 등록해주세요.");
	    		return false;
	    	}
	  		else if(profile.trim() != "") {
		    	let ext = profile.substring(profile.lastIndexOf(".")+1).toLowerCase();
		    	let maxSize = 1024 * 1024 * 10;
		    	let fileSize = document.getElementById("profile").files[0].size;
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
		    		profileForm.submit();
		    	}
	  		}
	    }
	    
	    // 기본 프로필로 수정
	   	function profileNoImgUpdate(){
	    	let mid = $("#mid").val();
	    	let oProfile = $("#oProfile").val();
	    	
	    	let query = {
	    		mid : mid,
	    		oProfile : oProfile
	    	}
	    	$.ajax({
	    		url : "${ctp}/member/profileNoImgUpdate",
	    		type : "post",
	    		data : query,
	    		success : function(res){
	    			if(res == "1") location.reload();
	    			else if(res == "2") alert("프로필 삭제에 실패하였습니다.");
	    		},
	    		error : function(){
	    			alert("전송오류(profileUpdate.jsp)")
	    		}
	    	});
	    }
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/myPageMenu.jsp" />
	<div id="myPage-container">
		<div id="myPage-right-content">
			<div id="top-menu-str">${menuStr}</div>
			<div id="myPage-right-inner-content">
				<form name="profileForm" method="post" enctype="multipart/form-data" >
					<div id="myPage-pwdUpdate">
						<div id="myPage-pwdUpdate-str">프로필 변경 <i class="fa-solid fa-id-card-clip"></i></div>
						<div style="color:gray">대표 프로필을 변경할 수 있습니다.</div><br/>
						<div>프로필 사진</div>
						<hr/>
						<div id="profile-img-div"><img id="profileImg" ></div>
						<div id="file-btns-div">
							<div class="file-btn-div">
								<label for="profile">
									<b>사진 등록</b>
								</label>
								<input type="file" name="profile" id="profile" onchange="imgCheck(this)" />
							</div>
							<div class="file-btn-div">
								<a href="javascript:profileNoImgUpdate()">
									<b>삭제</b>
								</a>
							</div>
						</div>
						<hr/>
						<div id="ok-no-btn">
							<input type="button" value="적용" id="ok-btn" onclick="profileUpdateOk()" />
							<input type="button" value="취소" id="no-btn" onclick="location.href='${ctp}/member/myPage'" />
						</div>
					</div>
					<input type="hidden" id="oProfile" name="oProfile" value="${vo.profile}"/>
					<input type="hidden" id="mid" name="mid" value="${vo.mid}"/>
				</form>
			</div>
		</div>
	</div>
</body>
</html>