<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>중고거래 카테고리 관리</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
    		width: 80%;
    		margin-top: 80px; 
    		margin-bottom: 20px; 
    	}
    	#admin-main-menu{
    		margin: 0 auto;
    		width : 100%;
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
    	.f-d{
    		display: flex;
    	}
    	.f-d-3{
    		display: flex;
    		width: 33%;
    	}
    	.catefory-f-d{
    		margin: 10px;
    		width: 100%;
    		min-height: 200px;
    		overflow: auto
    	}
    	.catefory-f-d select{
    		height: 200px;
    		width: 100%;
    		border: 1px solid #aaa;
    	}
    	
    	#go-btn-div{
    		text-align: right;
    		margin-bottom: 20px;
    	}
    	#top-input-go, #mid-input-go, #btm-input-go{
    		display: inline-block;
    		height: 40px;
    		border: 1px solid gray;
    		width: 200px;
    		line-height: 40px;
    		border-radius: 5px;
    		text-align: center;
    	}
    	#top-input-go a, #mid-input-go a, #btm-input-go a{
    		text-decoration: none;
    	}
    	#top-input-go, #btm-input-go{
    		background-color: #315eb2;
    		color: #fff;
    		font-weight: bold;
    	}
    	#mid-input-go a{
    		color: #000;
    	}
    	#top-input-go a,#btm-input-go a{
    		color: #fff;
    	}
    	.f-8-b{
    		margin : 0 auto;
    		justify-content: centet;
    		display: flex;
    		width: 80%;
    		border: 1px solid #eee;
    		padding: 10px;
    	}
    	.categ-str{
    		text-align: left;
    		padding-left: 10px;
    		font-size: 1.1em;
    		font-weight: bold;
    		margin-bottom: 10px;
    	}
    	.mTCa-select{
    		width: 30%;	
    	}
    	.mTCa-select select{
    		width: 80%;
    		height: 40px;
    		border: 1px solid #ddd;
    	}
    	.mName-input{
    		width: 50%;
    	}
    	.mName-input input[type="text"]{
    		width: 100%;
    		height: 40px;
    		outline: none;
    		border: 0px;
    		border-bottom: 1px solid;
    		padding-left: 10px;
    	}
    	.mName-cnt{
    		line-height: 40px;
    		margin-left: 20px;
    	}
    	.mName-up-btn{
    		margin-left: auto;
    		margin-top: 20px;
    	}
    	.mName-up-btn a{
    		display : flex;
    		justify-content : center;
    		text-decoration: none;
    		color: #000;
    		width: 100px;
    		height: 30px;
    		line-height: 30px;
    		border-radius: 5px;
    		border : 1px solid #315eb2;
    	}
    </style>
    <script>
    	'use strict'
    	
    	// 대분류 클릭시 중분류 보이기
    	function topMidOpen(){
    		let topCa = topCategoryForm.topCategory.value;
    		let str = '';
    		$.ajax({
    			url : "${ctp}/admin/topMidCategory",
    			type : "post",
    			data : {topCa : topCa},
    			success : function(vos){
    				for(let i=0; i<vos.length; i++){
	    				str += '<option value="'+vos[i].idx+'">'+vos[i].midCategoryName+'</option>';
    				}
    				$("#midCategory").html(str);
    				$("#btmCategory").html('');
    			},
    			error : function(){
    				alert("전송오류(categoryManag.jsp)");
    			}
    		});
    	}
    	
    	
    	// 중분류 클릭시 소분류 보이기
    	function midBtmOpen(){
    		let midCa = midCategoryForm.midCategory.value;
    		let str = '';
    		$.ajax({
    			url : "${ctp}/admin/midBtmCategory",
    			type : "post",
    			data : {midCa : midCa},
    			success : function(vos){
    				for(let i=0; i<vos.length; i++){
	    				str += '<option value="'+vos[i].idx+'">'+vos[i].btmCategoryName+'</option>';
    				}
    				$("#btmCategory").html(str);
    			},
    			error : function(){
    				alert("전송오류(categoryManag.jsp)");
    			}
    		});
    	}
    	
    	// 대분류 cnt 세기
    	$(function() {
    		$("#midCategoryName").on("keyup", function(){
    			let midCategoryName = $("#midCategoryName").val();
    			$(".mName-cnt").html("("+ midCategoryName.length +"/15)");
    			
    			if(midCategoryName.length > 15){
	    			$(".mName-cnt").html("(15/15)");
	    			$("#midCategoryName").val(midCategoryName.substring(0,15));
    				alert("중분류는 15글자까지 가능합니다.")
    			}
    		});
    	});
    	
    	// 중분류 삭제
    	function topCategoryDel(usedCnt,idx){
    		if(usedCnt > 0){
    			alert("사용중인 카테고리는 삭제하실 수 었습니다.");
    		}
    		else {
    			let ans = confirm("중분류 삭제시 해당 중분류와 소분류 또한 삭제됩니다. 삭제하시겠습니까?");
    			if(ans){
    				$.ajax({
    					url : "${ctp}/admin/midBtmCategoryDel",
    					type : "post",
    					data : {idx : idx},
    					success : function(res){
    						if(res == "1") {
    							alert("삭제되었습니다.")
    							location.reload();
    						}
    						else if(res == "2") alert("삭제에 실패하였습니다.")
    					},
    					error : function(){
    						alert("전송오류(midCategoryInput.jsp)")
    					}
    				});
    			}
    		}
    	}
    	
    	// 중분류 등록
    	function midCategoryInput(){
    		let midCategoryName = $("#midCategoryName").val();
    		let topCategoryIdx = $("#topCategoryIdx").val();
    		
    		if(topCategoryIdx == ""){
    			alert("대분류를 선택하세요.");
    			return false;
    		}
    		else if(midCategoryName.trim() ==""){
    			alert("등록할 중분류를 입력하세요.");
    			return false;
    		}
    		else{
    			let query = {
   					midCategoryName : midCategoryName,
   					topCategoryIdx : topCategoryIdx
    			}
    			$.ajax({
    				url : "${ctp}/admin/midCategoryInput",
    				type : "post",
    				data : query,
    				success : function(res){
    					if(res == "1") location.reload();
    					else if(res == "2") alert("중분류 등록에 실패하였습니다.");
    				},
    				error : function(){
    					alert("전송오류(midCategoryInput.jsp)")
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
			<div id="top-menu-str">카테고리 관리</div>
			<div id="admin-main-right-inner-content">
				<div id="admin-main-menu">
					<div id="admin-main-menu-str">카테고리 관리 | 중분류 등록 <i class="fa-solid fa-file-pen"></i></div>
					<div id="go-btn-div">
						<div id="top-input-go">
							<a href="${ctp}/admin/topCategoryInput">대분류 등록 이동 <i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
						<div id="mid-input-go">
							<a href="${ctp}/admin/memberReport">소분류 등록 이동 <i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
						<div id="btm-input-go">
							<a href="${ctp}/admin/categoryManag">카테고리 리스트 이동 <i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
					</div>
					<h3>중분류 카테고리 관리</h3>
					<div class="f-d">
						<div class="f-8-b">
							<div style="width: 100%">
								<div class="categ-str">중분류 등록</div>
								<div class="f-d">
									<div class="mTCa-select">
										<select name="topCategoryIdx" id="topCategoryIdx" >
											<option value="">대분류명 선택</option>
											<c:forEach var="tVO" items="${tVOS}">
												<option value="${tVO.idx}">${tVO.topCategoryName}</option>
											</c:forEach>
										</select>
									</div>
									<div class="mName-input"><input type="text" name="midCategoryName" id="midCategoryName" maxlength="15" placeholder="중분류 명"/></div>
									<div class="mName-cnt">(0/15)</div>
								</div>
								<div class="f-d">
									<div class="mName-up-btn"><a href="javascript:midCategoryInput()">중분류 등록</a></div>
								</div>
							</div>
						</div>
					</div>
					
					<div style="margin-top: 10px; height: 348px">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>번호</th>
									<th>대분류명</th>
									<th>중분류명</th>
									<th>소분류 개수</th>
									<th>등록된 글 수</th>
									<th>기능</th>
								</tr>
							</thead>
							<c:set var="curScrStartNo" value="${pageVO.curScrStartNo }"></c:set>
							<c:forEach var="midVO" items="${midVOS}">
								<tr>
									<td>${curScrStartNo }</td>
									<td>
										<c:forEach var="tVO" items="${tVOS}">
											<c:if test="${tVO.idx == midVO.topCategoryIdx }">
											${tVO.topCategoryName}
											</c:if>
										</c:forEach>
									</td>
									<td>${midVO.midCategoryName }</td>
									<td>${midVO.btmCnt }</td>
									<td>${midVO.usedCnt }</td>
									<td><a href="javascript:topCategoryDel(${midVO.usedCnt},${midVO.idx})">삭제</a></td>
								</tr>
								<c:set var="curScrStartNo" value="${curScrStartNo-1}"></c:set>
							</c:forEach>
						</table>
						
						
						<br/>
						<div class="text-center">
							<ul class="pagination justify-content-center">
							    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="midCategoryInput?pag=1&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
							  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="midCategoryInput?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
							  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
								    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="midCategoryInput?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
								    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="midCategoryInput?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
							  	</c:forEach>
							  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="midCategoryInput?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
							  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="midCategoryInput?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
							</ul>
						</div>
					</div>
					
					<div class="f-d">
						<div class="f-d-3">
							<div class="catefory-f-d">
							    <form name="topCategoryForm">
									<select multiple name="topCategory" id="topCategory" onchange="topMidOpen()">
										<c:forEach var="tVO" items="${tVOS}">
											<option value="${tVO.idx}">${tVO.topCategoryName}</option>
										</c:forEach>
									</select>
								</form>
							</div>
						</div>
						<div class="f-d-3">
							<div class="catefory-f-d">
								<form name="midCategoryForm">
									<select multiple name="midCategory" id="midCategory" onchange="midBtmOpen()">
									</select>
								</form>
							</div>
						</div>
						<div class="f-d-3">
							<div class="catefory-f-d">
								<select multiple id="btmCategory" >
								</select>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>