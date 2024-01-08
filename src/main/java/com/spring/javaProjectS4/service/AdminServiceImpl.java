package com.spring.javaProjectS4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS4.dao.AdminDAO;
import com.spring.javaProjectS4.vo.MemberVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO adminDAO;

	@Override
	public List<MemberVO> getMemberList(int startIndexNo, int pageSize) {
		return adminDAO.getMemberList(startIndexNo, pageSize);
	}

	@Override
	public List<MemberVO> getMemberSearchList(String part, String searchString, int startIndexNo, int pageSize) {
		return adminDAO.getMemberSearchList( part, searchString, startIndexNo, pageSize);
	}

	@Override
	public List<MemberVO> getUserDelList(int startIndexNo, int pageSize) {
		return adminDAO.getUserDelList( startIndexNo, pageSize);
	}

}
