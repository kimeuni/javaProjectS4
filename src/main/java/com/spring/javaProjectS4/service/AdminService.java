package com.spring.javaProjectS4.service;

import java.util.List;

import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.NoticeVO;

public interface AdminService {

	public List<MemberVO> getMemberList(int startIndexNo, int pageSize);

	public List<MemberVO> getMemberSearchList(String part, String searchString, int startIndexNo, int pageSize);

	public List<MemberVO> getUserDelList(int startIndexNo, int pageSize);

	public void setImgCheck(String content);

	public int setNoticeInput(NoticeVO vo);

	public void setUserAccountDel(String mid);

	public List<NoticeVO> getNoticeAllList(int startIndexNo, int pageSize);

	public NoticeVO getNoticeIdx(int idx);

	public void getImgBackUp(String content);

	public void setImgDelete(String content);

	public int setNoticeUpdate(NoticeVO vo);

}
