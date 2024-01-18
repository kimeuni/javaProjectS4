package com.spring.javaProjectS4.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.BtmCategoryVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.MidCategoryVO;
import com.spring.javaProjectS4.vo.TopCategoryVO;
import com.spring.javaProjectS4.vo.UsedVO;

public interface UsedDAO {

	public List<TopCategoryVO> getTopCategoryList();

	public List<MidCategoryVO> getMidCategoryList();

	public List<BtmCategoryVO> getBtmCategoryList();

	public int setUsedInput(@Param("imgsStr") String imgsStr,@Param("title") String title,@Param("topCategoryIdx") int topCategoryIdx,@Param("midCategoryIdx") int midCategoryIdx,@Param("btmCategoryIdx") int btmCategoryIdx,
			@Param("usedState") String usedState,@Param("exchange") String exchange,@Param("money") int money,@Param("delivery") int delivery,@Param("content") String content,@Param("mid") String mid,@Param("region") String region);

	public MemberVO getMemberMid(@Param("mid") String mid);

	public List<UsedVO> getUsedAllList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int getUsedAllRecCnt();

	public UsedVO getUsedIdx(@Param("idx") int idx);

	public int getUsedMidRecCnt(String searchString);

	public List<UsedVO> getUsedMidList(@Param("mid") String mid,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);
	
}
