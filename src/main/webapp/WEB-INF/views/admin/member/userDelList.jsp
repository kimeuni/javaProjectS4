<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 리스트</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-memberList-right-content{
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
    	#admin-memberList-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 110px; 
    		margin-bottom: 60px; 
    	}
    	#admin-memberList-inner-content{
    		margin: 0 auto;
    		width : 100%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#memberInfo-container{
    		border: 1px solid gray;
    		margin: 10px 50px;
    	}
    	#memberInfor-div{
    		margin: 0 auto;
    		width: 75%;
    		border: 1px solid gray;
    		margin-bottom: 20px;
    	}
    	#search-member-container{
    		margin: 20px 0px;
    		text-align: right;
    	}
    	#search-member-container div, #search-member-container select{
    		display: inline-block;
    	}
    	#memberInfo-container{
    		padding: 10px;
    	}
    	#memberInfor-div{
    		padding: 10px;
    	}
    	.member-str{
    		width: 25%;
    		display: inline-block;
    	}
    	.member-input{
    		width: 70%;
    		display: inline-block;
    		text-align: left;
    	}
    	.member-input img{
    		width: 100px;
    		border-radius: 100%;
    	}
    	.member-str-input-div{
    		padding : 5px 0px;
    		border-top: 1px solid gray;
    	}
    	#admin-userDelList-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#go-btn-div{
    		text-align: right;
    		margin-bottom: 20px;
    	}
    	#memberList-go, #memberReport-go{
    		display: inline-block;
    		height: 40px;
    		border: 1px solid gray;
    		width: 200px;
    		line-height: 40px;
    		border-radius: 5px;
    		text-align: center;
    	}
    	#memberList-go a, #memberReport-go a{
    		text-decoration: none;
    	}
    	#memberList-go{
    		background-color: #315eb2;
    		color: #fff;
    		font-weight: bold;
    	}
    	#memberList-go a{
    		color: #fff;
    	}
    	#memberReport-go a{
    		color: #000;
    	}
    	#choice-Del-btn{
    		text-align: left;
    		padding-left: 30px;
    		margin: 10px 0px;
    		width: 120px;
    		height: 35px;
    		background-color: red;
    		color: #fff;
    		line-height: 35px;
    		border-radius: 5px;
    		font-weight: bold;
    	}
    	#choice-Del-btn a{
    		text-decoration: none;
    		color : #fff;
    	}
    </style>
    <script>
    	'use strict'
    	
    	// 개별 검색
    	function searchMembers(){
    		let searchString = $("#searchString").val();
    		let part = $("#part").val();
    		
    		if(searchString.trim() == ""){
    			alert("검색할 단어를 입력하세요.");
    			$("#searchString").focus();
    			return false;
    		}
    		else if(part.trim() == ""){
    			alert("검색한 구분을 선택해주세요.");
    			return false;
    		}
    		else {
    			location.href='${ctp}/admin/memberSearchList?searchString='+searchString+"&part="+part;
    		}
    	}
    	
    	$(function() {
    		$("#searchString").on("keydown",function(e) {
    			if(e.keyCode == 13){
    				searchMembers();
    			}
    		});
    	});
    	
    	// 전체 선택 및 전체 해제
    	function checkAll(){
    		let checkAll = "N";
    		if($("#ckAll")[0].checked) checkAll = "All"
    		
    		if(checkAll == "All"){
	    		for(let i=0; i<$('input:checkbox[name=ckS]').length; i++){
	    			$(".ckS")[i].checked = true;
	    		}
    		}
    		else{
	    		for(let i=0; i<$('input:checkbox[name=ckS]').length; i++){
	    			$(".ckS")[i].checked = false;
	    		}
    		}
    	}
    	
    	// 계정삭제 버튼으로 개별 삭제
    	function accountDel(mid,nickName){
    		let ans = confirm(nickName+"님의 계정을 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/admin/memberUserDel",
    				type : "post",
    				data : {mid : mid},
    				success : function(res){
    					alert("삭제되었습니다.");
						location.reload();
    				},
    				error : function(){
    					alert("전송오류(userDelList.jsp)")
    				}
    			});
    		}
    	}
    	
    	// 선택 삭제
    	function choiceDel(){
    		let mid = '';
    		let nickName = '';
    		
    		for(let i=0; i<$('input:checkbox[name=ckS]').length; i++){
    			if(userDelForm.ckS[i].checked){
    				let str = userDelForm.ckS[i].value.split("/");
    				let midStr = str[0];
    				let nickStr = str[1];
    				
    				mid += midStr+"/";
    				nickName += nickStr+"/";
    			}
    		}
    		mid = mid.substring(0,mid.length-1);
    		nickName = nickName.substring(0,nickName.length-1);
    		
    		if(mid.trim() == ""){
    			alert("삭제할 계정을 선택해주세요.");
    			return false;
    		}
    		
    		let ans = confirm(nickName+"님의 계정을 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/admin/memberUserDel",
    				type : "post",
    				data : {mid : mid},
    				success : function(res){
						alert("삭제되었습니다.");
						location.reload();
    				},
    				error : function(){
    					alert("전송오류(userDelList.jsp)")
    				}
    			});
    		}
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-memberListcontainer">
		<div id="admin-memberList-right-content">
			<div id="top-menu-str">탈퇴 신청 회원 리스트</div>
			<div id="admin-memberList-right-inner-content">
				<div id="admin-memberList-inner-content">
					<div id="admin-userDelList-menu-str">탈퇴 신청 회원 리스트 <i class="fa-solid fa-users-slash"></i></div>
					<hr/>
						<div style="text-align: left">
							1. 탈퇴 후 30일이 지나면 <span style="color: red">계정 삭제</span> 해주세요.<br/>
							2. 30일이 지난 계정은 <span style="color: red">분홍색으로 제일 상단에 표시</span>됩니다.
						</div>
					<hr/>
					<div id="go-btn-div">
						<div id="memberList-go">
							<a href="${ctp}/admin/memberList">회원 리스트 이동 <i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
						<div id="memberReport-go">
							<a href="${ctp}/admin/memberReport">회원 신고 관리 이동<i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
					</div>
					<div id="choice-Del-btn">
						<a href="javascript:choiceDel()">선택 삭제</a>
					</div>
					<form name="userDelForm">
						<table class="table table-hover text-center">
							<thead>
								<tr>
									<th><input type="checkbox" name="ckAll" id="ckAll" value="all" onclick="checkAll()"/></th>
									<th>성명</th>
									<th>닉네임</th>
									<th>이메일</th>
									<th>가입일</th>
									<th>탈퇴 경과</th>
									<th>계정 삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="mVO" items="${mVOS}" varStatus="st">
									<c:if test="${mVO.date_diff > 30 }">
										<tr style="background-color: #F08282; color: #fff">
											<th><input type="checkbox" name="ckS" class="ckS" value="${mVO.mid}/${mVO.nickName}"/></th>
											<td>${mVO.name}</td>
											<td>${mVO.nickName}</td>
											<td>${mVO.email}</td>
											<td>${fn:substring(mVO.startDate,0,10)}</td>
											<td>${mVO.date_diff}</td>
											<td><button onclick="accountDel('${mVO.mid}','${mVO.nickName}')">계정 삭제</button></td>
										</tr>
									</c:if>
									<c:if test="${mVO.date_diff <= 30 }">
										<tr>
											<td>x</td>
											<td>${mVO.name}</td>
											<td>${mVO.nickName}</td>
											<td>${mVO.email}</td>
											<td>${fn:substring(mVO.startDate,0,10)}</td>
											<td>${mVO.date_diff}</td>
											<td>삭제 불가</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</form>
					<br/>
					<div class="text-center">
						<ul class="pagination justify-content-center">
						    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="memberList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
						  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="memberList?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
						  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
							    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="memberList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
							    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="memberList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
						  	</c:forEach>
						  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="memberList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
						  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="memberList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>