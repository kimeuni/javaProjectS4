package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReplyVO {
	private int idx;
	private String part;
	private int partIdx;
	private String mid;
	private String content;
	private String rDate;
	private int parentsReplyIdx;
	private String userDel;
}
