package com.spring.javaProjectS4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS4.dao.BoardDAO;
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

}
