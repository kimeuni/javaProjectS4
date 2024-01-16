package com.spring.javaProjectS4.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.vo.AnswerVO;
import com.spring.javaProjectS4.vo.AskVO;
import com.spring.javaProjectS4.vo.EventMailVO;
import com.spring.javaProjectS4.vo.FAQVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.NoticeVO;
import com.spring.javaProjectS4.vo.ReasonTitleVO;
import com.spring.javaProjectS4.vo.UserReportVO;

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

	public List<MainAdvertisementVO> getAdAllList();

	public MainAdvertisementVO getMainAdIdx(@Param("idx") int idx);

	public int setAdOpenSwNo(@Param("idx") int idx);

	public MainAdvertisementVO getMainAdOpenSwY();

	public int setAdOpenSwYes(@Param("idx") int idx);

	public int setMainAdDelete(@Param("idx") int idx);

	public List<EventMailVO> getMailAllList();

	public EventMailVO getEventMailIdx(@Param("idx") int idx);

	public int setMailDelete(@Param("idx") int idx);

	public List<AskVO> getAskStatusList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("status") String status);

	public int getAskStatusRecCnt(@Param("part") String part);

	public void setaskStatusNoDel(@Param("idx") int idx);

	public AskVO getAskIdx(@Param("idx") int idx);

	public UserReportVO getUserAskReport(@Param("part") String part,@Param("partIdx") int partIdx);

	public void setUserReportInput(@Param("part") String part,@Param("partIdx") int partIdx,@Param("mid") String mid,@Param("reason") String reason);

	public int setMemberReportCntUpdate(@Param("mid") String mid);

	public void setAnsInput(@Param("idx") int idx,@Param("content") String content);

	public int setAskStatusUpdate(@Param("idx") int idx);

	public AnswerVO getAnswerAskIdx(@Param("idx") int idx);

	public void setAnsDel(@Param("idx") int idx);



}
