package com.spring.javaProjectS4.service;

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

import com.spring.javaProjectS4.dao.HomeDAO;
import com.spring.javaProjectS4.vo.UserShowAdvertisementVO;
import com.spring.javaProjectS4.vo.ChatGroupVO;
import com.spring.javaProjectS4.vo.FollowUsedAlarmVO;
import com.spring.javaProjectS4.vo.LikeVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;
import com.spring.javaProjectS4.vo.MapVO;
import com.spring.javaProjectS4.vo.MemberVO;

@Service
public class HomeServiceImpl implements HomeService {
	
	@Autowired
	HomeDAO homeDAO;

	@Override
	public MainAdvertisementVO getMainAdOpen() {
		return homeDAO.getMainAdOpen();
	}

	@Override
	public UserShowAdvertisementVO getUserShowAd(String mid) {
		return homeDAO.getUserShowAd(mid);
	}

	@Override
	public void setAlarmUpdateN(String mid) {
		homeDAO.setAlarmUpdateN(mid);
	}
	

	@Override
	public MemberVO getMemberMid(String mid) {
		return homeDAO.getMemberMid( mid);
	}


	@Override
	public int setAskInput(String mid, String title, String content, MultipartHttpServletRequest imgs, String category,
			String reportShop, String imgStr) {
		int res = 0;
		try {
			MultipartFile fileImg = imgs.getFile("imgs");
			
			String saveFileName = "";
			// 저장되는 파일명 중복되지 않도록 처리 (날짜 + 랜덤 2자리 숫자 + 원본 파일명)
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
			UUID uid = UUID.randomUUID();
			String uuid = uid.toString().substring(0,2);
			saveFileName = sdf.format(date) + "_" + uuid + "_" + fileImg.getOriginalFilename();
			
			
			writeFile(fileImg,saveFileName);
			
			if(saveFileName.indexOf(".jpg") != -1 || saveFileName.indexOf(".png") != -1 || saveFileName.indexOf(".jpeg") != -1 || saveFileName.indexOf(".gif") != -1) {
				imgStr= saveFileName;
			}
			else imgStr = "";
			res = homeDAO.setAskInput( mid, title, content, category, reportShop, imgStr);
		} catch (IOException e) {
			System.out.println("IO오류" + e.getMessage());
			e.printStackTrace();
		}
		return res;
	}
	
	// 중복 방지 이름
	private String saveFileName(String oFileName) {
		// 저장되는 파일명 중복되지 않도록 처리 (날짜 + 랜덤 2자리 숫자 + 원본 파일명)
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		UUID uid = UUID.randomUUID();
		String uuid = uid.toString().substring(0,2);
		oFileName = sdf.format(date) + "_" + uuid + "_" + oFileName;
		
		return oFileName;
	}

	private void writeFile(MultipartFile file, String saveFileName) throws IOException {
		if(saveFileName.indexOf(".jpg") != -1 || saveFileName.indexOf(".png") != -1 || saveFileName.indexOf(".jpeg") != -1 || saveFileName.indexOf(".gif") != -1) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ask/");
			
			byte[] data = file.getBytes();
			FileOutputStream fos = new FileOutputStream(realPath + saveFileName);
			
			fos.write(data);
			fos.close();
		}
	}

	@Override
	public MapVO getMapOne() {
		return homeDAO.getMapOne();
	}

	@Override
	public List<LikeVO> getLikeAlarm(String alarmMyMid) {
		return homeDAO.getLikeAlarm( alarmMyMid);
	}

	@Override
	public List<FollowUsedAlarmVO> getFollowUsedAlarm(String alarmMyMid) {
		return homeDAO.getFollowUsedAlarm( alarmMyMid);
	}

	@Override
	public List<ChatGroupVO> getReportShopList(String mid) {
		return homeDAO.getReportShopList( mid);
	}

	@Override
	public void geterror() {
		homeDAO.geterror();
	}

}
