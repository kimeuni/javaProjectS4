package com.spring.javaProjectS4.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.vo.BtmCategoryVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.MidCategoryVO;
import com.spring.javaProjectS4.vo.TopCategoryVO;
import com.spring.javaProjectS4.vo.UsedVO;

public interface UsedService {

	public List<TopCategoryVO> getTopCategoryList();

	public List<MidCategoryVO> getMidCategoryList();

	public List<BtmCategoryVO> getBtmCategoryList();

	public int setUsedInput(MultipartHttpServletRequest imgs, String imgsStr, String title, int topCategoryIdx,
			int midCategoryIdx, int btmCategoryIdx, String usedState, String exchange, int money, int delivery,
			String content, String mid, String region);

	public MemberVO getMemberMid(String mid);

	public List<UsedVO> getUsedAllList(int startIndexNo, int pageSize);

	public UsedVO getUsedIdx(int idx);

	public List<UsedVO> getUsedMidList(String mid, int startIndexNo, int pageSize);

}
