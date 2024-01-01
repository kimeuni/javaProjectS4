package com.spring.javaProjectS4.controller;

import java.util.List;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.MailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaProjectS4.service.MemberService;
import com.spring.javaProjectS4.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class memberController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	JavaMailSender mailSender;
	
	// 로그인 화면 이동
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginGet() {
		return "member/login";
	}
	
	// 회원가입 화면 이동
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinGet() {
		return "member/join";
	}
	
	// 아이디 유효성 검사
	@ResponseBody
	@RequestMapping(value = "/midCheck", method = RequestMethod.POST)
	public String midCheckPost(String mid) {
		
		MemberVO vo = memberService.getMemberMidCheck(mid);
		// 중복
		if(vo != null){
			return "1";
		}
		else {
			return "2";
		}
	}
	
	// 닉네임 유효성 검사
	@ResponseBody
	@RequestMapping(value = "/nickNameCheck", method = RequestMethod.POST)
	public String nickNameCheckPost(String nickName) {
		
		MemberVO vo = memberService.getMemberNickNameCheck(nickName);
		// 중복
		if(vo != null){
			return "1";
		}
		else {
			return "2";
		}
	}
	
	// 이메일에 인증번호 전송
	@ResponseBody
	@RequestMapping(value = "/emailCode", method = RequestMethod.POST)
	public String emailCodePost(String email, HttpSession session) throws MessagingException {
		// 인증번호 생성
		UUID uid = UUID.randomUUID();
		String mailCode = uid.toString().substring(0,6);
		
		// 메일 전송 처리
		String title = "인증번호가 도착했습니다.";
		String mailFlag = mailCode;
		String res = mailSend(email, title, mailFlag,"emailCode");
		
		if(res.equals("1")) {
			// 메일 전송 완료되면 세션에 값 저장
			session.setAttribute("sMailCode", mailCode);
			return "2";
		}
		else return "1";
	}
	
	// 이메일에 인증번호 세션 삭제
	@ResponseBody
	@RequestMapping(value = "/mailCodeDelete", method = RequestMethod.POST)
	public String mailCodeDeletePost(HttpSession session) {
		
		session.removeAttribute("sMailCode");
		
		return "1";
	}
	
	// 메일 인증번호 확인
	@ResponseBody
	@RequestMapping(value = "/emailCodeOk", method = RequestMethod.POST)
	public String emailCodeOkPost(HttpSession session,String codeW) {
		
		String mailCode = session.getAttribute("sMailCode")==null ? "" : (String)session.getAttribute("sMailCode");
		
		// 인증번호가 같을 시
		if(mailCode.equals(codeW)) {
			session.removeAttribute("sMailCode");
			return "1";
		}
		else return "2";
	}

	// 메일 전송을 위한 메소드
	private String mailSend(String email, String title, String mailFlag, String flag) throws MessagingException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String content = "";
		
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
		if(flag.equals("emailCode")) {
			content += "<tr><td>'다모아' 계정에 등록한 이메일 주소가 올바른지 확인하기 위한 인증번호입니다.</td></tr>";
			content += "<tr><td>아래의 인증번호를 복사하여 이메일 인증을 완료해 주세요.</td></tr>";
			content += "<tr><td style='height:20px'></td></tr>";
			content += "<tr><td>인증번호 : </td></tr>";
			content += "<tr><td style='font-size: 24px; color:blue; font-weight: bold;'>"+ mailFlag +"</td></tr>";
			content += "<tr><td style='height:20px'></td></tr>";
			content += "<tr><td>본 메일의 인증번호는 <span style='color:red'>3분 동안만 유효</span>합니다.</td></tr>";
		}
		content += "<tr><td style='height:20px'></td></tr>";
		content += "<tr><td style='height:20px; background-color: #5E5756;'></td></tr>";
		content += "</table>";
		
		messageHelper.setText(content,true);
		
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/data/images/MailMain.png")); 
		messageHelper.addInline("MailMain.png", file);
		
		mailSender.send(message);
		return "1";
	}
}
