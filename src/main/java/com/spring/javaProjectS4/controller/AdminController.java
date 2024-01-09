package com.spring.javaProjectS4.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS4.pagination.PageProcess;
import com.spring.javaProjectS4.pagination.PageVO;
import com.spring.javaProjectS4.service.AdminService;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.NoticeVO;

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
	
	// 관리자-탈퇴회원 30일 지난 계정 삭제
	@ResponseBody
	@RequestMapping(value = "/memberUserDel", method = RequestMethod.POST)
	public String memberUserDelPost(String mid) {
		
		String[] midArr = null;
		if(mid.indexOf("/") != -1) {
			midArr = mid.split("/");
			
			// 계정 삭제
			for(int i=0; i<midArr.length; i++) {
				adminService.setUserAccountDel(midArr[i]);
			}
			return "1";
		}
		else {
			adminService.setUserAccountDel(mid);
			return "1";
		}
	}
	
	// 관리자-공지사항 작성 이동
	@RequestMapping(value = "/noticeInput",method = RequestMethod.GET)
	public String noticeInputGet(Model model) {
		
		model.addAttribute("menuCk","공지작성");
		return "admin/board/noticeInput";
	}
	
	// 관리자-공지사항 작성 처리
	@ResponseBody
	@RequestMapping(value = "/noticeInput",method = RequestMethod.POST)
	public String noticeInputPost(NoticeVO vo, Model model) {
		
		if(vo.getContent().equals("")) {
			return "redirect:/message/noticeContentNo";
		}
		
		// 내용에 이미지가 들어가 있으면 올린 이미지만 저장처리
		if(vo.getContent().indexOf("src=\"/") != -1) adminService.setImgCheck(vo.getContent());
		
		// DB에 저장되는 content의 경로 변경
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/notice/"));
		
		int res = adminService.setNoticeInput(vo);
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 관리자-공지사항 관리(삭제,수정) 화면이동
	@RequestMapping(value = "/noticeManagement",method = RequestMethod.GET)
	public String noticeManagementGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "notice", "", "");
		// 공지사항 리스트 가져오기
		List<NoticeVO> nVOS = adminService.getNoticeAllList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("menuCk","공지관리");
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("nVOS",nVOS);
		return "admin/board/noticeManagement";
	}
	
	// 관리자-공지사항 관리 => 수정 화면 이동
	@RequestMapping(value = "/noticeUpdate", method = RequestMethod.GET)
	public String noticeUpdateGet(@RequestParam(name="idx",defaultValue = "",required = false) int idx,
			Model model) {
		// 현재 글 내용에 존재하는 이미지 임시 파일에 백업받기
		NoticeVO vo = adminService.getNoticeIdx(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) adminService.getImgBackUp(vo.getContent());
		
		model.addAttribute("menuCk","공지관리");
		model.addAttribute("vo",vo);
		return "admin/board/noticeUpdate";
	}
	
	// 관리자-공지사항 관리 => 수정 처리
	@ResponseBody
	@RequestMapping(value = "/noticeUpdate", method = RequestMethod.POST)
	public String noticeUpdatePost(NoticeVO vo) {
		NoticeVO origVO = adminService.getNoticeIdx(vo.getIdx());
		
		// 이미지 처리
		if(!origVO.getContent().equals(vo.getContent())) {
			// 내용이 바뀌었으면 원본 내용에 들어 있던 이미지 모두 삭제처리
			if(origVO.getContent().indexOf("src=\"/") != -1) adminService.setImgDelete(origVO.getContent());
			
			// 만약 이미지를 모두 삭제했을시에는 바로 업데이트 처리하도록 하기위해서 밑에 과정 건너뛰도록 처리
			if(vo.getContent().indexOf("src=\"/") != -1) {
				vo.setContent(vo.getContent().replace("/data/notice/", "/data/ckeditor/"));
				
				adminService.setImgCheck(vo.getContent());
				
				vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/notice/"));
			}
		}
		int res = adminService.setNoticeUpdate(vo);
		
		if(res != 0) return "1";
		else return "2";
	}
	
	
}
