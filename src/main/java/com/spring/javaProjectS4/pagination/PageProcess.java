package com.spring.javaProjectS4.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS4.dao.AdminDAO;
import com.spring.javaProjectS4.dao.BoardDAO;

@Service
public class PageProcess {
	@Autowired
	AdminDAO adminDAO;
	
	@Autowired
	BoardDAO boardDAO;
	
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
