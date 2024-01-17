package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BtmCategoryVO {
	private int idx;
	private int topCategoryIdx;
	private int midCategoryIdx;
	private String btmCategoryName;
}
