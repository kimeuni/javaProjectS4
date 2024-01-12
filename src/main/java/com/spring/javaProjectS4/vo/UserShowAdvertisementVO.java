package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserShowAdvertisementVO {
	private int idx;
	private int adIdx ;
	private String mid;
	private String loginDate;
	private String alarm;
	private String alarmNDate;
}
