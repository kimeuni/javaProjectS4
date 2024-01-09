package com.spring.javaProjectS4.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.NoticeVO;

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

}
