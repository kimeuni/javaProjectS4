package com.spring.javaProjectS4.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.NoticeVO;

public interface BoardDAO {

	public List<NoticeVO> getNoticeList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int getNoticeAllTotRecCnt();

	public int getNoticeSearchTotRecCnt(@Param("part") String part,@Param("searchString") String searchString);
	
}
