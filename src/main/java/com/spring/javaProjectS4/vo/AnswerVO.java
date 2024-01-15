package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AnswerVO {
	private int idx;
	private int askIdx;
	private String content;
	private String ansDate;
}
