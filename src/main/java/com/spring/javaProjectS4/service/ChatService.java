package com.spring.javaProjectS4.service;

import java.util.List;

import com.spring.javaProjectS4.vo.ChatGroupVO;
import com.spring.javaProjectS4.vo.EmoticonVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.UsedVO;

public interface ChatService {

	public List<EmoticonVO> getEmoticonList();

	public ChatGroupVO getChatGroupCheck(int usedIdx, String mid, String sMid);

	public void setChatGroupInput(int usedIdx, String mid, String sMid);

	public UsedVO getUsedIdx(int usedIdx);

	public void setFirstChat(String title, String mid, String sMid, String whoMid, int idx);

	public List<ChatGroupVO> getChatGroupList(String myMid);

	public MemberVO getMemberMid(String mid);

}
