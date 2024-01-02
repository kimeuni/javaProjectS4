package com.spring.javaProjectS4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value = "/message/{msgFalg}", method = RequestMethod.GET )
	public String msgGet(@PathVariable String msgFalg, String mid, Model model,
			@RequestParam(name="temp", defaultValue = "", required = false) String temp
			) {
		if(msgFalg.equals("joinOk")) {
			model.addAttribute("msg", "회원가입 되셨습니다.");
			model.addAttribute("url","damoa");
		}
		else if(msgFalg.equals("joinNo")) {
			model.addAttribute("msg", "회원가입에 실패하였습니다.");
			model.addAttribute("url","member/join");
		}
		else if(msgFalg.equals("validatorError")) {
			model.addAttribute("msg", "회원가입에 실패하였습니다. " + temp + "를 확인하세요.");
			model.addAttribute("url","member/join");
		}
			
		return "include/message";
	}
}