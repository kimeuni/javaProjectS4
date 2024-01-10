package com.spring.javaProjectS4.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.FAQVO;
import com.spring.javaProjectS4.vo.NoticeVO;

public interface BoardDAO {

	public List<NoticeVO> getNoticeList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int getNoticeAllTotRecCnt();

	public int getNoticeSearchTotRecCnt(@Param("part") String part,@Param("searchString") String searchString);

	public NoticeVO getNoticeIdx(@Param("idx") int idx);

	public int getNoticeOpenSwYTotRecCnt();

	public NoticeVO getPreNNextSearch(@Param("idx") int idx,@Param("str") String str);

	public void setReadNumUpdate(@Param("idx") int idx);

	public int getFAQAllTotRecCnt();

	public List<FAQVO> getFAQList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int getFAQCategoryTotRecCnt(@Param("searchString") String searchString);

	public List<FAQVO> getFAQCategoryList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("searchString") String searchString);

	public int getFAQStringTotRecCnt(@Param("searchString") String searchString);

	public List<FAQVO> getFAQStringSearchList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("searchString") String searchString);

	public List<NoticeVO> getNoticeSearchList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("part") String part,@Param("searchString") String searchString);
	
}
