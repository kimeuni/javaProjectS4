package com.spring.javaProjectS4.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS4.service.ChatService;
import com.spring.javaProjectS4.vo.ChatGroupVO;
import com.spring.javaProjectS4.vo.ChatVO;
import com.spring.javaProjectS4.vo.EmoticonVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.UsedVO;

@Controller
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
	@RequestMapping(value = "/chatContent", method = RequestMethod.GET)
	public String chatContentGet(Model model, HttpSession session,
			@RequestParam(name="usedIdx",defaultValue = "0",required = false) int usedIdx,
			String mid, String sMid
			) {
		String myMid = session.getAttribute("sMid")== null ? "" : (String)session.getAttribute("sMid");
		// 만들어진 채팅 그룹이 있는 지 확인
		if(usedIdx != 0) {
			ChatGroupVO cgChaeck = chatService.getChatGroupCheck(usedIdx,mid,sMid);
			// 채팅 그룹이 없으면 채팅그룹 만들기
			if(cgChaeck == null) {
				chatService.setChatGroupInput(usedIdx,mid,sMid);
				
				// 첫 채팅보내기 (상품명 '~~~' 대한 이야기 시작)
				UsedVO usedVO = chatService.getUsedIdx(usedIdx);
				String whoMid = "";
				if(!usedVO.getMid().equals(mid)) {
					whoMid = mid;
				}
				else if(!usedVO.getMid().equals(sMid)) {
					whoMid = sMid;
				}
				cgChaeck = chatService.getChatGroupCheck(usedIdx,mid,sMid);
				String chat = "상품명 < "+usedVO.getTitle()+" >에 대한 이야기를 시작해보세요!";
				chatService.setFirstChat(chat,mid,sMid,whoMid,cgChaeck.getIdx());
				
				// 채팅방 들어왔을 때 알림 n 처리
				chatService.setChattingAlarmN(mid,sMid,myMid);
				
				ChatGroupVO cgVO = chatService.getInnerChatInfo(usedIdx,mid,sMid); 
				model.addAttribute("cgVO",cgVO);
				
				List<ChatVO> cVOS = chatService.getChatting(mid,sMid);
				model.addAttribute("cVOS",cVOS);
			}
			else {
				if(cgChaeck.getUsedIdx() == usedIdx) {
					// 채팅방 들어왔을 때 알림 n 처리
					chatService.setChattingAlarmN(mid,sMid,myMid);
					// 같은 중고거래를 한 방이 있으면..
					ChatGroupVO cgVO = chatService.getInnerChatInfo(usedIdx,mid,sMid); 
					model.addAttribute("cgVO",cgVO);
					
					List<ChatVO> cVOS = chatService.getChatting(mid,sMid);
					model.addAttribute("cVOS",cVOS);
				}
				else if(cgChaeck.getUsedIdx() != usedIdx) {
					// 같은 중고거래 방이 없으면..(usedIdx 업데이트 처리)
					chatService.setUsedIdxUpdateChatG(usedIdx,mid,sMid);
					// (상품명 '~~~' 대한 이야기 시작)
					UsedVO usedVO = chatService.getUsedIdx(usedIdx);
					String whoMid = "";
					if(!usedVO.getMid().equals(mid)) {
						whoMid = mid;
					}
					else if(!usedVO.getMid().equals(sMid)) {
						whoMid = sMid;
					}
					cgChaeck = chatService.getChatGroupCheck(usedIdx,mid,sMid);
					String chat = "상품명 < "+usedVO.getTitle()+" >에 대한 이야기를 시작해보세요!";
					chatService.setFirstChat(chat,mid,sMid,whoMid,cgChaeck.getIdx());
					
					// 채팅방 들어왔을 때 알림 n 처리
					chatService.setChattingAlarmN(mid,sMid,myMid);
					
					ChatGroupVO cgVO = chatService.getInnerChatInfo(usedIdx,mid,sMid); 
					model.addAttribute("cgVO",cgVO);
					
					List<ChatVO> cVOS = chatService.getChatting(mid,sMid);
					model.addAttribute("cVOS",cVOS);
				}
			}
		}
		
		// 채팅 리스트 가져오기
		MemberVO memVO = chatService.getMemberMid(myMid);
		List<ChatGroupVO> cgVOS = chatService.getChatGroupList(myMid);
		
		// 이모티콘
		List<EmoticonVO> eVOS = chatService.getEmoticonList();
		model.addAttribute("cgVOS",cgVOS);
		model.addAttribute("eVOS",eVOS);
		model.addAttribute("memVO",memVO);
		return "chat/chatContent";
	}
	
	// 채팅 입력
	@ResponseBody
	@RequestMapping(value = "/chattingInput", method = RequestMethod.POST)
	public String chattingInputPost(@RequestParam(name="chatIdx",defaultValue = "0",required = false) int chatIdx,
			@RequestParam(name="emoticon",defaultValue = "0",required = false) String emoticon,
			@RequestParam(name="chat",defaultValue = "",required = false) String chat,
			String mid1, String mid2, String whoMid
			) throws UnsupportedEncodingException {
		mid1 = URLDecoder.decode(mid1, "UTF-8");
		mid2 = URLDecoder.decode(mid2, "UTF-8");
		whoMid = URLDecoder.decode(whoMid, "UTF-8");
		chat = URLDecoder.decode(chat, "UTF-8");
		
		System.out.println(emoticon);
		
		chatService.setChatInput(chatIdx,emoticon,mid1,mid2,whoMid,chat);
		return "";
	}
	
	// 채팅 뿌리기
	@ResponseBody
	@RequestMapping(value = "/chattingList", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String chattingListPost(String listType, String mid1, String mid2, HttpSession session) {
		String myMid = session.getAttribute("sMid")== null ? "" : (String)session.getAttribute("sMid");
		if(listType == null || listType.equals("")) {
			return "";
		}
		else if(listType.equals("thirty")) {
			// 채팅방 들어왔을 때 알림 n 처리
			chatService.setChattingAlarmN(mid1,mid2,myMid);
			return chatService.getThirty(mid1,mid2);
		}
		else {
			// 채팅방 들어왔을 때 알림 n 처리
			chatService.setChattingAlarmN(mid1,mid2,myMid);
			return chatService.getListIdx(listType,mid1,mid2);
		}
	}
}
