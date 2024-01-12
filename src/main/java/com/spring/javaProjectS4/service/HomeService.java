package com.spring.javaProjectS4.service;

import com.spring.javaProjectS4.vo.UserShowAdvertisementVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;

public interface HomeService {

	public MainAdvertisementVO getMainAdOpen();

	public UserShowAdvertisementVO getUserShowAd(String mid);

	public void setAlarmUpdateN(String mid);

}
