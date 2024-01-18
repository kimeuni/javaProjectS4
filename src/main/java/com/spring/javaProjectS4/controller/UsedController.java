package com.spring.javaProjectS4.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.pagination.PageProcess;
import com.spring.javaProjectS4.pagination.PageVO;
import com.spring.javaProjectS4.service.UsedService;
import com.spring.javaProjectS4.vo.BtmCategoryVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.MidCategoryVO;
import com.spring.javaProjectS4.vo.TopCategoryVO;
import com.spring.javaProjectS4.vo.UsedVO;

@Controller
@RequestMapping("/used")
public class UsedController {

	@Autowired
	UsedService usedService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 중고거래 메인화면 이동
	@RequestMapping(value = "/usedMain", method = RequestMethod.GET)
	public String usedMainGet(Model model,HttpSession session,
			@RequestParam(name="pag",defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize",defaultValue = "40", required = false) int pageSize
			) {
		List<TopCategoryVO> tVOS = usedService.getTopCategoryList();
		List<MidCategoryVO> mVOS = usedService.getMidCategoryList();
		List<BtmCategoryVO> bVOS = usedService.getBtmCategoryList();
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "used", "", "");
		List<UsedVO> usedVOS = usedService.getUsedAllList(pageVO.getStartIndexNo(),pageSize);
		
		String mid = session.getAttribute("sMid")== null ? "" : (String)session.getAttribute("sMid");
		
		// 지역 찾기 (서울/충남/충북 등..)
		MemberVO mVO = usedService.getMemberMid(mid);
		String [] region1 = null;
		region1 = mVO.getAddress().split("/");
		String[] region2 = region1[1].split(" ");
		String region = region2[0];
		
		model.addAttribute("tVOS",tVOS);
		model.addAttribute("mVOS",mVOS);
		model.addAttribute("bVOS",bVOS);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("usedVOS",usedVOS);
		model.addAttribute("region",region);
		
		return "used/usedMain";
	}
	
	// 중고거래 상품 등록 화면 이동
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
	
	// 중고거래 상품 등록 처리
	@RequestMapping(value = "/usedInput", method = RequestMethod.POST)
	public String usedInputPost(MultipartHttpServletRequest imgs,
			@RequestParam(name="title",defaultValue = "",required = false)String title ,
			@RequestParam(name="topCategoryIdx",defaultValue = "0",required = false)int topCategoryIdx,
			@RequestParam(name="midCategoryIdx",defaultValue = "0",required = false)int midCategoryIdx,
			@RequestParam(name="btmCategoryIdx",defaultValue = "0",required = false)int btmCategoryIdx,
			@RequestParam(name="usedState",defaultValue = "",required = false)String usedState ,
			@RequestParam(name="exchange",defaultValue = "",required = false)String exchange ,
			@RequestParam(name="money",defaultValue = "0",required = false) int money,
			@RequestParam(name="delivery",defaultValue = "0",required = false) String delivery,
			@RequestParam(name="deliveryInput",defaultValue = "0",required = false) int deliveryInput,
			@RequestParam(name="content",defaultValue = "",required = false) String content,
			@RequestParam(name="mid",defaultValue = "",required = false) String mid
			) {
		
		// 지역 찾기 (서울/충남/충북 등..)
		MemberVO mVO = usedService.getMemberMid(mid);
		String [] region1 = null;
		region1 = mVO.getAddress().split("/");
		String[] region2 = region1[1].split(" ");
		String region = region2[0];
		
		int res = 0;
		// 중고거래 상품 등록
		String imgsStr = "";
		if(delivery.equals("별도")) {
			res = usedService.setUsedInput(imgs,imgsStr,title,topCategoryIdx,midCategoryIdx,btmCategoryIdx,usedState,exchange,money,deliveryInput,content,mid,region);
		}
		else {
			res = usedService.setUsedInput(imgs,imgsStr,title,topCategoryIdx,midCategoryIdx,btmCategoryIdx,usedState,exchange,money,Integer.parseInt(delivery),content,mid,region);
		}
		
		if(res != 0) return "redirect:/message/usedInputOk";
		else return "redirect:/message/usedInputNo";
	}
	
	@RequestMapping(value = "/usedContent", method = RequestMethod.GET)
	public String usedContentGet(Model model,
			@RequestParam(name="idx",defaultValue = "0",required = false) int idx,
			@RequestParam(name="pag",defaultValue = "1",required = false) int pag,
			@RequestParam(name="pageSize",defaultValue = "40",required = false) int pageSize
			) {
		List<TopCategoryVO> tVOS = usedService.getTopCategoryList();
		List<MidCategoryVO> mVOS = usedService.getMidCategoryList();
		List<BtmCategoryVO> bVOS = usedService.getBtmCategoryList();
		
		// 들어온 글 불러오기
		UsedVO usedVO = usedService.getUsedIdx(idx);
		MemberVO memVO = usedService.getMemberMid(usedVO.getMid());
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "used", "mid", usedVO.getMid());
		List<UsedVO> usedVOS = usedService.getUsedMidList(usedVO.getMid(),pageVO.getStartIndexNo(),pageSize);
		
		String topCategoryName = "0";
		String midCategoryName = "0";
		String btmCategoryName = "0";
		for(int i=0; i<tVOS.size(); i++) {
			if(usedVO.getTopCategoryIdx() == tVOS.get(i).getIdx()) {
				topCategoryName = tVOS.get(i).getTopCategoryName();
				break;
			}
		}
		for(int i=0; i<mVOS.size(); i++) {
			if(usedVO.getMidCategoryIdx() == mVOS.get(i).getIdx()) {
				midCategoryName = mVOS.get(i).getMidCategoryName();
				break;
			}
		}
		for(int i=0; i<bVOS.size(); i++) {
			if(usedVO.getBtmCategoryIdx() == bVOS.get(i).getIdx()) {
				btmCategoryName = bVOS.get(i).getBtmCategoryName();
				break;
			}
		}
		
		model.addAttribute("usedVO",usedVO);
		model.addAttribute("memVO",memVO);
		model.addAttribute("usedVOS",usedVOS);
		model.addAttribute("topCategoryName",topCategoryName);
		model.addAttribute("midCategoryName",midCategoryName);
		model.addAttribute("btmCategoryName",btmCategoryName);
		return "used/usedContent";
	}
}
