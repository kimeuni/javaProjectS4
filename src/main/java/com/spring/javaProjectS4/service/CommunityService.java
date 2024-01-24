package com.spring.javaProjectS4.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.vo.CommunityVO;
import com.spring.javaProjectS4.vo.MemberVO;

public interface CommunityService {

	public MemberVO getMemberMid(String Mid);

	public int setCommunityInput(MultipartHttpServletRequest imgs, String mid, String content, String region,
			String imgsStr);

	public List<CommunityVO> getCommunityList(int startIndexNo, int pageSize, String sMid);


}
