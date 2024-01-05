package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserDelReasonVO {
	private int idx;
	private String titleCode;
	private String reason;
	private String rDate;
}
