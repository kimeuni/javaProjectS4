<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${proVO.nickName} @${proVO.mid}</title>
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
			padding-right: 30px;
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
		.f-d-3-menu a{
			width : 100%;
			height: 60px;
			text-decoration: none;
			color: #000;
			text-align: center;
		}
		.f-d-menu{
			height: 60px;
			display: flex;
			width: 100%;
			justify-content: left;
			font-size: 1.5em;
			line-height: 60px;
			border-left: 1px solid #ddd;
			padding-left: 35px;
		}
		.checked-yes{
			background-color: #fff;
		}
		.checked-no{
			background-color: #eee;
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
		.comu-content:hover{
			background-color: #eee;
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
		.comu-main-go a{
			display: flex;
			width: 50px;
			font-size: 1.1em;
			height: 40px;
			justify-content: center;
			text-decoration: none;
			color: #000;
			margin-top: 19px;
			padding-right: 20px;
		}
		.pro-header-img-div{
			list-style: none;
			margin: 0px;
			padding: 0px;
		}
		.pro-header-img-div ul{
			list-style: none;
			margin: 0px;
			padding: 0px;
		}
		.pro-header-img-div{
			position: relative;
		}
		.pro-header-img-div:hover .pro-header-file-div{
			display: block;
		}
		.pro-header-file-div img{
			width: 100%;
			height: 100%;
			cursor: pointer;
		}
		.pro-header-file-div input[type="button"]{
			height: 1px;
    		width: 1px;
    		margin: -1px;
    		overflow: hidden;
			position: absolute;
			border: 0px;
			background-color: rgba(0,0,0,0);
		}
		.pro-header-file-div{
			position: absolute;
			width: 100px;
			height: 100px;
			top: 25%;
			left : 40%;
			display: none;
		}
		.pro-profile-text-div{
			padding: 20px
		}
		.f-follow{
			display : flex;
			margin-left: auto;
			line-height: 55px;
			text-align: center;
			justify-content: center;
		}
		.f-follow a{
			padding: 3px;
			border: 1px solid;
			width: 100px;
			line-height: 30px;
			text-decoration: none;
			color: #000;
			border-radius: 5px;
		}
		.store-info-str{
			padding-right: 20px;
		}
		#f-follow-alarm{
			display : flex;
			line-height: 55px;
			padding-left: 20px;
			text-align: center;
		}
		#f-follow-alarm a{
			width: 30px;
			height: 30px;
			line-height : 30px;
			border: 1px solid;
			text-decoration: none;
			color: #000;
			margin: 10px;
		}
		.f-alarm-ok{
			background-color: #faf1f2;
			color: red !important;
			border: 1px solid red !important;
		}
		.used-shop-go-btn{
			display : flex;
			line-height: 55px;
			text-align: center;
			justify-content: flex-end; 
			margin-left: auto;
		}
		.used-shop-go-btn a{
			padding: 10px;
			border: 1px solid #5E5756;
			width: 100px;
			line-height: 30px !important;
			text-decoration: none;
			color: #fff;
			border-radius: 5px;
			background-color: #5E5756
		}
		.used-shop-go-btn .pro-soge-update-show a,.used-shop-go-btn .pro-soge-update-close a{
			margin-right : 10px;
			background-color : #fff;
			border: 1px solid #5E5756;
			color: #000;
		}
		.pro-soge-update-close a{
			background-color: #EBDDCC !important;
		}
		.pro-nickName-div{
			font-weight: bold;
			font-size: 1.2em;
			margin-top: 10px;
			margin-bottom: 5px;
		}
		.header-img-container-f{
			position: fixed;
			top:25%;
			left: 50%;
    		transform: translate(-50%, 0);
			width: 1000px;
			border: 1px solid gray;
			background-color:#fff;
		}
		.fowing-hover:hover{
			background-color: #ddd;
		}
		.fowing-list-d{
			height: 500px;
			overflow: auto;
		}
		.intro-div{
			height: 40px;
		}
		.close-fing-btn{
			justify-content: flex-end;
		}
		.close-fing-btn a{
			justify-content : center;
			display : flex;
			margin-bottom: 10px;
			margin-right: 10px;
			background-color: #ccc;
			border: 1px solid;
			border-radius: 5px;
			width: 70px;
			text-decoration: none;
			color: #000;
		}
		#follower-list-container{
			position: fixed;
			top:25%;
			left: 50%;
    		transform: translate(-50%, 0);
			width: 500px;
			border: 1px solid gray;
			background-color:#fff;
		}
		#follower-list-container img{
			border-radius: 100%
		}
		#folloing-list-container img{
			border-radius: 100%
		}
		#folloing-list-container{
			position: fixed;
			top:25%;
			left: 50%;
    		transform: translate(-50%, 0);
			width: 500px;
			border: 1px solid gray;
			background-color:#fff;
		}
		.fing-text-list{
			font-size: 1.2em;
			margin-top: 10px;
			text-align: center;
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
    	.file-btn-div{
    		display: inline-block;
    	}
    	#headerImg-demo{
    		margin: 10px 0px;
    	}
    	#img-url-div input[type="text"]{
    		width: 350px;
    		height : 35px;
    		border: 1px solid gray;
    		padding: 0px 10px;
    		margin-bottom: 20px;
    	}
    	#img-url-div input[type="button"]{
    		width: 350px;
    		height : 35px;
    		background-color: #eee;
    		border: 1px solid gray;
    		font-weight: bold;
    	}
    	.c-h-div-btn {
    		display : flex;
    		margin-left: auto; 
    	}
    	.c-h-div-btn a{
    		width: 100px;
    		display: flex;
    		height: 35px;
    		line-height: 35px;
    		justify-content: center;
    		border: 1px solid;
    		text-decoration: none;
    		color: #000;
    		margin-right: 10px;
    		margin-bottom: 10px;
    	}
    	.pro-comuSoge-div{
    		max-height: 150px;
    		overflow: auto;
    		padding: 10px 0px;
    	}
    	.f-1-d{
    		display: flex;
    		width: 20%;
    	}
    	.f-9-d{
    		display: flex;
    		width: 80%;
    	}
    	.fing-list-div{
    		padding: 5px;
    	}
    	.no-comVOS{
    		text-align: center;
    		margin: 30px;
    		font-size: 1.5em;
    		font-weight: bold;
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
    		$("#rContent").on("keyup",function() {
	    		let content = $("#rContent").val();
    			str = '('+ content.length +'/140)';
    			$(".content-reply-cnt").html(str);
    			
    			if(content.length > 140){
	    			$(".content-reply-cnt").html("(140/140)");
    				alert("내용은 140글자까지 가능합니다.")
    				$("#rContent").val(content.substring(0,140));
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
    			
    			content = content.replace(/(?:\r\n|\r|\n)/g,'<br/>');
    			communityForm.content.value = content
    			
    			communityForm.submit();
    		}
    	}
    	
    	// 댓글 모달에 값 넘기기
    	function modalView(nickName, mid,idx,content,img){
    		
    		console.log(nickName);
    		console.log(mid);
    		console.log(idx);
    		console.log(content);
    		console.log(img);
    		
    		content = content.replaceAll("<", "&lt;");
    		content = content.replaceAll(">", "&gt;");
    		
    		$("#rMid").html(mid);
    		$("#rNickName").html(nickName);
    		$("#rContentM").html(content);
    		$("#rIdx").val(idx);
    		$("#imgSrc").attr("src","${ctp}/data/member/"+img);
    	}
    	
    	// 댓글 업로드
    	function replyUpload(){
    		let content = $("#rContent").val();
    		let idx = $("#rIdx").val();
    		let mid = "${sMid}";
    		
    		if(content.trim() == ""){
    			alert("댓글을 입력해주세요.");
    			$("#rContent").focus();
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
    					alert("전송오류")
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
    		else{
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
	    				alert("전송오류")
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
    		else{
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
	    				alert("전송오류")
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
    		else{
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
	    				alert("전송오류")
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
    		else{
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
	    				alert("전송오류")
	    			}
	    		});
    		}
    	}
    	
    	// 해당 게시글 상세보기 화면 이동
    	function comuContentInnerGo(pag,pageSize,idx){
    		location.href="${ctp}/used/usedMain"
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
    					if(res == "1") location.reload();
    					else if(res == "2") alert("게시글 삭제에 실패하였습니다.");
    				},
    				error : function(){
    					alert("전송오류")
    				}
    			});
    		}
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
        				alert("전송오류");
        			}
        		});
        	}
        }
        
		//헤더 이미지 DB에서 띄우기
    	$(function() {
    		let headerImgs = $("#headerImgs").val();
    		if(headerImgs == ""){
	   			$("#headerImges").attr("src", '${ctp}/data/communityProfile/${proVO.headerImg}');
    		}
    	});
    
	    // 선택한 이미지 화면에 출력 (미리보기)
	    function imgCheck(e){
	    	if(e.files && e.files[0]){
	    		let reader = new FileReader();
				reader.onload = function(e){
					document.getElementById("headerImges").src = e.target.result;
				}
				reader.readAsDataURL(e.files[0]);
			}
	    }
        
        // 헤더 변경 화면 감추기
        $(function() {
        	$(".header-img-container-f").hide();
        });
        
        // 헤더 변경 화면 보여주기
        function headerImgShow(){
        	$(".header-img-container-f").show();
        }
        
        // 헤더 등록
	    function headerImgInput(){
	    	let headerImg = document.getElementById("headerImgs").value;
	  		
	    	if(headerImg.trim() == ""){
	    		alert("이미지를 등록해주세요.");
	    		return false;
	    	}
	  		else if(headerImg.trim() != "") {
		    	let ext = headerImg.substring(headerImg.lastIndexOf(".")+1).toLowerCase();
		    	let maxSize = 1024 * 1024 * 10;
		    	let fileSize = document.getElementById("headerImgs").files[0].size;
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
		    	else {
		    		headerForm.submit();
		    	}
	  		}
	    }
        
        function closeHeader(){
        	$(".header-img-container-f").hide();
        }
        
        // 프로필 소개 수정
        $(function(){
        	$(".pro-soge-update-close").hide();
        	$(".pro-comuSoge-input").hide();
        });
        
        function proSogeUpdateShow(){
        	$(".pro-soge-update-close").show();
        	$(".pro-comuSoge-input").show();
        	$(".pro-soge-update-show").hide();
        }
        function proSogeUpdateClose(){
        	$(".pro-soge-update-show").show();
        	$(".pro-soge-update-close").hide();
        	$(".pro-comuSoge-input").hide();
        	
        	let communityIntroduce = $("#communityIntroduce").val();
        	let mid = '${sMid}';

        	let query = {
        		mid : mid,
        		communityIntroduce : communityIntroduce
        	}
        	$.ajax({
        		url : "${ctp}/community/communitySogeUpdate",
        		type : "post",
        		data : query,
        		success : function(res){
        			if(res == "1") location.reload();
        			else if(res == "2") alert("프로필 소개 수정에 실패하였습니다.")
        		},
        		error : function(){
        			alert("전송오류")
        		}
        	});
        }

		// 팔로우 취소
		function followNo(followingMid){
			let query = {
					followerMid : '${sMid}',
					followingMid : followingMid,
					flag : "No"
			}
			$.ajax({
				url : "${ctp}/community/communityFollow",
				type : "post",
				data : query,
				success : function(res){
					if(res == "1") location.reload();
					else if(res == "2") alert("팔로우 취소에 실패하였습니다.");
				},
				error : function(){
					alert("전송오류");
				}
			});
		}
		
		// 팔로우 하기
		function followYes(followingMid){
			let query = {
					followerMid : '${sMid}',
					followingMid : followingMid,
					flag : "Yes"
			}
			$.ajax({
				url : "${ctp}/community/communityFollow",
				type : "post",
				data : query,
				success : function(res){
					if(res == "1") location.reload();
					else if(res == "2") alert("팔로우에 실패하였습니다.");
				},
				error : function(){
					alert("전송오류");
				}
			});
		}
		

		// 해당 알림 N
		function fAlarmNo(sMid,followingMid){
			let query = {
				sMid : sMid,
				followingMid : followingMid,
				flag : 'N'
			}
			$.ajax({
				url : "${ctp}/community/followAlarmYN",
				type : "post",
				data : query,
				success : function(res){
					if(res == "1") location.reload();
					else if(res == "2") alert("알림 끄기에 실패하였습니다.")
				},
				error : function(){
					alert("전송오류")
				}
			});
		}
		
		// 해당 알림 Y
		function fAlarmYes(sMid,followingMid){
			let query = {
				sMid : sMid,
				followingMid : followingMid,
				flag : 'Y'
			}
			$.ajax({
				url : "${ctp}/community/followAlarmYN",
				type : "post",
				data : query,
				success : function(res){
					if(res == "1") location.reload();
					else if(res == "2") alert("알림 켜기에 실패하였습니다.")
				},
				error : function(){
					alert("전송오류")
				}
			});
		}
		
		
		$(function(){
			$("#folloing-list-container").hide();
			$("#follower-list-container").hide();
		});
		
		// 팔로우 중 리스트
		function openFing(){
			$("#folloing-list-container").show();
		}
		
		function closeFing(){
			$("#folloing-list-container").hide();
		}
		
		// 팔로워 리스트
		function openFer(){
			$("#follower-list-container").show();
		}
		
		function closeFer(){
			$("#follower-list-container").hide();
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
			    		<div class="bookmark-go-btn"><a href="${ctp}/community/communityBookmark?mid=${sMid}"><i class="fa-solid fa-bookmark"></i>&nbsp;&nbsp; 북마크</a></div>
			    		<hr/>
			    		<div class="comu-up-btn"><button type="button" data-toggle="modal" data-target="#myModal"> 글 올리기</button></div>
		    		</c:if>
	    		</div>
	    	</div>
	    	<div class="f-d-8" >
	    		<div style="width: 100%">
    				<div class="f-d f-sc">
    					<div class="f-d-menu checked-yes">
    						<c:if test="${empty flag}">
	    						<div class="comu-main-go"><a href="${ctp}/community/communityMain"><i class="fa-solid fa-angle-left"></i></a></div>
    						</c:if>
    						<c:if test="${flag == 'comuContent'}">
	    						<div class="comu-main-go"><a href="${ctp}/community/communityContent?pag=${pag}&pageSize=${pageSize}&idx=${idx}"><i class="fa-solid fa-angle-left"></i></a></div>
    						</c:if>
    						<div>${proVO.nickName} &nbsp;&nbsp; <span style="color: gray; font-size: 0.8em;">${proVO.comuCnt} 게시물</span></div>
    					</div>
    				</div>
    				<div class="f-d">
    					<div style="width: 100%">
	    					<div>
	    						<c:if test="${sMid == proVO.mid }">
	    							<ul class="pro-header-img-div">
	    								<li> <img src="${ctp}/data/communityProfile/${proVO.headerImg}" width="100%" height="250px" />
	    									<ul class="pro-header-file-div">
	    										<li>
	    											<label for="headerImg"><img src="${ctp}/data/communityProfile/추가.png"></label>
	    											<input type="button" name="headerImg" id="headerImg" onclick="headerImgShow()">
	    										</li>
	    									</ul>
	    								</li>
	    							</ul>
	    						</c:if>
	    						<c:if test="${sMid != proVO.mid }">
		    						<img src="${ctp}/data/communityProfile/${proVO.headerImg}" width="100%" height="250px" />
	    						</c:if>
    						</div>
    						<div class="pro-profile-text-div">
	    						<div class="f-d">
			    					<div class="pro-img-div">
			    						<img src="${ctp}/data/member/${proVO.profile}" width="80px" height="80px">
		    						</div>
	    							<div>
	    								<c:if test="${sMid != proVO.mid && sMid != null}">
	    									<div class="f-d">
											<c:if test="${empty fVO }">
		    									<div class="f-d" style="justify-content: flex-end;">
													<div class="f-follow" style="margin-left: 10px;"><a href="javascript:followYes('${proVO.mid}')"><i class="fa-solid fa-user-plus"></i> 팔로우</a></div>
												</div>
											</c:if>
											<c:if test="${!empty fVO }">
												<div id="f-follow-alarm">
													<c:if test="${fVO.alarm == 'Y' }">
														<a href="javascript:fAlarmNo('${sMid}','${proVO.mid}')" class="f-alarm-ok"><div><i class="fa-regular fa-bell-slash"></i></div></a>
													</c:if>
													<c:if test="${fVO.alarm != 'Y' }">
														<a href="javascript:fAlarmYes('${sMid}','${proVO.mid}')"><div><i class="fa-solid fa-bell"></i></div></a>
													</c:if>
												</div>
												<div class="f-d " style="justify-content: flex-end; margin: auto; margin-left: auto">
													<div class="f-follow"><a href="javascript:followNo('${proVO.mid}')"><i class="fa-solid fa-user-check"></i> 팔로잉</a></div>
												</div>
											</c:if>
											</div>
										</c:if>
	    							</div>
	    							<div class="used-shop-go-btn">
	    								<c:if test="${sMid == proVO.mid }">
		    								<div class="pro-soge-update-show"><a href="javascript:proSogeUpdateShow()">프로필 소개 수정</a></div>
		    								<div class="pro-soge-update-close"><a href="javascript:proSogeUpdateClose()">프로필 소개 저장</a></div>
	    								</c:if>
	    								<div><a href="${ctp}/used/usedStore?mid=${proVO.mid}">상점보기 <i class="fa-solid fa-right-to-bracket"></i></a></div>
    								</div>
	    						</div>
		    					<div class="pro-nickName-div">${proVO.nickName }</div>
		    					<div class="pro-mid-div" >@${proVO.mid }</div>
		    					<div class="pro-comuSoge-div" >${proVO.communityIntroduce }</div>
		    					<div class="pro-comuSoge-input" ><textarea rows="4" id="communityIntroduce" name="communityIntroduce" style="width: 100%">${proVO.communityIntroduce }</textarea> </div>
		    					<div class="f-d">
		    						<div><a href="javascript:openFing()">팔로우 중 ${fingCnt }</a></div> &nbsp;&nbsp;| &nbsp;&nbsp;
		    						<div><a href="javascript:openFer()">팔로워 ${ferCnt}</a></div>
		    					</div>
	    					</div>
    					</div>
    				</div>
    				<div class="f-d">
   						<div class="f-d-3-menu checked-ok"><a href="${ctp}/community/communityProfile?mid=${proVO.mid }">게시물</a></div>
   						<div class="f-d-3-menu checked-no"><a href="${ctp}/community/communityMedia?mid=${proVO.mid }">미디어</a></div>
   						<div class="f-d-3-menu checked-no"><a href="${ctp}/community/communityGood?mid=${proVO.mid }">좋아요</a></div>
    				</div>
	    			<c:if test="${empty comVOS}"><div class="no-comVOS">올린 글이 존재하지 않습니다.</div></c:if>
		    		<c:forEach var="comVO" items="${comVOS }">
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
				    				<a href="${ctp}/community/communityProfile?mid=${comVO.mid}"><img src="${ctp}/data/member/${comVO.profile}" ></a>
		    					</div>
		    				</div>
		    				<div class="f-d-9 pd-i">
		    					<div style="width: 100%">
		    						<div class="f-d">
				    					<div class="pr-1">${comVO.nickName }</div>
				    					<div style="color: #aaa">@${comVO.mid}</div>
				    					<div style="margin-left: auto;color: gray">
				    						<c:if test="${comVO.second_diff <= 59}"><div class="inner-flex-end">${comVO.second_diff}초</div></c:if>
							    			<c:if test="${comVO.second_diff > 59 && comVO.minute_diff <= 59}"><div class="inner-flex-end">${comVO.minute_diff}분</div></c:if>
							    			<c:if test="${comVO.minute_diff > 59 && comVO.hour_diff <=23}"><div class="inner-flex-end">${comVO.hour_diff}시간</div></c:if>
							    			<c:if test="${comVO.hour_diff > 23}"><div class="inner-flex-end">${fn:substring(comVO.CDate,0,10)}</div></c:if>
				    						
				    					</div>
		    						</div>
		    						<div class="f-d pt-2 comu-content-inner">
		    							<div style="width: 100%">
			    							<a href="communityContent?idx=${comVO.idx}&pag=${pageVO.pag }&pageSize=${pageVO.pageSize}&flag=profile&mid=${comVO.mid}">${comVO.content }</a>
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
			    							<div class="f-d-3 replyhover " style="color: #aaa"><a><i class="fa-regular fa-comment"> ${comVO.replyCnt }</i></a></div>
		    							</c:if>
		    							<c:if test="${sMid != null }">
			    							<div class="f-d-3 replyhover reply-input"><button type="button" data-toggle="modal" data-target="#replyModal" onclick="modalView('${comVO.nickName}','${comVO.mid }','${comVO.idx }','${fn:replace(comVO.content,newLine,'') }','${comVO.profile }')"><i class="fa-regular fa-comment"></i> ${comVO.replyCnt }</button></div>
		    							</c:if>
		    							<c:if test="${comVO.midGoodCheck == 0 }">
			    							<div class="f-d-3 goodhover"><a href="javascript:goodYes(${comVO.idx})"><i class="fa-regular fa-heart"></i> ${comVO.goodCnt }</a></div>
		    							</c:if>
		    							<c:if test="${comVO.midGoodCheck == 1 }">
			    							<div class="f-d-3 goodhover" style="color: pink"><a href="javascript:goodNo(${comVO.idx})"><i class="fa-solid fa-heart"></i> ${comVO.goodCnt }</a></div>
		    							</c:if>
		    							<c:if test="${comVO.midBookmarkCheck == 0 }">
			    							<div class="f-d-3"><a href="javascript:bookmarkYes(${comVO.idx})"><i class="fa-regular fa-bookmark"></i> ${comVO.bookmarkCnt }</a></div>
		    							</c:if>
		    							<c:if test="${comVO.midBookmarkCheck == 1 }">
			    							<div class="f-d-3" style="color: blue"><a href="javascript:bookmarkNo(${comVO.idx})"><i class="fa-solid fa-bookmark"></i> ${comVO.bookmarkCnt }</a></div>
		    							</c:if>
		    						</div>
		    					</div>
		    				</div>
		    			</div>
		    		</c:forEach>
			    <br/>
				<div class="text-center">
					<ul class="pagination justify-content-center">
					    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="communityProfile?pag=1&pageSize=${pageVO.pageSize}&mid=${mid}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
					  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="communityProfile?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&mid=${mid}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
					  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
						    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="communityProfile?pag=${i}&pageSize=${pageVO.pageSize}&mid=${mid}">${i}</a></li></c:if>
						    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="communityProfile?pag=${i}&pageSize=${pageVO.pageSize}&mid=${mid}">${i}</a></li></c:if>
					  	</c:forEach>
					  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="communityProfile?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&mid=${mid}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
					  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="communityProfile?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&mid=${mid}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
					</ul>
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
    	<form name="communityForm" method="post" enctype="multipart/form-data" action="communityMain">
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

<!-- 댓글 -->
<div class="modal fade" id="replyModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
    	<div class="f-d ">
	    	<div style="width: 100%;">
	    		<!-- <div class="p-3" style="color: #aaa"><span id="rNickName"></span>(@<span id="rMid"></span><span>)님께 답변</span></div> -->
	    		<div class="f-d btb pd comu-content">
		    		<div class="f-d-1-img profile-img">
	   					<div>
		    				<img id="imgSrc"/>
	   					</div>
	   				</div>
	   				<div class="f-d-9 pd-i">
	   					<div style="width: 100%">
	   						<div class="f-d">
		    					<div class="pr-1"><span id="rNickName"></span></div>
		    					<div style="color: #aaa">@<span id="rMid"></span></div>
	   						</div>
	   						<div class="f-d pt-2 comu-content-inner">
	   							<div style="width: 100%">
	    							<span id="rContentM"></span>
	   							</div>
							</div>
						</div>
					</div>
				</div>
				<div class="pl-3 pt-3">답글 달기</div>
	    		<div class="f-d pd-1">
		      		<div class="f-d-1">
		      			<img src="${ctp}/data/member/${memVO.profile}" width="90px" height="90px" style="border-radius: 100%" >
		      		</div>
		      		<div class="f-d-9 f-a f-b-ddd">
		      			<div style="width: 100%">
		      				<div class="f-d">
			      				<textarea rows="5" style="width: 100%" name="rContent" required id="rContent" maxlength="140" placeholder="답글 게시하기"></textarea>
		      				</div>
		      			</div>
		      		</div>
		      	</div>
	      		<div class="f-d f-b-ddd pl-4">
			  		<div class="content-reply-cnt">(0/140)</div>
			  		<div class="content-upload-btn"><a href="javascript:replyUpload()" >게시하기</a></div>
		      	</div>
		      	<input type="hidden" id="rIdx" name="rIdx" />
	    	</div>
    	</div>
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

<!-- 헤더 변경 화면 -->
<div class="header-img-container-f">
	<form name="headerForm" method="post" enctype="multipart/form-data" >
		<div class="f-d">
			<div style="width: 100%">
				<div class="text-center"><h3>헤더 이미지 변경</h3></div>
				<div class="text-center">
					헤더 이미지는 900px x 250px 을 권장합니다.
				</div>
				<hr/>
				<div id="file-btns-div" style="margin-left: 20px;">
					<div class="file-btn-div">
						<label for="headerImgs">
							<b>사진 등록</b>
						</label>
						<input type="file" name="headerImgs" id="headerImgs" onchange="imgCheck(this)" />
					</div>
					<div class="file-btn-div">
						<a href="javascript:location.reload()">
							<b>삭제</b>
						</a>
					</div>
				</div>
				<div id="headerImg-demo" class="text-center">
					<img id="headerImges"  style="border: 1px solid;" height="250px" width="900px">
				</div>
				<hr/>
				<div class="f-d">
					<div class="c-h-div-btn">
						<a href="javascript:closeHeader()">창닫기</a>
						<a href="javascript:headerImgInput()">헤더 변경하기</a>
					</div>
				</div>
			</div>
		</div>
		<input type="hidden" id="proMid" name="proMid" value="${proVO.mid }" />
	</form>
</div>

<!-- 팔로우중 리스트 띄우기 -->
<div id="folloing-list-container">
	<div class="f-d">
		<div style="width: 100%">
			<div class="fing-text-list">팔로우 중인 리스트</div>
			<hr/>
			<div class="fowing-list-d">
				<c:forEach var="fingVO" items="${fingVOS}">
					<div class="f-d p-2 fowing-hover">
						<div class="f-1-d">
							<div><a href="${ctp}/community/communityProfile?mid=${fingVO.followingMid}"><img src="${ctp}/data/member/${fingVO.profile}" width="80px" height="80px" /></a></div>
						</div>
						<div class="f-9-d">
							<div class="f-d">
								<div style="width: 100%">
									<div>${fingVO.nickName}</div>
									<div style="color: #aaa"> @${fingVO.followingMid}</div>
									<div class="intro-div">
										<c:if test="${fn:length(fingVO.communityIntroduce) > 20 }">
											${fn:substring(fingVO.communityIntroduce,0,20)}...
										</c:if> 
										<c:if test="${fn:length(fingVO.communityIntroduce) <= 20 }">
											${fingVO.communityIntroduce}
										</c:if> 
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<hr/>
			<div class="f-d close-fing-btn">
				<a href="javascript:closeFing()">창닫기</a>
			</div>
		</div>
	</div>
</div>

<!-- 팔로워 리스트 띄우기 -->
<div id="follower-list-container">
	<div class="f-d">
		<div style="width: 100%">
			<div class="fing-text-list">팔로워 리스트</div>
			<hr/>
			<div class="fowing-list-d">
				<c:forEach var="ferVO" items="${ferVOS}">
					<div class="f-d p-2 fowing-hover">
						<div class="f-1-d">
							<div><a href="${ctp}/community/communityProfile?mid=${ferVO.followerMid}"><img src="${ctp}/data/member/${ferVO.profile}" width="80px" height="80px" /></a></div>
						</div>
						<div class="f-9-d">
							<div class="f-d">
								<div style="width: 100%">
									<div>${ferVO.nickName}</div>
									<div style="color: #aaa"> @${ferVO.followerMid}</div>
									<div class="intro-div">
										<c:if test="${fn:length(ferVO.communityIntroduce) > 20 }">
											${fn:substring(ferVO.communityIntroduce,0,20)}...
										</c:if> 
										<c:if test="${fn:length(ferVO.communityIntroduce) <= 20 }">
											${ferVO.communityIntroduce}
										</c:if> 
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<hr/>
			<div class="f-d close-fing-btn">
				<a href="javascript:closeFer()">창닫기</a>
			</div>
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