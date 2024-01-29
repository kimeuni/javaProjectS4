package com.spring.javaProjectS4.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS4.vo.ChatGroupVO;
import com.spring.javaProjectS4.vo.EmoticonVO;

public interface ChatDAO {

	public List<EmoticonVO> getEmoticonList();

	public ChatGroupVO getChatGroupCheck(@Param("usedIdx") int usedIdx,@Param("mid") String mid,@Param("sMid") String sMid);

}
