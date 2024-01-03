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

	@Override
	public void setKakaoMemberInput1(String mid, String pwd, String nickName, String email) {
		memberDAO.setKakaoMemberInput1( mid,  pwd,  nickName,  email);
	}

	@Override
	public MemberVO getMemberEmailTokenCheck(String email, String token) {
		return memberDAO.getMemberEmailTokenCheck(email, token);
	}

	@Override
	public int setKakaoFirstUpdatInfor(String mid, String address, String gender, String email, String adYN) {
		return memberDAO.setKakaoFirstUpdatInfor( mid, address, gender, email, adYN);
	}

	@Override
	public void setKakaoMemberInput2(String mid, String pwd, String name, String email, String newNickName) {
		memberDAO.setKakaoMemberInput2(mid, pwd, name, email, newNickName);
	}

	@Override
	public MemberVO getMemberMidEmailCheck(String mid, String email) {
		return memberDAO.getMemberMidEmailCheck(mid,email);
	}

	@Override
	public void setMemberPwdUpdate(String mid, String pwd) {
		memberDAO.setMemberPwdUpdate(mid,pwd);
	}

	
}
