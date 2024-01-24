package com.spring.javaProjectS4.controller;

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
import com.spring.javaProjectS4.service.CommunityService;
import com.spring.javaProjectS4.vo.CommunityVO;
import com.spring.javaProjectS4.vo.MemberVO;

@Controller
@RequestMapping("/community")
public class CommunityController {

	@Autowired
	CommunityService communityService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 커뮤니티 메인화면 이동
	@RequestMapping(value = "/communityMain", method = RequestMethod.GET)
	public String communityMainGet(Model model,HttpSession session,
			@RequestParam(name="pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name="pageSize",defaultValue = "2",required = false)int pageSize
			) {
		// 로그인한 사람의 아이디로 계정 정보 가져오기
		String sMid = session.getAttribute("sMid")== null ? "" : (String)session.getAttribute("sMid");
		
		MemberVO memVO = communityService.getMemberMid(sMid);
		// 지역 찾기 (서울/충남/충북 등..)
		if(!sMid.equals("")) {
			MemberVO mVO = communityService.getMemberMid(sMid);
			String [] region1 = null;
			region1 = mVO.getAddress().split("/");
			String[] region2 = region1[1].split(" ");
			String region = region2[0];
			
			model.addAttribute("region",region);
		}
		
		// 등록한 게시글 가져오기
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "community", "", "");
		List<CommunityVO> comVOS = communityService.getCommunityList(pageVO.getStartIndexNo(),pageSize,sMid);
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("comVOS",comVOS);
		model.addAttribute("memVO",memVO);
		return "community/communityMain";
	}
	
	// 커뮤니티 글 등록처리
	@RequestMapping(value = "/communityMain",method = RequestMethod.POST)
	public String communityMainPost(MultipartHttpServletRequest imgs,
			@RequestParam(name="mid",defaultValue = "",required = false)String mid,
			@RequestParam(name="content",defaultValue = "",required = false)String content
			) {
		// 지역 찾기 (서울/충남/충북 등..)
		MemberVO mVO = communityService.getMemberMid(mid);
		String [] region1 = null;
		region1 = mVO.getAddress().split("/");
		String[] region2 = region1[1].split(" ");
		String region = region2[0];
		
		content = content.replace("<", "&lt;");
		content = content.replace(">", "&gt;");
		content = content.replace("\n", "<br/>");
		
		String imgsStr = "";
		// 등록하기
		int res = communityService.setCommunityInput(imgs,mid,content,region,imgsStr);
		
		if(res != 0) return "redirect:/message/communityInputY";
		else return "redirect:/message/communityInputN"; 
	}
	
	// 좋아요 하기 및 취소
	@ResponseBody
	@RequestMapping(value = "/communityGood", method = RequestMethod.POST)
	public String communityGoodPost(@RequestParam(name="idx",defaultValue = "",required = false)int idx,
			String mid, String flag, String part
			) {
		int res = 0;
		
		// 좋아요 누르기 yes / 취소 no
		if(flag.equals("yes")) {
			res = communityService.setGoodYes(idx,mid,part);
		}
		else if(flag.equals("no")) {
			res = communityService.setGoodNo(idx,mid,part);
		}
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 북마크 하기 및 취소
	@ResponseBody
	@RequestMapping(value = "/communityBookmark", method = RequestMethod.POST)
	public String communityBookmarkPost(@RequestParam(name="idx",defaultValue = "",required = false)int idx,
			String mid, String flag, String part
			) {
		int res = 0;
		
		// 북마크 누르기 yes / 취소 no
		if(flag.equals("yes")) {
			res = communityService.setBookmarkYes(idx,mid,part);
		}
		else if(flag.equals("no")) {
			res = communityService.setBookmarkNo(idx,mid,part);
		}
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 커뮤니티 댓글 달기
	@ResponseBody
	@RequestMapping(value = "/communityReplyInput", method = RequestMethod.POST)
	public String communityReplyInputPost(@RequestParam(name="idx",defaultValue = "",required = false)int idx,
			String mid, String content) {
		
		content = content.replace("<", "&lt;");
		content = content.replace(">", "&gt;");
		content = content.replace("\n", "<br/>");
		int res = communityService.setReplyInput(idx,mid,content,"community");
		
		if(res != 0) return "1";
		else return "2";
	}
	
	// 커뮤니티 글 삭제
	@ResponseBody
	@RequestMapping(value = "/communityDel", method = RequestMethod.POST)
	public String communityDelPost(@RequestParam(name="idx",defaultValue = "",required = false)int idx) {
		CommunityVO comVO = communityService.getCommunityIdx(idx);
		
		// 댓글 삭제
		communityService.setCommunityReplyAllDel("community",idx);
		
		// 좋아요 삭제
		communityService.setCommunityGoodAllDel("community",idx);
		
		// 북마크 삭제
		communityService.setCommunityBookmarkDel("community",idx);
		
		// 게시글 삭제
		int res = communityService.setCommunityDel(idx,comVO.getImgs());
		
		if(res != 0) return "1";
		else return "2";
	}
}
