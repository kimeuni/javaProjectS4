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

import com.spring.javaProjectS4.dao.AskDAO;
import com.spring.javaProjectS4.vo.MemberVO;

@Service
public class AskServiceImpl implements AskService {
	@Autowired
	AskDAO askDAO;

	@Override
	public MemberVO getMemberMid(String mid) {
		return askDAO.getMemberMid( mid);
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
			res = askDAO.setAskInput( mid, title, content, category, reportShop, imgStr);
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

}
