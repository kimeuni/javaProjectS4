package com.spring.javaProjectS4.vo;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {
	private int idx;
	@NotEmpty(message = "아이디가 공백입니다./midEmpty")
	@Size(min=5, max=16, message= "아이디 길이가 잘못되었습니다/midSizeNo")
	private String mid;
	@NotEmpty(message = "비밀번호가 공백입니다./pwdEmpty")
	@Size(min=8, max=16, message= "비밀번호 길이가 잘못되었습니다/pwdSizeNo")
	private String pwd;
	@NotEmpty(message = "성명이 공백입니다./nameEmpty")
	@Size(min=2, max=10, message= "성명 길이가 잘못되었습니다/nameSizeNo")
	private String name;
	@NotEmpty(message = "닉네임이 공백입니다./nickNameEmpty")
	@Size(min=2, max=8, message= "닉네임 길이가 잘못되었습니다/nickNameSizeNo")
	private String nickName;
	@NotEmpty(message = "주소가 공백입니다./addressEmpty")
	private String address;
	@NotEmpty(message = "이메일이 공백입니다./emailEmpty")
	private String email;
	@NotEmpty(message = "성별이 공백입니다./genderEmpty")
	private String gender;
	private String profile;
	private String userDel;
	private String adminYN;
	private String startDate;
	private String lastDate;
	private String adYN;
	private String token;
	private int totReportCnt;
	
	private int date_diff; // 탈퇴한지 30일이 지났는지 체크
	private int start_date_diff; // 상점 오픈 일
	private int usedCnt;	// 총 올린 글 수
	private int followerCnt;	// 총 팔로워 수
}
