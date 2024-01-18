package com.spring.javaProjectS4.service;

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

import com.spring.javaProjectS4.dao.UsedDAO;
import com.spring.javaProjectS4.vo.BtmCategoryVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.MidCategoryVO;
import com.spring.javaProjectS4.vo.TopCategoryVO;
import com.spring.javaProjectS4.vo.UsedVO;

@Service
public class UsedServiceImpl implements UsedService {
	
	@Autowired
	UsedDAO usedDAO;

	@Override
	public List<TopCategoryVO> getTopCategoryList() {
		return usedDAO.getTopCategoryList();
	}

	@Override
	public List<MidCategoryVO> getMidCategoryList() {
		return usedDAO.getMidCategoryList();
	}

	@Override
	public List<BtmCategoryVO> getBtmCategoryList() {
		return usedDAO.getBtmCategoryList();
	}

	@Override
	public int setUsedInput(MultipartHttpServletRequest imgs, String imgsStr, String title, int topCategoryIdx,
			int midCategoryIdx, int btmCategoryIdx, String usedState, String exchange, int money, int delivery,
			String content, String mid, String region) {
		int res = 0;
		try {
			List<MultipartFile> fileList = imgs.getFiles("imgs");
			String saveFileNames = "";
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String saveFileName = saveFileName(oFileName);
				
				writeFile(file,saveFileName);
				
				saveFileNames += saveFileName + "/";
			}
			saveFileNames = saveFileNames.substring(0,saveFileNames.length()-1);
			
			imgsStr = saveFileNames;
			
			res = usedDAO.setUsedInput(imgsStr, title, topCategoryIdx,midCategoryIdx, btmCategoryIdx, usedState, exchange, money, delivery, content, mid, region);
		} catch (IOException e) {
			System.out.println("IO오류" + e.getMessage());
			e.printStackTrace();
		}
		return res;
	}
	// 파일 서버 폴더에 저장
	private void writeFile(MultipartFile file, String saveFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/used/");
		
		byte[] data = file.getBytes();
		FileOutputStream fos = new FileOutputStream(realPath + saveFileName);
		
		fos.write(data);
		fos.close();
		
	}

	// 파일명 중복방지를 위하여, 서버에 저장될 실제 파일명 만들기
	private String saveFileName(String oFileName) {
		String fileName = "";
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		UUID uid = UUID.randomUUID();
		String uuid = uid.toString().substring(0,2);
		fileName = sdf.format(date) + "_" + uuid + "_" + oFileName;
		
		return fileName;
	}

	@Override
	public MemberVO getMemberMid(String mid) {
		return usedDAO.getMemberMid(mid);
	}


	@Override
	public List<UsedVO> getUsedAllList(int startIndexNo, int pageSize) {
		return usedDAO.getUsedAllList( startIndexNo, pageSize);
	}

	@Override
	public UsedVO getUsedIdx(int idx) {
		return usedDAO.getUsedIdx( idx);
	}

	@Override
	public List<UsedVO> getUsedMidList(String mid, int startIndexNo, int pageSize) {
		return usedDAO.getUsedMidList( mid, startIndexNo, pageSize);
	}
}
