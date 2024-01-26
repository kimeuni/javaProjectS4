<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>커뮤니티 | ${comVO.content}</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	#community-main-container{
    		z-index: 1;
    	}
    	#community-main-img-container{
    		background-color: #F1E5D4;
    		min-width: 100vw;
    	}
    	#community-main-img-text-div{
    		height: 315px;
    		width: 1024px;
    		display: flex;
    		margin: 0 auto;
    	}
    	#community-text-left{
    		width: 40%;
    	}
    	#community-img-right{
    		width: 60%;
    	}
    	#community-text-div{
    		margin-top: 105px;
    		font-size: 2.0em;
		    font-weight: bold;
		    margin-bottom: 20px;
		    text-align: left;
    		padding-left: 30%;
    	}
    	#community-usedinput-btn{
    		padding-left: 30%;
    	}
    	#community-usedinput-btn button{
    		width: 120px;
    		height: 35px;
    		color : #fff;
    		border: 1px solid #5E5756;
    		background-color: #5E5756;
    		border-radius: 5px;
    	}
    	#community-usedinput-btn button:hover{
    		border: 1px solid #553830;
    		background-color: #553830;
    	}
    	.f-d{
    		display: flex;
    	}
    	.mgp-top{
    		margin: 20px 0px;
    		padding-left: 10px;
    	}
    	.f-d-1{
    		display: flex;
    		width: 15%;
    	}
    	.f-d-9{
    		display: flex;
    		width: 85%;
    	}
    	.pd-1{
    		padding: 15px;
    	}
    	#content{
    		font-size: 1.2em;
    		resize: none;
    		outline: none;
    		border: 0px
    	}
    	#rContent{
    		font-size: 1.2em;
    		resize: none;
    		outline: none;
    		border: 0px
    	}
    	.f-b-ddd{
    		border: 1px solid #ddd;
    		padding: 5px;
    	}
    	.f-a{
    		flex-wrap: wrap;
    	}
    	#file-btns-div input[type="file"]{
    		position : absolute;
    		height: 1px;
    		width: 1px;
    		margin: -1px;
    		overflow: hidden;
    	}
    	.la-f{
    		height: 30px;
    		line-height: 30px;
    	}
    	.la-f:hover{
    		color: #F3CF98;
    	}
    	.content-cnt{
    		margin-left: auto;
    		padding-right: 15px;
    		height: 30px;
    		line-height: 30px;
    	}
    	.content-reply-cnt{
    		margin-left: auto;
    		padding-right: 15px;
    		height: 30px;
    		line-height: 30px;
    	}
    	.content-upload-btn a{
    		justify-content : center;
    		display : flex;
    		width: 100px;
    		background-color: #5E5756;
    		color: #fff;
    		height: 30px;
    		border-radius: 5px;
    		line-height: 30px;
    		text-decoration: none;
    	}
    	#community-list-container{
    		width: 1200px;
    		margin: 0 auto;
    	}
    	
		.f-d-2{
			display : flex;
			position: sticky;
			top: 80px;
			width: 25%;
			max-height: 600px;
		}
		.f-d-8{
			display: flex;
			width: 75%;
			border-left: 1px solid #ddd;
			border-right: 1px solid #ddd;
		}
		.btb{
			border-bottom: 1px solid #ddd;
		}
		.f-d-1-img{
			display: flex;
			width: 10%;
		}
		.f-d-9{
			display: flex;
			width: 90%;
		}
		.profile-img img{
			width: 60px;
			height: 60px;
			border-radius: 100%
		}
		.pd{
			padding-bottom: 30px;
			padding-top: 10px;
			padding-left: 70px;
			padding-right: 70px;
		}
		.pd-i{
			padding-bottom: 10px;
			padding-top: 10px;
			padding-left: 30px;
			padding-right: 10px;
		}
		.heit{
			height: 300px;
			overflow: hidden;
			border: 1px solid #ddd;
			border-radius: 5px;
		}
		.f-d-5{
			display: flex;
			width: 50%;
			flex-wrap: wrap;
		}
		.heit-150{
			height: 150px;
		}
		.f-sc{
			display : flex;
			position: sticky;
			top: 80px;
			z-index: 100
		}
		.f-d-3-menu{
			height: 60px;
			display: flex;
			width: 33.39%;
			justify-content: center;
			font-size: 1.5em;
			line-height: 60px;
			border-left: 1px solid #ddd;
		}
		.f-d-menu{
			height: 60px;
			display: flex;
			width: 100%;
			justify-content: center;
			font-size: 1.5em;
			line-height: 60px;
		}
		.f-d-3{
			height: 25px;
			display: flex;
			width: 33.39%;
			font-size : 1.2em;
			justify-content: center;
			vertical-align: middle;
			margin-top: 10px; 
		}
		.main-home-btn , .profile-go-btn , .good-go-btn , .bookmark-go-btn  {
			margin-top: 15px;
		}
		.comu-up-btn {
			margin-top: 100px;
			margin-bottom: 40px;
			text-align: center;
		}
		.comu-up-btn button{
			margin: 0 auto;
			display : flex;
			justify-content: center;
			padding: 0px;
			font-size: 1.3em;
			margin-top: 5px;
			width : 150px;
			height : 40px;
			line-height : 40px;
			text-decoration: none;
			background-color: #5E5756;
			border: 1px solid #5E5756;
			border-radius: 5px;
			color: #fff;
			font-weight: bold;
		} 
		.comu-up-btn button:hover{
			background-color: #553830;
			border: 1px solid #553830;
		}
		.main-home-btn a, .profile-go-btn a, .bookmark-go-btn a{
			display : flex;
			padding-left: 15px;
			font-size: 1.5em;
			width: 100%;
			margin-top: 5px;
			text-decoration: none;
		}
		.main-home-btn a:hover, .profile-go-btn a:hover, .bookmark-go-btn a:hover{
			color: #553830;
		
		}
		.menu-c:hover{
			text-decoration: none;
			color: #000;
		}
		.menu-c{
			position: relative;
			margin-left: auto;
		}
		.reply-input button{
			background-color: rgba(0,0,0,0);
			border: 0px;
		}
		.report-del-btn{
			position: absolute;
		}
		.report-del-container{
			margin-left: auto; 
			padding-right: 20px;
			padding-top: 10px
		}
		.report-del-container ul{
			margin: 0px;
			padding: 0px;
			list-style: none;
		}
		.inner-li-report-del-btn hr{
			margin: 3px;
		}
		.inner-li-report-del-btn{
			text-align: center;
			width: 80px;
			border: 1px solid;
			position: absolute;
			background-color: #fff;
			padding: 5px !important;
			display: none;
		}
		.inner-li-report-del-btn a{
			text-decoration: none;
			color: #000;
		}
		.ul-report-del-btn:hover .inner-li-report-del-btn{
			display: block;
		}
		.comu-content{
			flex-wrap: wrap;
		}
		.comu-content-inner{
			width: 100%;
		}
		.comu-content-inner a{
			display : flex;
			width : 100%;
			min-height: 50px;
			text-decoration: none;
			color: #000;
		}
		.reply-good-bookmark-btn a{
			text-decoration: none;
		}
		.goodhover a:hover {
			color : red;
		}
		.replyhover button:hover {
			color : green;
		}
		.comu-main-go{
			justify-content: flex-start;
		}
		.comu-main-go a{
			display: flex;
			width: 50px;
			font-size: 1.6em;
			height: 40px;
			justify-content: center;
			text-decoration: none;
			color: #000;
			padding-left: 20px;
			margin-top: 10px;
		}
		.bt-1{
			border-top: 1px solid #ddd;
		}
		#loginNoReply{
			resize: none;
			outline: none;
		}
		#replyContent{
			resize: none;
			outline: none;
		}
		.select-report-community {
			text-align: center;
		}
		.select-report-community select{
			width: 400px;
			border: 1px solid #ccc;
			height: 40px;
		}
		.communitiy-report-btns{
			justify-content: flex-end;
		}
		.communitiy-report-btns a{
			justify-content : center;
			display : flex;
			height: 25px;
			width: 80px;
			background-color: red;
			color: #fff;
			border-radius: 5px;
			text-decoration: none;
		}
    </style>
    <script>
    	'use strict'
    	
    	$(function(){
    		$("#att_zone").hide();
    	});
    	
    	let str = '';
    	
    	// 글자 길이 체크
    	$(function() {
    		$("#content").on("keyup",function() {
	    		let content = $("#content").val();
    			str = '('+ content.length +'/140)';
    			$(".content-cnt").html(str);
    			
    			if(content.length > 140){
	    			$(".content-cnt").html("(140/140)");
    				alert("내용은 140글자까지 가능합니다.")
    				$("#content").val(content.substring(0,140));
    			}
    		});
    	});
    	// 댓글 글자 길이 체크
    	$(function() {
    		$("#replyContent").on("keyup",function() {
	    		let content = $("#replyContent").val();
    			str = '('+ content.length +'/140)';
    			$(".content-reply-cnt").html(str);
    			
    			if(content.length > 140){
	    			$(".content-reply-cnt").html("(140/140)");
    				alert("내용은 140글자까지 가능합니다.")
    				$("#replyContent").val(content.substring(0,140));
    			}
    		});
    	});
    	
    	// 게시글 등록하기
    	function communityUpload(){
    		let content = $("#content").val();
    		
    		if(content.trim() == ""){
    			alert("내용을 입력해주세요.");
    			$("#content").focus();
    			return false;
    		}
    		else{
    			document.getElementById("imgs").removeAttribute("disabled");
    			
    			communityForm.submit();
    		}
    	}
    	
    	// 댓글 업로드
    	function replyUpload(idx){
    		let content = $("#replyContent").val();
    		let mid = "${sMid}";
    		
    		if(content.trim() == ""){
    			alert("댓글을 입력해주세요.");
    			$("#replyContent").focus();
    		}
    		else {
    			let query = {
    				content : content,
    				idx : idx,
    				mid : mid
    			}
    			$.ajax({
    				url : "${ctp}/community/communityReplyInput",
    				type : "post",
    				data : query,
    				success : function(res){
    					if(res == "1") location.reload();
    					else if(res == "2") alert("댓글 게시에 실패하였습니다.");
    				},
    				error : function(){
    					alert("전송오류(communityMain.jsp)")
    				}
    			});
    		}
    	}
    	
    	// 좋아요 누르기
    	function goodYes(idx){
    		let mid = '${sMid}';
    		let part = 'community';

    		if(mid.trim() == ""){
    			alert("로그인 후 이용 가능한 서비스 입니다.");
    			location.href="${ctp}/member/login"
    		}
    		else {
	    		let query = {
	    			idx : idx,
	    			mid : mid,
	    			part : part,
	    			flag : "yes"
	    		}
	    		$.ajax({
	    			url : "${ctp}/community/communityGood",
	    			type : "post",
	    			data : query,
	    			success : function(res){
	    				if(res == "1") location.reload();
	    				else if(res == "2") alert("좋아요 실패");
	    			},
	    			error : function(){
	    				alert("전송오류(communityMain.jsp)")
	    			}
	    		});
    		}
    	}
    	
    	// 좋아요 취소
    	function goodNo(idx){
    		let mid = '${sMid}';
    		let part = 'community';

    		if(mid.trim() == ""){
    			alert("로그인 후 이용 가능한 서비스 입니다.");
    			location.href="${ctp}/member/login"
    		}
    		else {
	    		let query = {
	    			idx : idx,
	    			mid : mid,
	    			part : part,
	    			flag : "no"
	    		}
	    		$.ajax({
	    			url : "${ctp}/community/communityGood",
	    			type : "post",
	    			data : query,
	    			success : function(res){
	    				if(res == "1") location.reload();
	    				else if(res == "2") alert("좋아요 실패");
	    			},
	    			error : function(){
	    				alert("전송오류(communityMain.jsp)")
	    			}
	    		});
    		}
    	}
    	
    	// 북마크 선택
    	function bookmarkYes(idx){
    		let mid = '${sMid}';
    		let part = 'community';

    		if(mid.trim() == ""){
    			alert("로그인 후 이용 가능한 서비스 입니다.");
    			location.href="${ctp}/member/login"
    		}
    		else {
	    		let query = {
	    			idx : idx,
	    			mid : mid,
	    			part : part,
	    			flag : "yes"
	    		}
	    		$.ajax({
	    			url : "${ctp}/community/communityBookmark",
	    			type : "post",
	    			data : query,
	    			success : function(res){
	    				if(res == "1") location.reload();
	    				else if(res == "2") alert("북마크 실패");
	    			},
	    			error : function(){
	    				alert("전송오류(communityMain.jsp)")
	    			}
	    		});
    		}
    	}
    	
    	// 북마크 취소
    	function bookmarkNo(idx){
    		let mid = '${sMid}';
    		let part = 'community';

    		if(mid.trim() == ""){
    			alert("로그인 후 이용 가능한 서비스 입니다.");
    			location.href="${ctp}/member/login"
    		}
    		else {
	    		let query = {
	    			idx : idx,
	    			mid : mid,
	    			part : part,
	    			flag : "no"
	    		}
	    		$.ajax({
	    			url : "${ctp}/community/communityBookmark",
	    			type : "post",
	    			data : query,
	    			success : function(res){
	    				if(res == "1") location.reload();
	    				else if(res == "2") alert("북마크 해제 실패");
	    			},
	    			error : function(){
	    				alert("전송오류(communityMain.jsp)")
	    			}
	    		});
    		}
    	}
    	
    	// 글 삭제
    	function cDelBtn(idx){
    		let ans = confirm("해당 글을 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/community/communityDel",
    				type : "post",
    				data : {idx : idx},
    				success : function(res){
    					if(res == "1") location.href="${ctp}/community/communityMain";
    					else if(res == "2") alert("게시글 삭제에 실패하였습니다.");
    				},
    				error : function(){
    					alert("전송오류(communityMain.jsp)");
    				}
    			});
    		}
    	}
    	
    	function replyFocus(){
    		$("#replyContent").focus();
    	}
    	
    	// 댓글 대댓글 삭제
    	function replyDel(idx){
    		let ans = confirm("해당 댓글을 삭제하시겠습니까?");
    		
    		if(ans){
	    		$.ajax({
	    			url : "${ctp}/community/communityReplyDel",
	    			type : "post",
	    			data : {idx : idx},
	    			success : function(res){
	    				if(res == "1") location.reload();
						else if(res == "2") alert("댓글 삭제에 실패하였습니다.");
	    			},
	    			error : function(){
	    				alert("전송오류(communityContent.jsp)");
	    			}
	    		});
    		}
    	}
    	
    	$(function(){
        	$(".replyCloseBtn").hide();
        });
        
        // 대댓글 박스 보여주기
        function replyShow(idx) {
        	$("#replyShowBtn"+idx).hide();
        	$("#replyCloseBtn"+idx).show();
        	$("#replyDemo"+idx).slideDown(100);
        }
        
        // 대댓글 박스 감추기
        function replyClose(idx) {
        	$("#replyShowBtn"+idx).show();
        	$("#replyCloseBtn"+idx).hide();
        	$("#replyDemo"+idx).slideUp(300);
        }
        
        // 대댓글(부모글의 답변글) 입력처리
        function replyCheckRe(comuIdx, reIdx, Idx) {
        	let content = $("#contentRe"+Idx).val();
        	if(content.trim() == "") {
        		alert("답변글을 입력하세요!");
        		$("#contentRe"+Idx).focus();
        		return false;
        	}
        	let query = {
       			comuIdx : comuIdx,
       			reIdx : reIdx,
     			mid	: '${sMid}',
      			content	: content
        	}
        	
        	$.ajax({
        		url  : "${ctp}/community/communityRerplyInput",
        		type : "post",
        		data : query,
        		success:function(res) {
        			if(res == "1") {
        				location.reload();
        			}
        			else {
        				alert("대댓글 입력에 실패하였습니다.");
        			}
        		},
        		error : function() {
        			alert("전송오류(communityContent.jsp)");
        		}
        	});
        }
        
        // 게시글 신고 모달창 값 전달
        function reportContentModal(idx,mid,nickName){
        	$("#communityReportIdx").val(idx);
        	$("#communityReportMid").val(mid);
        	$(".communityReportMid").html(mid);
        	$("#communityReportNickName").html(nickName);
        }
        
        // 게시글 신고
        function communityReportBtn(){
        	let idx = $("#communityReportIdx").val(); 
        	let mid = $("#communityReportMid").val();
        	let reason = $("#communityReportSelect").val();
        	let sMid = '${sMid}';
        	
        	if(reason.trim() == ""){
        		alert("신고 이유를 선택해주세요.");
        		return false;
        	}
        	else {
        		let query = {
        			idx : idx,
        			mid : mid,
        			reason : reason,
        			sMid : sMid
        		}
        		$.ajax({
        			url : "${ctp}/community/communityContentReport",
        			type : "post",
        			data :query,
        			success : function(res){
        				if(res == "1") {
        					alert("신고처리 되었습니다.");
        					location.reload();
        				}
        				else if(res == "2") alert("신고처리에 실패하였습니다.");
        			},
        			error : function(){
        				alert("전송오류(communityContent.jsp)");
        			}
        		});
        	}
        	
        }
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<div id="community-main-container">
    <!-- 커뉴니티 글 보이기 -->
    <div id="community-list-container">
    	<div class="f-d">
	    	<div class="f-d-2">
	    		<div style="width: 100%">
		    		<div class="main-home-btn"><a href="${ctp}/community/communityMain"><i class="fa-solid fa-house"></i>&nbsp;&nbsp; 홈으로</a></div>
		    		<c:if test="${sMid != null }">
			    		<hr/>
			    		<div class="profile-go-btn"><a href="${ctp}/community/communityProfile?mid=${sMid}"><i class="fa-solid fa-user"></i>&nbsp;&nbsp; 프로필</a></div>
			    		<hr/>
			    		<div class="bookmark-go-btn"><a href=""><i class="fa-solid fa-bookmark"></i>&nbsp;&nbsp; 북마크</a></div>
			    		<hr/>
			    		<div class="comu-up-btn"><button type="button" data-toggle="modal" data-target="#myModal"> 글 올리기</button></div>
		    		</c:if>
	    		</div>
	    	</div>
	    	<div class="f-d-8" >
	    		<div style="width: 100%">
    				<div class="f-d f-sc">
    					<c:if test="${empty flag}">
	    					<div class="comu-main-go"><a href="${ctp}/community/communityMain?pag=${pag}&pageSize=${pageSize}"><i class="fa-solid fa-angle-left"></i></a></div>
    					</c:if>
    					<c:if test="${flag == 'profile'}">
	    					<div class="comu-main-go"><a href="${ctp}/community/communityProfile?pag=${pag}&pageSize=${pageSize}&mid=${mid}"><i class="fa-solid fa-angle-left"></i></a></div>
    					</c:if>
    					<div class="f-d-menu" style="background-color: #fff">커뮤니티 상세보기</div>
    				</div>
		    			<c:set var="img" value="${comVO.imgs.split('/')}" />
		    			<div class="f-d">
	    					<c:if test="${sMid != null }">
		    				<div class="report-del-container">
		    					<ul class="ul-report-del-btn">
		    						<li>
					    				<a href="javascript:menuC()" class="menu-c"><i class="fa-solid fa-bars"></i></a>
					    				<ul class="inner-li-report-del-btn">
					    					<c:if test="${sMid == comVO.mid }">
						    					<li><a href="javascript:cDelBtn(${comVO.idx })">삭제</a></li>
						    					<hr/>
					    					</c:if>
					    					<c:if test="${sMid != comVO.mid }">
						    					<li><a href="#" onclick="reportContentModal('${comVO.idx}','${comVO.mid}','${comVO.nickName}')" data-toggle="modal" data-target="#reportContentModal">신고</a></li>
					    					</c:if>
					    				</ul>
		    						</li>
		    					</ul>
		    				</div>
	    					</c:if>
	    				</div>
		    			<div class="f-d btb pd comu-content">
		    				<div class="f-d-1-img profile-img">
		    					<div>
				    				<a href="${ctp}/community/communityProfile?mid=${comVO.mid}&flag=comuContent&idx=${comVO.idx}"><img src="${ctp}/data/member/${comVO.profile}" ></a>
		    					</div>
		    				</div>
		    				<div class="f-d-9 pd-i">
		    					<div style="width: 100%">
		    						<div class="f-d">
				    					<div class="pr-1">${comVO.nickName }</div>
				    					<div style="color: #aaa">@${comVO.mid}</div>
				    					<div style="margin-left: auto">
				    						${fn:substring(comVO.CDate,0,16)}
				    					</div>
		    						</div>
		    						<div class="f-d pt-2 comu-content-inner">
		    							<div style="width: 100%">
			    							${comVO.content }
		    							</div>
	    							</div>
		    						<div class="f-d pt-2 ">
		    							<c:if test="${empty img}">
		    							</c:if>
		    							<c:if test="${fn:length(img) == 1 && !empty img[0]}">
		    								<div class="heit"><a href="${ctp}/data/community/${img[0]}" target="_blank"><img src="${ctp}/data/community/${img[0]}" width="100%"/></a></div>
		    							</c:if>
		    							<c:if test="${fn:length(img) == 2 && !empty img[0]}">
		    								<div class="f-d heit">
		    									<div class="f-d-5">
				    								<div class=""><a href="${ctp}/data/community/${img[0]}" target="_blank"><img src="${ctp}/data/community/${img[0]}" width="100%" /></a></div>
		    									</div>
		    									<div class="f-d-5">
				    								<div class=""><a href="${ctp}/data/community/${img[1]}" target="_blank"><img src="${ctp}/data/community/${img[1]}" width="100%"/></a></div>
		    									</div>
		    								</div>
		    							</c:if>
		    							<c:if test="${fn:length(img) == 3 && !empty img[0]}">
		    								<div class="f-d-5 heit">
			    								<div class=><a href="${ctp}/data/community/${img[0]}" target="_blank"><img src="${ctp}/data/community/${img[0]}" width="100%" /></a></div>
		    								</div>
		    								<div class="f-d-5 heit" >
			    								<a href="${ctp}/data/community/${img[1]}" target="_blank" class="heit-150"><img src="${ctp}/data/community/${img[1]}" width="100%" /></a>
			    								<a href="${ctp}/data/community/${img[2]}" target="_blank" class="heit-150"><img src="${ctp}/data/community/${img[2]}" width="100%" /></a>
		    								</div>
		    							</c:if>
		    							<c:if test="${fn:length(img) == 4 && !empty img[0]}">
		    								<div class="f-d-5 heit">
			    								<a href="${ctp}/data/community/${img[0]}" target="_blank" class="heit-150"><img src="${ctp}/data/community/${img[0]}" width="100%" /></a>
			    								<a href="${ctp}/data/community/${img[1]}" target="_blank" class="heit-150"><img src="${ctp}/data/community/${img[1]}" width="100%" /></a>
		    								</div>
		    								<div class="f-d-5 heit" >
			    								<a href="${ctp}/data/community/${img[2]}" target="_blank" class="heit-150"><img src="${ctp}/data/community/${img[2]}" width="100%" /></a>
			    								<a href="${ctp}/data/community/${img[3]}" target="_blank" class="heit-150"><img src="${ctp}/data/community/${img[3]}" width="100%" /></a>
		    								</div>
		    							</c:if>
		    						</div>
		    						<div class="f-d mt-2 reply-good-bookmark-btn">
		    							<c:if test="${sMid == null }">
			    							<div class="f-d-3 replyhover" style="color: #aaa"><a><i class="fa-regular fa-comment"> ${comVO.replyCnt }</i></a></div>
		    							</c:if>
		    							<c:if test="${sMid != null }">
			    							<div class="f-d-3 replyhover reply-input"><button type="button" onclick="replyFocus()"><i class="fa-regular fa-comment"></i> ${comVO.replyCnt }</button></div>
		    							</c:if>
		    							<c:if test="${comVO.midGoodCheck == 0 }">
			    							<div class="f-d-3 goodhover"><a href="javascript:goodYes(${comVO.idx})"><i class="fa-regular fa-heart"></i> ${comVO.goodCnt }</a></div>
		    							</c:if>
		    							<c:if test="${comVO.midGoodCheck == 1 }">
			    							<div class="f-d-3 goodhover" style="color: pink"><a href="javascript:goodNo(${comVO.idx})"><i class="fa-solid fa-heart"></i> ${comVO.goodCnt }</a></div>
		    							</c:if>
		    							<c:if test="${comVO.midBookmarkCheck == 0 }">
			    							<div class="f-d-3 "><a href="javascript:bookmarkYes(${comVO.idx})"><i class="fa-regular fa-bookmark"></i> ${comVO.bookmarkCnt }</a></div>
		    							</c:if>
		    							<c:if test="${comVO.midBookmarkCheck == 1 }">
			    							<div class="f-d-3 " style="color: blue"><a href="javascript:bookmarkNo(${comVO.idx})"><i class="fa-solid fa-bookmark"></i> ${comVO.bookmarkCnt }</a></div>
		    							</c:if>
		    						</div>
		    					</div>
		    				</div>
		    				<!-- 댓글 입력 창 -->
	    					<div style="width: 100%">
	    						<c:if test="${sMid != null }">
			    					<div class="f-d bt-1 pt-2 pb-2">
				    					<div class="f-d-1-img profile-img">
					    					<div>
							    				<a href=""><img src="${ctp}/data/member/${memVO.profile}" ></a>
					    					</div>
					    				</div>
					    				<div class="f-d-9 pd-i">
					    					<div style="width: 100%">
					    						<div class="f-d">
							    					<div class="pr-1">${memVO.nickName }</div>
							    					<div style="color: #aaa">@${memVO.mid}</div>
					    						</div>
				    							<div class="pt-2"><textarea rows="3" maxlength="140" style="width: 100%" id="replyContent" placeholder="답글 게시하기"></textarea></div>
				    							<div class="pr-2">
				    								<div class="f-d">
					    								<div class="content-reply-cnt">(0/140)</div>
					    								<div><a href="javascript:replyUpload(${comVO.idx })">게시하기</a></div>
				    								</div>
				    							</div>
					    					</div>
					    				</div>
			    					</div>
	    						</c:if>
	    						<c:if test="${sMid == null }">
			    					<div class="f-d bt-1 pt-3 mt-2">
				    					<div class="f-d-1-img profile-img">
					    					<div>
							    				<img src="${ctp}/data/member/no_img.png" >
					    					</div>
					    				</div>
					    				<div class="f-d-9 pd-i">
					    					<div style="width: 100%">
					    						<div class="f-d">
							    					<div class="pr-1"> 비회원 </div>
					    						</div>
				    							<div><a href="${ctp}/member/login"><textarea rows="2" style="width: 100%" id="loginNoReply" readonly placeholder="로그인 후 이용 가능한 서비스 입니다."></textarea></a></div>
					    					</div>
					    				</div>
			    					</div>
	    						</c:if>
		    				<!-- 올라온 댓글 보기 -->
		    				<c:forEach var="reVO" items="${reVOS }">
		    					<c:if test="${reVO.parentsReplyIdx == 0 }">
			    					<div class="f-d bt-1 pt-2 pb-2">
				    					<div class="f-d-1-img profile-img">
					    					<div>
							    				<a href=""><img src="${ctp}/data/member/${reVO.profile}" ></a>
					    					</div>
					    				</div>
					    				<div class="f-d-9 pd-i">
					    					<div style="width: 100%">
					    						<div class="f-d">
							    					<div class="pr-1">${reVO.nickName }</div>
							    					<div style="color: #aaa">@${reVO.mid}</div>
							    					<c:if test="${sMid != null }">
								    					<div style="margin-left: auto;" class="pr-1">
								    						<div class="f-d">
										    					<c:if test="${sMid == reVO.mid}">
											    					<div class="pr-3"><a href="javascript:replyDel(${reVO.idx})">삭제</a></div>
										    					</c:if>
										    					<div class="pr-3">
										    						<a href="javascript:replyShow(${reVO.idx})" id="replyShowBtn${reVO.idx}">대댓글</a>
											    					<a href="javascript:replyClose(${reVO.idx})" id="replyCloseBtn${reVO.idx}" class="replyCloseBtn" >대댓글</a>
									    						</div>
									    						<c:if test="${sMid != reVO.mid}">
										    						<div class="pr-3"><a href="javascript:replyReport(${reVO.idx})">신고</a></div>
										    					</c:if>
								    						</div>
								    					</div>
							    					</c:if>
					    						</div>
					    						<div class="f-d pt-2 comu-content-inner">
					    							<div style="width: 100%">
						    							${reVO.content }
					    							</div>
				    							</div>
			    							</div>
					    				</div>
			    					</div>
			    					
			    					<!-- 대댓글 -->
			    					<div class="f-d bt-1 pt-2 pb-2 pl-5" id="replyDemo${reVO.idx}" style="display: none;">
				    					<div class="f-d-1-img profile-img">
					    					<div>
							    				<a href=""><img src="${ctp}/data/member/${memVO.profile}" ></a>
					    					</div>
					    				</div>
					    				<div class="f-d-9 pd-i">
					    					<div style="width: 100%">
					    						<div class="f-d">
							    					<div class="pr-1">${memVO.nickName }</div>
							    					<div style="color: #aaa">@${memVO.mid}</div>
					    						</div>
				    							<div class="pt-2"><textarea rows="3" maxlength="140" style="width: 100%" id="contentRe${reVO.idx}" placeholder="답글 게시하기"></textarea></div>
				    							<div class="pr-2">
				    								<div class="f-d" style="justify-content: flex-end;">
					    								<div><a href="javascript:replyCheckRe(${comVO.idx },${reVO.idx},${reVO.idx})">게시하기</a></div>
				    								</div>
				    							</div>
					    					</div>
					    				</div>
			    					</div>
		    					</c:if>
		    					<c:forEach var="rerVO" items="${rerVOS }">
		    					<c:if test="${rerVO.parentsReplyIdx == reVO.idx}">
			    					<div class="f-d bt-1 pt-2 pb-2 pl-5">
				    					<div class="f-d-1-img profile-img">
					    					<div>
							    				<a href=""><img src="${ctp}/data/member/${rerVO.profile}" ></a>
					    					</div>
					    				</div>
					    				<div class="f-d-9 pd-i">
					    					<div style="width: 100%">
					    						<div class="f-d">
							    					<div class="pr-1">${rerVO.nickName }</div>
							    					<div style="color: #aaa">@${rerVO.mid}</div>
							    					<c:if test="${sMid != null }">
								    					<div style="margin-left: auto;" class="pr-1">
								    						<div class="f-d">
										    					<c:if test="${sMid == rerVO.mid}">
											    					<div class="pr-3"><a href="javascript:replyDel(${rerVO.idx})">삭제</a></div>
										    					</c:if>
										    					<div class="pr-3">
											    					<a href="javascript:replyShow(${rerVO.idx})" id="replyShowBtn${rerVO.idx}">대댓글</a>
											    					<a href="javascript:replyClose(${rerVO.idx})" id="replyCloseBtn${rerVO.idx}" class="replyCloseBtn" >대댓글</a>
										    					</div>
										    					<c:if test="${sMid != rerVO.mid}">
											    					<div class="pr-3"><a href="javascript:replyReport(${rerVO.idx})">신고</a></div>
										    					</c:if>
								    						</div>
								    					</div>
							    					</c:if>
					    						</div>
					    						<div class="f-d pt-2 comu-content-inner">
					    							<div style="width: 100%">
						    							${rerVO.content }
					    							</div>
				    							</div>
			    							</div>
					    				</div>
			    					</div>
			    					
			    					<!-- 대댓글 -->
			    					<div class="f-d bt-1 pt-2 pb-2 pl-5"  id="replyDemo${rerVO.idx}" style="display: none;">
				    					<div class="f-d-1-img profile-img">
					    					<div>
							    				<a href=""><img src="${ctp}/data/member/${memVO.profile}" ></a>
					    					</div>
					    				</div>
					    				<div class="f-d-9 pd-i">
					    					<div style="width: 100%">
					    						<div class="f-d">
							    					<div class="pr-1">${memVO.nickName }</div>
							    					<div style="color: #aaa">@${memVO.mid}</div>
					    						</div>
				    							<div class="pt-2"><textarea rows="3" maxlength="140" style="width: 100%" id="contentRe${rerVO.idx}" placeholder="답글 게시하기"></textarea></div>
				    							<div class="pr-2">
				    								<div class="f-d" style="justify-content: flex-end;">
					    								<div><a href="javascript:replyCheckRe(${comVO.idx },${rerVO.parentsReplyIdx},${rerVO.idx})">게시하기</a></div>
				    								</div>
				    							</div>
					    					</div>
					    				</div>
			    					</div>
		    					</c:if>
		    					</c:forEach>
		    				</c:forEach>
		    				</div>
		    			</div>
	    		</div>
		   	</div>
    	</div>
    </div>
