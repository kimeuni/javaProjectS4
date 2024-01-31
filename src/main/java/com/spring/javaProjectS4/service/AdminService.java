package com.spring.javaProjectS4.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.vo.AlarmCntVO;
import com.spring.javaProjectS4.vo.AnswerVO;
import com.spring.javaProjectS4.vo.AskVO;
import com.spring.javaProjectS4.vo.BtmCategoryVO;
import com.spring.javaProjectS4.vo.ChatVO;
import com.spring.javaProjectS4.vo.EmoticonVO;
import com.spring.javaProjectS4.vo.EventMailVO;
import com.spring.javaProjectS4.vo.FAQVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;
import com.spring.javaProjectS4.vo.MapVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.MidCategoryVO;
import com.spring.javaProjectS4.vo.NoticeVO;
import com.spring.javaProjectS4.vo.ReasonTitleVO;
import com.spring.javaProjectS4.vo.TopCategoryVO;
import com.spring.javaProjectS4.vo.UsedReportVO;
import com.spring.javaProjectS4.vo.UsedVO;
import com.spring.javaProjectS4.vo.UserReportVO;

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

	public List<MainAdvertisementVO> getAdAllList();

	public MainAdvertisementVO getMainAdIdx(int idx);

	public int setAdOpenSwNo(int idx);

	public MainAdvertisementVO getMainAdOpenSwY();

	public int setAdOpenSwYes(int idx);

	public int setMainAdDelete(int idx);

	public List<EventMailVO> getMailAllList();

	public EventMailVO getEventMailIdx(int idx);

	public int setMailDelete(int idx);

	public List<AskVO> getAskStatusList(int startIndexNo, int pageSize, String status);

	public void setaskStatusNoDel(int idx, String img);

	public AskVO getAskIdx(int idx);

	public UserReportVO getUserAskReport(String part, int partIdx);

	public void setUserReportInput(String part, int partIdx, String mid, String reason);

	public int setMemberReportCntUpdate(String mid);

	public void setAnsInput(int idx, String content);

	public int setAskStatusUpdate(int idx);

	public AnswerVO getAnswerAskIdx(int idx);

	public void setAnsDel(int idx);

	public List<TopCategoryVO> getTopCategoryList();

	public List<MidCategoryVO> getMidCategoryList();

	public List<BtmCategoryVO> getBtmCategoryList();

	public List<MidCategoryVO> getTopMidCategoryList(int top);

	public List<MidCategoryVO> getMidBtmCategoryList(int midCa);

	public List<TopCategoryVO> getTopCategoryTableList(int startIndexNo, int pageSize);

	public void setTopBtmCategoryDel(int idx);

	public void setTopMidCategoryDel(int idx);

	public int setTopCategoryDel(int idx);

	public int setTopCategoryInput(String topCategoryName);

	public List<MidCategoryVO> getMidCategoryTableList(int startIndexNo, int pageSize);

	public int setMidCategoryInput(String midCategoryName, int topCategoryIdx);

	public void setMidBtmCategoryDel(int idx);

	public int setMidCategoryDel(int idx);

	public List<BtmCategoryVO> getBtmCategoryTableList(int startIndexNo, int pageSize);

	public int setBtmCategoryInput(String btmCategoryName, int topCategoryIdx, int midCategoryIdx);

	public int setBtmCategoryDel(int idx);

	public List<UsedReportVO> getUsedReportList(int startIndexNo, int pageSize);

	public int setUsedReportNoDelete(int idx);

	public UsedVO getUsedIdx(int usedIdx);

	public void setUsedIdxDelete(int usedIdx, String imgs);

	public void setfollowUsedAlarmDel(int usedIdx);

	public UsedReportVO getUsedReportIdx(int idx);

	public int getMapInput(MapVO vo);

	public MapVO getMapOne();

	public int setEmoticonInput(MultipartHttpServletRequest img, String imgStr);

	public List<EmoticonVO> getEmoticonList();

	public int setEmoticonDel(int idx, String img);

	public List<MemberVO> getUserReportList(int startIndexNo, int pageSize);

	public void setUserAccountRUpdate(String mid);

	public List<ChatVO> getChattingList(int startIndexNo, int pageSize);

	public void setChattingDel(int idx);

	public MemberVO getMemberRegionCnt();

	public ReasonTitleVO getReasonTitleCnt();

	public AlarmCntVO getAlarmCnt();


}
