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
	private String reportShop;
	
	private String hour_diff;
	private String date_diff;
	private String ans_date_diff; //답변일로부터 date cnt
}
