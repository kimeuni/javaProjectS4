package com.spring.javaProjectS4.controller;

import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS4.service.MemberService;
import com.spring.javaProjectS4.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class memberController {

	@Autowired
	MemberService memberService;
	
	// 로그인 화면 이동
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginGet() {
		return "member/login";
	}
	
	// 회원가입 화면 이동
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinGet() {
		return "member/join";
	}
	
	// 아이디 유효성 검사
	@ResponseBody
	@RequestMapping(value = "/joinMidCheck", method = RequestMethod.POST)
	public String joinMidCheckPost(String mid) {
		
		MemberVO vo = memberService.getMemberMidCheck(mid);
		// 공백
		if(mid.trim() == "") {
			return "0";
		}
		// 유효성
		else if(!Pattern.matches("^[\\w]{5,16}$", mid)) {
			return "1";
		}
		// 중복
		else if(vo != null){
			return "2";
		}
		else {
			return "3";
		}
	}
}
