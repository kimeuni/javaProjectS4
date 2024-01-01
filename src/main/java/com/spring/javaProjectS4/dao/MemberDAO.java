package com.spring.javaProjectS4.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberMidCheck(@Param("mid") String mid);

	public MemberVO getMemberNickNameCheck(@Param("nickName") String nickName);

	public List<MemberVO> getMemberEmailCheck(@Param("email") String email);

}
