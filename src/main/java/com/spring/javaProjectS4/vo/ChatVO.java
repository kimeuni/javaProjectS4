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
	private String usedMid;
	private String myMid;
	private String chat;
	private String emoticon;
	private String alarm;
	private String chatDate;
	private String whoChatMid;
}
