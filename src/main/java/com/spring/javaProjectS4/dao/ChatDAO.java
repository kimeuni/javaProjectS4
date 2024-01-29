package com.spring.javaProjectS4.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.ChatGroupVO;
import com.spring.javaProjectS4.vo.EmoticonVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.UsedVO;

public interface ChatDAO {

	public List<EmoticonVO> getEmoticonList();

	public ChatGroupVO getChatGroupCheck(@Param("usedIdx") int usedIdx,@Param("mid") String mid,@Param("sMid") String sMid);

	public void setChatGroupInput(@Param("usedIdx") int usedIdx,@Param("mid") String mid,@Param("sMid") String sMid);

	public UsedVO getUsedIdx(@Param("usedIdx") int usedIdx);

	public void setFirstChat(@Param("title") String title,@Param("mid") String mid,@Param("sMid") String sMid,@Param("whoMid") String whoMid,@Param("idx") int idx);

	public List<ChatGroupVO> getChatGroupList(@Param("myMid") String myMid);

	public MemberVO getMemberMid(@Param("mid") String mid);

}
