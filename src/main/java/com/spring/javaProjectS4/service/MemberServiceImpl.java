package com.spring.javaProjectS4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS4.dao.MemberDAO;
import com.spring.javaProjectS4.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getMemberMidCheck(String mid) {
		return memberDAO.getMemberMidCheck(mid);
	}

	@Override
	public MemberVO getMemberNickNameCheck(String nickName) {
		return memberDAO.getMemberNickNameCheck(nickName);
	}

	@Override
	public List<MemberVO> getMemberEmailCheck(String email) {
		return memberDAO.getMemberEmailCheck(email);
	}

	@Override
	public int setMemberJoin(MemberVO vo) {
		return memberDAO.setMemberJoin(vo);
	}

	
}
