package com.spring.javaProjectS4.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaProjectS4.service.UsedService;
import com.spring.javaProjectS4.vo.BtmCategoryVO;
import com.spring.javaProjectS4.vo.MidCategoryVO;
import com.spring.javaProjectS4.vo.TopCategoryVO;

@Controller
@RequestMapping("/used")
public class UsedController {

	@Autowired
	UsedService usedService;
	
	@RequestMapping(value = "/usedMain", method = RequestMethod.GET)
	public String usedMainGet(Model model) {
		List<TopCategoryVO> tVOS = usedService.getTopCategoryList();
		List<MidCategoryVO> mVOS = usedService.getMidCategoryList();
		List<BtmCategoryVO> bVOS = usedService.getBtmCategoryList();
		
		model.addAttribute("tVOS",tVOS);
		model.addAttribute("mVOS",mVOS);
		model.addAttribute("bVOS",bVOS);
		return "used/usedMain";
	}
	
	@RequestMapping(value ="/usedInput",method = RequestMethod.GET)
	public String usedInputGet(Model model) {
		List<TopCategoryVO> tVOS = usedService.getTopCategoryList();
		List<MidCategoryVO> mVOS = usedService.getMidCategoryList();
		List<BtmCategoryVO> bVOS = usedService.getBtmCategoryList();
		
		model.addAttribute("tVOS",tVOS);
		model.addAttribute("mVOS",mVOS);
		model.addAttribute("bVOS",bVOS);
		return "used/usedInput";
	}
}
