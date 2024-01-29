package com.spring.javaProjectS4.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FollowVO {
	private int idx;
	private String followerMid;
	private String followingMid;
	private String alarm;
	private String followAlarm;
	
	private String profile;
	private String nickName;
	private String communityIntroduce;
}
