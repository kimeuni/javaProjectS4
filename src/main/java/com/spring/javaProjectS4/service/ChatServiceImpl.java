package com.spring.javaProjectS4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS4.dao.ChatDAO;
import com.spring.javaProjectS4.vo.ChatGroupVO;
import com.spring.javaProjectS4.vo.EmoticonVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.UsedVO;

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

	@Override
	public void setChatGroupInput(int usedIdx, String mid, String sMid) {
		chatDAO.setChatGroupInput( usedIdx, mid, sMid);
	}

	@Override
	public UsedVO getUsedIdx(int usedIdx) {
		return chatDAO.getUsedIdx( usedIdx);
	}

	@Override
	public void setFirstChat(String title, String mid, String sMid, String whoMid, int idx) {
		chatDAO.setFirstChat( title, mid, sMid, whoMid, idx);
	}

	@Override
	public List<ChatGroupVO> getChatGroupList(String myMid) {
		return chatDAO.getChatGroupList( myMid);
	}

	@Override
	public MemberVO getMemberMid(String mid) {
		return chatDAO.getMemberMid( mid);
	}
}
