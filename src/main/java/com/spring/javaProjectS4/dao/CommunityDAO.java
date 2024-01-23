package com.spring.javaProjectS4.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.MemberVO;

public interface CommunityDAO {

	public MemberVO getMemberMid(@Param("mid") String mid);

}
