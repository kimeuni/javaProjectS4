package com.spring.javaProjectS4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/chat")
public class ChatController {
	
	@RequestMapping(value = "/chatContent", method = RequestMethod.GET)
	public String chatContentGet() {
		return "chat/chatContent";
	}
}
