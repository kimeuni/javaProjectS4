package com.spring.javaProjectS4.pagination;

import org.springframework.stereotype.Service;

// 일하는 애니까.. 일하는 애인지 알려주기 위한 서비스 붙여주기..
@Service
public class PageProcess {
	// 필요한 자료 스캔
	
	
	
	// section = 게시판, 자료실 현재 글 위치
	// part = ex)자료실 안에 들어있는 카테고리
	public PageVO totRecCnt(int pag,int pageSize,String section,String part,String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0; //초기값
		String search = "";
		
		if(section.equals("board")) {
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
