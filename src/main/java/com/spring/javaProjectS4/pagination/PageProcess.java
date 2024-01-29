package com.spring.javaProjectS4.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS4.dao.AdminDAO;
import com.spring.javaProjectS4.dao.BoardDAO;
import com.spring.javaProjectS4.dao.CommunityDAO;
import com.spring.javaProjectS4.dao.MemberDAO;
import com.spring.javaProjectS4.dao.UsedDAO;

@Service
public class PageProcess {
	@Autowired
	AdminDAO adminDAO;
	
	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	UsedDAO usedDAO;
	
	@Autowired
	CommunityDAO communityDAO;
	
	// section = 게시판, 자료실 현재 글 위치
	// part = ex)자료실 안에 들어있는 카테고리
	public PageVO totRecCnt(int pag,int pageSize,String section,String part,String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0; //초기값
		String search = "";
		
		if(section.equals("adminMemberList")) {
			if(part.equals("")) {
				totRecCnt = adminDAO.getMemberAllTotRecCnt();
			}
			else {
				totRecCnt = adminDAO.getMemberSearchTotRecCnt(part,searchString);
			}
		}
		if(section.equals("notice")) {
			if(part.equals("")) {
				totRecCnt = boardDAO.getNoticeAllTotRecCnt();
			}
			else if(part.equals("main")) {
				totRecCnt = boardDAO.getNoticeOpenSwYTotRecCnt();
			}
			else {
				totRecCnt = boardDAO.getNoticeSearchTotRecCnt(part,searchString);
			}
		}
		if(section.equals("adminUserDelList")) {
			totRecCnt = adminDAO.getUserDelTotRecCnt();
		}
		if(section.equals("FAQ")) {
			if(part.equals("")) {
				totRecCnt = boardDAO.getFAQAllTotRecCnt();
			}
			else if(part.equals("category")) {
				totRecCnt = boardDAO.getFAQCategoryTotRecCnt(searchString);
			}
			else if(part.equals("string")) {
				totRecCnt = boardDAO.getFAQStringTotRecCnt(searchString);
			}
		}
		if(section.equals("myAskList")) {
			if(part.equals("")) {
				//searchString에 세션 mid 들어있음
				totRecCnt = memberDAO.getMyAskListTotRecCnt(searchString);
			}
			else if(part.equals("답변대기") || part.equals("답변완료")) {
				totRecCnt = memberDAO.getMyAskListSearchTotRecCnt(part,searchString);
			}
		}
		if(section.equals("askAdmin")) {
			if(part.equals("답변대기") || part.equals("답변완료")) {
				totRecCnt = adminDAO.getAskStatusRecCnt(part);
			}
		}
		if(section.equals("used")) {
			if(part.equals("")) {
				totRecCnt = usedDAO.getUsedAllRecCnt();
			}
			else if(part.equals("mid")) {
				totRecCnt = usedDAO.getUsedMidRecCnt(searchString);
			}
			else if(part.equals("sale")) {
				totRecCnt = usedDAO.getSaleUsedMidRecCnt(searchString);
			}
		}
		if(section.equals("usedLike")) {
			if(part.equals("")) {
				totRecCnt = usedDAO.getUsedLikeMidRecCnt(searchString);
			}
		}
		if(section.equals("following")) {
			if(part.equals("")) {
				totRecCnt = usedDAO.getFollowingMidRecCnt(searchString);
			}
		}
		if(section.equals("follower")) {
			if(part.equals("")) {
				totRecCnt = usedDAO.getFollowerMidRecCnt(searchString);
			}
		}
		if(section.equals("topCategory")) {
			if(part.equals("")) {
				totRecCnt = adminDAO.getTopCategoryRecCnt();
			}
		}
		if(section.equals("midCategory")) {
			if(part.equals("")) {
				totRecCnt = adminDAO.getMidCategoryRecCnt();
			}
		}
		if(section.equals("btmCategory")) {
			if(part.equals("")) {
				totRecCnt = adminDAO.getBtmCategoryRecCnt();
			}
		}
		if(section.equals("usedReport")) {
			if(part.equals("")) {
				totRecCnt = adminDAO.getUsedReportRecCnt();
			}
		}
		if(section.equals("community")) {
			if(part.equals("")) {
				totRecCnt = communityDAO.getCommunityRecCnt();
			}
		}
		if(section.equals("communityProfile")) {
			if(part.equals("")) {
				totRecCnt = communityDAO.getCommunityMidRecCnt(searchString);
			}
			else if(part.equals("Media")) {
				totRecCnt = communityDAO.getCommunityMediaMidRecCnt(searchString);
			}
			else if(part.equals("good")) {
				totRecCnt = communityDAO.getCommunityGoodMidRecCnt(searchString);
			}
		}
		if(section.equals("bookmark")) {
			if(part.equals("")) {
				totRecCnt = communityDAO.getCommunityBookmarkMidRecCnt(searchString);
			}
		}
		if(section.equals("comuRegion")) {
			if(part.equals("")) {
				totRecCnt = communityDAO.getComuRegionRecCnt(searchString);
			}
		}
		
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		//--------------------------------------------------------------------
		int blockSize = 3;
		int curBlock = (pag-1)/blockSize;
		int lastBlock = (totPage-1)/blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		pageVO.setPart(part);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		return pageVO;
	}
	
}
