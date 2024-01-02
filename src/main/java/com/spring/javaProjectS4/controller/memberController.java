package com.spring.javaProjectS4.controller;

import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
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
	BCryptPasswordEncoder bCrypt; 
	
	@Autowired
	JavaMailSender mailSender;
	
	// 로그인 화면 이동
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginGet() {
		return "member/login";
	}
	
	// 로그인 처리
	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPost(@RequestParam(name="mid", defaultValue = "", required = false) String mid, 
			@RequestParam(name="pwd", defaultValue = "", required = false) String pwd,
			@RequestParam(name="idSave", defaultValue = "No", required = false) String idSave,
			HttpSession session) {
		
		System.out.println("mid" + mid + "_" + "pwd" + pwd + "_" + "idSave" + idSave);
		
		MemberVO vo = memberService.getMemberMidCheck(mid);
		
		// 아이디 공백
		if(mid.equals("")) return "1";
		// 비밀번호 공백
		else if(pwd.equals("")) return "1";
		// vo가 null일시
		else if(vo == null) return "1";
		// 관리자일 경우
		else if(vo.getMid().equals("admin")) {
			if(!vo.getPwd().equals(pwd)) return "1";
			else if(vo.getPwd().equals(pwd)) {
				// 쿠기 저장 및 세션 저장
				session.setAttribute("sMid", mid);
				session.setAttribute("sNickName", vo.getNickName());
				
				return "3";
			}
		}
		// 비밀번호가 같지 않을 시
		else if(vo.getMid().equals(mid)) {
			// 암호화된 비밀번호와 매치시켜서 같은지 확인
			if(!bCrypt.matches(pwd,vo.getPwd())) {
				return "1";
			};
		}
		// 모든 검사가 끝나고 해당사항이 없으면..
		// 쿠기 저장 및 세션 저장
		
		
		
		return "2";
	}
	
	// 회원가입 화면 이동
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinGet() {
		return "member/join";
	}
	
	// 회원가입 처리
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPost(@Validated MemberVO vo, BindingResult bindingResult, Model model) {
		
		// 유효성 검사
		if(bindingResult.hasFieldErrors()) {
			List<ObjectError> list = bindingResult.getAllErrors();
			
			String temp = "";
			for(ObjectError e : list) {
				System.out.println("메세지 : " + e.getDefaultMessage());
				temp = e.getDefaultMessage().substring(e.getDefaultMessage().indexOf("/")+1);
				if(temp.equals("midEmpty") || temp.equals("midSizeNo") || temp.equals("pwdEmpty") || temp.equals("pwdSizeNo") || temp.equals("nameEmpty") || temp.equals("nameSizeNo") || temp.equals("nickNameEmpty") || temp.equals("nickNameSizeNo") || temp.equals("addressEmpty") || temp.equals("emailEmpty") || temp.equals("genderEmpty")) {
					break;
				}
			}
			if(temp.equals("midEmpty")) temp = "아이디";
			else if(temp.equals("midSizeNo")) temp = "아이디";
			else if(temp.equals("pwdEmpty")) temp = "비밀번호";
			else if(temp.equals("pwdSizeNo")) temp = "비밀번호";
			else if(temp.equals("nameEmpty")) temp = "성명";
			else if(temp.equals("nameSizeNo")) temp = "성명";
			else if(temp.equals("nickNameEmpty")) temp = "닉네임";
			else if(temp.equals("nickNameSizeNo")) temp = "닉네임";
			else if(temp.equals("addressEmpty")) temp = "주소";
			else if(temp.equals("emailEmpty")) temp = "이메일";
			else if(temp.equals("genderEmpty")) temp = "성별";
			
			model.addAttribute("temp",temp);
			return "redirect:/message/validatorError";
		}
		else if(vo.getMid() != null && memberService.getMemberMidCheck(vo.getMid()) != null) return "redirect:/message/joinNo";
		else if(vo.getNickName() != null && memberService.getMemberNickNameCheck(vo.getNickName()) != null) return "redirect:/message/joinNo";
		
		
		if(vo.getAdYN() == null) {
			vo.setAdYN("N");
		}
		
		// 암호화 처리
		vo.setPwd(bCrypt.encode(vo.getPwd()));
		
		// 회원가입 처리
		int res = memberService.setMemberJoin(vo);
		
		if(res == 1) return "redirect:/message/joinOk";
		else return "redirect:/message/joinNo";
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
		// 세션 만료시
		else if(mailCode.equals("")) return "2";
		else return "3";
	}
	
	// 아이디 찾기 화면 보기
	@RequestMapping(value = "/idFind", method = RequestMethod.GET)
	public String idFindGet() {
		return "member/idFind";
	}
	
	// 아이디 찾기 메일 보내기
	@ResponseBody
	@RequestMapping(value = "/idFind", method = RequestMethod.POST)
	public String idFindPost(String email) throws MessagingException {
		
		List<MemberVO> vos = memberService.getMemberEmailCheck(email);
		
		String emailList ="";
		if(vos.size() != 0) {
			
			for(int i=0; i<vos.size(); i++) {
				emailList += vos.get(i).getMid() + "/";
			}
			
			String title = "요청하신 아이디 안내 메일입니다.";
			String mailFlag = emailList.substring(0,emailList.length()-1);
			String res = mailSend(email, title, mailFlag,"idFind");
			
			if(res.equals("1")) return "1";
			else return "2";
		}
		else {
			return "2";
		}
		
	}
	
	// 비밀번호 발급 화면 보기
	@RequestMapping(value = "/pwdFind", method = RequestMethod.GET)
	public String pwdFindGet() {
		return "member/pwdFind";
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
		// 인증번호 발송
		if(flag.equals("emailCode")) {
			content += "<tr><td>'다모아' 계정에 등록한 이메일 주소가 올바른지 확인하기 위한 인증번호입니다.</td></tr>";
			content += "<tr><td>아래의 인증번호를 복사하여 이메일 인증을 완료해 주세요.</td></tr>";
			content += "<tr><td style='height:20px'></td></tr>";
			content += "<tr><td>인증번호 : </td></tr>";
			content += "<tr><td style='font-size: 24px; color:blue; font-weight: bold;'>"+ mailFlag +"</td></tr>";
			content += "<tr><td style='height:20px'></td></tr>";
			content += "<tr><td>본 메일의 인증번호는 <span style='color:red'>3분 동안만 유효</span>합니다.</td></tr>";
		}
		// 아이디 찾기
		else if(flag.equals("idFind")) {
			String[] mail = mailFlag.split("/");
			int cnt = 0;
			
			content += "<tr><td>안녕하세요. '다모아'를 이용해주셔서 감사합니다.</td></tr>";
			content += "<tr><td>요청하신 이메일(<font color='#A97BF5'>"+ email +"</font>)에 해당하는 아이디를 안내해 드립니다.</td></tr>";
			content += "<tr><td style='height:20px'></td></tr>";
			content += "<tr><td>해당 이메일을 통하여 가입한 아이디는 다음과 같습니다.</td></tr>";
			content += "<tr><td style='height:20px'></td></tr>";
			for(int i=0; i<mail.length; i++) {
				cnt++;
				content += "<tr><td style='font-size:24px; color:blue'>" +cnt +". " + mail[i] + "</td></tr>"; 
			}
			content += "<tr><td style='height:20px'></td></tr>";
			content += "<tr><td>감사합니다.</td></tr>";
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
