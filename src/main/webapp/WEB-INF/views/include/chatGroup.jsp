<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	#select-chat{
   		height: 7%;
   		margin-left: auto;
   		font-size: 1.2em;
   		line-height: 49px; 
   		padding: 0px 10px;
   		border-bottom: 1px solid #ddd;
   	}
   	#chat-list-div{
   		height: 93%;
   		overflow: auto;
   	}
   	.f-d{
   		display: flex;
   	}
   	.f-d-6{
   		display: flex;
   		width: 70%;
   	}
   	.f-d-2{
   		display: flex;
   		width: 15%;
   	}
   	.c-used-img img{
   		width: 77px;
   		height: 77px;
   		padding: 5px;
   	}
   	.chat-g-hover:hover{
   		background-color: #ddd;
   	}
   	.c-m-profile-img img{
   		width: 67px;
   		height: 67px;
		border-radius: 100%;
		border: 1px solid #eee;
		margin-top: 5px;
   	}
   	.f-6{
   		display: flex;
   		width: 60%;
   	}
   	.f-4{
   		display: flex;
   		width: 40%;
   	}
   	.f-d-r{
   		margin-left: auto;
   		margin-right: 3px;
   	}
   	.c-g-nick-div-b{
   		font-size: 1.2em;
   		font-weight: bold;
   		margin-top: 6px;
   	}
   	.chat-a-go a{
   		text-decoration: none;
   		color: #000;
   	}
   	.c-alarm-cnt{
   		border-radius: 100%;
   		color: #fff;
   		padding : 0px 8px;
   		background-color: orange;
   		height: 25px;
   		line-height: 25px;
   		margin-left: 10px;
   		font-weight: bolder;
   		font-size: 0.8em;
   		vertical-align: middle;
   	}
</style>
<div id="select-chat">전체대화</div>
<div id="chat-list-div">
	<c:forEach var="cgVO" items="${cgVOS }">
		<c:set var="img" value="${fn:split(cgVO.imgs,'/') }" />
		<div class="f-d chat-g-hover">
			<div class="f-d-2">
				<div class="c-m-profile-img">
					<c:if test="${memVO.profile == cgVO.profile1 }">
						<img src="${ctp}/data/member/${cgVO.profile2}" >
					</c:if>
					<c:if test="${memVO.profile == cgVO.profile2 }">
						<img src="${ctp}/data/member/${cgVO.profile1}" >
					</c:if>
				</div>
			</div>
			<div class="f-d-6">
				<div style="width: 100%">
					<div class="f-d p-2 chat-a-go">
						<div style="width: 100%">
							<a href="${ctp}/chat/chatContent?usedIdx=${cgVO.usedIdx}&mid=${cgVO.mid1}&sMid=${cgVO.mid2}">
								<div class="c-g-nick-div-b">
									<c:if test="${memVO.nickName == cgVO.nickName1 }">
										<div class="f-d">
											<div>${cgVO.nickName2}</div>
											<c:if test="${cgVO.chatAlarmCnt >0 }">
											<div class="c-alarm-cnt">${cgVO.chatAlarmCnt }</div>
											</c:if>
										</div>
									</c:if>
									<c:if test="${memVO.nickName == cgVO.nickName2 }">
										<div class="f-d">
											<div>${cgVO.nickName1}</div>
											<c:if test="${cgVO.chatAlarmCnt >0 }">
												<div class="c-alarm-cnt">${cgVO.chatAlarmCnt }</div>
											</c:if>
										</div>
									</c:if>
								</div>
								<div class="f-d">
									<div class="f-6">
										<div>
											<c:if test="${fn:length(cgVO.chat) >12 }">
												${fn:substring(cgVO.chat,0,12)}...
											</c:if>
											<c:if test="${fn:length(cgVO.chat) <=12 }">
												${cgVO.chat }
											</c:if>
										</div>
									</div>
									<div class="f-4">
										<div class="f-d-r">${fn:substring(cgVO.CDate,0,10)}</div>
									</div>
								</div>
							</a>
						</div>
					</div>
				</div>
			</div>
			<div class="f-d-2">
				<div class="c-used-img"><img src="${ctp}/data/used/${img[0]}" ></div>
			</div>
		</div>
	</c:forEach>
</div>