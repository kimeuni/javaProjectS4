package com.spring.javaProjectS4.service;

import java.util.List;

import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.ReasonTitleVO;
import com.spring.javaProjectS4.vo.UserShowAdvertisementVO;
import com.spring.javaProjectS4.vo.AnswerVO;
import com.spring.javaProjectS4.vo.AskVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;

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

	public List<ReasonTitleVO> getTitleList();

	public void setUserDelUpdateY(String mid);

	public void setUserDelReason(String whyDel, String why);

	public int setUserDelUpdateN(String mid, String token);

	public int setInfoUpdate(String mid, String name, String nickName, String email, String address);

	public UserShowAdvertisementVO getUserShowAdMid(String mid);

	public int setLoginDateUpdatMid(String mid);

	public void setAlarmYUpdate(String mid);

	public MainAdvertisementVO getMainAdOpen();

	public void setMainAdInputMid(String mid);

	public List<AskVO> getMyAskList(int startIndexNo, int pageSize, String mid);

	public AskVO getAskIdx(int idx);

	public AnswerVO getAnswerAskIdx(int idx);

	public List<AskVO> getMyAskListSearch(int startIndexNo, int pageSize, String mid, String part);

	public int setAdYNUpdate(String adYN, String mid);

}
