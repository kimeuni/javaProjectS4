package com.spring.javaProjectS4.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.UserShowAdvertisementVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;

public interface HomeDAO {

	public MainAdvertisementVO getMainAdOpen();

	public UserShowAdvertisementVO getUserShowAd(@Param("mid") String mid);

	public void setAlarmUpdateN(@Param("mid") String mid);
	
}
