package com.spring.javaProjectS4.service;

import com.spring.javaProjectS4.vo.UserShowAdvertisementVO;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.vo.MainAdvertisementVO;
import com.spring.javaProjectS4.vo.MapVO;
import com.spring.javaProjectS4.vo.MemberVO;

public interface HomeService {

	public MainAdvertisementVO getMainAdOpen();

	public UserShowAdvertisementVO getUserShowAd(String mid);

	public void setAlarmUpdateN(String mid);

	public MemberVO getMemberMid(String mid);

	public int setAskInput(String mid, String title, String content, MultipartHttpServletRequest imgs, String category,
			String reportShop, String imgStr);

	public MapVO getMapOne();
}
