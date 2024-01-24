<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>중고거래 상품 등록</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	#usedInput-container{
    		z-index: 1;
    		min-width: 100vw;
    	}
    	#used-input-div{
    		width: 900px;
    		margin: 0 auto;
    	}
    	.u-f-d{
    		display: flex;
    	}
    	.top-text{
    		display: flex;
    		font-size: 2em;
    		margin-top: 20px;
    	}
    	.pil-text{
    		margin-top: 25px;
    		margin-left : 30px;
    		color: red;
    		font-size: 1.2em;
    	}
    	#used-input-div .top-hr{
    		margin: 10px 0px;
    		border: 1px solid;
    	}
    	.f-r-str{
    		display: flex;
    		width: 18%;
    		font-size: 1.15em;
    		padding-left: 10px;
    	}
    	.f-l-input{
    		display: flex;
    		width: 82%;
    	}
    	.pil{
    		color: red;
    	}
    	.f-l-input-t{
    		display: flex;
    		width: 72%;
    	}
    	.f-l-input-t input[type="text"]{
    		width: 100%;
    		height: 40px;
    		border: 1px solid #ddd;
    		padding-left: 10px;
    	}
    	.f-l-input-t-c{
    		display: flex;
    		width: 10%;
    		line-height: 40px;
    		padding-left: 10px;
    	}
    	.c-f-l-3{
    		display : flex;
    		width: 33%;
    		height: 150px;
    		overflow: auto;
    		border: 1px solid #eee;
    	}
    	.f-s-b{
    		width: 83%;
    		font-size: 1.2em;
    	}
    	.g-f-sm{
    		color: #ccc;
    		font-size: 0.8em;
    	}
    	.m-d input[type="text"]{
    		border: 1px solid #ddd;
    		width: 250px;
    		height: 40px;
    		padding-left: 10px;
    	}
    	.mr-a{
    		margin-right: auto;
    	}
    	.ml-a{
    		justify-content: flex-end;
    		padding-right: 20px;
    		margin-bottom: 20px;
    		text-align: center;
    	}
    	.radi li{
    		list-style: none;
    	}
    	input[class*="midR"] + label{
    		display: none;
    	}
    	input[class*="btmR"] + label{
    		display: none;
    	}
    	.show-div{
    		display: block !important;
    	}
    	.radi input[type="radio"]{
    		display: none;
    	}
    	.f-c-r{
    		color: red;
    	}
    	.f-l-input ul{
    		margin: 0px;
    		padding: 0px;
    		padding-left: 10px;
    	}
    	.f-l-input li:hover{
    		background-color: #eee;
    	}
    	.ctg-str-div{
    		margin-left: 16%;
    		color: red;
    		margin-top: 10px;
    		font-size: 1.1em;
    	}
    	.ctg-str-pil-div{
    		margin-left: 16%;
    		color: #bbb;
    		font-size: 0.8em;
    	}
    	.used-input-btn{
    		border: 1px solid;
    		background-color: #252525;
    		color: #fff;
    		width: 120px;
    		height: 45px;
    		line-height : 45px;
    		font-size: 1.2em;
    		font-weight : bold;
    		text-decoration: none;
    	}
    	.ml-a a{
    		color: #fff;
    		text-decoration: none;
    	}
    	
    	#att_zone {
		  width: 100%;
		  min-height: 150px;
		  padding: 10px;
		  border: 1px solid #ddd;
		}
    </style>
    <script>
    	'use strict'
    	
    	// 제목 글자수 cnt
    	$(function() {
    		$("#title").on("keyup", function(){
    			let title = $("#title").val();
    			
    			$(".f-l-input-t-c").html("("+title.length+"/40)");
    			if(title.length > 40){
    				alert("상품명은 40글자까지 가능합니다.");
    				$("#title").val(title.substring(0,40));
	    			$(".f-l-input-t-c").html("(40/40)");
    			}
    		});
    	});
    	
    	
    	// 배송비 별도시 금액 작성폼 보이기
    	function deliveryInputOpen(strs){
			let str = '';
			if(strs == "별도"){
				str += '<div style="margin-top:10px" ><input type="text" name="deliveryInput" id="deliveryInput" required placeholder="배송비를 입력하세요." maxlength="6" style="width:250px; height:40px;padding-left:10px;border: 1px solid #ddd;" /></div>';
				str += '<div style="color:#ccc; font-size:0.8em;">-별도로 받을 배송비를 입력하실 수 있습니다.</div>';
				
				$("#delivery-input").html(str);
			}
			else $("#delivery-input").html(str);
    	}
    	
    	// 대분류 선택
    	function midCOpen(idx,name){
    		$("input:radio[name='midCategoryIdx']").prop('checked',false);
    		$("input:radio[name='btmCategoryIdx']").prop('checked',false);
    		$(".topR").removeClass("f-c-r");
    		$(".midR").removeClass("f-c-r");
    		$(".midR").removeClass("show-div");
    		$(".btmR").removeClass("show-div");
    		$(".mid"+idx).addClass("show-div");
    		$(".top"+idx).addClass("f-c-r");
    		
    		$("#top-category-str").html(name);
    		$("#mid-category-str").html('');
    		$("#btm-category-str").html('');
    	}
    	
    	// 중분류 선택
    	function btmCOpen(idx,name){
    		$("input:radio[name='btmCategoryIdx']").prop('checked',false);
    		$(".midR").removeClass("f-c-r");
    		$(".btmR").removeClass("f-c-r");
    		$(".btmR").removeClass("show-div");
    		$(".btm"+idx).addClass("show-div");
    		$(".mids"+idx).addClass("f-c-r");
    		
    		$("#mid-category-str").html( "> " + name);
    		$("#btm-category-str").html('');
    	}
    	
    	// 소분류 선택
    	function btnSelect(idx,name){
    		$(".btmR").removeClass("f-c-r");
    		$(".btms"+idx).addClass("f-c-r");
    		
    		$("#btm-category-str").html("> " + name);
    	}
    	
    	
    	// 중고거래 등록
    	function usedInput(){
    		let imgs = $("#imgs").val();
    		let title = $("#title").val();
    		let top = $('input[name="topCategoryIdx"]:checked').val();
    		let mid = $('input[name="midCategoryIdx"]:checked').val();
    		let btm = $('input[name="btmCategoryIdx"]:checked').val();
    		let usedState = $('input[name="usedState"]:checked').val();
    		let exchange = $('input[name="exchange"]:checked').val();
    		let money = $("#money").val();
    		let delivery = $('input[name="delivery"]:checked').val();
    		let deliveryInput = $("#deliveryInput").val();
    		let content = $("#content").val();
    		let ragMoney = /^[0-9]{2,9}$/;
    		let ragDelivery = /^[0-9]{3,6}$/;
    		
    		if(imgs == ""){
    			alert("상품 이미지를 선택해주세요.");
    			$("#imgs").focus();
    			return false;
    		}
    		else if(title.trim() == ""){
    			alert("상품명을 입력해주세요.");
    			$("#title").focus();
    			return false;
    		}
    		else if(!top){
    			alert("대분류 카테고리를 선택해주세요.");
    			return false;
    		}
    		else if(!usedState){
    			alert("상품 상태를 선택해주세요.");
    			return false;
    		}
    		else if(!exchange){
    			alert("교환 가능여부를 선택해주세요.");
    			return false;
    		}
    		else if(money.trim() == ""){
    			alert("상품의 가격을 입력해주세요.");
    			return false;
    		}
    		else if(!ragMoney.test(money)){
    			alert("상품의 가격은 10원 이상 999,999,999원 이하의 숫자만 가능합니다.");
    			return false;
    		}
    		else if(!delivery){
    			alert("배송비를 선택해주세요.");
    			return false;
    		}
    		else if(content.trim() == ""){
    			alert("상품의 내용을 입력해주세요.");
    			return false;
    		}
    		else if(delivery == "별도"){
    			if(deliveryInput.trim() == ""){
    				alert("배송비 가격을 입력하세요.");
    				return false;
    			}
    			else if(!ragDelivery.test(deliveryInput)){
    				alert("배송비의 가격은 100원 이상 100,000원 이하의 숫자만 가능합니다.");
    				return false;
    			}
    			else {
    				document.getElementById("imgs").removeAttribute("disabled");
	    			usedForm.submit();
    			}
    		}
    		else {
    			document.getElementById("imgs").removeAttribute("disabled");
    			
    			usedForm.submit();
    		}
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<div id="usedInput-container">
	<form name="usedForm" method="post" enctype="multipart/form-data">
		<div id="used-input-div">
			<div class="u-f-d">
				<div class="top-text">기본정보</div>
				<div class="pil-text">*필수항목</div>
			</div>
			<hr class="top-hr"/>
			<div class="u-f-d">
				<div class="f-r-str">
					<div style="width: 100%">
						상품이미지<span class="pil">*</span>
						<div class="u-f-d">
							<div style="color: #ccc; margin-top: 10px; font-size: 0.7em;">
								- 제일 먼저 등록한 그림이 메인 그림으로 설정됩니다.<br/><br/>
								- 이미지는 최대 <br/><span class="pil">8개까지 가능</span>합니다.
							</div>
						</div>
					</div>
				</div>
				<div class="f-l-input">
					<div id='image_preview'>
					    <input type='file' id='imgs' name='imgs' accept=".jpg , .png , .jpeg"  multiple='multiple' />
					    <div id='att_zone'></div>
					</div>
				</div>
			</div>
			 <ul class="lst_thumb">

   			</ul>
			<hr/>
			<div class="u-f-d">
				<div class="f-r-str">상품명<span class="pil">*</div>
				<div class="f-l-input-t"><input type="text" id="title" name="title" placeholder="상품명을 입력하세요. 최대 40글자" maxlength="40" required /></div>
				<div class="f-l-input-t-c">(0/40)</div>
			</div>
			<hr/>
			<div class="u-f-d radi">
				<div class="f-r-str">카테고리<span class="pil">*</div>
				<div class="f-l-input">
					<div class="c-f-l-3">
						<ul>
							<c:forEach var="tVO" items="${tVOS}">
								<li><input type="radio" value="${tVO.idx}" onclick="midCOpen('${tVO.idx}','${tVO.topCategoryName }')" id="top${tVO.idx}" name="topCategoryIdx" /><label for="top${tVO.idx}" class="top${tVO.idx} topR" > ${tVO.topCategoryName}</label></li>
							</c:forEach>
						</ul>
					</div>
					<div class="c-f-l-3">
						<ul>
							<c:forEach var="tVO" items="${tVOS}">
								<c:forEach var="mVO" items="${mVOS }">
									<c:if test="${tVO.idx == mVO.topCategoryIdx}">
										<li><input type="radio" value="${mVO.idx}"  onclick="btmCOpen('${mVO.idx}','${mVO.midCategoryName}')" name="midCategoryIdx" class=" midR" id="mid${mVO.idx}" /><label for="mid${mVO.idx}" class="mid${mVO.topCategoryIdx} mids${mVO.idx} midR"> ${mVO.midCategoryName}</label></li>
									</c:if>
								</c:forEach>
							</c:forEach>
						</ul>
					</div>
					<div class="c-f-l-3">
						<ul>
							<c:forEach var="mVO" items="${mVOS}">
								<c:forEach var="bVO" items="${bVOS }">
									<c:if test="${mVO.idx == bVO.midCategoryIdx}">
										<li><input type="radio" value="${bVO.idx}" name="btmCategoryIdx" onclick="btnSelect('${bVO.idx}','${bVO.btmCategoryName}')" class=" btmR" id="btm${bVO.idx}" /><label for="btm${bVO.idx}" class="btm${bVO.midCategoryIdx} btms${bVO.idx} btmR"> ${bVO.btmCategoryName}</label></li>
									</c:if>
								</c:forEach>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<div>
				<div class="ctg-str-div">선택 카테고리: 
					<span id="top-category-str"></span> 
					<span id="mid-category-str"></span> 
					<span id="btm-category-str"></span>
				</div>
				<div class="ctg-str-pil-div">
					- 대분류는 필수로 선택해야합니다.<br/>
					- 카테고리를 상세하게 설정하면 물건이 팔릴 확률이 올라갑니다.
				</div>
			</div>
			<hr/>
			<div class="u-f-d">
				<div class="f-r-str">상품상태<span class="pil">*</div>
				<div class=" f-s-b">
					<input type="radio" name="usedState" id="usedState1" value="새상품" /><label for="usedState1"> 새 상품(미사용) <span class="g-f-sm">사용하지 않은 새 상품</span></label><br/>
					<input type="radio" name="usedState" id="usedState2" value="사용감없음" /><label for="usedState2"> 사용감 없음 <span class="g-f-sm">사용은 했지만 눈에 띄는 흔적이나 얼룩이 없음</span></label><br/>
					<input type="radio" name="usedState" id="usedState3" value="사용감적음" /><label for="usedState3"> 사용감 적음 <span class="g-f-sm">눈에 띄는 흔적이나 얼룩이 약간 있음</span></label><br/>
					<input type="radio" name="usedState" id="usedState4" value="사용감많음" /><label for="usedState4"> 사용감 많음 <span class="g-f-sm">눈에 띄는 흔적이나 얼룩이 많이 있음</span></label><br/>
					<input type="radio" name="usedState" id="usedState5" value="고장/파손" /><label for="usedState5"> 고장/파손 상품 <span class="g-f-sm">기능 이상이나 외관 손상 등으로 수리/수선 필요</span></label>
				</div>
			</div>
			<hr/>
			<div class="u-f-d">
				<div class="f-r-str">교환<span class="pil">*</div>
				<div class="f-l-input f-s-b">
					<div><input type="radio" name="exchange" id="exchange1" value="불가" checked /><label for="exchange1">불가</label>&nbsp;&nbsp;&nbsp;&nbsp;</div>
					<div><input type="radio" name="exchange" id="exchange2" value="가능" /><label for="exchange2">가능</label></div>
				</div>
			</div>
			<hr/>
			<div class="u-f-d">
				<div class="f-r-str">가격<span class="pil">*</div>
				<div class="f-l-input f-s-b">
					<div class="m-d"><input type="text" name="money" id="money" required placeholder="가격을 입력하세요." maxlength="9" /></div>
				</div>
			</div>
			<hr/>
			<div class="u-f-d">
				<div class="f-r-str">배송비<span class="pil">*</div>
				<div class="f-l-input f-s-b mr-a">
					<div><input type="radio" name="delivery" id="delivery1" value="0" checked onclick="deliveryInputOpen()" /><label for="delivery1">배송비 포함</label>&nbsp;&nbsp;&nbsp;&nbsp;</div>
					<div><input type="radio" name="delivery" id="delivery2" value="별도" onclick="deliveryInputOpen('별도')" /><label for="delivery2">배송비 별도</label></div>
				</div>
			</div>
			<div style="margin-left: 18%;">
				<div id="delivery-input"></div>
			</div>
			<hr/>
			<div class="u-f-d">
				<div class="f-r-str">설명<span class="pil">*</div>
				<div class="f-l-input f-s-b">
					<div>
						<textarea rows="6" style="width: 739px;resize: none; padding: 10px;" required name="content" id="content"></textarea>
					</div>
				</div>
			</div>
			<hr/>
			<div class="u-f-d ml-a">
				<a href="javascript:usedInput()" class="used-input-btn">등록</a>
			</div>
		</div>
		<input type="hidden" name="mid" id="mid" value="${sMid}" />
	</form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
	
	( /* att_zone : 이미지들이 들어갈 위치 id, btn : file tag id */
    imageView = function imageView(att_zone, btn){

    var attZone = document.getElementById(att_zone);
    var imgs = document.getElementById(btn)
    var maxFileCnt = 8;
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
        
        // 재배치
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