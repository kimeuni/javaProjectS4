package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TopCategoryVO {
	private int idx;
	private String topCategoryName;
	
	// 대분류 관리에서 사용
	private int midCnt;
	private int btmCnt;
	private int usedCnt;
}
