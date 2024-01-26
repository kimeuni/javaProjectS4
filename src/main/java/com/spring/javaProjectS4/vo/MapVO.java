package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MapVO {
	private int idx;
	private String place;
	private String address;
	private double latitude;
	private double longitude;
	private String mDate;
}
