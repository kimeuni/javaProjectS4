<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>커뮤니티</title>
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
		}
		.reply-input button{
			background-color: rgba(0,0,0,0);
			border: 0px;
		}
    </style>
    <script>
    	'use strict'
    	
    	
    	$(function(){
    		$(".reply-close").hide();
    		$(".reply-content-div").hide();
    	});
    	
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
    			
    			communityForm.submit();
    		}
    	}
    	
    	// 댓글 입력창 보이기
    	function replyInputBtn(){
    		$(".reply-close").show();
    		$(".reply-input").hide();
    		
    		$(".reply-content-div").slideDown();
    		
    	}
    	
    	function replyCloseBtn(){
    		$(".reply-close").hide();
    		$(".reply-input").show();
    		
    		$(".reply-content-div").slideUp();
    	}
    	// 신고 및 삭제 보이기
    	function menuC(){
    	}
    	
    	function modalView(nickName, mid,idx){
    		$("#rMid").html(mid);
    		$("#rNickName").html(nickName);
    		$("#rIdx").val(idx);
    	}
    	
    	function replyUpload(){
    		let content = $("#rContent").val();
    		let idx = $("#rIdx").val();
    		let mid = "${sMid}";
    		
    		alert(content);
    		alert(idx);
    		alert(mid);
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<div id="community-main-container">
    <div id="community-main-img-container">
    	<div id="community-main-img-text-div">
    		<div id="community-text-left">
    			<div id="community-text-div">
	    			당신의 즐거운<br/> 일상을 공유
    			</div>
    			<div id="community-usedinput-btn">
    				<c:if test="${sMid != null }">
	    				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">글 올리기</button>
	    			</c:if>
   				</div>
    		</div>
    		<div id="community-img-right">
    			<img src="${ctp}/data/images/다모아_커뮤니티.png" width="100%" height="315px" />
    		</div>
    	</div>
    </div>
    <!-- 커뉴니티 글 보이기 -->
    <div id="community-list-container">
    	<div class="f-d">
	    	<div class="f-d-2">
	    		<div style="width: 100%">
		    		<div class="main-home-btn"><a href="${ctp}/community/communityMain"><i class="fa-solid fa-house"></i>&nbsp;&nbsp; 홈으로</a></div>
		    		<hr/>
		    		<div class="profile-go-btn"><a href=""><i class="fa-solid fa-user"></i>&nbsp;&nbsp; 프로필</a></div>
		    		<hr/>
		    		<div class="bookmark-go-btn"><a href=""><i class="fa-solid fa-bookmark"></i>&nbsp;&nbsp; 북마크</a></div>
		    		<hr/>
		    		<c:if test="${sMid != null }">
			    		<div class="comu-up-btn"><button type="button" data-toggle="modal" data-target="#myModal"> 글 올리기</button></div>
		    		</c:if>
	    		</div>
	    	</div>
	    	<div class="f-d-8" >
	    		<div style="width: 100%">
    				<div class="f-d f-sc">
    					<div class="f-d-3-menu checked-yes">전체</div>
    					<div class="f-d-3-menu checked-no">지역</div>
    					<div class="f-d-3-menu checked-no">팔로우</div>
    				</div>
		    		<c:forEach var="comVO" items="${comVOS }">
		    			<c:set var="img" value="${comVO.imgs.split('/')}" />
		    			<div class="f-d">
		    				<div style="margin-left: auto; padding-right: 20px;padding-top: 10px">
			    				<a href="javascript:menuC()" class="menu-c"><i class="fa-solid fa-bars"></i></a>
		    				</div>
	    				</div>
		    			<div class="f-d btb pd">
		    				<div class="f-d-1-img profile-img">
			    				<a href=""><img src="${ctp}/data/member/${comVO.profile}" ></a>
		    				</div>
		    				<div class="f-d-9 pd-i">
		    					<div style="width: 100%">
		    						<div class="f-d">
				    					<div class="pr-1">${comVO.nickName }</div>
				    					<div style="color: #aaa">@${comVO.mid}</div>
		    						</div>
		    						<div class="f-d pt-2">${comVO.content }</div>
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
		    						<div class="f-d mt-2">
		    							<c:if test="${sMid == null }">
			    							<div class="f-d-3" style="color: #aaa"><a><i class="fa-regular fa-comment"></i></a></div>
		    							</c:if>
		    							<c:if test="${sMid != null }">
			    							<div class="f-d-3 reply-input"><button type="button" data-toggle="modal" data-target="#replyModal" onclick="modalView('${comVO.nickName}','${comVO.mid }','${comVO.idx }')"><i class="fa-regular fa-comment"></i></button></div>
		    							</c:if>
		    							<div class="f-d-3"><a href=""><i class="fa-regular fa-heart"></i></a></div>
		    							<div class="f-d-3"><a href=""><i class="fa-regular fa-bookmark"></i></a></div>
		    						</div>
		    					</div>
		    				</div>
		    			</div>
		    		</c:forEach>
			    <br/>
				<div class="text-center">
					<ul class="pagination justify-content-center">
					    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="communityMain?pag=1&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
					  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="communityMain?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
					  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
						    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="communityMain?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
						    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="communityMain?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
					  	</c:forEach>
					  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="communityMain?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
					  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="communityMain?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
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

<!-- 댓글 -->
<div class="modal fade" id="replyModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
    	<div class="f-d ">
	    	<div style="width: 100%;">
	    		<div class="p-3" style="color: #aaa"><span id="rNickName"></span>(@<span id="rMid"></span><span>)님께 답변</span></div>
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