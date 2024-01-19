package com.spring.javaProjectS4.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS4.dao.MemberDAO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.ReasonTitleVO;
import com.spring.javaProjectS4.vo.UserShowAdvertisementVO;
import com.spring.javaProjectS4.vo.AnswerVO;
import com.spring.javaProjectS4.vo.AskVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getMemberMidCheck(String mid) {
		return memberDAO.getMemberMidCheck(mid);
	}

	@Override
	public MemberVO getMemberNickNameCheck(String nickName) {
		return memberDAO.getMemberNickNameCheck(nickName);
	}

	@Override
	public List<MemberVO> getMemberEmailCheck(String email) {
		return memberDAO.getMemberEmailCheck(email);
	}

	@Override
	public int setMemberJoin(MemberVO vo) {
		return memberDAO.setMemberJoin(vo);
	}

	@Override
	public void setKakaoMemberInput1(String mid, String pwd, String nickName, String email) {
		memberDAO.setKakaoMemberInput1( mid,  pwd,  nickName,  email);
	}

	@Override
	public MemberVO getMemberEmailTokenCheck(String email, String token) {
		return memberDAO.getMemberEmailTokenCheck(email, token);
	}

	@Override
	public int setKakaoFirstUpdatInfor(String mid, String address, String gender, String email, String adYN) {
		return memberDAO.setKakaoFirstUpdatInfor( mid, address, gender, email, adYN);
	}

	@Override
	public void setKakaoMemberInput2(String mid, String pwd, String name, String email, String newNickName) {
		memberDAO.setKakaoMemberInput2(mid, pwd, name, email, newNickName);
	}

	@Override
	public MemberVO getMemberMidEmailCheck(String mid, String email) {
		return memberDAO.getMemberMidEmailCheck(mid,email);
	}

	@Override
	public void setMemberPwdUpdate(String mid, String pwd) {
		memberDAO.setMemberPwdUpdate(mid,pwd);
	}

	@Override
	public void setUpdateLastDate(String mid) {
		memberDAO.setUpdateLastDate(mid);
	}

	@Override
	public List<ReasonTitleVO> getTitleList() {
		return memberDAO.getTitleList();
	}

	@Override
	public void setUserDelUpdateY(String mid) {
		memberDAO.setUserDelUpdateY(mid);
	}

	@Override
	public void setUserDelReason(String whyDel, String why) {
		memberDAO.setUserDelReason(whyDel, why);
	}

	@Override
	public int setUserDelUpdateN(String mid, String token) {
		return memberDAO.setUserDelUpdateN(mid, token);
	}

	@Override
	public int setInfoUpdate(String mid, String name, String nickName, String email, String address) {
		return memberDAO.setInfoUpdate( mid, name, nickName, email, address);
	}

	@Override
	public UserShowAdvertisementVO getUserShowAdMid(String mid) {
		return memberDAO.getUserShowAdMid(mid);
	}

	@Override
	public int setLoginDateUpdatMid(String mid) {
		return memberDAO.setLoginDateUpdatMid(mid);
	}

	@Override
	public void setAlarmYUpdate(String mid) {
		memberDAO.setAlarmYUpdate(mid);
	}

	@Override
	public MainAdvertisementVO getMainAdOpen() {
		return memberDAO.getMainAdOpen();
	}

	@Override
	public void setMainAdInputMid(String mid) {
		memberDAO.setMainAdInputMid(mid);
	}

	@Override
	public List<AskVO> getMyAskList(int startIndexNo, int pageSize, String mid) {
		return memberDAO.getMyAskList(startIndexNo,pageSize,mid);
	}

	@Override
	public AskVO getAskIdx(int idx) {
		return memberDAO.getAskIdx( idx);
	}

	@Override
	public AnswerVO getAnswerAskIdx(int idx) {
		return memberDAO.getAnswerAskIdx( idx);
	}

	@Override
	public List<AskVO> getMyAskListSearch(int startIndexNo, int pageSize, String mid, String part) {
		return memberDAO.getMyAskListSearch( startIndexNo, pageSize, mid, part);
	}

	@Override
	public int setAdYNUpdate(String adYN, String mid) {
		return memberDAO.setAdYNUpdate( adYN, mid);
	}

	@Override
	public void origProfileDel(String oProfile) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		String oFilePath = "";
		
		oFilePath = realPath + "member/" + oProfile;
		
		fileDelete(oFilePath);
	}
	
	// 이미지 삭제
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int setProfileUpdate(MultipartHttpServletRequest profile, String profileStr, String mid) {
		int res = 0;
		try {
			MultipartFile fileImg = profile.getFile("profile");
			
			String saveFileName = "";
			// 저장되는 파일명 중복되지 않도록 처리 (날짜 + 랜덤 2자리 숫자 + 원본 파일명)
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
			UUID uid = UUID.randomUUID();
			String uuid = uid.toString().substring(0,2);
			saveFileName = sdf.format(date) + "_" + uuid + "_" + fileImg.getOriginalFilename();
			
			
			writeFile(fileImg,saveFileName);
			
			profileStr= saveFileName;
			res = memberDAO.setProfileUpdate(profileStr,mid);
		} catch (IOException e) {
			System.out.println("IO오류" + e.getMessage());
			e.printStackTrace();
		}
		return res;
	}
	

	// 파일 서버 폴더에 저장
	private void writeFile(MultipartFile fileImg, String saveFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/member/");
		
		byte[] data = fileImg.getBytes();
		FileOutputStream fos = new FileOutputStream(realPath + saveFileName);
		
		fos.write(data);
		fos.close();
	}

	@Override
	public int setProfileNoImgUpdate(String profile, String mid) {
		return memberDAO.setProfileNoImgUpdate( profile, mid);
	}

	@Override
	public void setUsedStoreInput(String mid) {
		memberDAO.setUsedStoreInput( mid);
	}

}
