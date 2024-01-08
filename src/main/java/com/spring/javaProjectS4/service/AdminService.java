package com.spring.javaProjectS4.service;

import java.util.List;

import com.spring.javaProjectS4.vo.MemberVO;

public interface AdminService {

	public List<MemberVO> getMemberList(int startIndexNo, int pageSize);

	public List<MemberVO> getMemberSearchList(String part, String searchString, int startIndexNo, int pageSize);

	public List<MemberVO> getUserDelList(int startIndexNo, int pageSize);


}
