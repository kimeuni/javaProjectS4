package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatVO {
	private int idx;
	private int chatIdx;
	private String mid1;
	private String mid2;
	private String emoticon;
	private String chat;
	private String alarm;
	private String chatDate;
	private String whoChatMid;
	
	private String date_diff;
}
