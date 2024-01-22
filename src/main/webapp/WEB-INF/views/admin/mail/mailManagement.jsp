<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메일광고 관리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-mail-right-content{
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
    	#admin-mail-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 80px; 
    		margin-bottom: 20px; 
    	}
    	#admin-mail-menu{
    		margin: 0 auto;
    		width : 100%;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#admin-mail-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#go-btn-div{
    		text-align: right;
    		margin-bottom: 20px;
    	}
    	#mail-input-go{
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
    	#mail-input-go a{
    		color: #fff;
    		text-decoration: none;
    	}
    	#mail-list-content-div{
    		display: flex;
    	}
    	#mail-list-right{
    		width: 35%;
    		
    	}
    	#mail-content-left{
    		width: 60%;
    		margin-left: auto;
    	}
    	#mail-content-div{
    		border: 1px solid gray;
    		margin : 10px 0px;
    		border-radius: 5px;
    		padding: 10px 20px;
    		height: 550px;
    	}
    	.mail-list{
    		overflow: auto;
    		height: 550px;
    	}
    	.mail-list a{
    		text-decoration: none;
    		color: #000;
    	}
    	.mail-list-a:hover{
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
    	.list-title{
    		width: 55%;
    	}
    	#mail-content .url-c{
    		background-color: #eee;
    	}
    	#mail-btn-flex{
    		display: flex;
    		justify-content: center;
    	}
    	#mail-btn-flex a{
    		width: 100px;
    		height: 30px;
    		line-height : 30px;
    		border-radius: 5px;
    		text-decoration: none;
    		color: #fff;
    		margin: 0px 20px;
    	}
    	#mail-btn-flex #delete-btn{
    		background-color: red;
    		border: 1px solid red;
    	}
    	#mail-content-div h3{
    		background-color: #eee;
    		padding: 10px 0px;
    		border-top: 1px solid gray;
    		border-bottom: 1px solid gray;
    	}
    	.mail-content-size{
    		overflow: auto;
    		height: 85%;
    		width: 100%
    	}
    	#mail-inner-content img{
    		width: 550px !important;
    		height: 700px !important;
    	}
    </style>
    <script>
    	'use strict'
    	
    	function listClick(idx){
    		$.ajax({
    			url : "${ctp}/admin/MailManagContent",
    			type : "post",
    			data : {idx : idx},
    			success : function(vo){
    				let str = '';
    				
    				str += '<h3>'+vo.title+'</h3>';
    				str += '<div>메일 전송일 : '+vo.mdate+'</div>';
    				str += '<hr/>';
    				str += '<div id="mail-inner-content">';
    				str += vo.content;
    				str += '</div>';
    				str += '<br/>';
    				str += '<hr/>';
    				str += '<div id="mail-btn-flex">';
    				str += '<a href="javascript:mailDelete('+vo.idx+')" id="delete-btn">삭제</a>';
    				str += '<hr/>';
    				str += '</div>';
    				
    				$("#mail-demo").html(str);
    			},
    			error : function(){
    				alert("전송오류(mailMang.jsp)")
    			}
    		});
    	}
    	
    	// 메인광고 삭제
    	function mailDelete(idx){
    		let ans = confirm("메일정보를 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/admin/mailDelete",
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
	<div id="admin-mail-container">
		<div id="admin-mail-right-content">
			<div id="top-menu-str">메일광고 관리</div>
			<div id="admin-mail-right-inner-content">
				<div id="admin-mail-menu">
					<div id="admin-mail-menu-str">메일광고 관리 <i class="fa-solid fa-file-pen"></i></div>
					<hr/>
					<div id="go-btn-div">
						<div id="mail-input-go">
							<a href="${ctp}/admin/mailInput">광고메일 전송 이동 <i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
					</div>
					<hr/>
					<div id="mail-list-content-div">
						<div id="mail-list-right">
							<h3>전체 리스트</h3>
								<div class="mail-list" >
									<c:forEach var="mVO" items="${vos}" varStatus="st">
										<c:set var="fName" value="${fn:split(mVO.FName,'/')}" />
										<div class="mail-list-a">
											<a href="javascript:listClick(${mVO.idx})" class="mail-list-a">
												<div class="list-inner-flex">
													<div class="list-cnt">
														<div>${st.count}</div>
													</div>
													<div class="list-img">
														<c:if test="${mVO.FName == '' }">
															<img src="${ctp}/data/mail/이미지없음.png" width="70px" height="70px"/>
														</c:if>
														<c:if test="${mVO.FName != '' }">
															<img src="${ctp}/data/mail/${fName[0]}" width="70px" height="70px"/>
														</c:if>
													</div>
													<div class="list-title">
														<c:if test="${fn:length(mVO.title) > 10}">
															<div>${fn:substring(mVO.title,0,10)}...</div>
														</c:if>
														<c:if test="${fn:length(mVO.title) <= 10}">
															<div>${mVO.title}</div>
														</c:if>
													</div>
												</div>
											</a>
										</div>
									</c:forEach>
								</div>
							</div>
							<div id="mail-content-left">
								<h3>자세히 보기</h3>
								<div id="mail-content-div">
								자세히 보기에 띄워진 메일 내용을 확인 후 오래된 메일의 내용,사진 정리가 가능합니다.<span style="color:red">(오래된 메일 순서로 정렬)</span>
								<hr/>
								<div class="mail-content-size">
									<div id="mail-demo"></div>
								</div>
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