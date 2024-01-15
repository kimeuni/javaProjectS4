<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>1:1 문의하기</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
   		#main-home-go{
   			text-align: center;
   			border-bottom: 1px solid lightgray;
   		}
   		#ask-container-div h2{
   			padding: 0px 20px;
   		}
   		#ask-list-go a{
			text-decoration: underline;
			color: blue;   		
   		}
   		#ask-list-go{
   			text-align: right;
   		}
   		#ask-list-div{
   			/* border-bottom: 1px solid gray; */
   			padding: 10px 10px; 
   		}
   		#FAQ-div a{
			text-decoration: underline;
			color: blue;   		
   		}
   		#FAQ-div{
   			text-align: right;
   		}
   		#FAQ-text-div{
   			/* border-bottom: 1px solid gray; */
   			padding: 10px 10px; 
   		}
   		#ask-div{
   			padding: 10px 20px; 
   		}
   		#ask-div select{
   			width: 100%;
   			height: 45px;
   			border: 1px solid #ddd;
   			margin-top: 5px;
   			margin-bottom: 25px;
   		}
   		#ask-div input[type="text"]{
   			width: 100%;
   			height: 45px;
   			border: 1px solid #ddd;
   			margin-top: 5px;
   			margin-bottom: 25px;
   		}
   		.pli-c{
   			color: red;
   		}
   		#ask-content{
   			margin-top: 5px;
   			margin-bottom: 25px;
   		}
   		#ask-content textarea{
   			resize: none;
   			border : 1px solid #ddd;
   			background-color: #eee;
   			outline: none;
   			padding: 10px 10px;
   		}
   		#ask-btn-div{
   			text-align: center;
   			margin-top: 5px;
   			margin-bottom: 25px;
   		}
   		#ask-btn-div input[type="button"]{
   			width: 50%;
   			background-color: #5E5756;
   			color: #fff;
   			border: 1px solid #5E5756;
   			border-radius: 5px;
   			height: 40px;
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
    	
    	
		.imgsWrap {
		    height: 125px;
		    overflow: auto;
		    border: 1px solid #989898;
		    padding: 10px;
		    margin-top: 5px;
   			margin-bottom: 25px;
		}
		.imgsWrap img {
		    width: 100px;
		    height: 100px;
		    margin-left: 10px;
		    margin-right: 10px;
		}
    </style>
    <script>
    	'use strict'
    	
    	let str = '';
    	// 글자 길이 체크
    	$(function() {
    		$("#content").on("keyup",function() {
	    		let content = $("#content").val();
    			str = '('+ content.length +'/300)';
    			$("#content-text-cnt").html(str);
    			
    			if(content.length > 300){
    				alert("문의 내용은 300글자까지 가능합니다.")
    				$("#content").val(content.substring(0,300));
    			}
    		});
    	});
    	
    	// 신고상점 리스트 안보이게
    	$(function() {
    		$("#report-shop-list").hide();
    	});
    	
    	$(function() {
    		$("#category").on("click",function() {
	    		let category = $("#category").val();
		   		if(category == '거래신고'){
		   			$("#report-shop-list").show();
		   		}
		   		else{
		   			$("#report-shop-list").hide();
		   		}
    		});
    	});
    	
    	// 홈으로 가기
    	function mainOpen(){
    		opener.location.href="${ctp}/damoa";
    		window.close();
    	}
    	
    	// 자주하는 질문으로 가기
    	function FAQOpen(){
    		opener.location.href="${ctp}/board/FAQList";
    		window.close();
    	}
    	
    	// 내 문의내역 화면으로 가기
    	function askListopen(){
    		opener.location.href="${ctp}/member/ask/myAskList";
    		window.close();
    	}
    	
    	// 선택한 이미지 화면에 출력 (미리보기)
	    function imgCheck(e){
	    	if(e.files && e.files[0]){
	    		let reader = new FileReader();
				reader.onload = function(e){
					document.getElementById("img").src = e.target.result;
				}
				reader.readAsDataURL(e.files[0]);
			}
	    }
	    
	    // 광고 등록
	    function askInput(){
	    	let imgs = document.getElementById("imgs").value;
	    	let title = document.getElementById("title").value;
	    	let content = document.getElementById("content").value;
	    	let category = document.getElementById("category").value;
	    	let reportShop = document.getElementById("reportShop").value;
	  		
	  		if(title.trim() == ""){
	  			alert("문의 제목을 입력해주세요.");
	  			return false;
	  		}
	  		else if(category.trim() == ""){
	  			alert("유형을 선택하세요.");
	  			return false;
	  		}
	  		else if(content.trim() == ""){
	  			alert("문의 내용을 입력해주세요.");
	  			return false;
	  		}
	  		else if(imgs.trim() != "") {
		    	let ext = imgs.substring(imgs.lastIndexOf(".")+1).toLowerCase();
		    	let maxSize = 1024 * 1024 * 10;
		    	let fileSize = document.getElementById("imgs").files[0].size;
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
				else if(category == "거래신고"){
					if(reportShop.trim() == ''){
						alert("신고 상점명을 선택 or 입력하세요.");
						return false;
					}
			    	else {
			    		askForm.submit();
			    	}
				}
		    	else {
		    		askForm.submit();
		    	}
	  		}
	  		else if(category == "거래신고"){
				if(reportShop.trim() == ''){
					alert("신고 상점명을 선택하세요.");
					return false;
				}
		    	else {
		    		askForm.submit();
		    	}
	  		}
	  		else {
	    		askForm.submit();
	  		}
	    }
    	
    	
    </script>
