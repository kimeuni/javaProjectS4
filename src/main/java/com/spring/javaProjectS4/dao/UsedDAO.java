package com.spring.javaProjectS4.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.BtmCategoryVO;
import com.spring.javaProjectS4.vo.FollowUsedAlarmVO;
import com.spring.javaProjectS4.vo.FollowVO;
import com.spring.javaProjectS4.vo.LikeVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.MidCategoryVO;
import com.spring.javaProjectS4.vo.StoreVO;
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

	public int getUsedMidRecCnt(@Param("searchString") String searchString);

	public List<UsedVO> getUsedMidList(@Param("mid") String mid,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public List<FollowVO> getFollowerList(@Param("mid") String mid);

	public FollowVO getFollowerMid(@Param("mid") String mid,@Param("followingMid") String followingMid);

	public int getSaleUsedMidRecCnt(@Param("searchString") String searchString);

	public List<UsedVO> getSaleUsedMidList(@Param("mid") String mid,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int setFollowInput(@Param("followerMid") String followerMid,@Param("followingMid") String followingMid);

	public int setFollowDelete(@Param("followerMid") String followerMid,@Param("followingMid") String followingMid);

	public void setViewCntUpdate(@Param("idx") int idx);

	public StoreVO getStoreMid(@Param("mid") String mid);

	public List<FollowVO> getFollowingList(@Param("mid") String mid,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public List<LikeVO> getLikeMid(@Param("mid") String mid);

	public List<FollowVO> getFollowingCheckMid(@Param("mid") String mid);

	public UsedVO getNowUploadUsed(@Param("mid") String mid);

	public void setFollowUsedAlarmInput(@Param("idx") int idx,@Param("followerMid") String followerMid,@Param("mid") String mid);

	public FollowVO getFollowCheck(@Param("sMid")  String sMid,@Param("mid")  String mid);

	public LikeVO getUsedContentLikeMidCheck(@Param("idx") int idx,@Param("mid") String mid);

	public int setLikeInput(@Param("idx") int idx,@Param("mid") String mid);

	public int setLikeDelete(@Param("idx") int idx,@Param("mid") String mid);

	public List<UsedVO> getUsedLikeMidList(@Param("mid") String mid,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int getUsedLikeMidRecCnt(@Param("mid") String searchString);

	public void setUpdateTotLike(@Param("idx") int idx);

	public void setDeleteTotLike(@Param("idx") int idx);

	public List<MemberVO> getFollowingMemList(@Param("mid") String mid);

	public List<UsedVO> getFollowingUsedList(@Param("mid") String mid);

	public int getFollowingMidRecCnt(@Param("searchString") String searchString);

	public List<FollowVO> getFollowingAllList(@Param("mid") String mid);

	public List<MemberVO> getFollowerMemList(@Param("mid") String mid,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int getFollowerMidRecCnt(@Param("searchString") String searchString);

	public int setStoreSogeUpdate(@Param("storeIntroduce") String storeIntroduce,@Param("mid") String mid);

	public void setFollowUsedAlarmDel(@Param("followerMid") String followerMid,@Param("followingMid") String followingMid);

	public int getUsedMidListCnt(@Param("mid") String mid);

	public int setFollowAlarmN(@Param("sMid") String sMid,@Param("followingMid") String followingMid);

	public int setFollowAlarmY(@Param("sMid") String sMid,@Param("followingMid") String followingMid);

	public void setUsedUpUpdate(@Param("idx") int idx);

	public void setUsedIdxDelete(@Param("idx") int idx);

	public int setStateUpdate(@Param("idx") int idx,@Param("state") String state);

	public int setUsedReportInput(@Param("idx") int idx,@Param("reason") String reason,@Param("mid") String mid,@Param("usedMid") String usedMid);

	public void setUsedReportNoDelete(@Param("idx") int idx);

	public void setfollowUsedAlarmDel(@Param("idx") int idx);

	public int getUsedRegionRecCnt(@Param("searchString") String searchString);

	public List<UsedVO> getUsedRegionList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("region") String region);
	
}
