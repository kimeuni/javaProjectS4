package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommunityVO {
	private int idx;
	private String mid;
	private String content;
	private String imgs;
	private String cDate;
	private String region;
	
	private String profile;
	private String nickName;
	
	private int midGoodCheck;
	private int goodCnt;
	private int replyCnt;
	private int midBookmarkCheck;
	private int bookmarkCnt;
	
	// 게시글 올린 시간 체크
	private String second_diff;
	private String minute_diff;
	private String hour_diff;
}
