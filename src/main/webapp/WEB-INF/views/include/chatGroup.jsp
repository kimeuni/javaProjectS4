<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
</style>
<div id="select-chat">전체대화</div>
<div id="chat-list-div">
	<div class="f-d chat-g-hover">
		<div class="f-d-2">
			<a href=""><div class="c-m-profile-img"><img src="${ctp}/data/images/다모아 캐릭터.png" ></div></a>
		</div>
		<div class="f-d-6">
			<div style="width: 100%">
				<div class="f-d p-2 chat-a-go">
					<div style="width: 100%">
						<a href="">
							<div class="c-g-nick-div-b">닉네임</div>
							<div class="f-d">
								<div class="f-6">
									<div>채팅 내용...</div>
								</div>
								<div class="f-4">
									<div class="f-d-r">2024-01-29</div>
								</div>
							</div>
						</a>
					</div>
				</div>
			</div>
		</div>
		<div class="f-d-2">
			<div class="c-used-img"><img src="${ctp}/data/images/다모아 캐릭터.png" ></div>
		</div>
	</div>
</div>