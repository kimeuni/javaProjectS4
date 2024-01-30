<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅창</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	#chat-content-container{
    		margin: 0 auto;
    		width: 1024px;
    		display: flex;
    		border-top: 1px solid #ddd;
    		border-bottom: 1px solid #ddd;
    	}
    	#chat-left-container{
    		width: 50%;
    		height: 700px;
    		border-right: 1px solid #ddd;
    	}
    	#chat-right-container{
    		width: 50%;
    		height: 700px;
    	}
    	.c-nick-div-b{
    		font-size: 1.2em;
   			font-weight: bold;
    	}
    	.f-d-1{
    		display: flex;
    		width: 10%;
    	}
    	.f-d-9{
    		display: flex;
    		width: 90%;
    	}
    	.f-w{
    		flex-wrap: wrap;
    	}
    	.f-2{
    		display: flex;
    		width: 20%;
    	}
    	.f-2 img{
    		width: 100%;
    		padding: 5px;
    	}
    	.emo-s{
    		height: 120px;
    		overflow: auto;
    	}
    	.emo-s input[type="radio"]{
    		display: none;
    	}
    	.chat-input-btn a{
    		display: flex;
    		width: 7%;
    		padding: 10px;
    		text-decoration: none;
    		color: #000;
    	}
    	.chat-input-btn{
    		position:relative;
    		border-bottom: 1px solid #ddd;
    		border-top: 1px solid #ddd;
    	}
    	.chat-input-btn input[type="text"]{
    		width: 93%;
    		padding-left: 10px;
    		border: 1px solid #ddd;
    		border-radius: 5px;
    		outline: none;
    	}
    	.chat-height{
    		display : flex;
    		height: 410px;
    		overflow: auto;
    		flex-wrap: wrap-reverse;
    	}
    	.f-d-7{
    		display: flex;
    		width: 70%;
    	}
    	.inner-r-chat{
    		border: 1px solid #ddd;
    		max-width: 100%;
    		padding: 7px;
    		border-radius: 10px;
    		background-color: #eee;
    	}
    	.f-end{
    		justify-content: flex-end;
    	}
    	.f-start{
    		justify-content: flex-start;
    	}
    	.inner-l-chat{
    		border: 1px solid #aaa;
    		max-width: 100%;
    		padding: 7px;
    		border-radius: 10px;
    	}
    	.f-d-l{
    		margin-right: auto;
    		margin-left: 3px;
    	}
    </style>
    <script>
    	'use strict'
    	
    	// 이모티콘 띄우기
    	function emoticonChan(idx,img){
    		let emoticon = $("#emoticon"+idx).val();
    		let str= '';
    		
    		str += '<div class="f-d" onclick="emoticonDelBtn()" style="position: absolute; bottom: 308px; width: 512px; display: table; background: rgba(0, 0, 0, 0.2); color: #fff;">';
    		str += '<div style="display: table-cell; vertical-align: middle; text-align: center; font-size: 1.2em; font-weight: bold;"><img src="${ctp}/data/emoticon/'+img+'" width="80px" height="80px"/></div>';
    		str += '</div>';
		
    		$("#emoticon-demo").html(str);
    	}
    	
    	// 이모티콘 지우기
    	function emoticonDelBtn(){
   			$("input:radio[name='emoti']").prop('checked',false);
   			
    		$("#emoticon-demo").html('');
    	}
    	
    	
    	let lastIdx = 0;
        
        $(document).ready(function() {
        	chatListFunction("thirty","${cgVO.mid1}","${cgVO.mid2}");
        	
        	getRepeatChat();
        });
        
        // 페이지를 주기적으로 다시 로딩시켜준다. (3초마다)
        function getRepeatChat() {
        	setInterval(function() {
        		chatListFunction(lastIdx);
        	}, 3000);
        }
        
        // 메세지 내용을 출력하기위한 함수
        function chatListFunction(listType,mid1,mid2) {
        	mid1 =  "${cgVO.mid1}";
        	mid2 =  "${cgVO.mid2}";
        	
        	$.ajax({
        		url  : "${ctp}/chat/chattingList",
        		type : "post",
        		data : {listType : listType,
        				mid1 : mid1,
        				mid2 : mid2
        				},
        		success:function(data) {
        			if(data == "") return;
        			let tempData = data.replace(/\r/gi, '\\r').replace(/\n/gi, '\\n').replace(/\f/gi, '\\f').replace(/\t/gi, '\\t')
        			let parsed = JSON.parse(tempData);
        			let res = parsed.res;
        			console.log(res);
        			for(let i=0; i<res.length; i++) {
        				addChar(res[i][4].value,res[i][5].value,res[i][6].value,res[i][7].value,res[i][8].value);
        			}
        			lastIdx = Number(parsed.last);
        		}
        	});
        }
        
        // 앞에서 가져온 내용을 출력시킬 준비처리..
        function addChar(emoticon, chat, alarm, chatDate,whoMid) {
        	console.log(chat);
        	if('${memVO.mid}' == '${sMid}'){
	        	$("#chatList").append(
	        		'<div class="f-d-7 f-d-r text-right mb-2">'+
						'<div style="width: 100%">' +
							'<div><span>'+alarm+'</span> <span>'+ chatDate +'</span></div>'+
							'<div class="f-d f-end">'+
								'<div class="inner-r-chat">'+
									'<div><img src="${ctp}/data/emoticon/'+ emoticon +'" width="50%" height="50%"></div>'+
									'<div>'+chat+'</div>'+
								'</div>'+
							'</div>'+
						'</div>'+
					'</div>'
	        	);
       		}
       		else{
				$("#chatList").append(
				'<div class="f-d-7 f-d-l mb-2">'+
					'<div style="width: 100%">'+
						'<div class="text-left"><span>'+ chatDate +'</span> <span>'+alarm+'</span></div>'+
						'<div class="f-d f-start">'+
							'<div class="inner-l-chat text-left">'+
								'<div><img src="${ctp}/data/emoticon/'+ emoticon +'" width="50%" height="50%"></div>'+
								'<div>'+chat+'</div>'+
							'</div>'+
						'</div>'+
					'</div>'+
				'</div>'	
	       		);
  			}
	       	$("#chatList").scrollTop($("#chatList").scrollHeight);
        }
        
        // 메세지 내용 입력하기
        function submitFunction() {
        	let chatIdx = '${cgVO.idx}';
        	let mid1 = '${cgVO.mid1}';
        	let mid2 = '${cgVO.mid2}';
        	let whoMid = '${sMid}';
        	let chat = $("#chatInputB").val();
        	let emoticon = '공백'; 
        	if($('input[name="emoti"]:checked')){
        		emoticon = $('input[name="emoti"]:checked').val();
        	}
        	
        	if(chat.trim() == ""){
        		if($('input[name=emoti]').is(":checked")){
					let query = {
						chatIdx : chatIdx,
		        		mid1 : mid1,
		        		mid2 : mid2,
		        		whoMid : whoMid,
		        		chat : chat,
		        		emoticon : emoticon
		        	}
		        	$.ajax({
		        		type  : "post",
		        		url   : "${ctp}/chat/chattingInput",
		        		data  : query,
		        	});
		        	$("#chatInputB").val("");
		        	$("#chatInputB").focus();
		        	$("input:radio[name='emoti']").prop('checked',false);
		    		$("#emoticon-demo").html('');
        		}
        		else {
        			alert("채팅을 입력해주세요.")
        			$("#chatInputB").focus();
        		}
        	}
        	else {
        		if(chat.legnth > 100){
        			alert("100자까지 입력 가능합니다.")
        			$("#chatInputB").focus();
        		}
        		else{
		        	let query = {
		        		chatIdx : chatIdx,
		        		mid1 : mid1,
		        		mid2 : mid2,
		        		whoMid : whoMid,
		        		chat : chat,
		        		emoticon : emoticon
		        	}
		        	$.ajax({
		        		type  : "post",
		        		url   : "${ctp}/chat/chattingInput",
		        		data  : query,
		        	});
		        	$("#chatInputB").val("");
		        	$("#chatInputB").focus();
		        	$("input:radio[name='emoti']").prop('checked',false);
		    		$("#emoticon-demo").html('');
        		}
        	}
        }
        
        // 엔터키를 누르면 바로 전송처리... Shift엔터키는 다음줄로 이동처리
        $(function() {
        	$("#chatInputB").on("keydown", function(e) {
        		if(e.keyCode == 13) {
        			if(!e.shiftKey) {
        				e.preventDefault();
        				submitFunction();
        			}
        		}
        	})
        });
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div id="chat-content-container">
		<div id="chat-left-container">
			<jsp:include page="/WEB-INF/views/include/chatGroup.jsp" />
		</div>
		<div id="chat-right-container">
			<c:if test="${!empty cVOS}">
				<div class="f-d pl-3 pr-3 pt-3">
					<div style="width: 100%; padding-bottom: 3px; border-bottom: 1px solid #ddd; ">
						<div class="c-nick-div-b">
							<c:if test="${memVO.nickName == cgVO.nickName1 }">
								${cgVO.nickName2 }
							</c:if>
							<c:if test="${memVO.nickName == cgVO.nickName2 }">
								${cgVO.nickName1 }
							</c:if>
						</div>
						<div>
							<c:if test="${memVO.lastDate == cgVO.lastDate1 }">
								마지막 접속일 : ${fn:substring(cgVO.lastDate2,0,16) }
							</c:if>
							<c:if test="${memVO.lastDate == cgVO.lastDate2 }">
								마지막 접속일 : ${fn:substring(cgVO.lastDate1,0,16) }
							</c:if>
						</div>
						<div class="f-d">
							<c:set var="img" value="${fn:split(cgVO.imgs,'/')}" />
							<div class="f-d-1"><a href="${ctp}/used/usedContent?idx=${cgVO.usedIdx}"><img src="${ctp}/data/used/${img[0]}" width="40px" height="40px"></a></div>
							<div class="f-d-9 pl-2">
								<div style="width: 100%">
									<div>${cgVO.title }</div>
									<div><fmt:formatNumber value="${cgVO.money }"/>원</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="p-2 chat-height">
						<c:forEach var="cVO" items="${cVOS}">
							<div class="f-d">
								<div style="width: 100%">
									<div id="chatList"></div>
								</div>
							</div>
						</c:forEach>
				</div>
				<div id="emoticon-demo"></div>
				<div class="f-d p-2 chat-input-btn">
					<input type="text" name="chatInputB" id="chatInputB" maxlength="100" placeholder="메세지를 입력하세요."/>
					<div><a href="javascript:submitFunction()"><i class="fa-solid fa-circle-up"></i></a></div>
				</div>
				<div class="f-d f-w emo-s">
					<c:forEach var="eVO" items="${eVOS}">
						<div class="f-2">
							<input type="radio" value="${eVO.img}" name="emoti" id="emoticon${eVO.idx}" onclick="emoticonChan('${eVO.idx}','${eVO.img}')"  /><label for="emoticon${eVO.idx}"><img src="${ctp}/data/emoticon/${eVO.img}" /></label>
						</div>
					</c:forEach>
				</div>
			</c:if>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>