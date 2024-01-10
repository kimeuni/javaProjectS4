package com.spring.javaProjectS4.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaProjectS4.pagination.PageProcess;
import com.spring.javaProjectS4.pagination.PageVO;
import com.spring.javaProjectS4.service.BoardService;
import com.spring.javaProjectS4.vo.FAQVO;
import com.spring.javaProjectS4.vo.NoticeVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 공지사항 리스트 이동 및 화면에 띄울 리스트
	@RequestMapping(value = "/noticeList", method = RequestMethod.GET)
	public String adminMainGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "notice", "main", "");
		List<NoticeVO> vos = boardService.getNoticeList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO",pageVO);
		
		return "notice/noticeList";
	}
	
	@RequestMapping(value = "/noticeContent",method = RequestMethod.GET)
	public String noticeContentGet(Model model, HttpSession session,
			@RequestParam(name="idx",defaultValue = "",required = false) int idx
			) {
		
		// 조회수 처리
		ArrayList<String> boardContentIdx = (ArrayList)session.getAttribute("sBoardContentIdx");
		if(boardContentIdx == null) {  
			boardContentIdx = new ArrayList<String>();
		}
		String imsiContentIdx = "notice" + idx; 
		if(!boardContentIdx.contains(imsiContentIdx)) {
			boardService.setReadNumUpdate(idx);
			boardContentIdx.add(imsiContentIdx); // ArrayList에 추가해준다.
		}
		session.setAttribute("sBoardContentIdx", boardContentIdx);
		
		// idx에 해당하는 공지사항 값 가져오기
		NoticeVO vo = boardService.getNoticeIdx(idx);
		
		// 이전글
		NoticeVO preVO = boardService.getPreNNextSearch(idx,"preVO");
		// 다음글
		NoticeVO nextVO = boardService.getPreNNextSearch(idx,"nextVO");
		
		model.addAttribute("vo",vo);
		model.addAttribute("preVO",preVO);
		model.addAttribute("nextVO",nextVO);
		return "notice/noticeContent";
	}

	// 자주하는 질문 화면 이동
	@RequestMapping(value = "/FAQList",method = RequestMethod.GET)
	public String FAQListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "FAQ", "", "");
		List<FAQVO> vos = boardService.getFAQList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos",vos);
		return "notice/FAQList";
	}
	
	// 자주하는 질문 카테고리 검색 화면 이동 및 처리
	@RequestMapping(value = "/FAQCategorySearch" , method = RequestMethod.GET)
	public String FAQCategorySearchGet(Model model, String part, String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "FAQ", part, searchString);
		List<FAQVO> vos = boardService.getFAQCategoryList(pageVO.getStartIndexNo(),pageSize,searchString);
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos",vos);
		model.addAttribute("part",part);
		model.addAttribute("searchString",searchString);
		
		return "notice/FAQCategorySearch";
	}
	
	// 자주하는 질문 문자 검색 화면 이동 및 처리
	@RequestMapping(value = "/FAQStringSearch" , method = RequestMethod.GET)
	public String FAQStringSearchGet(Model model, String part, String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "FAQ", part, searchString);
		List<FAQVO> vos = boardService.getFAQStringSearchList(pageVO.getStartIndexNo(),pageSize,searchString);
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos",vos);
		model.addAttribute("part",part);
		model.addAttribute("searchString",searchString);
		
		return "notice/FAQStringSearch";
	}
}
