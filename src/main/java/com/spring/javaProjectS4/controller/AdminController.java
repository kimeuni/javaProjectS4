package com.spring.javaProjectS4.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaProjectS4.pagination.PageProcess;
import com.spring.javaProjectS4.pagination.PageVO;
import com.spring.javaProjectS4.service.AdminService;
import com.spring.javaProjectS4.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 관리자 메인 홈 이동
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public String adminMainGet() {
		return "admin/adminMain";
	}
	
	// 관리자- 회원 리스트 이동 및 페이징 처리
	@RequestMapping(value = "/memberList", method = RequestMethod.GET)
	public String memberListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminMemberList", "", "");
		
		List<MemberVO> mVOS = adminService.getMemberList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("menuCk","회원리스트");
		model.addAttribute("mVOS",mVOS);
		model.addAttribute("pageVO",pageVO);
		
		return "admin/member/memberList";
	}
	
	// 관리자- 회원 검색 리스트 이동 및 처리
	@RequestMapping(value = "/memberSearchList", method = RequestMethod.GET)
	public String memberSearchListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			String part, String searchString
			) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminMemberList", part, searchString);
		
		List<MemberVO> mVOS = adminService.getMemberSearchList(part,searchString,pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("menuCk","회원검색리스트");
		model.addAttribute("mVOS",mVOS);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("part",part);
		model.addAttribute("searchString",searchString);
		
		return "admin/member/memberSearchList";
	}
	
	// 관리자-탈퇴회원 리스트 화면 이동
	@RequestMapping(value = "/memberUserDel",method = RequestMethod.GET)
	public String memberUserDelGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminUserDelList", "", "");
		
		List<MemberVO> mVOS = adminService.getUserDelList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("mVOS",mVOS);
		model.addAttribute("menuCk","회원탈퇴신청");
		return "admin/member/userDelList";
	}
	
	// 관리자-공지사항 작성 이동
	@RequestMapping(value = "/noticeInput",method = RequestMethod.GET)
	public String noticeInputGet(Model model) {
		
		model.addAttribute("menuCk","공지작성");
		return "admin/board/noticeInput";
	}
}
