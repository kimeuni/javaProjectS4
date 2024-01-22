package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MidCategoryVO {
	private int idx;
	private int topCategoryIdx;
	private String midCategoryName;
	
	private int btmCnt;
	private int usedCnt;
}