</head>
<body>
	<div id="ask-container-div">
		<div id="main-home-go"><a href="javascript:mainOpen()"><img src="${ctp}/data/images/다모아로고1.png" width="150px"></a></div>
		<div id="FAQ-div">
			<div id="FAQ-text-div">자주하는 질문은 <a href="javascript:FAQOpen()">이곳 <i class="fa-solid fa-arrow-pointer"></i></a>에서 확인이 가능! </div>
		</div>
		<div id="ask-list-go">
			<div id="ask-list-div">내 문의내역 <a href="javascript:askListopen()">보러가기 <i class="fa-solid fa-arrow-pointer"></i></a></div>
		</div>
		<h2>1:1 문의하기</h2>
		<form name="askForm" method="post" enctype="multipart/form-data" >
			<div id="ask-div">
				<div>문의 제목<span class="pli-c">＊</span></div>
				<div><input type="text" name="title" id="title" required /></div>
				<div>유형 선택<span class="pli-c">＊</span></div>
				<div>
					<select name="category"  id="category">
						<option value="">유형을 선택해주세요.</option>
						<option value="거래신고">거래신고</option>
						<option value="회원/계정">회원/계정</option>
						<option value="채팅">채팅</option>
						<option value="기타 서비스">기타 서비스</option>
						<option value="오류/신고/제안">오류/신고/제안</option>
					</select>
				</div>
				<div id="report-shop-list">
				<div>신고 상점명<span class="pli-c">＊</span></div>
					<select name="reportShop"  id="reportShop">
						<option value="">신고할 상점을 선택해 주세요.</option>
						<option value="admin">관리자</option>
					</select>
				</div>
				<div>문의 내용<span class="pli-c">＊</span><span id="content-text-cnt">(0/300)</span></div>
				<div id="ask-content"><textarea rows="7" style="width: 100%" name="content" id="content" required  maxlength="300"></textarea></div>
				<div id="file-btns-div">
					<div class="file-btn-div">
						<label for="imgs">
							<b>사진 등록</b>
						</label>
						<input type="file"  name="imgs" id="imgs" onchange="imgCheck(this)"/>
					</div>
				</div>
				<div>
			    	<div class="imgsWrap">
			    		<img id="img" />
			    	</div>
			    </div>
				<div id="ask-btn-div">
					<input type="button" onclick="askInput()" name="askBtn" id="askBtn" value="문의하기" />
				</div> 
				<input type="hidden" name="mid" id="mid" value="${sMid}" />
			</div>
		</form>
	</div>
</body>
</html>