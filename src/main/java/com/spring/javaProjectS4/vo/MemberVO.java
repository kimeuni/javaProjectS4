package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String name;
	private String nickName;
	private String address;
	private String email;
	private String gender;
	private String profile;
	private String userDel;
	private String adminYN;
	private String startDate;
	private String lastDate;
	private String adYN;
}
