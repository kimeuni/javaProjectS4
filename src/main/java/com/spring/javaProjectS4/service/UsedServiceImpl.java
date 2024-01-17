package com.spring.javaProjectS4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS4.dao.UsedDAO;
import com.spring.javaProjectS4.vo.BtmCategoryVO;
import com.spring.javaProjectS4.vo.MidCategoryVO;
import com.spring.javaProjectS4.vo.TopCategoryVO;

@Service
public class UsedServiceImpl implements UsedService {
	
	@Autowired
	UsedDAO usedDAO;

	@Override
	public List<TopCategoryVO> getTopCategoryList() {
		return usedDAO.getTopCategoryList();
	}

	@Override
	public List<MidCategoryVO> getMidCategoryList() {
		return usedDAO.getMidCategoryList();
	}

	@Override
	public List<BtmCategoryVO> getBtmCategoryList() {
		return usedDAO.getBtmCategoryList();
	}
	
}