</div>

<!-- 글올리기 -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
    	<form name="communityForm" method="post" enctype="multipart/form-data">
	    	<div class="f-d mgp-top">
	    		<div class="pl-2">커뮤니티 작성하기</div>
	    		<div style="color: #aaa; margin-left: auto; margin-right: 15px;">-이미지 최대 4개</div>
	    	</div>
	      	<div class="f-d pd-1">
	      		<div class="f-d-1">
	      			<img src="${ctp}/data/member/${memVO.profile}" width="90px" height="90px" style="border-radius: 100%" >
	      		</div>
	      		<div class="f-d-9 f-a f-b-ddd">
	      			<div style="width: 100%">
	      				<div class="f-d">
		      				<textarea rows="5" style="width: 100%" name="content" required id="content" maxlength="140" placeholder="즐거운 일상을 공유해보세요"></textarea>
	      				</div>
	      			</div>
		      		<div style="width: 100%;">
			      		<div class="f-d">
			      			<div id='att_zone'></div>
			      		</div>
		      		</div>
	      		</div>
	      	</div>
	      	<div class="f-d f-b-ddd pl-4">
		  		<div id="file-btns-div">
		  			<label for="imgs" class="la-f"><div><i class="fa-solid fa-image"></i>이미지등록</div></label>
		  			<input type="file" name="imgs" id="imgs" multiple />
		  		</div>
		  		<div class="content-cnt">(0/140)</div>
		  		<div class="content-upload-btn"><a href="javascript:communityUpload()" >게시하기</a></div>
	      	</div>
	      	<input type="hidden" name="mid" id="mid" value="${sMid}" />
      	</form>
    </div>
  </div>
