package com.spring.javaProjectS4.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.CommunityProfileVO;
import com.spring.javaProjectS4.vo.CommunityVO;
import com.spring.javaProjectS4.vo.FollowVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.ReplyVO;

public interface CommunityDAO {

	public MemberVO getMemberMid(@Param("mid") String mid);

	public int setCommunityInput(@Param("mid") String mid,@Param("content") String content,@Param("region") String region,@Param("imgsStr") String imgsStr);

	public int getCommunityRecCnt();

	public List<CommunityVO> getCommunityList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("sMid") String sMid);

	public int setGoodYes(@Param("idx") int idx,@Param("mid") String mid,@Param("part") String part);

	public int setGoodNo(@Param("idx") int idx,@Param("mid") String mid,@Param("part") String part);

	public int setBookmarkYes(@Param("idx") int idx,@Param("mid") String mid,@Param("part") String part);

	public int setBookmarkNo(@Param("idx") int idx,@Param("mid") String mid,@Param("part") String part);

	public int setReplyInput(@Param("idx") int idx,@Param("mid") String mid,@Param("content") String content,@Param("part") String part);

	public CommunityVO getCommunityIdx(@Param("idx") int idx);

	public int setCommunityDel(@Param("idx") int idx);

	public void setCommunityReplyAllDel(@Param("part") String part,@Param("idx") int idx);

	public void setCommunityGoodAllDel(@Param("part") String part,@Param("idx") int idx);

	public void setCommunityBookmarkDel(@Param("part") String part,@Param("idx") int idx);

	public CommunityVO getCommunityMidIdx(@Param("idx") int idx,@Param("sMid") String sMid);

	public List<ReplyVO> getCommunityIdxReply(@Param("idx") int idx,@Param("sMid") String sMid);

	public List<ReplyVO> getCommunityIdxReRply(@Param("idx") int idx,@Param("sMid") String sMid);

	public int setCommunityReplyDel(@Param("idx") int idx);

	public int setCommunityReRplyInput(@Param("comuIdx") int comuIdx,@Param("reIdx") int reIdx,@Param("mid") String mid,@Param("content") String content);

	public int communityReportInput(@Param("idx") int idx,@Param("mid") String mid,@Param("sMid") String sMid,@Param("reason") String reason,@Param("part") String part);

	public List<CommunityVO> getCommunityMidList(@Param("mid") String mid,@Param("sMid") String sMid,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int getCommunityMidRecCnt(@Param("searchString") String searchString);

	public CommunityProfileVO getCommunityProfileMid(@Param("mid") String mid);

	public FollowVO getFollowerMid(@Param("sMid") String sMid,@Param("mid") String mid);

	public int getParentsReplyIdx(@Param("idx") int idx);

	public ReplyVO getCommunityOneIdxReply(@Param("idx") int idx);

	public int getCommunityReplyDelTextUpdate(@Param("idx") int idx);

	public int setComuProHeaderImgUpdate(@Param("headerImg") String headerImg,@Param("mid") String mid);

	public int setComuProSogeUpdate(@Param("communityIntroduce") String communityIntroduce,@Param("mid") String mid);

	public void setFollowUsedAlarmDel(@Param("followerMid") String followerMid,@Param("followingMid") String followingMid);

	public int setFollowDelete(@Param("followerMid") String followerMid,@Param("followingMid") String followingMid);

	public int setFollowInput(@Param("followerMid") String followerMid,@Param("followingMid") String followingMid);

	public int setFollowAlarmN(@Param("sMid") String sMid,@Param("followingMid") String followingMid);

	public int setFollowAlarmY(@Param("sMid") String sMid,@Param("followingMid") String followingMid);

	public int getCommunityBookmarkMidRecCnt(@Param("searchString") String searchString);

	public List<CommunityVO> getComuBookmarkMidList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("mid") String mid);

	public List<CommunityVO> getComuRegionList(@Param("region") String region,@Param("sMid") String sMid,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int getComuRegionRecCnt(@Param("searchString") String searchString);


}
