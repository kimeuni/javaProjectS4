<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅 기록 삭제</title>
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
    		margin-top: 80px; 
    		margin-bottom: 20px; 
    	}
    	#admin-memberList-inner-content{
    		margin: 0 auto;
    		width : 100%;
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
    	
    	$(function() {
    		$(".ckS").on("change", function() {
	    		if($('input:checkbox[name=ckS]').length == $('input:checkbox[name=ckS]:checked').length){
	    			$("#ckAll")[0].checked = true;
	    		}
	    		else {
	    			$("#ckAll")[0].checked = false;
	    		}
    		});
    	});
    	
    	// 선택박스 전부 선택하면 전체체크박스 체크, 전체 체크 아닐시 해제
    	$(function() {
    		$(".ckS").on("change", function() {
	    		if($('input:checkbox[name=ckS]').length == $('input:checkbox[name=ckS]:checked').length){
	    			$("#ckAll")[0].checked = true;
	    		}
	    		else {
	    			$("#ckAll")[0].checked = false;
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
    	function chattingDel(idx){
    		let ans = confirm("채팅을 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/admin/chattingDel",
    				type : "post",
    				data : {idx : idx},
    				success : function(res){
    					alert("삭제되었습니다.");
						location.reload();
    				},
    				error : function(){
    					alert("전송오류")
    				}
    			});
    		}
    	}
    	
    	// 선택 삭제
    	function choiceDel(){
    		let idx = '';
    		
    		$("input[name=ckS]:checked").each(function(){
    			let str = $(this).val().split("/");
				let idxStr = str[0];
				
				idx += idxStr+"/";
			})
			
    		idx = idx.substring(0,idx.length-1);
    		
    		if(idx.trim() == ""){
    			alert("삭제할 채팅을 선택해주세요.");
    			return false;
    		}
    		
    		let ans = confirm("채팅을 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/admin/chattingDel",
    				type : "post",
    				data : {idx : idx},
    				success : function(res){
						alert("삭제되었습니다.");
						location.reload();
    				},
    				error : function(){
    					alert("전송오류")
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
			<div id="top-menu-str">채팅 기록 삭제</div>
			<div id="admin-memberList-right-inner-content">
				<div id="admin-memberList-inner-content">
					<div id="admin-userDelList-menu-str">채팅 기록 삭제 <i class="fa-solid fa-users-slash"></i></div>
					<hr/>
						<div style="text-align: left">
							1. 6개월이 지난 채팅은 삭제 처리 해주세요.
						</div>
					<hr/>
					<div id="go-btn-div">
						<div id="memberList-go">
							<a href="${ctp}/admin/chatEmoticon">이모티콘 등록 이동 <i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
					</div>
					<div id="choice-Del-btn">
						<a href="javascript:choiceDel()">선택 삭제</a>
					</div>
						<table class="table table-hover text-center">
							<thead>
								<tr>
									<th><input type="checkbox" name="ckAll" id="ckAll" value="all" onclick="checkAll()"/></th>
									<th>채팅</th>
									<th>이모티콘</th>
									<th>계정 삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="cVO" items="${cVOS}" varStatus="st">
									<c:if test="${cVO.date_diff > 180 }">
										<tr style="background-color: #F08282; color: #fff">
											<th><input type="checkbox" name="ckS" class="ckS" value="${cVO.idx}"/></th>
											<td>${cVO.chat}</td>
											<td>
												<c:if test="${cVO.emoticon != '0' }">
													<img src="${ctp}/data/emoticon/${cVO.emoticon}" height="40px" width="40px" />
												</c:if>
											</td>
											<td><button onclick="chattingDel(${cVO.idx})">채팅 삭제</button></td>
										</tr>
									</c:if>
									<c:if test="${cVO.date_diff <= 180}">
										<tr>
											<td>x</td>
											<td>${cVO.chat}</td>
											<td>
												<c:if test="${cVO.emoticon != '0' }">
													<img src="${ctp}/data/emoticon/${cVO.emoticon}" height="40px" width="40px" />
												</c:if>
											</td>
											<td>삭제 불가</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					<br/>
					<div class="text-center">
						<ul class="pagination justify-content-center">
						    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="memberUserDel?pag=1&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
						  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="memberUserDel?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
						  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
							    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="memberUserDel?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
							    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="memberUserDel?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
						  	</c:forEach>
						  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="memberUserDel?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
						  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="memberUserDel?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>