package com.spring.javaProjectS4.service;

import java.util.List;

import com.spring.javaProjectS4.vo.NoticeVO;

public interface BoardService {

	public List<NoticeVO> getNoticeList(int startIndexNo, int pageSize);

}
