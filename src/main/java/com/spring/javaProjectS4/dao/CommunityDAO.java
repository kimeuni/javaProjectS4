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


}
