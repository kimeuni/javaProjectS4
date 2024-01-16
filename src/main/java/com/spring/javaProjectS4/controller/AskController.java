package com.spring.javaProjectS4.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.service.AskService;
import com.spring.javaProjectS4.vo.MemberVO;

@Controller
@RequestMapping("/ask")
public class AskController {
	
	@Autowired
	AskService askService;
	
	// 1:1 문의 화면 이동
	@RequestMapping(value = "/askInput", method = RequestMethod.GET)
	public String askInputGet(Model model, HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		MemberVO vo = askService.getMemberMid(mid);
		
		model.addAttribute("mVO", vo);
		return "ask/askInput";
	}
	
	// 1:1 문의 질문 등록
	@RequestMapping(value = "/askInput", method = RequestMethod.POST)
	public String askInputPost(MultipartHttpServletRequest imgs,
			HttpServletRequest request,
			@RequestParam(name = "mid",defaultValue = "", required = false) String mid,
			@RequestParam(name = "title",defaultValue = "", required = false) String title,
			@RequestParam(name = "content",defaultValue = "", required = false) String content,
			@RequestParam(name = "category",defaultValue = "", required = false) String category,
			@RequestParam(name = "reportShop",defaultValue = "", required = false) String reportShop,
			@RequestParam(name = "imgStr",defaultValue = "", required = false) String imgStr
			) {
		
		// 태그 변환
		content = content.replace("<", "&lt;");
		content = content.replace(">", "&gt;");
		content = content.replace("\n", "<br/>");
		
		int res = askService.setAskInput(mid,title,content,imgs,category,reportShop,imgStr);
		if(res != 0 ) return "redirect:/message/askInputOk";
		else return "redirect:/message/askInputNo";
	}
	
}
