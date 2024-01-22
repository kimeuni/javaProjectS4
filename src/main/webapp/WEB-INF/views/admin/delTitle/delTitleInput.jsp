<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>탈퇴 목록 등록</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-delTitle-right-content{
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
    	#admin-delTitle-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 80px; 
    		margin-bottom: 20px; 
    	}
    	#admin-delTitle-menu{
    		margin: 0 auto;
    		width : 100%;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#admin-delTitle-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#delTitle-input-container{
    		border: 1px solid gray;
    		border-radius: 5px;
    		min-height: 50px;
    	}
    	#delTitle-input-div h3{
    		color: gray;
    	}
    	#delTitle-input-str-div{
    		text-align: center;
    	}
    	.delTitle-input-str{
    		width: 24%;
    		display: inline-block;
    	}
    	#delTitle-input-div{
    		text-align: center;
    		margin: 10px 0px;
    	}
    	.delTitle-input{
    		width: 24%;
    		display: inline-block;
    	}
    	.delTitle-input input[type="text"]{
    		width: 80%;
   		    border: 0px;
    		padding: 0px 20px;
		    outline: none;
		    border-bottom: 1px solid;
    	}
    	#delTitle-title-list-content{
    		height: 400px;
    		padding: 20px 0px;
    	}
    	#delTitle-list{
    		width: 100%;
    		border: 1px solid;
    		border-radius: 5px;
    		overflow: auto;
    		height : 360px;
    		display: inline-block;
    	}
    	.delTitle-List-input:hover{
    		background-color: #eee;
    	}
    	.delTitle-List-input{
    		width: 100%;
    		text-align: center;
    		padding: 7px 0px;
    	}
    	.code-input{
    		width: 10%;
    		display: inline-block;
    		color: blue;
    	}
    	.title-input{
    		width: 59%;
    		display: inline-block;
    		text-align: left;
    	}
    	.displayNone-input{
    		width: 9%;
    		display: inline-block;
    	}
    	.displayYN{
    		width: 9%;
    		display: inline-block;
    	}
    	.reasonDel-btn{
    		width: 9%;
    		display: inline-block;
    	}
    </style>
    <script>
    	'use strict'
    	
    	// 목록 추가
    	function reasonDelInput(){
    		let code = $("#code").val();
    		let title = $("#title").val();
    		let displayNone;
	    	if(document.getElementsByName("displayNone")[0].checked) displayNone = "Y"; 
	    	else if(document.getElementsByName("displayNone")[1].checked) displayNone = "N"; 
	    	let regCode = /^[0-9a-zA-Z]{1,5}$/;
	    	
	    	if(code.trim() == ""){
	    		alert("코드를 입력하세요.");
	    		$("#code").focus();
	    		return false;
	    	}
	    	else if(code.length > 5){
	    		alert("코드는 5글자까지 가능합니다.");
	    		$("#code").focus();
	    		return false;
	    	}
	    	else if(!regCode.test(code)){
	    		alert("코드는 영문 대소문자와 숫자만 입력 가능합니다.");
	    		$("#code").focus();
	    		return false;
	    	}
	    	else if(title.trim() == ""){
	    		alert("목록명을 입력하세요.");
	    		$("#title").focus();
	    		return false;
	    	}
	    	else if(title.length > 29){
	    		alert("목록명은 29글자까지 가능합니다.");
	    		$("#title").focus();
	    		return false;
	    	}
	    	else{
	    		let query = {
	    			code : code,
	    			title : title,
	    			displayNone : displayNone
	    		}
	    		$.ajax({
	    			url : "${ctp}/admin/delTitleInput",
	    			type : "post",
	    			data : query,
	    			success : function(res){
	    				if(res == "1"){
	    					alert("탈퇴 목록이 등록되었습니다.")
	    					location.reload();
	    				}
	    				else if(res == "2"){
	    					alert("탈퇴 목록 등록에 실패하였습니다.")
	    					location.reload();
	    				}
	    				else if(res == "3"){
	    					alert("동일한 코드가 존재합니다. 다시 입력해주세요.");
	    					location.reload();
	    				}
	    			},
	    			error : function(){
	    				alert("전송오류(delTitleInput.jsp)")
	    			}
	    		});
	    	}
    	}
    	
    	// 목록 삭제
    	function reasonDel(code){
    		let ans1 = confirm("목록를 삭제시, 해당 목록로 탈퇴한 기록까지 모두 삭제됩니다.");
    		if(ans1){
	    		let ans2 = confirm("정말로 삭제하시겠습니까?");
	    		if(ans2){
		    		if(code == 'A9999'){
		    			alert("'기타'목록은 삭제할 수 없습니다.");
		    			return false;
		    		}
		    		else {
		    			$.ajax({
		    				url : "${ctp}/admin/reasonTitleDel",
		    				type : "post",
		    				data : {code : code},
		    				success : function(res){
		    					if(res == "1"){
		    						alert("삭제 되었습니다.");
		    						location.reload();
		    					}
		    					else if(res == "2"){
		    						alert("삭제에 실패하였습니다.");
		    						location.reload();
		    					}
		    				},
		    				error : function(){
		    					alert("전송오류(delTitleInput.jsp)")
		    				}
		    			});
		    		}
	    		}
    		}
    	}
    	
    	// 비공개 전환
    	function displayNoneNUpdate(displayNone,code){
    		let query = {
   				displayNone : displayNone,
   				code : code
       		}
    		
    		if(code == 'A9999'){
    			alert("'기타'목록은 비공개 처리가 불가능합니다.");
    			return false;
    		}
    		else {
	    		$.ajax({
	    			url : "${ctp}/admin/displayNoneUpdate",
	    			type : "post",
	    			data : query,
	    			success : function(res){
	    				if(res == "1"){
	    					location.reload();
	    				}
	    				else if(res == "2"){
	    					alert("비공개 전환 실패");
	    					location.reload();
	    				}
	    			},
	    			error : function(){
	    				alert("전송오류(delTitleInput.jsp)")
	    			}
	    		});
    		}
    	}
    	
    	// 공개 전환
    	function displayNoneYUpdate(displayNone,code){
    		let query = {
   				displayNone : displayNone,
   				code : code
    		}
    		
    		$.ajax({
    			url : "${ctp}/admin/displayNoneUpdate",
    			type : "post",
    			data : query,
    			success : function(res){
    				if(res == "1"){
    					location.reload();
    				}
    				else if(res == "2"){
    					alert("공개 전환 실패");
    					location.reload();
    				}
    			},
    			error : function(){
    				alert("전송오류(delTitleInput.jsp)")
    			}
    		});
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-delTitle-container">
		<div id="admin-delTitle-right-content">
			<div id="top-menu-str">탈퇴 목록 등록</div>
			<div id="admin-delTitle-right-inner-content">
				<div id="admin-delTitle-menu">
					<div id="admin-delTitle-menu-str">탈퇴 목록 등록 <i class="fa-solid fa-list-check"></i></div>
					<hr/>
					<div style="text-align: left;">
						1. <span style="color:red">코드는 5글자</span>까지의 숫자,영문으로만 작성이 가능합니다. <br/>
						2. <span style="color:red">목록명은 29글자</span>까지 작성이 가능합니다. <br/>
						3. 목록를 삭제 시, 해당 <span style="color:red">목록로 탈퇴한 기록까지 모두 삭제</span>되오니 주의 바랍니다. <br/>
						4. 목록 비공개시, '다모아'를 이용중인 회원은 탈퇴 이유 선택 시, 해당 목록를 확인할 수 없습니다. <br/>
					</div>
					<hr/>
					<div id="delTitle-input-container">
						<h3>탈퇴 목록 추가 등록</h3>
						<hr/>
						<div id="delTitle-input-str-div">
							<div class="delTitle-input-str">코드</div>
							<div class="delTitle-input-str">목록명</div>
							<div class="delTitle-input-str">공개유무</div>
							<div class="delTitle-input-str">등록</div>
						</div>
						<div id="delTitle-input-div">
							<div class="delTitle-input"><input type="text" name="code" id="code" maxlength="5" required /></div>
							<div class="delTitle-input"><input type="text" name="title" id="title" maxlength="29" required /></div>
							<div class="delTitle-input">
								<input type="radio" name="displayNone" id="displayNoneY" value="Y" checked/><label for="displayNoneY">공개</label> &nbsp;&nbsp;
								<input type="radio" name="displayNone" id="displayNoneN" value="N"/><label for="displayNoneN">비공개</label>
							</div>
							<div class="delTitle-input"><input type="button" onclick="reasonDelInput()" value="목록 추가" /></div>
						</div>
					</div>
					<div id="delTitle-title-list-content">
						<div id="delTitle-list">
							<h3>탈퇴 목록 리스트</h3>
							<hr/>
							<c:forEach var="vo" items="${vos}" varStatus="st">
								<div class="delTitle-List-input">
									<div class="code-input">${vo.code}</div>
									<div class="title-input">${vo.title }</div>
									<div class="displayNone-input">${vo.displayNone=='Y'? '공개' : '비공개'}</div>
									<c:if test="${vo.displayNone == 'Y' }">
										<div class="displayYN" ><input type="button" value="비공개" onclick="displayNoneNUpdate('N','${vo.code}')" /></div>
									</c:if>
									<c:if test="${vo.displayNone != 'Y' }">
										<div class="displayYN" ><input type="button" value="공개" onclick="displayNoneYUpdate('Y','${vo.code}')" /></div>
									</c:if>
									<div class="reasonDel-btn" ><input type="button" value="삭제" onclick="reasonDel('${vo.code}')" /></div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>