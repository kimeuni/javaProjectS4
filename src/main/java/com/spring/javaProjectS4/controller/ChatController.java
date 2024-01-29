package com.spring.javaProjectS4.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaProjectS4.service.ChatService;
import com.spring.javaProjectS4.vo.ChatGroupVO;
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
			@RequestParam(name="usedIdx",defaultValue = "0",required = false)int usedIdx,
			String mid, String sMid
			) {
		
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
			}
			else {
				// 같은 중고거래를 한 방이 있으면 그냥 보내기
				if(cgChaeck.getUsedIdx() != usedIdx) {
					
				}
			}
		}
		
		
		
		// 채팅 리스트 가져오기
		String myMid = session.getAttribute("sMid")== null ? "" : (String)session.getAttribute("sMid");
		MemberVO memVO = chatService.getMemberMid(myMid);
		List<ChatGroupVO> cgVOS = chatService.getChatGroupList(myMid);
		
		// 이모티콘
		List<EmoticonVO> eVOS = chatService.getEmoticonList();
		System.out.println(myMid);
		System.out.println(cgVOS);
		model.addAttribute("cgVOS",cgVOS);
		model.addAttribute("eVOS",eVOS);
		model.addAttribute("memVO",memVO);
		return "chat/chatContent";
	}
}
