package com.spring.javaProjectS4.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS4.dao.CommunityDAO;
import com.spring.javaProjectS4.vo.MemberVO;

@Service
public class CommunityServiceImpl implements CommunityService {
	
	@Autowired
	CommunityDAO communityDAO;

	@Override
	public MemberVO getMemberMid(String Mid) {
		return communityDAO.getMemberMid( Mid);
	}
	
}
