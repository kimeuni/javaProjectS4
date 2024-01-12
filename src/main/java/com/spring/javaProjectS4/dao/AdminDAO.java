package com.spring.javaProjectS4.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.vo.FAQVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.NoticeVO;
import com.spring.javaProjectS4.vo.ReasonTitleVO;

public interface AdminDAO {

	public List<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int getMemberAllTotRecCnt();

	public int getMemberSearchTotRecCnt(@Param("part") String part,@Param("searchString") String searchString);

	public List<MemberVO> getMemberSearchList(@Param("part") String part,@Param("searchString") String searchString,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public List<MemberVO> getUserDelList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int getUserDelTotRecCnt();

	public int setNoticeInput(@Param("vo") NoticeVO vo);

	public void setUserAccountDel(@Param("mid") String mid);

	public List<NoticeVO> getNoticeAllList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public NoticeVO getNoticeIdx(@Param("idx") int idx);

	public int setNoticeUpdate(@Param("vo") NoticeVO vo);

	public void setNoticeDel(@Param("idx") int idx);

	public int setFAQInput(@Param("vo") FAQVO vo);

	public List<FAQVO> getFAQAllList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public FAQVO getFAQIdx(@Param("idx") int idx);

	public void setFAQDel(@Param("idx") int idx);

	public int setFAQUpdate(@Param("vo") FAQVO vo);

	public List<String> getAdYEmailList();

	public void setEventEmailSave(@Param("title") String title,@Param("content") String content,@Param("fName") String fName);

	public void setUserShowDelMid(@Param("mid") String mid);

	public List<ReasonTitleVO> getReasonTitleList();

	public int setDelTitleInput(@Param("code") String code,@Param("title") String title,@Param("displayNone") String displayNone);

	public int setReasonTitleDel(@Param("code") String code);

	public void setUserDelReasonDel(@Param("code") String code);

	public int setDisplayNoneUpdate(@Param("displayNone") String displayNone,@Param("code") String code);

	public int setAdInput(@Param("mImg") String mImg,@Param("url") String url);


}
