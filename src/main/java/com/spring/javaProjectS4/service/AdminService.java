package com.spring.javaProjectS4.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.vo.FAQVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.NoticeVO;
import com.spring.javaProjectS4.vo.ReasonTitleVO;

public interface AdminService {

	public List<MemberVO> getMemberList(int startIndexNo, int pageSize);

	public List<MemberVO> getMemberSearchList(String part, String searchString, int startIndexNo, int pageSize);

	public List<MemberVO> getUserDelList(int startIndexNo, int pageSize);

	public void setImgCheck(String content, String str);

	public int setNoticeInput(NoticeVO vo);

	public void setUserAccountDel(String mid);

	public List<NoticeVO> getNoticeAllList(int startIndexNo, int pageSize);

	public NoticeVO getNoticeIdx(int idx);

	public void getImgBackUp(String content, String str);

	public void setImgDelete(String content, String str);

	public int setNoticeUpdate(NoticeVO vo);

	public void setNoticeDel(int idx);

	public int setFAQInput(FAQVO vo);

	public List<FAQVO> getFAQAllList(int startIndexNo, int pageSize);

	public FAQVO getFAQIdx(int idx);

	public void setFAQDel(int idx);

	public int setFAQUpdate(FAQVO vo);

	public List<String> getAdYEmailList();

	public void setEventEmailSave(String title, String content, String fName);

	public void setUserShowDelMid(String mid);

	public List<ReasonTitleVO> getReasonTitleList();

	public int setDelTitleInput(String code, String title, String displayNone);

	public int setReasonTitleDel(String code);

	public void setUserDelReasonDel(String code);

	public int setDisplayNoneUpdate(String displayNone, String code);

	public int setAdInput(String mImg, String url, MultipartHttpServletRequest mainImg);


}
