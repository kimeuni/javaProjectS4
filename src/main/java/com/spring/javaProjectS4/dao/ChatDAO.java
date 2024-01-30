package com.spring.javaProjectS4.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.ChatGroupVO;
import com.spring.javaProjectS4.vo.ChatVO;
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

	public ChatGroupVO getInnerChatInfo(@Param("usedIdx") int usedIdx, @Param("mid") String mid, @Param("sMid") String sMid);

	public List<ChatVO> getChatting(@Param("mid") String mid,@Param("sMid") String sMid);

	public void setUsedIdxUpdateChatG(@Param("usedIdx") int usedIdx,@Param("mid") String mid,@Param("sMid") String sMid);

	public void setChatInput(@Param("chatIdx") int chatIdx,@Param("emoticon") String emoticon,@Param("mid1") String mid1,@Param("mid2") String mid2,@Param("whoMid") String whoMid,@Param("chat") String chat);

	public ArrayList<ChatVO> getChatList(@Param("su") int su,@Param("mid1") String mid1,@Param("mid2") String mid2);

}
