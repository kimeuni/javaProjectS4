package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserReportVO {
	private int idx;
	private String mid;
	private String part;
	private int partIdx;
	private String rDate;
	private String reason;
}
