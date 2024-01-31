package com.spring.javaProjectS4.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.UserShowAdvertisementVO;
import com.spring.javaProjectS4.vo.ChatGroupVO;
import com.spring.javaProjectS4.vo.FollowUsedAlarmVO;
import com.spring.javaProjectS4.vo.LikeVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;
import com.spring.javaProjectS4.vo.MapVO;
import com.spring.javaProjectS4.vo.MemberVO;

public interface HomeDAO {

	public MainAdvertisementVO getMainAdOpen();

	public UserShowAdvertisementVO getUserShowAd(@Param("mid") String mid);

	public void setAlarmUpdateN(@Param("mid") String mid);

	public MemberVO getMemberMid(@Param("mid") String mid);

	public int setAskInput(@Param("mid") String mid,@Param("title") String title,@Param("content") String content,
			@Param("category") String category, @Param("reportShop") String reportShop, @Param("imgStr") String imgStr);

	public MapVO getMapOne();

	public List<LikeVO> getLikeAlarm(@Param("alarmMyMid") String alarmMyMid);

	public List<FollowUsedAlarmVO> getFollowUsedAlarm(@Param("alarmMyMid") String alarmMyMid);

	public List<ChatGroupVO> getReportShopList(@Param("mid") String mid);

	public void geterror();

}
