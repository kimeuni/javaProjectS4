package com.spring.javaProjectS4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value = "/message/{msgFalg}", method = RequestMethod.GET )
	public String msgGet(@PathVariable String msgFalg, String mid, Model model,
			@RequestParam(name="temp", defaultValue = "", required = false) String temp
			) {
		if(msgFalg.equals("joinOk")) {
			model.addAttribute("msg", "회원가입 되셨습니다.");
			model.addAttribute("url","damoa");
		}
		else if(msgFalg.equals("joinNo")) {
			model.addAttribute("msg", "회원가입에 실패하였습니다.");
			model.addAttribute("url","member/join");
		}
		else if(msgFalg.equals("validatorError")) {
			model.addAttribute("msg", "회원가입에 실패하였습니다. " + temp + "를 확인하세요.");
			model.addAttribute("url","member/join");
		}
		else if(msgFalg.equals("midSameSearch")) {
			model.addAttribute("msg", "동일한 아이디가 존재합니다.");
			model.addAttribute("url","member/login");
		}
		else if(msgFalg.equals("kakaoLoginNo")) {
			model.addAttribute("msg", "문제가 발생하였습니다. 다시 로그인해주세요.");
			model.addAttribute("url","member/login");
		}
		else if(msgFalg.equals("restoreMidNo")) {
			model.addAttribute("msg", "잘못된 접근");
			model.addAttribute("url","damoa");
		}
		else if(msgFalg.equals("noticeContentNo")) {
			model.addAttribute("msg", "공지사항의 내용을 입력해주세요.");
			model.addAttribute("url","admin/noticeInput");
		}
		else if(msgFalg.equals("adInputY")) {
			model.addAttribute("msg", "메인광고가 등록되었습니다.");
			model.addAttribute("url","admin/advertisementInput");
		}
		else if(msgFalg.equals("adInputN")) {
			model.addAttribute("msg", "메인광고 등록에 실패하였습니다.");
			model.addAttribute("url","admin/advertisementInput");
		}
		else if(msgFalg.equals("askInputOk")) {
			model.addAttribute("msg", "문의가 접수되었습니다.");
			model.addAttribute("url","ask/askInput");
		}
		else if(msgFalg.equals("askInputNo")) {
			model.addAttribute("msg", "문의 접수에 실패하였습니다.");
			model.addAttribute("url","ask/askInput");
		}
		else if(msgFalg.equals("profileUpdateY")) {
			model.addAttribute("msg", "프로필이 변경되었습니다.");
			model.addAttribute("url","member/profileUpdate");
		}
		else if(msgFalg.equals("profileUpdateN")) {
			model.addAttribute("msg", "프로필 변경에 실패하였습니다.");
			model.addAttribute("url","member/profileUpdate");
		}
		else if(msgFalg.equals("usedInputOk")) {
			model.addAttribute("msg", "상품이 등록되었습니다.");
			model.addAttribute("url","used/usedMain");
		}
		else if(msgFalg.equals("usedInputNo")) {
			model.addAttribute("msg", "상품 등록에 실패하였습니다.");
			model.addAttribute("url","used/usedInput");
		}
		else if(msgFalg.equals("communityInputY")) {
			model.addAttribute("msg", "글이 등록되었습니다.");
			model.addAttribute("url","community/communityMain");
		}
		else if(msgFalg.equals("communityInputN")) {
			model.addAttribute("msg", "글이 등록에 실패하였습니다.");
			model.addAttribute("url","community/communityMain");
		}
		return "include/message";
	}
}
