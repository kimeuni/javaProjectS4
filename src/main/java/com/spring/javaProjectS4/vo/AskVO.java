package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AskVO {
	private int idx;
	private String mid;
	private String title;
	private String content;
	private String imgs;
	private String category;
	private String askDate;
	private String status;
}
