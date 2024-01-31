package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FollowUsedAlarmVO {
	private int idx;
	private int usedIdx;
	private String UpUsedMid;
	private String alarmMid;
	
	private String nickName;
	private String title;
	private String imgs;
}
