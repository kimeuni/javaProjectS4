package com.spring.javaProjectS4.controller;

import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaProjectS4.pagination.PageProcess;
import com.spring.javaProjectS4.pagination.PageVO;
import com.spring.javaProjectS4.service.AdminService;
import com.spring.javaProjectS4.vo.FAQVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.NoticeVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	JavaMailSender mailSender;
	
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
		
		String partStr = "";
		if(part.equals("name")) partStr = "성명";
		else if(part.equals("nickName")) partStr = "닉네임";
		else partStr = "이메일";
		
		model.addAttribute("menuCk","회원검색리스트");
		model.addAttribute("mVOS",mVOS);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("part",part);
		model.addAttribute("partStr",partStr);
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
		if(vo.getContent().indexOf("src=\"/") != -1) adminService.setImgCheck(vo.getContent(),"notice");
		
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
	public String noticeUpdateGet(@RequestParam(name="idx",defaultValue = "0",required = false) int idx,
			Model model) {
		// 현재 글 내용에 존재하는 이미지 임시 파일에 백업받기
		NoticeVO vo = adminService.getNoticeIdx(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) adminService.getImgBackUp(vo.getContent(),"notice");
		
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
			if(origVO.getContent().indexOf("src=\"/") != -1) adminService.setImgDelete(origVO.getContent(),"notice");
			
			// 만약 이미지를 모두 삭제했을시에는 바로 업데이트 처리하도록 밑에 과정 건너뛰도록 처리
			if(vo.getContent().indexOf("src=\"/") != -1) {
				vo.setContent(vo.getContent().replace("/data/notice/", "/data/ckeditor/"));
				
				adminService.setImgCheck(vo.getContent(),"notice");
				
				vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/notice/"));
			}
		}
		int res = adminService.setNoticeUpdate(vo);
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 관리자-공지사항 관리 => 삭제 처리(개별 및 여러개)
	@ResponseBody
	@RequestMapping(value = "/noticeDel", method = RequestMethod.POST)
	public String noticeDelPost(@RequestParam(name="idx", defaultValue = "0", required = false) String idx) {
		String[] idxArr = null;
		if(idx.indexOf("/") != -1) {
			idxArr = idx.split("/");
			
			// 계정 삭제
			for(int i=0; i<idxArr.length; i++) {
				// 이미지 삭제 처리
				NoticeVO vo = adminService.getNoticeIdx(Integer.parseInt(idxArr[i]));
				if(vo.getContent().indexOf("src=\"/") != -1) adminService.setImgDelete(vo.getContent(),"notice");
				
				adminService.setNoticeDel(Integer.parseInt(idxArr[i]));
			}
			return "1";
		}
		else {
			// 이미지 삭제 처리
			NoticeVO vo = adminService.getNoticeIdx(Integer.parseInt(idx));
			if(vo.getContent().indexOf("src=\"/") != -1) adminService.setImgDelete(vo.getContent(),"notice");
			
			adminService.setNoticeDel(Integer.parseInt(idx));
			return "1";
		}
	}
	
	// 관리자-공지사항-상세보기 화면 이동
	@RequestMapping(value = "/noticeContent",method = RequestMethod.GET)
	public String noticeContentGet(Model model,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx
			) {
		
		NoticeVO vo = adminService.getNoticeIdx(idx);
		
		model.addAttribute("vo",vo);
		model.addAttribute("menuCk","공지관리");
		
		return "admin/board/noticeContent";
	}
	
	// 이벤트 등록 화면 이동
	@RequestMapping(value = "/eventInput", method = RequestMethod.GET)
	public String eventInputGet(Model model) {
		model.addAttribute("menuCk","이벤트작성");
		return "admin/board/eventInput";
	}
	
	// FAQ 등록 화면 이동
	@RequestMapping(value = "/FAQInput",method = RequestMethod.GET)
	public String FAQInputGet(Model model) {
		model.addAttribute("menuCk","자주하는질문작성");
		return "admin/board/FAQInput";
	}
	
	// FAQ 등록 처리
	@ResponseBody
	@RequestMapping(value = "/FAQInput",method = RequestMethod.POST)
	public String FAQInputPost(FAQVO vo) {
		
		vo.setAnswer(vo.getAnswer().replace("\n", "<br/>"));
		
		int res = adminService.setFAQInput(vo);
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// FAQ 관리 화면 이동
	@RequestMapping(value = "/FAQManagement",method = RequestMethod.GET)
	public String FAQManagementGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "FAQ", "", "");
		List<FAQVO> fVOS = adminService.getFAQAllList(pageVO.getStartIndexNo(),pageSize);
		model.addAttribute("menuCk","자주하는질문관리");
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("fVOS",fVOS);
		return "admin/board/FAQManagement";
	}
	
	// FAQ 상세보기 이동
	@RequestMapping(value = "/FAQContent",method = RequestMethod.GET)
	public String FAQContentGet(Model model,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
		
		FAQVO vo = adminService.getFAQIdx(idx);
		
		model.addAttribute("menuCk","자주하는질문관리");
		model.addAttribute("vo",vo);
		return "admin/board/FAQContent";
	}
	
	// FAQ 수정 이동
	@RequestMapping(value = "/FAQUpdate",method = RequestMethod.GET)
	public String FAQUpdateGet(Model model,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
		
		FAQVO vo = adminService.getFAQIdx(idx);
		
		// DB 저장했을 때  \n을 <br/>로 수정 저장하였기 때문에, 화면에 다시 띄울 때는 되돌려 놓는다. (수정 처리시에는 다시 \n을 <br/>로 바꿔서 저장하기)
		vo.setAnswer(vo.getAnswer().replace("<br/>", "\n"));
		
		model.addAttribute("menuCk","자주하는질문관리");
		model.addAttribute("vo",vo);
		return "admin/board/FAQUpdate";
	}
	
	// 관리자-FAQ 관리 => 수정 처리
	@ResponseBody
	@RequestMapping(value = "/FAQUpdate", method = RequestMethod.POST)
	public String FAQUpdatePost(FAQVO vo) {
		
		vo.setAnswer(vo.getAnswer().replace("\n", "<br/>"));
		int res = adminService.setFAQUpdate(vo);
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 관리자-FAQ 관리 => 삭제 처리(개별 및 여러개)
	@ResponseBody
	@RequestMapping(value = "/FAQDel", method = RequestMethod.POST)
	public String FAQDelPost(@RequestParam(name="idx", defaultValue = "0", required = false) String idx) {
		
		String[] idxArr = null;
		if(idx.indexOf("/") != -1) {
			idxArr = idx.split("/");
			// 계정 삭제
			for(int i=0; i<idxArr.length; i++) {
				
				adminService.setFAQDel(Integer.parseInt(idxArr[i]));
			}
			return "1";
		}
		else {
			adminService.setFAQDel(Integer.parseInt(idx));
			return "1";
		}
	}
	
	// (광고/이벤트)메일 전송 화면 이동
	@RequestMapping(value = "/mailInput", method = RequestMethod.GET)
	public String mailInputGet(Model model) {
		model.addAttribute("menuCk","광고메일");
		return "admin/mail/mailInput";
	}
	
	// (광고/이벤트)메일 전송 처리
	@ResponseBody
	@RequestMapping(value = "/mailInput", method = RequestMethod.POST)
	public String mailInputPost(String title, String content) throws MessagingException {
		
		title = "(광고/이벤트) "+title;
		
		// 이메일 보낼 유저 계정 가져오기
		List<String> emailVOS = adminService.getAdYEmailList();
		
		// 이미지 저장
		if(content.indexOf("src=\"/") != -1) {
			adminService.setImgCheck(content,"eventEmail");
			content = content.replace("/data/ckeditor/", "/data/mail/");
		}
		
		String res = "";
		// 메일 전송 처리
		for(int i=0; i<emailVOS.size(); i++) {
			res = mailSend(emailVOS.get(i), title, content,"eventMail");
			
		}
		// 이메일 전송 성공
		if(res.equals("1")) {
			String fName = "";
			// 보낸 메일 DB 저장
			adminService.setEventEmailSave(title,content,fName);
			
			return "2";
		}

		else {
			return "1";
		}
	}
	
	// 메일 전송을 위한 메소드
		private String mailSend(String email, String title, String mailFlag, String flag) throws MessagingException {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String content = "";
			
			// 이미지 있는 곳 src='cid:' 로 바꿔주기
			mailFlag = mailFlag.replaceAll("src=\"/javaProjectS4/data/mail/", "src=\"cid:");
			// 이미지 크기 고정
			mailFlag = mailFlag.replaceAll("height:([0-9]*)px; width:([0-9]*)px", "height:800px; width:650px");
			
			System.out.println(mailFlag);
			
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true,"UTF-8");
			
			messageHelper.setTo(email);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			// 메일 내용
			content = content.replace("\n", "<br/>");
			content += "<table style='width:650px'>";
			content += "<tr style='text-align:right; background-color: #5E5756;'><th><a href='' style='color:#fff'>다모아 바로가기</a></th></tr>";
			content += "<tr><td><img src='cid:MailMain.png' width='650px'></td></tr>";
			content += "<tr><td style='height:20px'></td></tr>";
			// 인증번호 발송
			if(flag.equals("eventMail")) {
				content += "<tr><td>"+ mailFlag +"</td></tr>";
			}
			content += "<tr><td style='height:20px'></td></tr>";
			content += "<tr><td style='height:20px; background-color: #5E5756;'></td></tr>";
			content += "</table>";
			
			messageHelper.setText(content,true);
			
			FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/data/images/MailMain.png")); 
			messageHelper.addInline("MailMain.png", file);
			
			// 이메일 전송하는 이미지 보여주기 처리
			if(flag.equals("eventMail")) {
				
				// src부터 시작하여 임시 파일 저장된 곳의 파일 이름 시작 index 번호
				int position = 9;
				
				String nextImg = mailFlag.substring(mailFlag.indexOf("src=\"cid:") + position);
				boolean sw = true;
				
				System.out.println("이미지 : " + nextImg);
				while(sw) {
					String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
					
					System.out.println(imgFile);
					
					file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/data/mail/"+imgFile));
					
					messageHelper.addInline(imgFile, file);
					if(nextImg.indexOf("src=\"cid:") == -1) sw = false;
					else nextImg = nextImg.substring(nextImg.indexOf("src=\"cid:") + position);
					
				}
			}
			
			mailSender.send(message);
			return "1";
		}
}
