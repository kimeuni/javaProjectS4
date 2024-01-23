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
    	#community-main-menu-container{
    		background-color: #F3CF98;
    		position: sticky;
  			top: 80px;
  			min-width: 100vw;
			z-index: 100;
    	}
    	#community-menu-flex{
    		display: flex;
    		width: 1200px;
    		height: 60px;
    		margin: 0 auto;
    		color: #553830;
    	}
    	#menu-div{
    		margin-left: 30px;
    	}
    	.inner-c{
    		padding-top: 3px;
    		padding-bottom: 3px;
    		padding-left: 10px;
    	}
    	.community-list-container{
    		display: flex;
    		min-height: 20px;
    		width: 1200px;
    		margin: 0 auto;
    		flex-wrap: wrap;
    	}
    	.community-list-content-div{
    		display: flex;
    		width: 240px;
    		padding: 10px;
    	}
    	.line-b{
    		border: 1px solid #ccc;
    	}
    	.mt-1{
    		margin: 7px;
    	}
    	.inner-flex-div{
    		display: flex;
    	}
    	.inner-flex-end{
    		margin-left: auto;
    	}
    	.w-2{
    		min-width: 50px;
    	}
    	.ml-a{
    		margin-left: auto;
    	}
    	.mt-5{
    		margin-top: 7px !important;
    	}
    	.mg-10{
    		margin-top : 15px;
    		margin-bottom : 15px;
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
    		border: 1px solid #ddd;
    	}
    </style>
    <script>
    	'use strict'
    	
    	$(function(){
    		$("#att_zone").hide();
    	});
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
    <div id="community-main-menu-container">
    	<div id="community-menu-flex">
    		<div>
    		
    		</div>
    	</div>
    </div>
    <!-- 커뉴니티 글 보이기 -->
    
    
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

<!-- The Modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
    	<div class="f-d mgp-top">
    		커뮤니티 작성하기
    	</div>
      	<div class="f-d pd-1">
      		<div class="f-d-1">
      			<img src="${ctp}/data/member/${memVO.profile}" width="90px" height="90px;">
      		</div>
      		<div class="f-d-9">
      			<textarea rows="4" style="width: 100%" name="content" id="content" placeholder="즐거운 일상을 공유해봐요"></textarea>
	      		<div class="f-d">
	      			<div id='att_zone'></div>
	      		</div>
      		</div>
      		<div><input type="file" name="imgs" id="imgs" multiple /></div>
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
/*     
 	// 새로운 파일이 추가될 때마다 imgs.files 업데이트
    updateImgFiles = function () {
    	 var dt = new DataTransfer();
    	  for (var f in sel_files) {
    	    var file = sel_files[f];
    	    dt.items.add(file);
    	  }
    	  imgs.files = dt.files;
    	  
    	  var inputElement = document.getElementById(btn);

          if (sel_files.length >= maxFileCnt) {
              inputElement.disabled = true;
          } else {
              inputElement.disabled = false;
          }
    	  
    };
     */
  }
)('att_zone', 'imgs')

</script>
</body>
</html>