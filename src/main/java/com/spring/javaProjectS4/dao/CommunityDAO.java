package com.spring.javaProjectS4.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.CommunityVO;
import com.spring.javaProjectS4.vo.MemberVO;

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


}
