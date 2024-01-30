package com.spring.javaProjectS4.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.pagination.PageProcess;
import com.spring.javaProjectS4.pagination.PageVO;
import com.spring.javaProjectS4.service.AdminService;
import com.spring.javaProjectS4.vo.AnswerVO;
import com.spring.javaProjectS4.vo.AskVO;
import com.spring.javaProjectS4.vo.BtmCategoryVO;
import com.spring.javaProjectS4.vo.ChatVO;
import com.spring.javaProjectS4.vo.EmoticonVO;
import com.spring.javaProjectS4.vo.EventMailVO;
import com.spring.javaProjectS4.vo.FAQVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;
import com.spring.javaProjectS4.vo.MapVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.MidCategoryVO;
import com.spring.javaProjectS4.vo.NoticeVO;
import com.spring.javaProjectS4.vo.ReasonTitleVO;
import com.spring.javaProjectS4.vo.TopCategoryVO;
import com.spring.javaProjectS4.vo.UsedReportVO;
import com.spring.javaProjectS4.vo.UsedVO;
import com.spring.javaProjectS4.vo.UserReportVO;

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
	public String adminMainGet(Model model,@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		// 회원 리스트
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminMemberList", "", "");
		List<MemberVO> memVOS = adminService.getMemberList(pageVO.getStartIndexNo(),pageSize);
		
		// 지역별 회원수
		MemberVO regionVO = adminService.getMemberRegionCnt();
		
		// 탈퇴 이유 통계
		ReasonTitleVO rtVO = adminService.getReasonTitleCnt();
		
		
		model.addAttribute("rtVO",rtVO);
		model.addAttribute("regionVO",regionVO);
		model.addAttribute("memVOS",memVOS);
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
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("mVOS",mVOS);
		model.addAttribute("menuCk","회원탈퇴신청");
		return "admin/member/userDelList";
	}
	
	// 관리자-신고 회원 리스트 화면 이동
	@RequestMapping(value = "/memberReport",method = RequestMethod.GET)
	public String memberReportGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminUserReport", "", "");
		
		List<MemberVO> mVOS = adminService.getUserReportList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("mVOS",mVOS);
		model.addAttribute("menuCk","회원신고리스트");
		return "admin/member/userReport";
	}
	
	// 관리자-신고 누적 신고수 10 개 영구정지 처리
	@ResponseBody
	@RequestMapping(value = "/memberReport", method = RequestMethod.POST)
	public String memberReportPost(String mid) {
		
		String[] midArr = null;
		if(mid.indexOf("/") != -1) {
			midArr = mid.split("/");
			
			// 영구정지 처리
			for(int i=0; i<midArr.length; i++) {
				
				// 메인광고 삭제
				//adminService.setUserShowDelMid(midArr[i]);
				
				// 계정 영구정지
				adminService.setUserAccountRUpdate(midArr[i]);
			}
			return "1";
		}
		else {
			// 메인광고 삭제
			//adminService.setUserShowDelMid(mid);
			// 계정 영구정지
			adminService.setUserAccountRUpdate(mid);
			return "1";
		}
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
				
				// 메인광고 삭제
				adminService.setUserShowDelMid(midArr[i]);
				
				// 계정 삭제
				adminService.setUserAccountDel(midArr[i]);
			}
			return "1";
		}
		else {
			// 메인광고 삭제
			adminService.setUserShowDelMid(mid);
			// 계정 삭제
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
			
			//  삭제
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
			// 삭제
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
	
	// (광고/이벤트)메일 관리 화면 이동
	@RequestMapping(value = "/mailManagement", method = RequestMethod.GET)
	public String mailManagementGet(Model model) {
		List<EventMailVO> vos = adminService.getMailAllList();
		
		model.addAttribute("menuCk","광고메일");
		model.addAttribute("vos",vos);
		return "admin/mail/mailManagement";
	}
	
	// (광고/이벤트)메일 관리에서 자세히 보기 열기
	@ResponseBody
	@RequestMapping(value = "/MailManagContent", method = RequestMethod.POST)
	public EventMailVO MailManagContentPost(@RequestParam(name="idx",defaultValue = "0", required = false) int idx) {
		return adminService.getEventMailIdx(idx);
	}
	
	// (광고/이벤트)메일 관리 삭제
	@ResponseBody
	@RequestMapping(value = "/mailDelete",method = RequestMethod.POST)
	public String mailDeletePost(@RequestParam(name="idx",defaultValue = "0", required = false) int idx) {
		
		EventMailVO vo = adminService.getEventMailIdx(idx);
		
		// 이미지 삭제
		if(vo.getFName() != "") {
			adminService.setImgDelete(vo.getFName(), "eventMail");
		}
		
		int res = adminService.setMailDelete(idx);
		if(res != 0) return "1";
		else return "2";
	}
	
	// 탈퇴 목록 등록 화면 이동
	@RequestMapping(value = "/delTitleInput", method = RequestMethod.GET)
	public String delTitleInputGet(Model model) {
		// 탈퇴 목록 리스트 가져오기
		List<ReasonTitleVO> vos = adminService.getReasonTitleList();
		
		model.addAttribute("vos",vos);
		return "admin/delTitle/delTitleInput";
	}
	
	// 탈퇴 목록 등록 처리
	@ResponseBody
	@RequestMapping(value = "/delTitleInput", method = RequestMethod.POST)
	public String delTitleInputPost(Model model,
			String code, String title, String displayNone) {
		
		//같은 코드가 있는지 확인
		List<ReasonTitleVO> vos = adminService.getReasonTitleList();
		for(int i=0; i<vos.size(); i++) {
			if(vos.get(i).getCode().equals(code)) {
				return "3";
			}
		}
		// 목록 등록
		int res = adminService.setDelTitleInput(code,title,displayNone);
		if(res != 0) return "1";
		else return "2";
		
	}
	
	// 탈퇴 목록 삭제 처리
	@ResponseBody
	@RequestMapping(value = "/reasonTitleDel", method = RequestMethod.POST)
	public String reasonTitleDelPost(String code) {
		
		// 해당 목차로 쌓은 데이터 삭제
		adminService.setUserDelReasonDel(code);
		
		// 목차 삭제
		int res = adminService.setReasonTitleDel(code);
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 탈퇴 목록 공개,비공개 전환 처리
	@ResponseBody
	@RequestMapping(value = "/displayNoneUpdate",method = RequestMethod.POST)
	public String displayNoneUpdatePost(String displayNone,String code) {
		
		int res = adminService.setDisplayNoneUpdate(displayNone, code);
		if(res != 0) return "1";
		else return "2";
	}
	
	// 메인화면 광고 등록
	@RequestMapping(value = "/advertisementInput", method = RequestMethod.GET)
	public String advertisementInputGet(Model model) {
		model.addAttribute("menuCk","메인광고등록");
		return "admin/advertisement/advertisementInput";
	}
	
	// 메인화면 광고 등록 처리
	@RequestMapping(value = "/advertisementInput", method = RequestMethod.POST)
	public String advertisementInputPost(MultipartHttpServletRequest mainImg, 
			@RequestParam(name="mImg",defaultValue = "", required = false) String mImg,
			String url) {
		System.out.println(url);
		// 등록 처리
		int res = adminService.setAdInput(mImg,url,mainImg);

		if(res != 0) return "redirect:/message/adInputY";
		else return "redirect:/message/adInputN";
	}
	
	
	// 메인화면 광고 관리 화면 이동
	@RequestMapping(value = "/advertisementManagement", method = RequestMethod.GET)
	public String advertisementManagementGet(Model model) {
		List<MainAdvertisementVO> vos = adminService.getAdAllList();
		MainAdvertisementVO vo = adminService.getMainAdOpenSwY();
		
		model.addAttribute("menuCk","메인광고관리");
		model.addAttribute("vos",vos);
		model.addAttribute("vo",vo);
		return "admin/advertisement/advertisementManagement";
	}
	
	// 메인화면 광고 관리 리스트 클릭 시 보이는 값 가져오기
	@ResponseBody
	@RequestMapping(value = "/adManagContent", method = RequestMethod.POST)
	public MainAdvertisementVO adManagContentPost(@RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
		return adminService.getMainAdIdx(idx);
	}
	
	// 메인화면 광고 관리 - 비공개 전환
	@ResponseBody
	@RequestMapping(value = "/adOpenSwNo", method = RequestMethod.POST)
	public String adOpenSwNoPost(@RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
		int res = adminService.setAdOpenSwNo(idx);
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 메인화면 광고 관리 - 공개 전환
	@ResponseBody
	@RequestMapping(value = "/adOpenSwYes", method = RequestMethod.POST)
	public String adOpenSwYesPost(@RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
		
		MainAdvertisementVO vo = adminService.getMainAdOpenSwY();
		
		if(vo == null) {
			int res = adminService.setAdOpenSwYes(idx);
			
			if(res != 0) {
				return "1";
			}
			else {
				return "3";
			}
		}
		else {
			return "2";
		}
	}
	
	// 메인화면 광고 관리 - 삭제
	@ResponseBody
	@RequestMapping(value = "/adDelete", method = RequestMethod.POST)
	public String adDeletePost(@RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
		MainAdvertisementVO vo = adminService.getMainAdIdx(idx);
		
		// 이미지 삭제
		adminService.setImgDelete(vo.getMainImg(), "mainAd");
		
		int res = adminService.setMainAdDelete(idx);
		if(res != 0) return "1";
		else return "2";
	}
	
	// 임시 이미지 삭제 화면 이동
	@RequestMapping(value = "/imsiImgDelete",method = RequestMethod.GET)
	public String ImsiImgDeleteGet(HttpServletRequest request, Model model) {
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor");
		
		String[] files = new File(realPath).list();
		
		model.addAttribute("files", files);
		model.addAttribute("fileCount", files.length);
		
		return "admin/imsiImgDelete";
	}
	
	// 임시 이미지 삭제 처리
	@ResponseBody
	@RequestMapping(value = "/imsiImgDelete",method = RequestMethod.POST)
	public String ImsiImgDeletePost(HttpServletRequest request,
			@RequestParam(name="file", defaultValue = "", required=false) String fName) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		int res = 0;
		
		// 여러개 값이 들어왔을 때
		String[] fNames = null;
		if(fName.indexOf("/") != -1) {
			fNames = fName.split("/");
			for(int i=0; i<fNames.length; i++) {
				File file = new File(realPath + fNames[i]);
				
				if(file.exists()) {
					file.delete();
					res = 1;
				}
			}
		}
		else {
			File file = new File(realPath + fName);
			
			if(file.exists()) {
				file.delete();
				res = 1;
			}
		}
		
		
		return res + "";
	}
	
	// 문의 관리 - 답변대기 문의 화면이동
	@RequestMapping(value = "/askStatusNo", method = RequestMethod.GET)
	public String askStatusNoGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "askAdmin", "답변대기", "");
		List<AskVO> vos = adminService.getAskStatusList(pageVO.getStartIndexNo(),pageSize,"답변대기");
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("menuCk","답변대기");
		return "admin/ask/askStatusNo";
	}
	
	// 문의 관리 - 답변대기 문의 - 삭제
	@ResponseBody
	@RequestMapping(value = "/askStatusNoDel",method = RequestMethod.POST)
	public String askStatusNoDelPost(@RequestParam(name="idx", defaultValue = "0", required = false) String idx) {

		String[] idxArr = null;
		if(idx.indexOf("/") != -1) {
			idxArr = idx.split("/");
			// 삭제
			for(int i=0; i<idxArr.length; i++) {
				AskVO vo = adminService.getAskIdx(Integer.parseInt(idxArr[i]));
				adminService.setaskStatusNoDel(Integer.parseInt(idxArr[i]),vo.getImgs());
			}
			return "1";
		}
		else {
			AskVO vo = adminService.getAskIdx(Integer.parseInt(idx));
			adminService.setaskStatusNoDel(Integer.parseInt(idx),vo.getImgs());
			return "1";
		}
	}
	
	// 문의 관리 - 답변대기 문의- 문의 답변 화면 이동
	@RequestMapping(value = "/askAnsInput", method = RequestMethod.GET)
	public String askAnsInputGet(Model model,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		
		AskVO askVO = adminService.getAskIdx(idx);
		
		// 해당 유저 신고처리된게 있는지 확인
		UserReportVO reportVO = adminService.getUserAskReport("ask",idx);
		
		model.addAttribute("askVO",askVO);
		model.addAttribute("reportVO",reportVO);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("menuCk","답변대기");
		return "admin/ask/askAnsInput";
	}
	
	// 문의 관리 - 답변대기문의- 문의답변 - 신고처리
	@ResponseBody
	@RequestMapping(value = "/askUserReport",method = RequestMethod.POST)
	public String askUserReportPost(String reportShop, 
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx,
			String reason) {
		// 신고 처리 업데이트
		adminService.setUserReportInput("ask",idx,reportShop,reason);
		
		// 해당 유저 신고 cnt 업데이트
		int res = adminService.setMemberReportCntUpdate(reportShop);
		if(res !=0) return "1";
		else return "2";
	}
	
	// 문의 관리 - 답변대기문의 - 문의답변 - 문의답변 처리
	@ResponseBody
	@RequestMapping(value = "/askAnsInput",method = RequestMethod.POST)
	public String askAnsInputPost(String content,@RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
		content = content.replace("\n", "<br/>");
		// 답변 등록
		adminService.setAnsInput(idx,content);
		
		// ask에서 상태 답변완료 로 업데이트
		int res = adminService.setAskStatusUpdate(idx);
		if(res != 0 ) return "1";
		else return "2";
	}

	// 문의 관리 - 답변완료 문의 삭제 화면이동
	@RequestMapping(value = "/askStatusYes", method = RequestMethod.GET)
	public String askStatusYesGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "askAdmin", "답변완료", "");
		List<AskVO> vos = adminService.getAskStatusList(pageVO.getStartIndexNo(),pageSize,"답변완료");
		
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("menuCk","답변완료");
		return "admin/ask/askStatusYes";
	}
	
	// 문의 관리 - 완료 문의 삭제 - 상세보기 화면 이동
	@RequestMapping(value = "/askAnsContent",method = RequestMethod.GET)
	public String askAnsContentGet(Model model,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		AskVO askVO = adminService.getAskIdx(idx);
		AnswerVO ansVO = adminService.getAnswerAskIdx(idx);
		
		model.addAttribute("askVO",askVO);
		model.addAttribute("ansVO",ansVO);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("menuCk","답변완료");
		return "admin/ask/askAnsContent";
	}
	
	// 문의관리 - 완료 문의 삭제 - 삭제 처리
	@ResponseBody
	@RequestMapping(value = "/askStatusYesDel",method = RequestMethod.POST)
	public String askStatusYesDelPost(@RequestParam(name="idx", defaultValue = "0", required = false) String idx) {

		String[] idxArr = null;
		if(idx.indexOf("/") != -1) {
			idxArr = idx.split("/");
			// 삭제
			for(int i=0; i<idxArr.length; i++) {
				AskVO vo = adminService.getAskIdx(Integer.parseInt(idxArr[i]));
				
				// 답변 삭제
				adminService.setAnsDel(Integer.parseInt(idxArr[i]));
				//문의 삭제
				adminService.setaskStatusNoDel(Integer.parseInt(idxArr[i]),vo.getImgs());
			}
			return "1";
		}
		else {
			AskVO vo = adminService.getAskIdx(Integer.parseInt(idx));
			adminService.setAnsDel(Integer.parseInt(idx));
			adminService.setaskStatusNoDel(Integer.parseInt(idx),vo.getImgs());
			return "1";
		}
	}
	
	// 카테고리 관리
	@RequestMapping(value = "/categoryManag", method = RequestMethod.GET)
	public String categoryManagGet(Model model) {
		List<TopCategoryVO> tVOS = adminService.getTopCategoryList();
		
		model.addAttribute("tVOS",tVOS);
		model.addAttribute("menuCk","카테고리관리");
		return "admin/used/categoryManag";
	}
	
	// top 카테고리 클릭시, mid 카테고리 가져오기
	@ResponseBody
	@RequestMapping(value = "/topMidCategory",method = RequestMethod.POST)
	public List<MidCategoryVO> topMidCategoryPost(int topCa) {
		return adminService.getTopMidCategoryList(topCa);
	}
	
	// mid 카테고리 클릭시, btm 카테고리 가져오기
	@ResponseBody
	@RequestMapping(value = "/midBtmCategory",method = RequestMethod.POST)
	public List<MidCategoryVO> midBtmCategoryPost(int midCa) {
		return adminService.getMidBtmCategoryList(midCa);
	}
	
	// 대분류 카테고리 등록 화면 이동
	@RequestMapping(value = "/topCategoryInput", method = RequestMethod.GET)
	public String topCategoryInputGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize
			) {
		// 띄울 대분류 가져오기
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "topCategory", "", "");
		List<TopCategoryVO> topVOS = adminService.getTopCategoryTableList(pageVO.getStartIndexNo(),pageSize);
		
		List<TopCategoryVO> tVOS = adminService.getTopCategoryList();
		
		model.addAttribute("tVOS",tVOS);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("topVOS",topVOS);
		model.addAttribute("menuCk","카테고리관리");
		return "admin/used/topCategoryInput";
	}
	
	// 대분류 카테고리 등록 처리
	@ResponseBody
	@RequestMapping(value = "/topCategoryInput", method = RequestMethod.POST)
	public String topCategoryInputPost(String topCategoryName) {
		
		int res = adminService.setTopCategoryInput(topCategoryName);
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 대분류, 중분류, 소분류 삭제
	@ResponseBody
	@RequestMapping(value = "/topMidBtmCategoryDel", method = RequestMethod.POST)
	public String topMidBtmCategoryDelPost(@RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
		// 소분류 삭제
		adminService.setTopBtmCategoryDel(idx);
		
		// 중분류 삭제
		adminService.setTopMidCategoryDel(idx);
		
		// 대분류 삭제
		int res = adminService.setTopCategoryDel(idx);
		
		if(res !=0 ) return "1";
		else return "2";
	}
	
	// 중분류 카테고리 등록 화면 이동
	@RequestMapping(value = "/midCategoryInput", method = RequestMethod.GET)
	public String midCategoryInputGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize
			) {
		// 띄울 중분류 가져오기
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "midCategory", "", "");
		List<MidCategoryVO> midVOS = adminService.getMidCategoryTableList(pageVO.getStartIndexNo(),pageSize);
		
		List<TopCategoryVO> tVOS = adminService.getTopCategoryList();
		
		model.addAttribute("tVOS",tVOS);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("midVOS",midVOS);
		model.addAttribute("menuCk","카테고리관리");
		return "admin/used/midCategoryInput";
	}
	
	// 중분류 카테고리 등록 처리
	@ResponseBody
	@RequestMapping(value = "/midCategoryInput", method = RequestMethod.POST)
	public String midCategoryInputPost(String midCategoryName,
			@RequestParam(name="topCategoryIdx", defaultValue = "0", required = false) int topCategoryIdx
			) {
		int res = adminService.setMidCategoryInput(midCategoryName,topCategoryIdx);
		if(res != 0) return "1";
		else return "2";
	}
	
	// 중분류 카테고리 등록 - 중분류,소분류 삭제
	@ResponseBody
	@RequestMapping(value = "/midBtmCategoryDel", method = RequestMethod.POST)
	public String midBtmCategoryDelPost(@RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
		
		//소분류 삭제
		adminService.setMidBtmCategoryDel(idx);
		
		// 중분류 삭제
		int res = adminService.setMidCategoryDel(idx);
		
		if(res != 0) return "1";
		else return "2";
	}
	

	// 소분류 카테고리 등록 화면 이동
	@RequestMapping(value = "/btmCategoryInput", method = RequestMethod.GET)
	public String btmCategoryInputGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize
			) {
		// 띄울 소분류 가져오기
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "btmCategory", "", "");
		List<BtmCategoryVO> btmVOS = adminService.getBtmCategoryTableList(pageVO.getStartIndexNo(),pageSize);
		
		List<TopCategoryVO> tVOS = adminService.getTopCategoryList();
		List<MidCategoryVO> mVOS = adminService.getMidCategoryList();
		
		model.addAttribute("tVOS",tVOS);
		model.addAttribute("mVOS",mVOS);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("btmVOS",btmVOS);
		model.addAttribute("menuCk","카테고리관리");
		return "admin/used/btmCategoryInput";
	}
	
	// 소분류 카테고리 등록처리
	@ResponseBody
	@RequestMapping(value = "/btmCategoryInput", method = RequestMethod.POST)
	public String btmCategoryInputPost(String btmCategoryName, int topCategoryIdx, int midCategoryIdx) {
		int res = adminService.setBtmCategoryInput(btmCategoryName,topCategoryIdx,midCategoryIdx);
		if(res != 0 ) return "1";
		else return "2";
	}
	
	// 소분류 카테고리-top 카테고리 클릭시, mid 카테고리 가져오기
	@ResponseBody
	@RequestMapping(value = "/topMidChategoryShow",method = RequestMethod.POST)
	public List<MidCategoryVO> topMidChategoryShowPost(@RequestParam(name="topCategoryIdx", defaultValue = "0", required = false) int topCategoryIdx) {
		return adminService.getTopMidCategoryList(topCategoryIdx);
	}
	
	// 소분류 카테고리 삭제 처리
	@ResponseBody
	@RequestMapping(value = "/btmCategoryDel", method = RequestMethod.POST)
	public String btmCategoryDelPost(@RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
		
		int res = adminService.setBtmCategoryDel(idx);
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 중고거래 신고 리스트 화면 이동
	@RequestMapping(value = "/usedReportList", method = RequestMethod.GET)
	public String usedReportListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		// 신고된 중고거래 리스트 불러오기
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "usedReport", "", "");
		List<UsedReportVO> usedRVOS = adminService.getUsedReportList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("usedRVOS",usedRVOS);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("menuCk","중고거래신고관리");
		return "admin/used/usedReportList";
	}
	
	// 중고거래 신고관리 - 문제 없음 처리
	@ResponseBody
	@RequestMapping(value = "/usedReportNo", method = RequestMethod.POST)
	public String usedReportNoPost(@RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
		int res = adminService.setUsedReportNoDelete(idx);
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 중고거래 신고관리 - 신고처리
	@ResponseBody
	@RequestMapping(value = "/usedReportYes", method = RequestMethod.POST)
	public String usedReportYesPost(String usedMid, String reason,
			@RequestParam(name="usedIdx", defaultValue = "0", required = false) int usedIdx) {
		
		int res = 0;
		
		// 해당 유저 신고처리
		adminService.setUserReportInput("used", usedIdx, usedMid,reason );
		res = adminService.setMemberReportCntUpdate(usedMid);
		
		// 신고된 글 삭제
		res = adminService.setUsedReportNoDelete(usedIdx);
		
		// 신고된 글 팔로우 알림 삭제
		adminService.setfollowUsedAlarmDel(usedIdx);
		
		// 신고된 게시글 삭제
		UsedVO uVO = adminService.getUsedIdx(usedIdx);
		adminService.setUsedIdxDelete(usedIdx,uVO.getImgs());
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 중고거래 신고관리 상세보기
	@RequestMapping(value = "/usedReportContent", method = RequestMethod.GET)
	public String usedReportContentGet(Model model,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		
		//해당 신고 글 정보 가져오기
		UsedReportVO usedRVO = adminService.getUsedReportIdx(idx);
		// 해당 신고글 게시글 가져오기
		UsedVO usedVO = adminService.getUsedIdx(usedRVO.getUsedIdx());
		
		// 카테고리
		List<TopCategoryVO> tVOS = adminService.getTopCategoryList();
		List<MidCategoryVO> mVOS = adminService.getMidCategoryList();
		List<BtmCategoryVO> bVOS = adminService.getBtmCategoryList();
		
		String topCategoryName = "0";
		String midCategoryName = "0";
		String btmCategoryName = "0";
		for(int i=0; i<tVOS.size(); i++) {
			if(usedVO.getTopCategoryIdx() == tVOS.get(i).getIdx()) {
				topCategoryName = tVOS.get(i).getTopCategoryName();
				break;
			}
		}
		for(int i=0; i<mVOS.size(); i++) {
			if(usedVO.getMidCategoryIdx() == mVOS.get(i).getIdx()) {
				midCategoryName = mVOS.get(i).getMidCategoryName();
				break;
			}
		}
		for(int i=0; i<bVOS.size(); i++) {
			if(usedVO.getBtmCategoryIdx() == bVOS.get(i).getIdx()) {
				btmCategoryName = bVOS.get(i).getBtmCategoryName();
				break;
			}
		}
		
		model.addAttribute("usedRVO",usedRVO);
		model.addAttribute("usedVO",usedVO);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("pag",pag);
		model.addAttribute("topCategoryName",topCategoryName);
		model.addAttribute("midCategoryName",midCategoryName);
		model.addAttribute("btmCategoryName",btmCategoryName);
		model.addAttribute("menuCk","중고거래신고관리");
		return "admin/used/usedReportContent";
	}
	
	// 찾아오는 길 등록 화면
	@RequestMapping(value = "/addressInput", method = RequestMethod.GET)
	public String damoaAddressInputGet(Model model) {
		// map에 등록된 제일 최신 1개 가져오기
		MapVO mapVO = adminService.getMapOne();
		
		if(mapVO == null) {
			mapVO =new MapVO();
			mapVO.setAddress("충청북도 청주시 서원구 사직대로 109 4층");
			mapVO.setPlace("다모아");
			mapVO.setLatitude(36.63510174438098);
			mapVO.setLongitude(127.45952955343128);
			model.addAttribute("mapVO",mapVO);
		}
		else {
			model.addAttribute("mapVO",mapVO);
		}
		
		return "admin/address/addressInput";
	}
	
	// 찾아오는 길 등록 처리
	@ResponseBody
	@RequestMapping(value = "/addressInput", method = RequestMethod.POST)
	public String damoaAddressInputPost(MapVO vo) {
		
		int res = adminService.getMapInput(vo);
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 채팅 이모티콘 등록 페이지 이동
	@RequestMapping(value = "/chatEmoticon", method = RequestMethod.GET)
	public String emoticonGet(Model model) {
		
		List<EmoticonVO> emoVOS = adminService.getEmoticonList();
		
		model.addAttribute("emoVOS",emoVOS);
		model.addAttribute("menuCk","이모티콘");
		return "admin/chat/emoticon";
	}
	
	// 채팅 이모티콘 등록 처리
	@RequestMapping(value = "/chatEmoticon", method = RequestMethod.POST)
	public String emoticonPost(MultipartHttpServletRequest img) {
		
		String imgStr = "";
		int res = adminService.setEmoticonInput(img,imgStr);
		
		if(res != 0) return "redirect:/message/emoticonInputY";
		else return "redirect:/message/emoticonInputN";
	}
	
	// 채팅 이모티콘 삭제 처리
	@ResponseBody
	@RequestMapping(value = "/emoticonDel", method = RequestMethod.POST)
	public String emoticonDelPost(@RequestParam(name="idx",defaultValue = "0",required = false) int idx, String img) {
		
		int res = adminService.setEmoticonDel(idx,img);
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 커뮤니티 신고 리스트 화면 이동
	@RequestMapping(value = "/communityReportList", method = RequestMethod.GET)
	public String communityReportListGet(Model model) {
		
		model.addAttribute("menuCk","커뮤니티신고");
		return "admin/community/communityReportList";
	}
	
	// 채팅 기록 삭제 화면 이동
	@RequestMapping(value = "/chattingDel", method = RequestMethod.GET)
	public String chattingDelGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "chattingDel", "", "");
		List<ChatVO> cVOS = adminService.getChattingList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute(pageVO);
		model.addAttribute("cVOS",cVOS);
		model.addAttribute("menuCk","채팅삭제");
		return "admin/chat/chattingDel";
	}
	
	// 채팅 기록 삭제 처리
	@ResponseBody
	@RequestMapping(value = "/chattingDel", method = RequestMethod.POST)
	public String chattingDelPost(@RequestParam(name="idx", defaultValue = "0", required = false) String idx) {

		String[] idxArr = null;
		if(idx.indexOf("/") != -1) {
			idxArr = idx.split("/");
			// 삭제
			for(int i=0; i<idxArr.length; i++) {
				adminService.setChattingDel(Integer.parseInt(idxArr[i]));
			}
			return "1";
		}
		else {
			adminService.setChattingDel(Integer.parseInt(idx));
			return "1";
		}
	}
	
	// 404 에러 페이지 이동
	@RequestMapping(value = "/error404", method = RequestMethod.GET)
	public String error404Get(Model model) {
		model.addAttribute("menuCk","에러페이지");
		return "admin/errorPage/error404ad";
	}
	
	// 500 에러 페이지 이동
	@RequestMapping(value = "/error500", method = RequestMethod.GET)
	public String error500Get(Model model) {
		model.addAttribute("menuCk","에러페이지");
		return "admin/errorPage/error500ad";
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
		// 작성한 내용
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
			
			
			if(mailFlag.indexOf("src=\"cid:") != -1) {
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
		}
		
		mailSender.send(message);
		return "1";
	}
}
