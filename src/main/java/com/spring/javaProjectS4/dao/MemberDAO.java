package com.spring.javaProjectS4.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.ReasonTitleVO;
import com.spring.javaProjectS4.vo.UserShowAdvertisementVO;
import com.spring.javaProjectS4.vo.AnswerVO;
import com.spring.javaProjectS4.vo.AskVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;

public interface MemberDAO {

	public MemberVO getMemberMidCheck(@Param("mid") String mid);

	public MemberVO getMemberNickNameCheck(@Param("nickName") String nickName);

	public List<MemberVO> getMemberEmailCheck(@Param("email") String email);

	public int setMemberJoin(@Param("vo") MemberVO vo);

	public void setKakaoMemberInput1(@Param("mid") String mid,@Param("pwd") String pwd,@Param("nickName") String nickName,@Param("email") String email);

	public MemberVO getMemberEmailTokenCheck(@Param("email") String email,@Param("token") String token);

	public int setKakaoFirstUpdatInfor(@Param("mid") String mid,@Param("address") String address,@Param("gender") String gender,@Param("email") String email,@Param("adYN") String adYN);

	public void setKakaoMemberInput2(@Param("mid") String mid,@Param("pwd") String pwd,@Param("name") String name,@Param("email") String email,@Param("nickName") String newNickName);

	public MemberVO getMemberMidEmailCheck(@Param("mid") String mid,@Param("email") String email);

	public void setMemberPwdUpdate(@Param("mid") String mid,@Param("pwd") String pwd);

	public void setUpdateLastDate(@Param("mid") String mid);

	public List<ReasonTitleVO> getTitleList();

	public void setUserDelUpdateY(@Param("mid") String mid);

	public void setUserDelReason(@Param("whyDel") String whyDel,@Param("why") String why);

	public int setUserDelUpdateN(@Param("mid") String mid,@Param("token") String token);

	public int setInfoUpdate(@Param("mid") String mid,@Param("name") String name,@Param("nickName") String nickName,@Param("email") String email,@Param("address") String address);

	public UserShowAdvertisementVO getUserShowAdMid(@Param("mid") String mid);

	public int setLoginDateUpdatMid(@Param("mid") String mid);

	public void setAlarmYUpdate(@Param("mid") String mid);

	public MainAdvertisementVO getMainAdOpen();

	public void setMainAdInputMid(@Param("mid") String mid);

	public List<AskVO> getMyAskList(@Param("startIndexNo")int startIndexNo,@Param("pageSize") int pageSize,@Param("mid") String mid);

	public int getMyAskListTotRecCnt(@Param("searchString") String searchString);

	public AskVO getAskIdx(@Param("idx") int idx);

	public AnswerVO getAnswerAskIdx(@Param("idx") int idx);

	public List<AskVO> getMyAskListSearch(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("mid") String mid,@Param("part") String part);

	public int getMyAskListSearchTotRecCnt(@Param("part") String part,@Param("searchString") String searchString);

	public int setAdYNUpdate(@Param("adYN") String adYN,@Param("mid") String mid);

}
