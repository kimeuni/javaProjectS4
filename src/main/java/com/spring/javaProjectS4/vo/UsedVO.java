package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UsedVO {
	private int idx;
	private String imgs;
	private String title;
	private int topCategoryIdx;
	private int midCategoryIdx;
	private int btmCategoryIdx;
	private String region;
	private String usedState;
	private String exchange;
	private int money;
	private int delivery;
	private String content;
	private String mid;
	private int viewCnt;
	private int totLike;
	private String state;
	private String userDel;
	private String uploadDate;
	
	// 게시글 올린 시간 체크
	private String second_diff;
	private String minute_diff;
	private String hour_diff;
	private String day_diff;
	private String month_diff;
	private String year_diff;
}
