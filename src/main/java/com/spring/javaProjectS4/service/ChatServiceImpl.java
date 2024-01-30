package com.spring.javaProjectS4.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS4.dao.ChatDAO;
import com.spring.javaProjectS4.vo.ChatGroupVO;
import com.spring.javaProjectS4.vo.ChatVO;
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

	@Override
	public ChatGroupVO getInnerChatInfo(int usedIdx, String mid, String sMid) {
		return chatDAO.getInnerChatInfo(usedIdx , mid, sMid);
	}

	@Override
	public List<ChatVO> getChatting( String mid, String sMid) {
		return chatDAO.getChatting( mid, sMid);
	}

	@Override
	public void setUsedIdxUpdateChatG(int usedIdx, String mid, String sMid) {
		chatDAO.setUsedIdxUpdateChatG( usedIdx, mid, sMid);
	}

	@Override
	public void setChatInput(int chatIdx, String emoticon, String mid1, String mid2, String whoMid, String chat) {
		chatDAO.setChatInput( chatIdx, emoticon, mid1, mid2, whoMid, chat);
	}

	@Override
	public String getThirty(String mid1, String mid2) {
		
		ArrayList<ChatVO> vos = chatDAO.getChatList(30,mid1,mid2);
		ChatVO vo = new ChatVO();
		
		StringBuffer res = new StringBuffer();
		res.append("{\"res\":[");
		for(int i=0; i<vos.size(); i++) {
			vo = vos.get(i);
			
			vo.setChat(vo.getChat().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>"));
			vo.setChatDate(vo.getChatDate().substring(0,16));
			if(vo.getAlarm().equals("Y")) {
				vo.setAlarm("안읽음");
			}
			else {
				vo.setAlarm("");
			}
			
			res.append("[{\"value\":\""+vo.getIdx()+"\"},");
			res.append("{\"value\":\""+vo.getChatIdx()+"\"},");
			res.append("{\"value\":\""+vo.getMid1()+"\"},");
			res.append("{\"value\":\""+vo.getMid2()+"\"},");
			res.append("{\"value\":\""+vo.getEmoticon()+"\"},");
			res.append("{\"value\":\""+vo.getChat()+"\"},");
			res.append("{\"value\":\""+vo.getAlarm()+"\"},");
			res.append("{\"value\":\""+vo.getChatDate()+"\"},");
			res.append("{\"value\":\""+vo.getWhoChatMid()+"\"}]");
			if(i != (vos.size()-1)) res.append(",");
		}
		res.append("],\"last\":\""+vos.get(vos.size()-1).getIdx()+"\"}");
		return res.toString();
	}

	@Override
	public String getListIdx(String listType, String mid1, String mid2) {
		ArrayList<ChatVO> vos = chatDAO.getChatList(Integer.parseInt(listType), mid1, mid2);	// 마지막자료를 기준으로 처리.(마지막 자료 이후것을 가져오게한다.)
		ChatVO vo = new ChatVO();
		
		StringBuffer res = new StringBuffer();
		res.append("{\"res\":[");
		for(int i=0; i<vos.size(); i++) {
			vo = vos.get(i);
			
			vo.setChat(vo.getChat().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>"));
			vo.setChatDate(vo.getChatDate().substring(0,16));
			if(vo.getAlarm().equals("Y")) {
				vo.setAlarm("안읽음");
			}
			else {
				vo.setAlarm("");
			}
			
			res.append("[{\"value\":\""+vo.getIdx()+"\"},");
			res.append("{\"value\":\""+vo.getChatIdx()+"\"},");
			res.append("{\"value\":\""+vo.getMid1()+"\"},");
			res.append("{\"value\":\""+vo.getMid2()+"\"},");
			res.append("{\"value\":\""+vo.getEmoticon()+"\"},");
			res.append("{\"value\":\""+vo.getChat()+"\"},");
			res.append("{\"value\":\""+vo.getAlarm()+"\"},");
			res.append("{\"value\":\""+vo.getChatDate()+"\"},");
			res.append("{\"value\":\""+vo.getWhoChatMid()+"\"}]");
			if(i != (vos.size()-1)) res.append(",");
		}
		if(vos.size() != 0) {
			res.append("],\"last\":\""+vos.get(vos.size()-1).getIdx()+"\"}");
		}
		else {
			res.append("],\"last\":\""+listType+"\"}");
		}
		return res.toString();
	}

	@Override
	public void setChattingAlarmN(String mid, String sMid, String myMid) {
		chatDAO.setChattingAlarmN( mid, sMid,myMid);
	}
}
