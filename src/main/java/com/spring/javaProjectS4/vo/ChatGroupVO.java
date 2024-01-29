package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatGroupVO {
	private int idx;
	private int usedIdx;
	private String mid1;
	private String mid2;

	private String imgs;
	private String nickName1;
	private String nickName2;
	private String profile1;
	private String profile2;
	private String chat;
	private String cDate;
}
