package com.spring.javaProjectS4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/member")
public class memberController {

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginGet() {
		return "member/login";
	}
}
