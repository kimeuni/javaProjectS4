package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeVO {
	private int idx;
	private String nickName;
	private String title;
	private String content;
	private String nDate;
	private int readNum;
	private String openSw;
	
	private String hour_diff;
	private String date_diff;
}
