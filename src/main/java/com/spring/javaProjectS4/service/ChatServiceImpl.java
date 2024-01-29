package com.spring.javaProjectS4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS4.dao.ChatDAO;
import com.spring.javaProjectS4.vo.ChatGroupVO;
import com.spring.javaProjectS4.vo.EmoticonVO;

@Service
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	ChatDAO chatDAO;

	@Override
	public List<EmoticonVO> getEmoticonList() {
		return chatDAO.getEmoticonList();
	}

	@Override
	public ChatGroupVO getChatGroupCheck(int usedIdx, String mid, String sMid) {
		return chatDAO.getChatGroupCheck( usedIdx, mid, sMid);
	}
}
