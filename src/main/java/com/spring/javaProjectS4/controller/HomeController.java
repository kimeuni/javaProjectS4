package com.spring.javaProjectS4.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.pagination.PageProcess;
import com.spring.javaProjectS4.pagination.PageVO;
import com.spring.javaProjectS4.service.HomeService;
import com.spring.javaProjectS4.vo.UserShowAdvertisementVO;
import com.spring.javaProjectS4.vo.ChatGroupVO;
import com.spring.javaProjectS4.vo.FollowUsedAlarmVO;
import com.spring.javaProjectS4.vo.LikeVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;
import com.spring.javaProjectS4.vo.MapVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.UsedVO;

@Controller
public class HomeController {
	
	//private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	HomeService homeService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 메인 홈
	@RequestMapping(value = {"/", "/damoa"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		//logger.info("Welcome home! The client locale is {}.", locale);
		String mid = session.getAttribute("sMid")== null ? "" : (String)session.getAttribute("sMid");
		
		// 메인화면에 띄울 광고 가져오기
		MainAdvertisementVO mainAdVO = homeService.getMainAdOpen();
		
		// 로그인한 유저 광고 체크
		UserShowAdvertisementVO userAdVO = homeService.getUserShowAd(mid);
		
		model.addAttribute("damoa","damoa");
		model.addAttribute("mainAdVO",mainAdVO);
		model.addAttribute("userAdVO",userAdVO);
		
		// 알림 띄우기
		String alarmMyMid = session.getAttribute("sMid")== null ? "" : (String)session.getAttribute("sMid");
		//1. 찜 알림
		List<LikeVO> likeAlarm = homeService.getLikeAlarm(alarmMyMid);
		
		// 2. 팔로우한 사람 게시글 올라온 알림
		List<FollowUsedAlarmVO> foAlarm = homeService.getFollowUsedAlarm(alarmMyMid);
		
		model.addAttribute("likeAlarm",likeAlarm);
		model.addAttribute("foAlarm",foAlarm);
		
		return "mainHome";
	}
	
	// ckeditor 임시 사진 저장
	@RequestMapping(value = "/imageUpload", method = RequestMethod.POST)
	public void imageUploadPost(MultipartFile upload,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		String oFileName = upload.getOriginalFilename();
		
		// 저장되는 파일명 중복되지 않도록 처리 (날짜 + 랜덤 2자리 숫자 + 원본 파일명)
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		UUID uid = UUID.randomUUID();
		String uuid = uid.toString().substring(0,2);
		oFileName = sdf.format(date) + "_" + uuid + "_" + oFileName;
		
		// 이미지 폴더에 저장
		byte[] bytes = upload.getBytes();
		FileOutputStream fos = new FileOutputStream(new File(realPath + oFileName) );
		fos.write(bytes);
		
		// 저장된 이미지 ckeditor 화면에 띄우기
		PrintWriter out = response.getWriter();
		String fileURL = request.getContextPath() + "/data/ckeditor/" + oFileName;
		out.println("{\"originalFilename\": \""+ oFileName +"\", \"uploaded\":1, \"url\": \""+ fileURL +"\"}");
		
		out.flush();
		fos.close();
	}
	
	// 메인광고 하루 안보기
	@ResponseBody
	@RequestMapping(value = "/userShowNUpdate", method = RequestMethod.POST)
	public String userShowNUpdatePost(String mid) {
		// 로그인한 유저 메인광고 알람 N로 업데이트
		
		homeService.setAlarmUpdateN(mid);
		
		return "1";
	}

	// 1:1 문의 화면 이동
	@RequestMapping(value = "/ask/askInput", method = RequestMethod.GET)
	public String askInputGet(Model model, HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		MemberVO vo = homeService.getMemberMid(mid);
		
		// 신고 상점 뿌리기
		List<ChatGroupVO> cgVOS = homeService.getReportShopList(mid);
		
		model.addAttribute("cgVOS", cgVOS);
		model.addAttribute("mVO", vo);
		return "ask/askInput";
	}
	
	// 1:1 문의 질문 등록
	@RequestMapping(value = "/ask/askInput", method = RequestMethod.POST)
	public String askInputPost(MultipartHttpServletRequest imgs,
			HttpServletRequest request,
			@RequestParam(name = "mid",defaultValue = "", required = false) String mid,
			@RequestParam(name = "title",defaultValue = "", required = false) String title,
			@RequestParam(name = "content",defaultValue = "", required = false) String content,
			@RequestParam(name = "category",defaultValue = "", required = false) String category,
			@RequestParam(name = "reportShop",defaultValue = "", required = false) String reportShop,
			@RequestParam(name = "imgStr",defaultValue = "", required = false) String imgStr
			) {
		
		
		int res = homeService.setAskInput(mid,title,content,imgs,category,reportShop,imgStr);
		if(res != 0 ) return "redirect:/message/askInputOk";
		else return "redirect:/message/askInputNo";
	}
	
	@RequestMapping(value = "/address", method = RequestMethod.GET)
	public String addressGet(Model model) {
		MapVO mapVO = homeService.getMapOne();

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
		return "address/address";
	}
	
	// 에러 페이지
	@RequestMapping(value = "/errorPage/error404", method = RequestMethod.GET)
	public String error404Get() {
		return "errorPage/error404";
	}
	
	// 에러 페이지
	@RequestMapping(value = "/errorPage/error500", method = RequestMethod.GET)
	public String error500Get() {
		return "errorPage/error500";
	}
	
	// 500에러 발생
	@RequestMapping(value = "/error500s", method = RequestMethod.GET)
	public String error500s() {
		homeService.geterror();
		return "mainHome";
	}
	
	
	// 전체 검색
	@RequestMapping(value = "/mainSearch", method = RequestMethod.GET)
	public String mainSearchGet(Model model,String str) {
		return "mainSearch";
	}
}
