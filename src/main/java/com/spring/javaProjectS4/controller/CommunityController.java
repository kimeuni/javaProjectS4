package com.spring.javaProjectS4.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaProjectS4.service.CommunityService;
import com.spring.javaProjectS4.vo.MemberVO;

@Controller
@RequestMapping("/community")
public class CommunityController {

	@Autowired
	CommunityService communityService;
	
	@RequestMapping(value = "/communityMain", method = RequestMethod.GET)
	public String communityMainGet(Model model,HttpSession session) {
		// 로그인한 사람의 아이디로 계정 정보 가져오기
		String sMid = session.getAttribute("sMid")== null ? "" : (String)session.getAttribute("sMid");
		
		MemberVO memVO = communityService.getMemberMid(sMid);
		
		
		model.addAttribute("memVO",memVO);
		return "community/communityMain";
	}
}
