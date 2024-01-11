package com.spring.javaProjectS4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS4.dao.BoardDAO;
import com.spring.javaProjectS4.vo.FAQVO;
import com.spring.javaProjectS4.vo.NoticeVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDAO;
	
	@Override
	public List<NoticeVO> getNoticeList(int startIndexNo, int pageSize) {
		return boardDAO.getNoticeList(startIndexNo, pageSize);
	}

	@Override
	public NoticeVO getNoticeIdx(int idx) {
		return boardDAO.getNoticeIdx( idx);
	}

	@Override
	public NoticeVO getPreNNextSearch(int idx, String str, String part, String searchString) {
		return boardDAO.getPreNNextSearch(idx, str, part, searchString);
	}

	@Override
	public void setReadNumUpdate(int idx) {
		boardDAO.setReadNumUpdate(idx);
	}

	@Override
	public List<FAQVO> getFAQList(int startIndexNo, int pageSize) {
		return boardDAO.getFAQList(startIndexNo, pageSize);
	}

	@Override
	public List<FAQVO> getFAQCategoryList(int startIndexNo, int pageSize, String searchString) {
		return boardDAO.getFAQCategoryList( startIndexNo, pageSize, searchString);
	}

	@Override
	public List<FAQVO> getFAQStringSearchList(int startIndexNo, int pageSize, String searchString) {
		return boardDAO.getFAQStringSearchList( startIndexNo, pageSize, searchString);
	}

	@Override
	public List<NoticeVO> getNoticeSearchList(int startIndexNo, int pageSize, String part, String searchString) {
		return boardDAO.getNoticeSearchList( startIndexNo, pageSize, part, searchString);
	}

}
