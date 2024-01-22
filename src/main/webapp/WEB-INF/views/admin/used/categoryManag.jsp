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
    		margin-top: 110px; 
    		margin-bottom: 60px; 
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
    		min-height: 250px;
    		overflow: auto
    	}
    	.catefory-f-d select{
    		height: 400px;
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
    	
    	
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-main-container">
		<div id="admin-main-right-content">
			<div id="top-menu-str">카테고리 관리</div>
			<div id="admin-main-right-inner-content">
				<div id="admin-main-menu">
					<div id="admin-main-menu-str">카테고리 관리 <i class="fa-solid fa-file-pen"></i></div>
					<div id="go-btn-div">
						<div id="top-input-go">
							<a href="${ctp}/admin/topCategoryInput">대분류 등록 이동 <i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
						<div id="mid-input-go">
							<a href="${ctp}/admin/midCategoryInput">중분류 등록 이동 <i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
						<div id="btm-input-go">
							<a href="${ctp}/admin/memberReport">소분류 등록 이동 <i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
					</div>
					<h3>현재 등록된 카테고리 리스트</h3>
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