<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인화면 광고 관리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-advertisement-right-content{
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
    	#admin-advertisement-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 80px; 
    		margin-bottom: 20px; 
    	}
    	#admin-advertisement-menu{
    		margin: 0 auto;
    		width : 100%;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#admin-advertisement-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#go-btn-div{
    		text-align: right;
    		margin-bottom: 20px;
    	}
    	#advertisement-input-go{
    		display: inline-block;
    		height: 40px;
    		border: 1px solid gray;
    		width: 200px;
    		line-height: 40px;
    		border-radius: 5px;
    		text-align: center;
    		background-color: #315eb2;
    		color: #fff;
    		font-weight: bold;
    	}
    	#advertisement-input-go a{
    		color: #fff;
    		text-decoration: none;
    	}
    	#advertisement-list-content-div{
    		display: flex;
    	}
    	#advertisement-list-right{
    		width: 35%;
    		
    	}
    	#advertisement-content-left{
    		width: 60%;
    		margin-left: auto;
    	}
    	#ad-content-div{
    		border: 1px solid gray;
    		margin : 10px 0px;
    		border-radius: 5px;
    		padding: 10px 20px;
    		height: 550px;
    	}
    	.ad-list{
    		overflow: auto;
    		height: 550px;
    	}
    	.ad-list a{
    		text-decoration: none;
    		color: #000;
    	}
    	.ad-list-a:hover{
    		background-color: #eee;
    	}
    	.list-inner-flex{
    		display: flex;
    		height: 80px;
    		line-height: 80px;
    	}
    	.list-cnt{
    		width: 15%;
    	}
    	.list-img{
    		width: 30%;
    	}
    	.list-url{
    		width: 55%;
    	}
    	#ad-content .url-c{
    		background-color: #eee;
    	}
    	#ad-content-url{
    		margin: 20px 0px;
    	}
    	#ad-content-url input[type="text"]{
    		width: 400px;
    		height: 40px;
    		border: 0px;
    		outline:none;
    	}
    	#ad-btn-flex{
    		display: flex;
    		justify-content: center;
    	}
    	#ad-btn-flex a{
    		width: 100px;
    		height: 30px;
    		line-height : 30px;
    		border-radius: 5px;
    		text-decoration: none;
    		color: #fff;
    		margin: 0px 20px;
    	}
    	#ad-btn-flex .update-btn{
    		background-color: orange;
    		border: 1px solid orange;
    	}
    	#ad-btn-flex #delete-btn{
    		background-color: red;
    		border: 1px solid red;
    	}
    </style>
    <script>
    	'use strict'
    	
    	function listClick(idx){
    		$.ajax({
    			url : "${ctp}/admin/adManagContent",
    			type : "post",
    			data : {idx : idx},
    			success : function(vo){
    				let str = '';
    				
    				str += '<div id="ad-content">';
    				str += '<div><img src="${ctp}/data/advertisement/'+vo.mainImg+'" width="320px" height="320px"></div>';
    				str += '<div id="ad-content-url">';
    				str += '<div><input type="text" value="'+vo.url+'" readonly name="url" id="url" class="url-c"/></div>';
    				str += '</div>';
    				str += '</div>';
    				str += '<div id="ad-btn-flex">';
    				if(vo.openSw == 'Y'){
	    				str += '<a href="javascript:adOpenSwN('+vo.idx+')" class="update-btn">비공개</a>';
    				}
    				else{
	    				str += '<a href="javascript:adOpenSwY('+vo.idx+')" class="update-btn">공개</a>';
    				}
    				str += '<a href="javascript:adDelete('+vo.idx+')" id="delete-btn">삭제</a>';
    				str += '</div>';
    				str += '</div>';
    				
    				$("#ad-demo").html(str);
    			},
    			error : function(){
    				alert("전송오류(adMang.jsp)")
    			}
    		});
    	}
    	
    	// 비공개 전환
    	function adOpenSwN(idx){
    		$.ajax({
    			url : "${ctp}/admin/adOpenSwNo",
    			type : "post",
    			data : {idx : idx},
    			success : function(res){
    				if(res == "1"){
    					alert("비공개 처리 되었습니다.");
    					location.reload();
    				}
    				else if(res == "2"){
    					alert("비공개 처리에 실패하였습니다.");
    					location.reload();
    				}
    			},
    			error : function(){
    				alert("전송오류(메인광고관리.jsp)")
    			}
    		});
    	}
    	
    	// 공개 전환
    	function adOpenSwY(idx){
    		$.ajax({
    			url : "${ctp}/admin/adOpenSwYes",
    			type : "post",
    			data : {idx : idx},
    			success : function(res){
    				if(res == "1"){
    					alert("공개 처리 되었습니다.");
    					location.reload();
    				}
    				else if(res == "2"){
    					alert("현재 공개중인 메인광고가 있습니다. 비공개 처리 후, 이용해주세요.");
    				}
    				else if(res == "3"){
    					alert("공개 처리에 실패하였습니다.");
    					location.reload();
    				}
    			},
    			error : function(){
    				alert("전송오류(메인광고관리.jsp)")
    			}
    		});
    	}
    	
    	// 메인광고 삭제
    	function adDelete(idx){
    		let ans = confirm("광고를 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/admin/adDelete",
    				type : "post",
    				data : {idx : idx},
    				success : function(res){
    					if(res == "1"){
    						alert("삭제되었습니다.")
    						location.reload();
    					}
    					else if(res == "2"){
    						alert("삭제에 실패하였습니다.")
    						location.reload();
    					}
    				},
    				error : function(){
    					alert("전송오류(메인광고관리.jsp)")
    				}
    			});
    		}
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-advertisement-container">
		<div id="admin-advertisement-right-content">
			<div id="top-menu-str">메인화면 광고 관리</div>
			<div id="admin-advertisement-right-inner-content">
				<div id="admin-advertisement-menu">
					<div id="admin-advertisement-menu-str">메인화면 광고 관리 <i class="fa-solid fa-file-pen"></i></div>
					<hr/>
					<div id="go-btn-div">
						<div id="advertisement-input-go">
							<a href="${ctp}/admin/advertisementInput">메인화면 광고 등록 이동 <i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
					</div>
					<hr/>
					<div id="advertisement-list-content-div">
						<div id="advertisement-list-right">
							<h3>전체 리스트</h3>
								<div class="ad-list" >
									<c:if test="${empty vo }">
										<div class="ad-list-a">
											<div class="list-inner-flex" style="background-color: pink">
												공개중인 광고가 없습니다.
											</div>
										</div>
									</c:if>
									<c:if test="${!empty vo }">
										<div class="ad-list-a">
											<a href="javascript:listClick(${vo.idx})" >
												<div class="list-inner-flex" style="background-color: pink">
													<div class="list-cnt">
														<div>공개중</div>
													</div>
													<div class="list-img">
														<img src="${ctp}/data/advertisement/${vo.mainImg}" width="70px" height="70px"/>
													</div>
													<div class="list-url">
														<c:if test="${fn:length(vo.url) > 15}">
															<div>${fn:substring(vo.url,0,15)}...</div>
														</c:if>
														<c:if test="${fn:length(vo.url) <= 15}">
															<div>${vo.url}</div>
														</c:if>
													</div>
												</div>
											</a>
										</div>
									</c:if>
									<c:forEach var="mVO" items="${vos}" varStatus="st">
										<div class="ad-list-a">
											<a href="javascript:listClick(${mVO.idx})" class="ad-list-a">
												<div class="list-inner-flex">
													<div class="list-cnt">
														<div>${st.count}</div>
													</div>
													<div class="list-img">
														<img src="${ctp}/data/advertisement/${mVO.mainImg}" width="70px" height="70px"/>
													</div>
													<div class="list-url">
														<c:if test="${fn:length(mVO.url) > 15}">
															<div>${fn:substring(mVO.url,0,15)}...</div>
														</c:if>
														<c:if test="${fn:length(mVO.url) <= 15}">
															<div>${mVO.url}</div>
														</c:if>
													</div>
												</div>
											</a>
										</div>
									</c:forEach>
								</div>
							</div>
							<div id="advertisement-content-left">
								<h3>자세히 보기</h3>
								<div id="ad-content-div">
								자세히 보기에서 확인한 광고를 <span style="color:red">공개/비공개, 삭제가 가능</span>합니다.
								<hr/>
								<div id="ad-demo"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>