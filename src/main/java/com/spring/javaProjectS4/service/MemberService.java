package com.spring.javaProjectS4.service;

import java.util.List;

import com.spring.javaProjectS4.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberMidCheck(String mid);

	public MemberVO getMemberNickNameCheck(String nickName);

	public List<MemberVO> getMemberEmailCheck(String email);

	public int setMemberJoin(MemberVO vo);

	public void setKakaoMemberInput1(String mid, String pwd, String nickName, String email);

	public MemberVO getMemberEmailTokenCheck(String email, String token);

	public int setKakaoFirstUpdatInfor(String mid, String address, String gender, String email, String adYN);

	public void setKakaoMemberInput2(String mid, String pwd, String name, String email, String newNickName);

	public MemberVO getMemberMidEmailCheck(String mid, String email);

	public void setMemberPwdUpdate(String mid, String pwd);

	public void setUpdateLastDate(String mid);

}
