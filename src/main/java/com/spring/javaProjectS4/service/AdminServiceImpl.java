package com.spring.javaProjectS4.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
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

import com.spring.javaProjectS4.dao.AdminDAO;
import com.spring.javaProjectS4.vo.FAQVO;
import com.spring.javaProjectS4.vo.MainAdvertisementVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.NoticeVO;
import com.spring.javaProjectS4.vo.ReasonTitleVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO adminDAO;

	@Override
	public List<MemberVO> getMemberList(int startIndexNo, int pageSize) {
		return adminDAO.getMemberList(startIndexNo, pageSize);
	}

	@Override
	public List<MemberVO> getMemberSearchList(String part, String searchString, int startIndexNo, int pageSize) {
		return adminDAO.getMemberSearchList( part, searchString, startIndexNo, pageSize);
	}

	@Override
	public List<MemberVO> getUserDelList(int startIndexNo, int pageSize) {
		return adminDAO.getUserDelList( startIndexNo, pageSize);
	}

	@Override
	public void setImgCheck(String content, String str) {
		// 임시 파일에 저장된 사진을 실제로 올린 이미지만 저장 처리하는 곳.
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		// src부터 시작하여 임시 파일 저장된 곳의 파일 이름 시작 index 번호
		int position = 34;
		
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		String copyFilePath = "";
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String origFilePath = realPath + "ckeditor/" + imgFile;
			if(str.equals("notice")) {
				copyFilePath = realPath + "notice/" + imgFile;
			}
			else if(str.equals("eventEmail")) {
				copyFilePath = realPath + "mail/" + imgFile;
			}
			
			fileCopyCheck(origFilePath,copyFilePath); // ckeditor에 있는 그림 board에 복사 처리
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			
		}
	}

	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] bytes = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(bytes)) != -1) {
				fos.write(bytes,0,cnt);
			}
			
			fos.flush();
			fos.close();
			fis.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public int setNoticeInput(NoticeVO vo) {
		return adminDAO.setNoticeInput(vo);
	}

	@Override
	public void setUserAccountDel(String mid) {
		adminDAO.setUserAccountDel(mid);		
	}

	@Override
	public List<NoticeVO> getNoticeAllList(int startIndexNo, int pageSize) {
		return adminDAO.getNoticeAllList(startIndexNo, pageSize);
	}

	@Override
	public NoticeVO getNoticeIdx(int idx) {
		return adminDAO.getNoticeIdx(idx);
	}

	@Override
	public void getImgBackUp(String content, String str) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 0;
		if(str.equals("notice")) {
			position = 32;
		}
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		String origFilePath = "";
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			if(str.equals("notice")) {
				origFilePath = realPath + "notice/" + imgFile;
			}
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/")+position);
		}
		
	}

	@Override
	public void setImgDelete(String content, String str) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 0;
		if(str.equals("notice")) {
			position = 32;
		}
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		String origFilePath = "";
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			if(str.equals("notice")) {
				origFilePath = realPath + "notice/" + imgFile;
			}
			
			fileDelete(origFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/")+position);
		}
	}

	// 이미지 삭제
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int setNoticeUpdate(NoticeVO vo) {
		return adminDAO.setNoticeUpdate(vo);
	}

	@Override
	public void setNoticeDel(int idx) {
		adminDAO.setNoticeDel(idx);
	}

	@Override
	public int setFAQInput(FAQVO vo) {
		return adminDAO.setFAQInput(vo);
	}

	@Override
	public List<FAQVO> getFAQAllList(int startIndexNo, int pageSize) {
		return adminDAO.getFAQAllList( startIndexNo, pageSize);
	}

	@Override
	public FAQVO getFAQIdx(int idx) {
		return adminDAO.getFAQIdx(idx);
	}

	@Override
	public void setFAQDel(int idx) {
		adminDAO.setFAQDel(idx);
	}

	@Override
	public int setFAQUpdate(FAQVO vo) {
		return adminDAO.setFAQUpdate(vo);
	}

	@Override
	public List<String> getAdYEmailList() {
		return adminDAO.getAdYEmailList();
	}

	@Override
	public void setEventEmailSave(String title, String content, String fName) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 30;
		
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		// fName에 저장할 이미지 이름 저장
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			
			fName += imgFile + "/";
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/")+position);
		}
		
		fName = fName.substring(0,fName.length()-1);
		
		adminDAO.setEventEmailSave( title, content, fName);
	}

	@Override
	public void setUserShowDelMid(String mid) {
		adminDAO.setUserShowDelMid(mid);
	}

	@Override
	public List<ReasonTitleVO> getReasonTitleList() {
		return adminDAO.getReasonTitleList();
	}

	@Override
	public int setDelTitleInput(String code, String title, String displayNone) {
		return adminDAO.setDelTitleInput(code, title, displayNone);
	}

	@Override
	public int setReasonTitleDel(String code) {
		return adminDAO.setReasonTitleDel(code);
	}

	@Override
	public void setUserDelReasonDel(String code) {
		adminDAO.setUserDelReasonDel(code);
	}

	@Override
	public int setDisplayNoneUpdate(String displayNone, String code) {
		return adminDAO.setDisplayNoneUpdate(displayNone, code);
	}

	@Override
	public int setAdInput(String mImg, String url, MultipartHttpServletRequest mainImg) {
		System.out.println("서비스");
		int res = 0;
		try {
			MultipartFile fileImg = mainImg.getFile("mainImg");
			
			String saveFileName = "";
			// 저장되는 파일명 중복되지 않도록 처리 (날짜 + 랜덤 2자리 숫자 + 원본 파일명)
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
			UUID uid = UUID.randomUUID();
			String uuid = uid.toString().substring(0,2);
			saveFileName = sdf.format(date) + "_" + uuid + "_" + fileImg.getOriginalFilename();
			
			
			writeFile(fileImg,saveFileName);
			
			mImg= saveFileName;
			System.out.println(mImg);
			res = adminDAO.setAdInput(mImg, url);
		} catch (IOException e) {
			System.out.println("IO오류" + e.getMessage());
			e.printStackTrace();
		}
		return res;
		
	}

	// 파일 서버 폴더에 저장
	private void writeFile(MultipartFile fileImg, String saveFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/advertisement/");
		
		byte[] data = fileImg.getBytes();
		FileOutputStream fos = new FileOutputStream(realPath + saveFileName);
		
		fos.write(data);
		fos.close();
	}


}
