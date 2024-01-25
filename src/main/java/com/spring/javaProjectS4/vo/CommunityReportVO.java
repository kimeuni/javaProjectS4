package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommunityReportVO {
	private int idx;
	private String part;
	private int partIdx;
	private String mid;
	private String reportMid;
	private String rDate;
	private String reason;
}
