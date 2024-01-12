package com.spring.javaProjectS4.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS4.dao.HomeDAO;
import com.spring.javaProjectS4.vo.UserShowAdvertisementVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;

@Service
public class HomeServiceImpl implements HomeService {
	
	@Autowired
	HomeDAO homeDAO;

	@Override
	public MainAdvertisementVO getMainAdOpen() {
		return homeDAO.getMainAdOpen();
	}

	@Override
	public UserShowAdvertisementVO getUserShowAd(String mid) {
		return homeDAO.getUserShowAd(mid);
	}

	@Override
	public void setAlarmUpdateN(String mid) {
		homeDAO.setAlarmUpdateN(mid);
	}
}
