package com.spring.javaProjectS4.service;

import java.util.List;

import com.spring.javaProjectS4.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberMidCheck(String mid);

	public MemberVO getMemberNickNameCheck(String nickName);

	public List<MemberVO> getMemberEmailCheck(String email);

	public int setMemberJoin(MemberVO vo);

}
