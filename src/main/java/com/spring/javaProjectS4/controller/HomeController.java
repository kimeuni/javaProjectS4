package com.spring.javaProjectS4.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS4.service.HomeService;
import com.spring.javaProjectS4.vo.UserShowAdvertisementVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;

@Controller
public class HomeController {
	
	//private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	HomeService homeService;
	
	// 메인 홈
	@RequestMapping(value = {"/", "/damoa"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		//logger.info("Welcome home! The client locale is {}.", locale);
		String mid = session.getAttribute("sMid")== null ? "" : (String)session.getAttribute("sMid");
		
		// 메인화면에 띄울 광고 가져오기
		MainAdvertisementVO mainAdVO = homeService.getMainAdOpen();
		
		// 로그인한 유저 광고 체크
		UserShowAdvertisementVO userAdVO = homeService.getUserShowAd(mid);
		
		model.addAttribute("mainAdVO",mainAdVO);
		model.addAttribute("userAdVO",userAdVO);
		
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
}
