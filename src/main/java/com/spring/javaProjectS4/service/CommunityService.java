package com.spring.javaProjectS4.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.vo.CommunityVO;
import com.spring.javaProjectS4.vo.MemberVO;

public interface CommunityService {

	public MemberVO getMemberMid(String Mid);

	public int setCommunityInput(MultipartHttpServletRequest imgs, String mid, String content, String region,
			String imgsStr);

	public List<CommunityVO> getCommunityList(int startIndexNo, int pageSize, String sMid);

	public int setGoodYes(int idx, String mid, String part);

	public int setGoodNo(int idx, String mid, String part);

	public int setBookmarkYes(int idx, String mid, String part);

	public int setBookmarkNo(int idx, String mid, String part);

	public int setReplyInput(int idx, String mid, String content, String part);

	public CommunityVO getCommunityIdx(int idx);

	public int setCommunityDel(int idx, String imgs);

	public void setCommunityReplyAllDel(String part, int idx);

	public void setCommunityGoodAllDel(String part, int idx);

	public void setCommunityBookmarkDel(String part, int idx);


}
