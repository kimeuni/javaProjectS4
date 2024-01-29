package com.spring.javaProjectS4.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaProjectS4.service.ChatService;
import com.spring.javaProjectS4.vo.ChatGroupVO;
import com.spring.javaProjectS4.vo.EmoticonVO;

@Controller
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
	@RequestMapping(value = "/chatContent", method = RequestMethod.GET)
	public String chatContentGet(Model model,@RequestParam(name="usedIdx",defaultValue = "1",required = false)int usedIdx,
			String mid, String sMid
			) {
		
		// 만들어진 채팅 그룹이 있는 지 확인
		ChatGroupVO cgVO = chatService.getChatGroupCheck(usedIdx,mid,sMid);
		
		// 이모티콘
		List<EmoticonVO> eVOS = chatService.getEmoticonList();
		
		model.addAttribute("eVOS",eVOS);
		return "chat/chatContent";
	}
}
