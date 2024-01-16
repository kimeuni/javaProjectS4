package com.spring.javaProjectS4.controller;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Formatter;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.pagination.PageProcess;
import com.spring.javaProjectS4.pagination.PageVO;
import com.spring.javaProjectS4.service.MemberService;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.ReasonTitleVO;
import com.spring.javaProjectS4.vo.UserShowAdvertisementVO;
import com.spring.javaProjectS4.vo.AnswerVO;
import com.spring.javaProjectS4.vo.AskVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder bCrypt; 
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	PageProcess pageProcess;
	
	// 로그인 화면 이동
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginGet(HttpServletRequest request,Model model) {
		Cookie[] cookies = request.getCookies();
		String cMid = "";
		if(cookies != null){
			for(int i=0; i<cookies.length; i++){
				if(cookies[i].getName().equals("cMid")){
					cMid = cookies[i].getValue();
					model.addAttribute("cMid", cMid);
				}
			}
		}
		return "member/login";
	}
	
	// 로그인 처리
	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPost(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid, 
			@RequestParam(name="pwd", defaultValue = "", required = false) String pwd,
			@RequestParam(name="idSave", defaultValue = "NO", required = false) String idSave,
			HttpSession session,Model model) {
		
		MemberVO vo = memberService.getMemberMidCheck(mid);
		
		// 아이디 공백
		if(mid.equals("")) return "1";
		// 비밀번호 공백
		else if(pwd.equals("")) return "1";
		// 회원이 아닐 시,
		else if(vo == null) return "1";
		// 관리자일 경우
		else if(vo.getMid().equals("admin")) {
			if(!vo.getPwd().equals(pwd)) return "1";
			else if(vo.getPwd().equals(pwd)) {
				// 쿠기 저장 및 세션 저장
				session.setAttribute("sMid", mid);
				session.setAttribute("sNickName", vo.getNickName());
				session.setAttribute("sToken", vo.getToken());
				
				if(idSave.equals("save")) {
					Cookie cookie = new Cookie("cMid", mid);
					cookie.setMaxAge(60*60*24*5);
					cookie.setPath("/");
					
					response.addCookie(cookie);
				}
				else if(idSave.equals("NO")) {
					Cookie[] cookies = request.getCookies();
					for(int i=0; i<cookies.length; i++) {
						if(cookies[i].getName().equals("cMid")) {
							cookies[i].setMaxAge(0);
							cookies[i].setPath("/");
							
							response.addCookie(cookies[i]);
						}
					}
				}
				
				// 마지막 접속일 업데이트
				memberService.setUpdateLastDate(mid);
				
				// 메인 광고 알림 Y로 바꾸기 (하루 지났으면)
				Date now = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String today = sdf.format(now);
				
				// 로그인한 날짜 업데이트
				int res = memberService.setLoginDateUpdatMid(mid);
				
				if(res != 0) {
					// 해당 유저의 광고 알람 유무를 알기 위해 값 불러오기
					UserShowAdvertisementVO UserAdVO = memberService.getUserShowAdMid(mid);
					
					if(UserAdVO.getAlarm().equals("Y")) return "3";
					else {
						// 알람 N한 날이 오늘이랑 같으면 화면으로 이동 아니면 알람을 Y로 바꿔준다.
						UserAdVO.setAlarmNDate(UserAdVO.getAlarmNDate().substring(0,10));
						if(UserAdVO.getAlarmNDate().equals(today)) return "3";
						else {
							// 알람 Y로 수정
							memberService.setAlarmYUpdate(mid);
							
							return "3";
						}
					}
				}
			}
		}
		// 계정 탈퇴 했는데 30일 안지났을 경우(로그인시 계정 복구할거냐고 물어보기)
		else if(vo.getUserDel().equals("Y") && vo.getDate_diff() <= 30 ) {
			return mid+"/damoa/"+vo.getLastDate();
		}
		// 계정 탈퇴 했는데 30일 지났을 경우 (완전히 계정 이용 불가)
		else if(vo.getUserDel().equals("Y") && vo.getDate_diff() > 30) {
			return "1";
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
		session.setAttribute("sMid", mid);
		session.setAttribute("sNickName", vo.getNickName());
		session.setAttribute("sToken", vo.getToken());
		
		if(idSave.equals("save")) {
			Cookie cookie = new Cookie("cMid", mid);
			cookie.setMaxAge(60*60*24*5);
			cookie.setPath("/");
			
			response.addCookie(cookie);
		}
		// 아이디 저장 체크 x시 쿠기 삭제
		else if(idSave.equals("NO")) {
			Cookie[] cookies = request.getCookies();
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					cookies[i].setMaxAge(0);
					cookies[i].setPath("/");
					
					response.addCookie(cookies[i]);
				}
			}
		}

		// 마지막 접속일 업데이트
		memberService.setUpdateLastDate(mid);

		// 메인 광고 알림 Y로 바꾸기 (하루 지났으면)
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(now);
		
		// 로그인한 날짜 업데이트
		int res = memberService.setLoginDateUpdatMid(mid);
		
		if(res != 0) {
			// 해당 유저의 광고 알람 유무를 알기 위해 값 불러오기
			UserShowAdvertisementVO UserAdVO = memberService.getUserShowAdMid(mid);
			
			if(UserAdVO.getAlarm().equals("Y")) return "2";
			else {
				// 알람 N한 날이 오늘이랑 같으면 화면으로 이동 아니면 알람을 Y로 바꿔준다.
				UserAdVO.setAlarmNDate(UserAdVO.getAlarmNDate().substring(0,10));
				if(UserAdVO.getAlarmNDate().equals(today)) return "2";
				else {
					// 알람 Y로 수정
					memberService.setAlarmYUpdate(mid);
					
					return "2";
				}
			}
		}
		return "2";
	}
	
	// 로그아웃 처리
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logoutGet(HttpSession session) {
		String token = session.getAttribute("sToken")==null ? "" : (String)session.getAttribute("sToken");
		if(token.equals("damoa")) {
			System.out.println("일반 로그아웃");
			// 세션삭제
			session.invalidate();
			
			return "redirect:/damoa";
		}
		else {
			System.out.println("카카오 로그아웃");
			
			String mid = (String) session.getAttribute("sMid");
			String accessToken = (String) session.getAttribute("sAccessToken");
			String reqURL = "https://kapi.kakao.com/v1/user/unlink";
			
			try {
			    URL url = new URL(reqURL);
			    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			    conn.setRequestMethod("POST");
			    conn.setRequestProperty("Authorization", "Bearer " + accessToken);
		
			    // 카카오에 정상처리 되면 200번이 돌아옴
			    int responseCode = conn.getResponseCode();
			    System.out.println("responseCode : " + responseCode);
	      
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			session.invalidate();
			
			return "redirect:/damoa";
		}
	}
	
	// 카카오 로그인 처리
	@RequestMapping(value = "/kakaoLogin", method = RequestMethod.GET)
	public String kakaoLoginGet(HttpSession session, Model model,
			@RequestParam(name="nickName", defaultValue = "", required = false) String nickName,
			@RequestParam(name="email", defaultValue = "", required = false) String email,
			@RequestParam(name="accessToken", defaultValue = "", required = false) String accessToken
			) throws MessagingException{
		
		session.setAttribute("sAccessToken", accessToken);
		
		// 이메일 및 토큰을 통하여 회원인지 확인
		MemberVO vo = memberService.getMemberEmailTokenCheck(email,"kakao");
		
		// 카카오 회원이 아닐시, 혹은 탈퇴 후 30일이 지났을 시
		if(vo == null || (vo.getDate_diff() > 30 && vo.getUserDel().equals("Y"))) {
			// 아이디 결정해주기
			String mid = email.substring(0,email.indexOf("@"));
			
			// 기존에 같은 아이디가 존재한다면 랜덤의 아이디 부여
			MemberVO midVO = memberService.getMemberMidCheck(mid);
			if(midVO != null ) mid = RandomStringUtils.randomAlphanumeric(64).substring(0,12);
			
			// 임시 비밀번호를 발급처리 후 메일로 전송처리한다.
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8);
			session.setAttribute("sImsiPwd", pwd);
			String imsiPwd = pwd;
			
			// 비밀번호 암호화
			pwd = bCrypt.encode(pwd);
			
			// 닉네임 중복시 닉 부여
			String newNickName = "";
			MemberVO nickVO = memberService.getMemberNickNameCheck(nickName);
			if(nickVO != null) newNickName = "모아"+(int)(Math.random() * 1000)+1;
			
			// 새로 발급된 임시 비밀번호를 메일로 전송
			String title = "임시 비밀번호가 도착하였습니다.";
			String mailFlag = imsiPwd;
			String res = mailSend(email, title, mailFlag, "kakaoLoginPwd");
			
			if(!res.equals("1")) {
				return "redirect:/message/kakaoLoginNo";
			}
			
			// 자동 회원 가입처리(DB에 앞에서 만들어준 값들로 가입처리한다.)
			if(newNickName.equals("")) {
				// 닉네임 중복x
				memberService.setKakaoMemberInput1(mid,pwd,nickName,email);
			}
			else {
				// 닉네임 중복o
				String name = nickName;
				memberService.setKakaoMemberInput2(mid,pwd,name,email,newNickName);
			}
			
			vo = memberService.getMemberMidCheck(mid);
		}
		// 계정 탈퇴 했는데 30일 안지났을 경우(로그인시 계정 복구할거냐고 물어보기)
		else if(vo.getUserDel().equals("Y") && vo.getDate_diff() <= 30 ) {
			model.addAttribute("mid",email);
			model.addAttribute("token","kakao");
			model.addAttribute("lastDate",vo.getLastDate());
			
			return "member/accountRestore";
		}
		
		model.addAttribute("vo", vo);
		// 처음 로그인시, 정보 수정 페이지로
		if(vo.getAddress().equals("")) return "member/kakaoInforUpdate";
		else {
			// 처음 로그인이 아닐시, 로그인 처리
			// 세션 저장
			session.setAttribute("sMid", vo.getMid());
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sToken", vo.getToken());
			
			// 마지막 접속일 업데이트
			memberService.setUpdateLastDate(vo.getMid());
			

			// 메인 광고 알림 Y로 바꾸기 (하루 지났으면)
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String today = sdf.format(now);
			
			// 로그인한 날짜 업데이트
			int res = memberService.setLoginDateUpdatMid(vo.getMid());
			
			if(res != 0) {
				// 해당 유저의 광고 알람 유무를 알기 위해 값 불러오기
				UserShowAdvertisementVO UserAdVO = memberService.getUserShowAdMid(vo.getMid());
				
				if(UserAdVO.getAlarm().equals("Y")) return "redirect:/";
				else {
					// 알람 N한 날이 오늘이랑 같으면 화면으로 이동 아니면 알람을 Y로 바꿔준다.
					UserAdVO.setAlarmNDate(UserAdVO.getAlarmNDate().substring(0,10));
					if(UserAdVO.getAlarmNDate().equals(today)) return "redirect:/";
					else {
						// 알람 Y로 수정
						memberService.setAlarmYUpdate(vo.getMid());
						
						return "redirect:/";
					}
				}
			}
		}
		return "redirect:/";
	}
	
	// 카카오 처음 로그인 시 정보 수정 처리
	@RequestMapping(value = "/kakaoInforUpdate", method = RequestMethod.POST)
	public String kakaoInforUpdatePost(MemberVO vo){
		System.out.println(vo);
		// 가져온 내용 업데이트 처리 하기
		if(vo.getAdYN() == null) {
			vo.setAdYN("N");
		}
		
		int res = memberService.setKakaoFirstUpdatInfor(vo.getMid(),vo.getAddress(),vo.getGender(),vo.getEmail(),vo.getAdYN());
		
		if(res != 0) {
			// 메인 광고 화면 DB 저장
			memberService.setMainAdInputMid(vo.getMid());
			
			return "redirect:/member/kakaoLogin?email="+vo.getEmail();
		}
		else return "redirect:/message/kakaoLoginNo";
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
		
		if(res != 0) {
			// 메인 광고 화면 DB 

			memberService.setMainAdInputMid(vo.getMid());
			return "redirect:/message/joinOk";
		}
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
	public String nickNameCheckPost(String nickName,HttpSession session) {
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		MemberVO voM = memberService.getMemberMidCheck(mid);
		
		MemberVO vo = memberService.getMemberNickNameCheck(nickName);
		// 중복
		if(vo != null){
			// 마이페이지-정보 수정시 사용
			if(voM !=null) {
				if(nickName.equals(voM.getNickName())) {
					// infoUpdate 부분에서 닉네임 동일 시
					return "3";
				}
			}
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
	public String idFindPost(String email, String name) throws MessagingException {
		
		List<MemberVO> vos = memberService.getMemberEmailCheck(email);
		
		String emailList ="";
		if(vos.size() != 0) {
			
			emailList += name + "/";
			for(int i=0; i<vos.size(); i++) {
				String token = "";
				if(vos.get(i).getToken().equals("damoa")) {
					token = "일반 회원가입";
				}
				else if(vos.get(i).getToken().equals("kakao")) {
					token = "카카오 회원가입";
				}
				emailList += token + ": " + vos.get(i).getMid() + "&nbsp;&nbsp;&nbsp;&nbsp; <span style='font-size:14px; color:black'>가입일 : " + vos.get(i).getStartDate().substring(0,10) + "<span>/";
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
	
	// 비밀번호 발급 처리
	@ResponseBody
	@RequestMapping(value = "/pwdFind", method = RequestMethod.POST)
	public String pwdFindPost(String email, String mid) throws MessagingException {

		MemberVO vo = memberService.getMemberMidEmailCheck(mid,email);
		
		if(vo != null) {
			String pwd = RandomStringUtils.randomAlphanumeric(64).substring(0,10);
			
			String title = "임시 비밀번호가 도착하였습니다.";
			String mailFlag = pwd;
			String res = mailSend(email, title, mailFlag,"pwdFind");
			
			if(res.equals("1")) {
				// 암호화 후 DB 업데이트
				pwd = bCrypt.encode(pwd);
				memberService.setMemberPwdUpdate(mid,pwd);
				
				return "1";
			}
			else return "2";
		}
		else {
			return "2";
		}
	}
	
	// 마이페이지 이동
	@RequestMapping(value = {"/myPage","/myPage/myInfo"}, method = RequestMethod.GET)
	public String myPageGet(HttpSession session, Model model,
			@RequestParam(name="flag",defaultValue = "", required = false)String flag
			) {
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		String nickName = session.getAttribute("sNickName")==null ? "" : (String)session.getAttribute("sNickName");
		
		MemberVO vo = memberService.getMemberMidCheck(mid);
		
		if(flag.equals("myPg")) {
			model.addAttribute("menuStr",nickName+"님 마이페이지");
		}
		else {
			model.addAttribute("menuStr","개인정보 관리");
		}
		
		model.addAttribute("vo",vo);
		
		return "member/myPage";
	}
	
	// 탈퇴 안내 페이지로 이동
	@RequestMapping(value = "/userDel", method = RequestMethod.GET)
	public String userDelGet(HttpSession session, Model model) {
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberMidCheck(mid);
		List<ReasonTitleVO> vos = memberService.getTitleList();
		
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		model.addAttribute("menuStr","계정탈퇴 안내");
		
		return "member/userDel";
	}
	
	// 탈퇴 처리
	@ResponseBody
	@RequestMapping(value = "/userDelOk", method = RequestMethod.POST)
	public String userDelPost(HttpSession session,
				@RequestParam(name="pwd",defaultValue = "", required = false) String pwd,
				@RequestParam(name="whyDel",defaultValue = "", required = false) String whyDel,
				@RequestParam(name="why",defaultValue = "", required = false) String why
			) {
		
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberMidCheck(mid);
		if(!bCrypt.matches(pwd, vo.getPwd())) {
			return "1";
		}
		else {
			// userDel Y로 업데이트처리
			memberService.setUserDelUpdateY(mid);
			
			// 탈퇴 이유 등록(A9999=기타)
			if(whyDel.equals("A9999")) {
				memberService.setUserDelReason(whyDel,why);
			}
			else {
				List<ReasonTitleVO> vos = memberService.getTitleList();
				for(int i=0; i<vos.size(); i++) {
					if(vos.get(i).getCode().equals(whyDel)) {
						why = vos.get(i).getTitle();
						break;
					}
				}
				memberService.setUserDelReason(whyDel,why);
			}
			
			// 중고거래, 커뮤니티, 모아모아 등 게시글 안보이게 처리
			
			return "2";
		}
	}
	
	// 탈퇴 후 보이는 페이지 들어가기 및 세션 끊기
	@RequestMapping(value = "/userBye", method = RequestMethod.GET)
	public String userByeGet(HttpSession session) {
		String token = session.getAttribute("sToken")==null ? "" : (String)session.getAttribute("sToken");
		
		if(token.equals("damoa")) {
			session.invalidate();
		}
		else if(token.equals("kakao")) {

			String mid = (String) session.getAttribute("sMid");
			String accessToken = (String) session.getAttribute("sAccessToken");
			String reqURL = "https://kapi.kakao.com/v1/user/unlink";
			
			try {
			    URL url = new URL(reqURL);
			    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			    conn.setRequestMethod("POST");
			    conn.setRequestProperty("Authorization", "Bearer " + accessToken);
		
			    int responseCode = conn.getResponseCode();
	      
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			session.invalidate();
		}
		return "member/userBye";
	}
	
	// 비밀번호 변경 화면 이동
	@RequestMapping(value = "/pwdUpdate",method = RequestMethod.GET)
	public String pwdUpdateGet(HttpSession session, Model model) {
		
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberMidCheck(mid);
		
		model.addAttribute("vo",vo);
		model.addAttribute("menuStr","비밀번호 변경");
		
		return "member/pwdUpdate";
	}
	
	// 비밀번호 변경 처리
	@ResponseBody
	@RequestMapping(value = "/pwdUpdate",method = RequestMethod.POST)
	public String puwdUpdatePost(String pwd, String nPwd, HttpSession session) {
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberMidCheck(mid);
		
		// 현재 비밀번호와 입력한 비밀번호가 다를시,
		if(!bCrypt.matches(pwd,vo.getPwd())) {
			return "1";
		}
		else if(bCrypt.matches(nPwd,vo.getPwd())) {
			// 새 비밀번호와 기본 비밀번호가 동일할 경우
			return "2";
		}
		else {
			// 비밀번호 암호화 후 업데이트 처리
			nPwd = bCrypt.encode(nPwd);
			
			memberService.setMemberPwdUpdate(mid, nPwd);
			
			return "3";
		}
	}
	
	// 계정 복구 화면 이동
	@RequestMapping(value = "/accountRestore", method = RequestMethod.GET)
	public String accountRestoreGet(String mid,String token,String lastDate, Model model,HttpSession session) {
		model.addAttribute("mid",mid);
		model.addAttribute("token",token);
		model.addAttribute("lastDate",lastDate);
		
		return "member/accountRestore";
	}
	
	// 계정 복구 처리
	@ResponseBody
	@RequestMapping(value = "/restoreOk", method = RequestMethod.POST)
	public String restoreOkPost(String mid, String token) {
		int res = 0;
		System.out.println(mid + "/" + token);
		
		res = memberService.setUserDelUpdateN(mid,token);
		
		if(res != 0) {
			return "1";
		}
		else {
			return "2";
		}
	}
	
	// 마이페이지-정보수정 화면 이동
	@RequestMapping(value = "/infoUpdate",method = RequestMethod.GET)
	public String infoUpdateGet(Model model, HttpSession session) {
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberMidCheck(mid);
		
		model.addAttribute("vo",vo);
		model.addAttribute("menuStr","정보 수정");
		
		return "member/infoUpdate";
	}
	
	// 마이페이지-정보수정 처리
	@ResponseBody
	@RequestMapping(value = "/infoUpdateOk", method = RequestMethod.POST)
	public String infoUpdateOkPost(String name, String nickName, String email, String address,HttpSession session) {
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		
		// 계정 정보 업데이트 처리
		int res = memberService.setInfoUpdate(mid,name,nickName,email,address);
		if(res == 1) {
			return "1";
		}
		else return "2";
	}
	
	// 마이페이지-프로필변경 화면 이동
	@RequestMapping(value = "/profileUpdate", method = RequestMethod.GET)
	public String profileUpdateGet(Model model, HttpSession session) {
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberMidCheck(mid);
		
		model.addAttribute("vo",vo);
		model.addAttribute("menuStr","프로필 변경");
		
		return "member/profileUpdate";
	}

	// 마이페이지-내 문의 내역 화면 이동
	@RequestMapping(value = "/ask/myAskList", method = RequestMethod.GET )
	public String myAskListGet(Model model, HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberMidCheck(mid);

		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myAskList", "", mid);
		// 내가 문의한 리스트 불러오기
		List<AskVO> vos = memberService.getMyAskList(pageVO.getStartIndexNo(),pageSize,mid);
		
		
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("menuStr","내 문의 내역");
		
		return "ask/myAskList";
	}
	
	// 마이페이지-내문의내역-문의 상세보기
	@RequestMapping(value = "/ask/askContent", method = RequestMethod.GET)
	public String askContentGet(@RequestParam(name="idx",defaultValue = "0",required = false) int idx,
			Model model,HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "", required = false) String part
			) {
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberMidCheck(mid);
		
		AskVO askVO = memberService.getAskIdx(idx);
		AnswerVO ansVO = memberService.getAnswerAskIdx(idx);
		
		model.addAttribute("vo",vo);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("askVO",askVO);
		model.addAttribute("ansVO",ansVO);
		model.addAttribute("part",part);
		model.addAttribute("menuStr","내 문의 내역");
		return "ask/askContent";
	}
	
	// 마이페이지-내문의내역-검색(유형)
	@RequestMapping(value = "/ask/myAskListSearch", method = RequestMethod.GET)
	public String myAskListSearchGet(Model model,HttpSession session,
			@RequestParam(name="part",defaultValue = "",required = false) String part,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberMidCheck(mid);
		
		PageVO pageVO = null;
		List<AskVO> vos = null;
		if(part.equals("전체")) return "redirect:/member/ask/myAskList";
		else {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "myAskList", part, mid);
			vos = memberService.getMyAskListSearch(pageVO.getStartIndexNo(),pageSize,mid,part);
		}
		model.addAttribute("vo",vo);
		model.addAttribute("menuStr","내 문의 내역");
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("part",part);
		if(part.equals("답변대기")) return "ask/myAskListNo";
		else return "ask/myAskListYes";
	}
	
	// 이벤트/광고 메일 알람 화면 이동
	@RequestMapping(value = "/adMailAlarm", method = RequestMethod.GET)
	public String adMailAlarmGet(HttpSession session, Model model) {
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberMidCheck(mid);
		
		model.addAttribute("vo",vo);
		model.addAttribute("menuStr","(광고/이벤트) 메일 알림");
		return "member/adMailAlarm";
	}
	
	// 광고/이벤트 메일 알람 처리(Y/N)
	@ResponseBody
	@RequestMapping(value = "/adYN", method = RequestMethod.POST)
	public String adYNPost(String adYN,String mid) {
		int res = memberService.setAdYNUpdate(adYN,mid);
		if(res != 0) return "1";
		else return "2";
	}
	
	// 프로필 수정
	@RequestMapping(value = "/profileUpdate", method = RequestMethod.POST)
	public String profileUpdatePost(MultipartHttpServletRequest profile, String oProfile) {
		
		// 기본 프로필이 아닐 시 삭제 후 새 이미지 업데이트
		if(!oProfile.equals("no_img.png")) {
			//int res = memberService.origProfileDel(oProfile);
			
		}
		
		return "";
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
			
			content += "<tr><td>안녕하세요. "+ mail[0] +"님</td></tr>";
			content += "<tr><td>'다모아'를 이용해주셔서 감사합니다.</td></tr>";
			content += "<tr><td>요청하신 이메일(<font color='#A97BF5'>"+ email +"</font>)에 해당하는 아이디를 안내해 드립니다.</td></tr>";
			content += "<tr><td style='height:20px'></td></tr>";
			content += "<tr><td>해당 이메일을 통하여 가입한 아이디는 다음과 같습니다.</td></tr>";
			content += "<tr><td style='height:20px'></td></tr>";
			for(int i=1; i<mail.length; i++) {
				cnt++;
				content += "<tr><td style='font-size:24px; color:blue'>" +cnt +". " + mail[i] + "</td></tr>"; 
			}
			content += "<tr><td style='height:20px'></td></tr>";
			content += "<tr><td>감사합니다.</td></tr>";
		}
		else if(flag.equals("kakaoLoginPwd")) {
			content += "<tr><td>안녕하세요.</td></tr>";
			content += "<tr><td>'다모아'를 이용해주셔서 감사합니다.</td></tr>";
			content += "<tr><td style='height:20px'></td></tr>";
			content += "<tr><td>'다모아'사이트 이용을 위한 임시비밀번호를 안내해드립니다.</td></tr>";
			content += "<tr><td style='height:20px'></td></tr>";
			content += "<tr><td>임시 비밀번호 : </td></tr>";
			content += "<tr><td style='font-size: 24px; color:blue; font-weight: bold;'>"+ mailFlag +"</td></tr>";
			content += "<tr><td style='height:20px'></td></tr>";
			content += "<tr><td>해당 임시 비밀번호는 '마이페이지 -> 비밀번호 변경'에서 변경이 가능하며,</td></tr>";
			content += "<tr><td>카카오 첫 로그인 시 수정한 아이디를 통하여 일반 로그인 또한 가능합니다.</td></tr>";
			content += "<tr><td>감사합니다.</td></tr>";
		}
		else if(flag.equals("pwdFind")) {
			content += "<tr><td>안녕하세요.</td></tr>";
			content += "<tr><td>'다모아'를 이용해주셔서 감사합니다.</td></tr>";
			content += "<tr><td style='height:20px'></td></tr>";
			content += "<tr><td>저희 사이트는 관리자라도 회원님의 비밀번호를 알 수 없기 때문에,</td></tr>";
			content += "<tr><td>비밀번호를 알려드리는 대신 임시 비밀번호를 발급해드리고 있습니다.</td></tr>";
			content += "<tr><td>아래의 임시 비밀번호를 확인 후, <span style='color:red'>'마이페이지 -> 비밀번호 변경'</span>에서</td></tr>";
			content += "<tr><td><span style='color:red'>비밀번호를 변경해주시기 바랍니다.</span></td></tr>";
			content += "<tr><td style='height:20px'></td></tr>";
			content += "<tr><td>임시 비밀번호 : </td></tr>";
			content += "<tr><td style='font-size: 24px; color:blue; font-weight: bold;'>"+ mailFlag +"</td></tr>";
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
