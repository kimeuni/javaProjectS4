package com.spring.javaProjectS4.service;

import java.util.List;

import com.spring.javaProjectS4.vo.FAQVO;
import com.spring.javaProjectS4.vo.NoticeVO;

public interface BoardService {

	public List<NoticeVO> getNoticeList(int startIndexNo, int pageSize);

	public NoticeVO getNoticeIdx(int idx);

	public NoticeVO getPreNNextSearch(int idx, String str);

	public void setReadNumUpdate(int idx);

	public List<FAQVO> getFAQList(int startIndexNo, int pageSize);

	public List<FAQVO> getFAQCategoryList(int startIndexNo, int pageSize, String searchString);

	public List<FAQVO> getFAQStringSearchList(int startIndexNo, int pageSize, String searchString);

	public List<NoticeVO> getNoticeSearchList(int startIndexNo, int pageSize, String part, String searchString);

}
