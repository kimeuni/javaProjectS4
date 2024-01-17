<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>임시 이미지 삭제</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#imsi-del-right-content{
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
    	#imsi-del-right-inner-content{
    		margin: 0 auto;
    		width: 100%;
    		margin-top: 70px; 
    		margin-bottom: 20px; 
    	}
    	#imsi-del-menu{
    		margin: 0 auto;
    		width : 85%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#imsi-del-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
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
    	function imsiImgDel(file){
    		let ans = confirm("임시 이미지를 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/admin/imsiImgDelete",
    				type : "post",
    				data : {file : file},
    				success : function(res){
    					alert("삭제되었습니다.");
						location.reload();
    				},
    				error : function(){
    					alert("전송오류(imsiImgDelete.jsp)")
    				}
    			});
    		}
    	}
    	
    	// 선택 삭제
    	function choiceDel(){
    		let file = '';
    		let cnt = 0;
    		
    		$("input[name=ckS]:checked").each(function(){
    			let str = $(this).val().split("/");
				let fileStr = str[0];
				
				file += fileStr+"/";
				cnt++;
			})
			
    		file = file.substring(0,file.length-1);
    		
    		if(file.trim() == ""){
    			alert("삭제할 이미지를 선택해주세요.");
    			return false;
    		}
    		
    		let ans = confirm(cnt+"건의 임시 이미지를 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/admin/imsiImgDelete",
    				type : "post",
    				data : {file : file},
    				success : function(res){
						alert("삭제되었습니다.");
						location.reload();
    				},
    				error : function(){
    					alert("전송오류(imsiImgDelete.jsp)")
    				}
    			});
    		}
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="imsi-del-container">
		<div id="imsi-del-right-content">
			<div id="top-menu-str">임시 이미지 삭제</div>
			<div id="imsi-del-right-inner-content">
				<div id="imsi-del-menu">
					<div id="imsi-del-menu-str">임시 이미지 삭제 | 서버에 저장된 파일(총 : <span style="color:red">${fileCount}건</span>) <i class="fa-solid fa-image"></i></div>
					<div id="choice-Del-btn">
						<a href="javascript:choiceDel()">선택 삭제</a>
					</div>
					<table class="table table-hover">
						<thead>
							<tr>
								<th><input type="checkbox" name="ckAll" id="ckAll" value="all" onclick="checkAll()"/></th>
								<th>번호</th>
								<th>이미지</th>
								<th>파일명</th>
								<th>삭제</th>
							</tr>
						</thead>
						<c:forEach var="file" items="${files}" varStatus="st">
							<tr>
								<td><input type="checkbox" name="ckS" class="ckS" value="${file}"/></td>
								<td>${st.count}</td>
								<td><img src="${ctp}/data/ckeditor/${file}" width="60px" height="60px"/></td>
								<td>${file}</td>
								<td><button onclick="imsiImgDel('${file}')">계정 삭제</button></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>