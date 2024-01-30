package com.spring.javaProjectS4.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.pagination.PageProcess;
import com.spring.javaProjectS4.pagination.PageVO;
import com.spring.javaProjectS4.service.UsedService;
import com.spring.javaProjectS4.vo.BtmCategoryVO;
import com.spring.javaProjectS4.vo.FollowUsedAlarmVO;
import com.spring.javaProjectS4.vo.FollowVO;
import com.spring.javaProjectS4.vo.LikeVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.MidCategoryVO;
import com.spring.javaProjectS4.vo.StoreVO;
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
		if(!mid.equals("")) {
			MemberVO mVO = usedService.getMemberMid(mid);
			String [] region1 = null;
			region1 = mVO.getAddress().split("/");
			String[] region2 = region1[1].split(" ");
			String region = region2[0];
			
			model.addAttribute("region",region);
		}
		
		model.addAttribute("tVOS",tVOS);
		model.addAttribute("mVOS",mVOS);
		model.addAttribute("bVOS",bVOS);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("usedVOS",usedVOS);
		
		return "used/usedMain";
	}
	
	// 중고거래-지역 화면 이동
	@RequestMapping(value = "/usedRegion", method = RequestMethod.GET)
	public String usedRegionGet(Model model,HttpSession session, String regionStr,
			@RequestParam(name="pag",defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize",defaultValue = "40", required = false) int pageSize
			) {
		List<TopCategoryVO> tVOS = usedService.getTopCategoryList();
		List<MidCategoryVO> mVOS = usedService.getMidCategoryList();
		List<BtmCategoryVO> bVOS = usedService.getBtmCategoryList();
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "used", "region", regionStr);
		List<UsedVO> usedVOS = usedService.getUsedRegionList(pageVO.getStartIndexNo(),pageSize,regionStr);
		
		String mid = session.getAttribute("sMid")== null ? "" : (String)session.getAttribute("sMid");
		
		// 지역 찾기 (서울/충남/충북 등..)
		if(!mid.equals("")) {
			MemberVO mVO = usedService.getMemberMid(mid);
			String [] region1 = null;
			region1 = mVO.getAddress().split("/");
			String[] region2 = region1[1].split(" ");
			String region = region2[0];
			
			model.addAttribute("region",region);
		}
		
		model.addAttribute("tVOS",tVOS);
		model.addAttribute("mVOS",mVOS);
		model.addAttribute("bVOS",bVOS);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("usedVOS",usedVOS);
		
		return "used/usedRegion";
	}
	
	// 중고거래-카테고리 화면 이동
	@RequestMapping(value = "/usedCategorySearch", method = RequestMethod.GET)
	public String usedCategorySearchGet(Model model,HttpSession session, String regionStr,
			@RequestParam(name="top",defaultValue = "0", required = false) String top,
			@RequestParam(name="mid",defaultValue = "0", required = false) String mid,
			@RequestParam(name="btm",defaultValue = "0", required = false) String btm,
			@RequestParam(name="pag",defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize",defaultValue = "40", required = false) int pageSize
			) {
		List<TopCategoryVO> tVOS = usedService.getTopCategoryList();
		List<MidCategoryVO> mVOS = usedService.getMidCategoryList();
		List<BtmCategoryVO> bVOS = usedService.getBtmCategoryList();
		
		PageVO pageVO = null;
		List<UsedVO> usedVOS = null;
		if(mid.equals("0") & btm.equals("0")) {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "used", "topC", top);
			usedVOS = usedService.getUsedTopCList(pageVO.getStartIndexNo(),pageSize,Integer.parseInt(top));
		}
		else if(!mid.equals("0") & btm.equals("0")) {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "used", "midC", mid);
			usedVOS = usedService.getUsedMidCList(pageVO.getStartIndexNo(),pageSize,Integer.parseInt(mid));
		}
		else if(!mid.equals("0") & !btm.equals("0")) {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "used", "btmC", btm);
			usedVOS = usedService.getUsedBtmCList(pageVO.getStartIndexNo(),pageSize,Integer.parseInt(btm));
		}
		
		String sMid = session.getAttribute("sMid")== null ? "" : (String)session.getAttribute("sMid");
		
		// 지역 찾기 (서울/충남/충북 등..)
		if(!sMid.equals("")) {
			MemberVO mVO = usedService.getMemberMid(sMid);
			String [] region1 = null;
			region1 = mVO.getAddress().split("/");
			String[] region2 = region1[1].split(" ");
			String region = region2[0];
			
			model.addAttribute("region",region);
		}
		
		// 카테고리
		String topCategoryName = "0";
		String midCategoryName = "0";
		String btmCategoryName = "0";
		for(int i=0; i<tVOS.size(); i++) {
			if(Integer.parseInt(top) == tVOS.get(i).getIdx()) {
				topCategoryName = tVOS.get(i).getTopCategoryName();
				break;
			}
		}
		for(int i=0; i<mVOS.size(); i++) {
			if(Integer.parseInt(mid) == mVOS.get(i).getIdx()) {
				midCategoryName = mVOS.get(i).getMidCategoryName();
				break;
			}
		}
		for(int i=0; i<bVOS.size(); i++) {
			if(Integer.parseInt(btm) == bVOS.get(i).getIdx()) {
				btmCategoryName = bVOS.get(i).getBtmCategoryName();
				break;
			}
		}
		
		model.addAttribute("top",Integer.parseInt(top));
		model.addAttribute("mid",Integer.parseInt(mid));
		model.addAttribute("btm",Integer.parseInt(btm));
		model.addAttribute("topCategoryName",topCategoryName);
		model.addAttribute("midCategoryName",midCategoryName);
		model.addAttribute("btmCategoryName",btmCategoryName);
		model.addAttribute("tVOS",tVOS);
		model.addAttribute("mVOS",mVOS);
		model.addAttribute("bVOS",bVOS);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("usedVOS",usedVOS);
		return "used/usedCategorySearch";
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
		
		content = content.replace("\n", "<br/>");
		
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
		
		
		if(res != 0) {
			// 해당 유저가 방금 등록한 글 가져오기
			UsedVO usedVO = usedService.getNowUploadUsed(mid);
			// 중고거래 게시물 등록시, following이 나인 사람이 있으면! followUsedAlarm에 추가
			List<FollowVO> fuVOS = usedService.getFollowingCheckMid(mid);
			if(fuVOS.size() != 0) {
				for(int i=0; i<fuVOS.size(); i++) {
					// 팔로우한 사람이 알림이 Y이면 followUsedAlarm에 추가
					if(fuVOS.get(i).getAlarm().equals("Y")) {
						usedService.setFollowUsedAlarmInput(usedVO.getIdx(),fuVOS.get(i).getFollowerMid(),mid);
					}
				}
			}
			
			return "redirect:/message/usedInputOk";
		}
		else return "redirect:/message/usedInputNo";
	}
	
	// 중고거래 글 상세보기
	@RequestMapping(value = "/usedContent", method = RequestMethod.GET)
	public String usedContentGet(Model model, HttpSession session,
			@RequestParam(name="flag",defaultValue = "",required = false) String flag,
			@RequestParam(name="idx",defaultValue = "0",required = false) int idx,
			@RequestParam(name="pag",defaultValue = "1",required = false) int pag,
			@RequestParam(name="pageSize",defaultValue = "40",required = false) int pageSize
			) {
		List<TopCategoryVO> tVOS = usedService.getTopCategoryList();
		List<MidCategoryVO> mVOS = usedService.getMidCategoryList();
		List<BtmCategoryVO> bVOS = usedService.getBtmCategoryList();
		
		if(flag.equals("alarm")) {
			// 알림 n 처리
			usedService.setAlarmN(idx);
		}
		
		// 조회수 처리
		ArrayList<String> boardContentIdx = (ArrayList)session.getAttribute("sBoardContentIdx");
		if(boardContentIdx == null) {  
			boardContentIdx = new ArrayList<String>();
		}
		String imsiContentIdx = "used" + idx; 
		if(!boardContentIdx.contains(imsiContentIdx)) {
			usedService.setViewCntUpdate(idx);
			boardContentIdx.add(imsiContentIdx); 
		}
		session.setAttribute("sBoardContentIdx", boardContentIdx);
		
		// 들어온 글 불러오기
		// 게시물 정보
		UsedVO usedVO = usedService.getUsedIdx(idx);
		// 유저 정보
		MemberVO memVO = usedService.getMemberMid(usedVO.getMid());
		// 해당 유저가 작성한 게시글 개수
		PageVO pageVO1 = pageProcess.totRecCnt(pag, pageSize, "used", "mid", usedVO.getMid());
		List<UsedVO> usedVOS = usedService.getUsedMidList(usedVO.getMid(),pageVO1.getStartIndexNo(),pageSize);
		
		// 해당 유저가 작성한 게시글 중 판매중인 상품 리스트만 가져오기
		PageVO pageVO2 = pageProcess.totRecCnt(pag, pageSize, "used", "sale", usedVO.getMid());
		List<UsedVO> saleUsedVOS = usedService.getSaleUsedMidList(usedVO.getMid(),pageVO2.getStartIndexNo(),pageSize);
		
		// 카테고리
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
		
		// 팔로워 (해당 상점을 팔로우한 사람)
		List<FollowVO> fVOS = usedService.getFollowerList(usedVO.getMid());
		
		// 해당 상점 팔로우한 사람 확인용 (로그인 한 사람만)
		String mid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		if(!mid.equals("")) {
			FollowVO fVO = usedService.getFollowerMid(mid,usedVO.getMid());
			
			model.addAttribute("fVO",fVO);
		}
		
		// 로그인한 사람이 해당 해당 글을 찜했는지 확인
		LikeVO likeVO = usedService.getUsedContentLikeMidCheck(idx, mid);
		
		model.addAttribute("top",usedVO.getTopCategoryIdx());
		model.addAttribute("mid",usedVO.getMidCategoryIdx());
		model.addAttribute("btm",usedVO.getBtmCategoryIdx());
		model.addAttribute("usedVO",usedVO);
		model.addAttribute("memVO",memVO);
		model.addAttribute("saleUsedVOS",saleUsedVOS);
		model.addAttribute("saleCnt",saleUsedVOS.size());
		model.addAttribute("usedCnt",usedVOS.size());
		model.addAttribute("follower",fVOS.size());
		model.addAttribute("likeVO",likeVO);
		model.addAttribute("topCategoryName",topCategoryName);
		model.addAttribute("midCategoryName",midCategoryName);
		model.addAttribute("btmCategoryName",btmCategoryName);
		return "used/usedContent";
	}
	
	// 팔로우 하기, 팔로우 취소
	@ResponseBody
	@RequestMapping(value = "/usedFollow",method = RequestMethod.POST)
	public String usedFollowPost(String followerMid,String followingMid,String flag) {
		int res = 0;
		if(flag.equals("No")) {
			// 팔로우 게시물 알림이 있으면 모두 삭제
			usedService.setFollowUsedAlarmDel(followerMid,followingMid);
			res = usedService.setFollowDelete(followerMid,followingMid);
		}
		else if(flag.equals("Yes")){
			res = usedService.setFollowInput(followerMid,followingMid);
		}
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 찜 하기, 찜 취소
	@ResponseBody
	@RequestMapping(value = "/likeUpNDel", method = RequestMethod.POST)
	public String likeUpNDelPost(@RequestParam(name="idx",defaultValue = "0",required = false) int idx,
			String mid, String flag) {
		int res = 0;
		if(flag.equals("update")) {
			res = usedService.setLikeInput(idx,mid);
			usedService.setUpdateTotLike(idx);
		}
		else if(flag.equals("delete")){
			res = usedService.setLikeDelete(idx,mid);
			usedService.setDeleteTotLike(idx);
		}
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 상점 화면 이동
	@RequestMapping(value = "/usedStore" ,method = RequestMethod.GET)
	public String usedStoreGet(String mid, Model model,HttpSession session,
			@RequestParam(name="pag",defaultValue = "1",required = false) int pag,
			@RequestParam(name="pageSize",defaultValue = "25",required = false) int pageSize,
			@RequestParam(name="topC",defaultValue = "",required = false) String topC,
			@RequestParam(name="midC",defaultValue = "",required = false) String midC,
			@RequestParam(name="btmC",defaultValue = "",required = false) String btmC
			) {
		
		// 회원 정보
		MemberVO memVO = usedService.getMemberMid(mid);
		// 해당 회원 상점 정보
		StoreVO stVO = usedService.getStoreMid(mid);
		// 팔로잉 리스트 가져오기 (해당 상점이 팔로우한 사람)
		List<FollowVO> fingVOS = usedService.getFollowingAllList(mid);
		
		// 팔로워 (해당 상점을 팔로우한 사람)
		List<FollowVO> ferVOS = usedService.getFollowerList(mid);
		
		// 해당 유저가 작성한 게시글 정보
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "used", "mid",mid);
		List<UsedVO> usedVOS = usedService.getUsedMidList(mid,pageVO.getStartIndexNo(),pageSize);
		
		// 해당 유저가 찜한 개수
		List<LikeVO> likeVOS = usedService.getLikeMid(mid);
		
		
		// 카테고리 가져오기
		// 대분류
		
		// 해당 유저가 작성한 게시글 개수
		int usedCnt  = usedService.getUsedMidListCnt(mid);
		
		// 해당 상점 팔로우한 사람 확인용 (로그인 한 사람만)
		String sMid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		if(!mid.equals("")) {
			FollowVO fVO = usedService.getFollowerMid(sMid,mid);
			
			model.addAttribute("fVO",fVO);
		}
		
		
		model.addAttribute("memVO",memVO);
		model.addAttribute("stVO",stVO);
		model.addAttribute("ferVOS",ferVOS);
		model.addAttribute("ferCnt",ferVOS.size()); // 총 팔로워 수
		model.addAttribute("fingVOS",fingVOS);
		model.addAttribute("fingCnt",fingVOS.size()); // 총 팔로잉 수
		model.addAttribute("usedVOS",usedVOS);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("usedCnt",usedCnt); // 총 상품수
		model.addAttribute("likeCnt",likeVOS.size()); //총 찜 수
		model.addAttribute("topC",topC);
		model.addAttribute("midC",midC);
		model.addAttribute("btmC",btmC);
		
		return "used/usedStore";
	}
	
	// 찜 목록 화면 이동
	@RequestMapping(value = "/usedStoreLike" , method = RequestMethod.GET)
	public String usedStoreLikeGet(String mid, Model model,HttpSession session,
			@RequestParam(name="pag",defaultValue = "1",required = false) int pag,
			@RequestParam(name="pageSize",defaultValue = "25",required = false) int pageSize){
		// 회원 정보
		MemberVO memVO = usedService.getMemberMid(mid);
		// 해당 회원 상점 정보
		StoreVO stVO = usedService.getStoreMid(mid);
		// 팔로잉 리스트 가져오기 (해당 상점이 팔로우한 사람)
		List<FollowVO> fingVOS = usedService.getFollowingAllList(mid);
		
		// 팔로워 (해당 상점을 팔로우한 사람)
		List<FollowVO> ferVOS = usedService.getFollowerList(mid);
		
		// 해당 유저가 작성한 게시글 개수 및 정보
		PageVO pageVO1 = pageProcess.totRecCnt(pag, pageSize, "used", "mid",mid);
		List<UsedVO> usedVOS = usedService.getUsedMidList(mid,pageVO1.getStartIndexNo(),pageSize);
		
		// 해당 유저가 찜한 개수
		List<LikeVO> likeVOS = usedService.getLikeMid(mid);
		
		// 해당 유저가 찜한 게시글
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "usedLike", "",mid);
		List<UsedVO> usedLikeVOS = usedService.getUsedLikeMidList(mid,pageVO.getStartIndexNo(),pageSize);
		

		// 해당 상점 팔로우한 사람 확인용 (로그인 한 사람만)
		String sMid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		if(!mid.equals("")) {
			FollowVO fVO = usedService.getFollowerMid(sMid,mid);
			
			model.addAttribute("fVO",fVO);
		}
		
		// 해당 유저가 작성한 게시글 개수
		int usedCnt  = usedService.getUsedMidListCnt(mid);
		
		model.addAttribute("memVO",memVO);
		model.addAttribute("stVO",stVO);
		model.addAttribute("ferVOS",ferVOS);
		model.addAttribute("ferCnt",ferVOS.size()); // 총 팔로워 수
		model.addAttribute("fingVOS",fingVOS);
		model.addAttribute("fingCnt",fingVOS.size()); // 총 팔로잉 수
		model.addAttribute("usedVOS",usedVOS);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("usedCnt",usedCnt); // 총 상품수
		model.addAttribute("likeCnt",likeVOS.size()); //총 찜 수
		model.addAttribute("usedLikeVOS",usedLikeVOS);
		
		return "used/usedStoreLike";
	}
	
	// 팔로잉 목록 화면 이동
	@RequestMapping(value = "/usedStoreFollowing" , method = RequestMethod.GET)
	public String usedStoreFollowingGet(String mid, Model model,HttpSession session,
			@RequestParam(name="pag",defaultValue = "1",required = false) int pag,
			@RequestParam(name="pageSize",defaultValue = "10",required = false) int pageSize){
		// 회원 정보
		MemberVO memVO = usedService.getMemberMid(mid);
		// 해당 회원 상점 정보
		StoreVO stVO = usedService.getStoreMid(mid);
		//팔로잉 사람 cnt
		List<FollowVO> fingsVOS = usedService.getFollowingAllList(mid);
		// 팔로잉 리스트 가져오기 (해당 상점이 팔로우한 사람)
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "following", "",mid);
		List<FollowVO> fingVOS = usedService.getFollowingList(mid,pageVO.getStartIndexNo(),pageSize);
		// 팔로잉 리스트 가져오기(해당 상점 정보 1. member)
		List<MemberVO> fingMemVOS = usedService.getFollowingMemList(mid);
		// 팔로잉 리스트 가져오기(해당 상점 정보 2. used) 
		List<UsedVO> fingUsedVOS = usedService.getFollowingUsedList(mid);
		
		// 팔로워 (해당 상점을 팔로우한 사람)
		List<FollowVO> ferVOS = usedService.getFollowerList(mid);
		
		// 해당 유저가 작성한 게시글 개수 및 정보
		PageVO pageVO1 = pageProcess.totRecCnt(pag, pageSize, "used", "mid",mid);
		List<UsedVO> usedVOS = usedService.getUsedMidList(mid,pageVO1.getStartIndexNo(),pageSize);
		
		// 해당 유저가 찜한 개수
		List<LikeVO> likeVOS = usedService.getLikeMid(mid);
		
		// 해당 상점 팔로우한 사람 확인용 (로그인 한 사람만)
		String sMid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		if(!mid.equals("")) {
			FollowVO fVO = usedService.getFollowerMid(sMid,mid);
			
			model.addAttribute("fVO",fVO);
		}
		
		// 해당 유저가 작성한 게시글 개수
		int usedCnt  = usedService.getUsedMidListCnt(mid);
		
		model.addAttribute("memVO",memVO);
		model.addAttribute("stVO",stVO);
		model.addAttribute("ferVOS",ferVOS);
		model.addAttribute("ferCnt",ferVOS.size()); // 총 팔로워 수
		model.addAttribute("fingVOS",fingVOS);
		model.addAttribute("fingCnt",fingsVOS.size()); // 총 팔로잉 수
		model.addAttribute("usedVOS",usedVOS);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("usedCnt",usedCnt); // 총 상품수
		model.addAttribute("likeCnt",likeVOS.size()); //총 찜 수
		model.addAttribute("fingMemVOS",fingMemVOS);
		model.addAttribute("fingUsedVOS",fingUsedVOS);
		
		return "used/usedStoreFollowing";
	}

	// 팔로워 목록 화면 이동
	@RequestMapping(value = "/usedStoreFollower" , method = RequestMethod.GET)
	public String usedStoreFollowerGet(String mid, Model model,HttpSession session,
			@RequestParam(name="pag",defaultValue = "1",required = false) int pag,
			@RequestParam(name="pageSize",defaultValue = "25",required = false) int pageSize){
		// 회원 정보
		MemberVO memVO = usedService.getMemberMid(mid);
		// 해당 회원 상점 정보
		StoreVO stVO = usedService.getStoreMid(mid);
		// 팔로잉 리스트 가져오기 (해당 상점이 팔로우한 사람)
		List<FollowVO> fingVOS = usedService.getFollowingAllList(mid);
		
		// 팔로워 (해당 상점을 팔로우한 사람)
		List<FollowVO> ferVOS = usedService.getFollowerList(mid);
		
		// 해당 유저가 작성한 게시글 개수 및 정보
		PageVO pageVO1 = pageProcess.totRecCnt(pag, pageSize, "used", "mid",mid);
		List<UsedVO> usedVOS = usedService.getUsedMidList(mid,pageVO1.getStartIndexNo(),pageSize);
		
		// 해당 유저가 찜한 개수
		List<LikeVO> likeVOS = usedService.getLikeMid(mid);
		
		// 팔로워 정보
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "follower", "",mid);
		List<MemberVO> ferMemVOS = usedService.getFollowerMemList(mid,pageVO.getStartIndexNo(),pageSize);
		
		// 해당 상점 팔로우한 사람 확인용 (로그인 한 사람만)
		String sMid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		if(!mid.equals("")) {
			FollowVO fVO = usedService.getFollowerMid(sMid,mid);
			
			model.addAttribute("fVO",fVO);
		}

		// 해당 유저가 작성한 게시글 개수
		int usedCnt  = usedService.getUsedMidListCnt(mid);
		
		model.addAttribute("memVO",memVO);
		model.addAttribute("stVO",stVO);
		model.addAttribute("ferVOS",ferVOS);
		model.addAttribute("ferCnt",ferVOS.size()); // 총 팔로워 수
		model.addAttribute("fingVOS",fingVOS);
		model.addAttribute("fingCnt",fingVOS.size()); // 총 팔로잉 수
		model.addAttribute("usedVOS",usedVOS);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("usedCnt",usedCnt); // 총 상품수
		model.addAttribute("likeCnt",likeVOS.size()); //총 찜 수
		model.addAttribute("ferMemVOS",ferMemVOS);
		
		return "used/usedStoreFollower";
	}
	
	// 상점관리 목록 화면 이동
	@RequestMapping(value = "/usedStoreManagement" , method = RequestMethod.GET)
	public String usedStoreManagementGet(String mid, Model model,HttpSession session,
			@RequestParam(name="pag",defaultValue = "1",required = false) int pag,
			@RequestParam(name="pageSize",defaultValue = "5",required = false) int pageSize){
		// 회원 정보
		MemberVO memVO = usedService.getMemberMid(mid);
		// 해당 회원 상점 정보
		StoreVO stVO = usedService.getStoreMid(mid);
		// 팔로잉 리스트 가져오기 (해당 상점이 팔로우한 사람)
		List<FollowVO> fingVOS = usedService.getFollowingAllList(mid);
		
		// 팔로워 (해당 상점을 팔로우한 사람)
		List<FollowVO> ferVOS = usedService.getFollowerList(mid);
		
		// 해당 유저가 작성한 게시글 정보
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "used", "mid",mid);
		List<UsedVO> usedVOS = usedService.getUsedMidList(mid,pageVO.getStartIndexNo(),pageSize);
		
		// 해당 유저가 찜한 개수
		List<LikeVO> likeVOS = usedService.getLikeMid(mid);

		// 해당 상점 팔로우한 사람 확인용 (로그인 한 사람만)
		String sMid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		if(!mid.equals("")) {
			FollowVO fVO = usedService.getFollowerMid(sMid,mid);
			
			model.addAttribute("fVO",fVO);
		}

		// 해당 유저가 작성한 게시글 개수
		int usedCnt  = usedService.getUsedMidListCnt(mid);
		
		model.addAttribute("memVO",memVO);
		model.addAttribute("stVO",stVO);
		model.addAttribute("ferVOS",ferVOS);
		model.addAttribute("ferCnt",ferVOS.size()); // 총 팔로워 수
		model.addAttribute("fingVOS",fingVOS);
		model.addAttribute("fingCnt",fingVOS.size()); // 총 팔로잉 수
		model.addAttribute("usedVOS",usedVOS);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("usedCnt",usedCnt); // 총 상품수
		model.addAttribute("likeCnt",likeVOS.size()); //총 찜 수
		
		return "used/usedStoreManagement";
	}
	
	// 내상점 소개 업데이트
	@ResponseBody
	@RequestMapping(value = "/StoreSogeUpdate", method = RequestMethod.POST)
	public String StoreSogeUpdatePost(String storeIntroduce, String mid) {
		storeIntroduce = storeIntroduce.replace("\n", "<br/>");
		
		int res = usedService.setStoreSogeUpdate(storeIntroduce,mid);
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 팔로우 알람 Y N 변경 처리
	@ResponseBody
	@RequestMapping(value = "/followAlarmYN", method = RequestMethod.POST)
	public String followAlarmYNPost(String sMid ,String followingMid, String flag) {
		int res = 0;
		if(flag.equals("N")) {
			res = usedService.setFollowAlarmN(sMid,followingMid);
		}
		else if(flag.equals("Y")) {
			res = usedService.setFollowAlarmY(sMid,followingMid);
		}
		
		if(res != 0 ) return "1";
		else return "2";
	}
	
	// 상점관리- UP 버튼
	@ResponseBody
	@RequestMapping(value = "/usedUpUpdate", method = RequestMethod.POST)
	public String usedUpUpdatePost(@RequestParam(name="idx", defaultValue = "0", required = false) String idx) {

		String[] idxArr = null;
		if(idx.indexOf("/") != -1) {
			idxArr = idx.split("/");
			// Up
			for(int i=0; i<idxArr.length; i++) {
				
				usedService.setUsedUpUpdate(Integer.parseInt(idxArr[i]));
			}
			return "1";
		}
		else {
			usedService.setUsedUpUpdate(Integer.parseInt(idx));
			return "1";
		}
	}
	
	// 상점관리 - 삭제 버튼
	@ResponseBody
	@RequestMapping(value = "/usedIdxDelete", method = RequestMethod.POST)
	public String usedIdxDeletePost(@RequestParam(name="idx", defaultValue = "0", required = false) String idx) {

		String[] idxArr = null;
		if(idx.indexOf("/") != -1) {
			idxArr = idx.split("/");
			// 삭제
			for(int i=0; i<idxArr.length; i++) {
				UsedVO uVO = usedService.getUsedIdx(Integer.parseInt(idxArr[i]));
				
				// 게시물 신고된 거 삭제
				usedService.setUsedReportNoDelete(Integer.parseInt(idxArr[i]));
				
				// 게시물 팔로우 알림 삭제
				usedService.setfollowUsedAlarmDel(Integer.parseInt(idxArr[i]));
				
				// 게시물 삭제
				usedService.setUsedIdxDelete(Integer.parseInt(idxArr[i]),uVO.getImgs());
			}
			return "1";
		}
		else {
			UsedVO uVO = usedService.getUsedIdx(Integer.parseInt(idx));
			usedService.setUsedIdxDelete(Integer.parseInt(idx),uVO.getImgs());
			return "1";
		}
	}
	
	// 상점관리 - 판매상태 업데이트
	@ResponseBody
	@RequestMapping(value = "/stateUpdate",method = RequestMethod.POST)
	public String stateUpdatePost(@RequestParam(name="idx", defaultValue = "0", required = false) int idx,
			String state) {
		System.out.println(state);
		System.out.println(idx);
		int res = usedService.setStateUpdate(idx,state);
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 상세보기 - 신고 처리
	@ResponseBody
	@RequestMapping(value = "/usedReport", method = RequestMethod.POST)
	public String usedReportPost(@RequestParam(name="idx", defaultValue = "0", required = false) int idx,
			String cpWhy, String otherWhy, String mid, String usedMid
			) {
		otherWhy = otherWhy.replace("\n", "<br/>");
		
		int res = 0;
		if(cpWhy.equals("기타")) {
			res = usedService.setUsedReportInput(idx,otherWhy,mid,usedMid);
		}
		else {
			res = usedService.setUsedReportInput(idx,cpWhy,mid,usedMid);
		}
		
		if(res != 0) return "1";
		else return "2";
	}
}
