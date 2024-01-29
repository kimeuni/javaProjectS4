package com.spring.javaProjectS4.service;

import java.util.List;

import com.spring.javaProjectS4.vo.ChatGroupVO;
import com.spring.javaProjectS4.vo.EmoticonVO;

public interface ChatService {

	public List<EmoticonVO> getEmoticonList();

	public ChatGroupVO getChatGroupCheck(int usedIdx, String mid, String sMid);

}
