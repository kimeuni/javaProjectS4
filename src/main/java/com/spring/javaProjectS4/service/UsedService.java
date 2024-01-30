package com.spring.javaProjectS4.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.vo.BtmCategoryVO;
import com.spring.javaProjectS4.vo.FollowUsedAlarmVO;
import com.spring.javaProjectS4.vo.FollowVO;
import com.spring.javaProjectS4.vo.LikeVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.MidCategoryVO;
import com.spring.javaProjectS4.vo.StoreVO;
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

	public List<FollowVO> getFollowerList(String mid);

	public FollowVO getFollowerMid(String mid, String followingMid);

	public List<UsedVO> getSaleUsedMidList(String mid, int startIndexNo, int pageSize);

	public int setFollowInput(String followerMid, String followingMid);

	public int setFollowDelete(String followerMid, String followingMid);

	public void setViewCntUpdate(int idx);

	public StoreVO getStoreMid(String mid);

	public List<FollowVO> getFollowingList(String mid, int startIndexNo, int pageSize);

	public List<LikeVO> getLikeMid(String mid);

	public List<FollowVO> getFollowingCheckMid(String mid);

	public UsedVO getNowUploadUsed(String mid);

	public void setFollowUsedAlarmInput(int idx, String followerMid, String mid);

	public FollowVO getFollowCheck(String sMid, String mid);

	public LikeVO getUsedContentLikeMidCheck(int idx, String mid);

	public int setLikeInput(int idx, String mid);

	public int setLikeDelete(int idx, String mid);

	public List<UsedVO> getUsedLikeMidList(String mid, int startIndexNo, int pageSize);

	public void setUpdateTotLike(int idx);

	public void setDeleteTotLike(int idx);

	public List<MemberVO> getFollowingMemList(String mid);

	public List<UsedVO> getFollowingUsedList(String mid);

	public List<FollowVO> getFollowingAllList(String mid);

	public List<MemberVO> getFollowerMemList(String mid, int startIndexNo, int pageSize);

	public int setStoreSogeUpdate(String storeIntroduce, String mid);

	public void setFollowUsedAlarmDel(String followerMid, String followingMid);

	public int getUsedMidListCnt(String mid);

	public int setFollowAlarmN(String sMid, String followingMid);

	public int setFollowAlarmY(String sMid, String followingMid);

	public void setUsedUpUpdate(int idx);

	public void setUsedIdxDelete(int idx, String imgs);

	public int setStateUpdate(int idx, String state);

	public int setUsedReportInput(int idx, String reason, String mid, String usedMid);

	public void setUsedReportNoDelete(int idx);

	public void setfollowUsedAlarmDel(int idx);

	public List<UsedVO> getUsedRegionList(int startIndexNo, int pageSize, String region);

	public List<UsedVO> getUsedTopCList(int startIndexNo, int pageSize, int top);

	public List<UsedVO> getUsedMidCList(int startIndexNo, int pageSize, int mid);

	public List<UsedVO> getUsedBtmCList(int startIndexNo, int pageSize, int btm);

	public void setAlarmN(int idx);



}
