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
	private String usedMid;
	private String myMid;
}
