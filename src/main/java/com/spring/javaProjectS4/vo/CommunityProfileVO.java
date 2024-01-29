package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommunityProfileVO {
	private int idx;
	private String mid;
	private String communityIntroduce;
	private String headerImg;
	
	private String profile;
	private String nickName;
	
	private int comuCnt; // 해당 유저가 올린 글 게수
	private int mediCnt;
	private int goodCnt;
}