</div>

<!-- 글 신고 -->
<div class="modal fade" id="reportContentModal">
  <div class="modal-dialog">
    <div class="modal-content">
    	<div class="f-d p-4">
    		<div style="width: 100%">
    		<div class="pb-2"><span id="communityReportNickName"></span><span style="color: #aaa"> (@<span class="communityReportMid"></span>)</span>님의 글을 신고</div>
    		<div>이 게시물에 어떤 문제가 있나요?</div>
    		<hr/>
	    		<div class="select-report-community">
	    			<select name="communityReportSelect" id="communityReportSelect">
	    				<option value="">신고할 내용을 선택해주세요.</option>
	    				<option value="불법촬영">전자통신사업법에 의거하여 불법촬영등 신고</option>
	    				<option value="관심없음">관심없는 게시물</option>
	    				<option value="스팸">의심스럽거나 스팸</option>
	    				<option value="민감한사진">민감한 사진을 보여주고 있음</option>
	    				<option value="유해한내용">가학적이거나 유해한 내용</option>
	    				<option value="오해소지">오해의 소지가 있음</option>
	    				<option value="자해자살표현">자해 또는 자살 의도를 표현하고 있음</option>
	    			</select>
	    		</div>
			<div class="mt-3 ">
				<div class="f-d communitiy-report-btns">
					<a href="javascript:communityReportBtn()">신고 하기</a>
				</div>
			</div>
    		</div>
    	</div>
    	<input type="hidden" id="communityReportIdx">
    	<input type="hidden" id="communityReportMid">
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
	
	( /* att_zone : 이미지들이 들어갈 위치 id, btn : file tag id */
    imageView = function imageView(att_zone, btn){

    var attZone = document.getElementById(att_zone);
    var imgs = document.getElementById(btn)
    var maxFileCnt = 4;
    var sel_files = [];
    
    // 이미지와 체크 박스를 감싸고 있는 div 속성
    var div_style = 'display:inline-block;position:relative;'
                  + 'width:150px;height:120px;margin:5px;border:1px solid #eee;z-index:1';
    // 미리보기 이미지 속성
    var img_style = 'width:100%;height:100%;z-index:none';
    // 이미지안에 표시되는 체크박스의 속성
    var chk_style = 'width:30px;height:30px;line-height:20px;position:absolute;font-size:24px;'
                  + 'right:0px;bottom:0px;z-index:99;background-color:rgba(255,255,255,0.1);color:#f00';
  
    imgs.onchange = function(e){
      var files = e.target.files;
      console.log('Selected files:', files);
      var fileArr = Array.prototype.slice.call(files)
      
       // 허용할 확장자 배열
	  var allowedExtensions = ["jpg", "jpeg", "png"];
	
	  // 파일 확장자 체크
	  for (var i = 0; i < fileArr.length; i++) {
	    var file = fileArr[i];
	    var extension = file.name.split('.').pop().toLowerCase();
	    
	    if (allowedExtensions.indexOf(extension) === -1) {
	      alert("허용되지 않는 파일 형식입니다. (jpg, jpeg, png만 허용)");
	      if (imgs) {
	        imgs.value = "";
	      }
	      return;
	    }
	  }
      
      if (sel_files.length + fileArr.length > maxFileCnt) {
        alert("이미지는 "+maxFileCnt+"개 올리실 수 있습니다.");
        if (imgs) {
            imgs.value = "";
        }
        return;
      }
      for(f of fileArr){
        imageLoader(f);
      }
      
   	  // 새로운 파일이 추가될 때만 imgs.files 업데이트
      updateImgFiles();
    }  
    
    
    /*첨부된 이미리즐을 배열에 넣고 미리보기 */
    imageLoader = function(file){
    	
    	if(sel_files.length == 0){
    		$("#att_zone").hide();
    	}
   	    if (sel_files.length >= maxFileCnt) {
          alert("이미지는 "+maxFileCnt+"개 올리실 수 있습니다.");
          return;
        }
    	
      sel_files.push(file);
      var reader = new FileReader();
      reader.onload = function(ee){
    	    let img = document.createElement('img');
    	    img.setAttribute('style', img_style);
    	    img.src = ee.target.result;
    	    attZone.appendChild(makeDiv(img, file));
    	  };
    	  
    	  reader.readAsDataURL(file);
    	}
    
    /*첨부된 파일이 있는 경우 checkbox와 함께 attZone에 추가할 div를 만들어 반환 */
    makeDiv = function(img, file){
      var div = document.createElement('div')
      div.setAttribute('style', div_style)
      
      var btn = document.createElement('input')
      btn.setAttribute('type', 'button')
      btn.setAttribute('value', 'x')
      btn.setAttribute('delFile', file.name);
      btn.setAttribute('style', chk_style);
      btn.onclick = function(ev){
        var ele = ev.srcElement;
        var delFile = ele.getAttribute('delFile');
        for(var i=0; i<sel_files.length; i++){
          if(delFile== sel_files[i].name){
            sel_files.splice(i, 1);      
          }
        }
        
        dt = new DataTransfer();
        for(f in sel_files) {
          var file = sel_files[f];
          dt.items.add(file);
        }
        
        imgs.files = dt.files;
        var p = ele.parentNode;
        attZone.removeChild(p)
        
        updateImgFiles();
      }
      
   	  // 파일이 제거될 때마다 imgs.files 업데이트
      updateImgFiles();
      
      div.appendChild(img)
      div.appendChild(btn)
      
      return div
    }
 // 새로운 파일이 추가될 때만 imgs.files 업데이트
    updateImgFiles = function () {
        var dt = new DataTransfer();
        for (var f in sel_files) {
            var file = sel_files[f];
            dt.items.add(file);
        }
        imgs.files = dt.files;

        // 비활성화 상태 업데이트는 여기서 진행
        updateDisabledState();
    };

    // 이미지가 제거될 때마다 비활성화 상태를 업데이트
    updateImgFiles = function () {
        var dt = new DataTransfer();
        for (var f in sel_files) {
            var file = sel_files[f];
            dt.items.add(file);
        }
        imgs.files = dt.files;

        // 비활성화 상태 업데이트는 여기서 진행
        updateDisabledState();
    };

    // 파일 추가 및 제거 시 파일 input 엘리먼트의 비활성화 상태를 업데이트
    updateDisabledState = function () {
        var inputElement = document.getElementById(btn);

        if (sel_files.length >= maxFileCnt) {
            inputElement.disabled = true;
        } else {
            inputElement.disabled = false;
        }
        
        if(sel_files.length > 0){
    		$("#att_zone").show();
    	}
    };
  }
)('att_zone', 'imgs')

</script>
</body>
</html>