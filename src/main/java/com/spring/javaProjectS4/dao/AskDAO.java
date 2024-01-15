package com.spring.javaProjectS4.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.MemberVO;

public interface AskDAO {

	public MemberVO getMemberMid(@Param("mid") String mid);

	public int setAskInput(@Param("mid") String mid,@Param("title") String title,@Param("content") String content,
			@Param("category") String category, @Param("reportShop") String reportShop, @Param("imgStr") String imgStr);

}
