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
</style>
<div id="select-chat">전체대화</div>
<div id="chat-list-div">
	
</div>