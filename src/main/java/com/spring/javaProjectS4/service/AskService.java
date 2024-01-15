package com.spring.javaProjectS4.service;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.vo.MemberVO;

public interface AskService {

	public MemberVO getMemberMid(String mid);

	public int setAskInput(String mid, String title, String content, MultipartHttpServletRequest imgs, String category,
			String reportShop, String imgStr);


}
