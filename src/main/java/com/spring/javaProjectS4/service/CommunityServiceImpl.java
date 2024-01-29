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

import com.spring.javaProjectS4.dao.CommunityDAO;
import com.spring.javaProjectS4.vo.CommunityProfileVO;
import com.spring.javaProjectS4.vo.CommunityVO;
import com.spring.javaProjectS4.vo.FollowVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.ReplyVO;

@Service
public class CommunityServiceImpl implements CommunityService {
	
	@Autowired
	CommunityDAO communityDAO;

	@Override
	public MemberVO getMemberMid(String Mid) {
		return communityDAO.getMemberMid( Mid);
	}

	@Override
	public int setCommunityInput(MultipartHttpServletRequest imgs, String mid, String content, String region, String imgsStr) {
		int res = 0;
		try {
			List<MultipartFile> fileList = imgs.getFiles("imgs");
			String saveFileNames = "";
			
			// 이미지가 들어왔는지 체크
			if(fileList.size() > 0 && !fileList.get(0).getOriginalFilename().equals("")){
				for(MultipartFile file : fileList) {
					String oFileName = file.getOriginalFilename();
					String saveFileName = saveFileName(oFileName);
					
					writeFile(file,saveFileName);
					
					saveFileNames += saveFileName + "/";
				}
				saveFileNames = saveFileNames.substring(0,saveFileNames.length()-1);
			}
			
			imgsStr = saveFileNames;
			
			res = communityDAO.setCommunityInput( mid, content, region, imgsStr);
		} catch (IOException e) {
			System.out.println("IO오류" + e.getMessage());
			e.printStackTrace();
		}
		return res;
	}
	
	// 파일 서버 폴더에 저장
	private void writeFile(MultipartFile file, String saveFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/community/");
		
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
	public List<CommunityVO> getCommunityList(int startIndexNo, int pageSize, String sMid) {
		return communityDAO.getCommunityList( startIndexNo, pageSize,sMid);
	}

	@Override
	public int setGoodYes(int idx, String mid, String part) {
		return communityDAO.setGoodYes( idx, mid, part);
	}

	@Override
	public int setGoodNo(int idx, String mid, String part) {
		return communityDAO.setGoodNo( idx, mid, part);
	}

	@Override
	public int setBookmarkYes(int idx, String mid, String part) {
		return communityDAO.setBookmarkYes( idx, mid, part);
	}

	@Override
	public int setBookmarkNo(int idx, String mid, String part) {
		return communityDAO.setBookmarkNo( idx, mid, part);
	}

	@Override
	public int setReplyInput(int idx, String mid, String content, String part) {
		return communityDAO.setReplyInput( idx, mid, content, part);
	}

	@Override
	public CommunityVO getCommunityIdx(int idx) {
		return communityDAO.getCommunityIdx( idx);
	}

	@Override
	public int setCommunityDel(int idx, String imgs) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		String[] img = imgs.split("/");
		
		String oFilePath = "";
		
		// 이미지 삭제
		if(!imgs.equals("")) {
			for(int i=0; i<img.length; i++) {
				oFilePath = realPath + "community/" + img[i];
				
				fileDelete(oFilePath);
			}
		}
		return communityDAO.setCommunityDel( idx);
	}
	
	// 이미지 삭제
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public void setCommunityReplyAllDel(String part, int idx) {
		communityDAO.setCommunityReplyAllDel( part, idx);
	}

	@Override
	public void setCommunityGoodAllDel(String part, int idx) {
		communityDAO.setCommunityGoodAllDel( part, idx);
	}

	@Override
	public void setCommunityBookmarkDel(String part, int idx) {
		communityDAO.setCommunityBookmarkDel( part, idx);
	}

	@Override
	public CommunityVO getCommunityMidIdx(int idx, String sMid) {
		return communityDAO.getCommunityMidIdx( idx, sMid);
	}

	@Override
	public List<ReplyVO> getCommunityIdxReply(int idx, String sMid) {
		return communityDAO.getCommunityIdxReply( idx, sMid);
	}

	@Override
	public List<ReplyVO> getCommunityIdxReRply(int idx, String sMid) {
		return communityDAO.getCommunityIdxReRply( idx, sMid);
	}

	@Override
	public int setCommunityReplyDel(int idx) {
		return communityDAO.setCommunityReplyDel( idx);
	}

	@Override
	public int setCommunityReRplyInput(int comuIdx, int reIdx, String mid, String content) {
		return communityDAO.setCommunityReRplyInput( comuIdx, reIdx, mid, content);
	}

	@Override
	public int communityReportInput(int idx, String mid, String sMid, String reason, String part) {
		return communityDAO.communityReportInput( idx, mid, sMid, reason, part);
	}

	@Override
	public List<CommunityVO> getCommunityMidList(String mid, String sMid, int startIndexNo, int pageSize) {
		return communityDAO.getCommunityMidList( mid,sMid,startIndexNo,pageSize);
	}

	@Override
	public CommunityProfileVO getCommunityProfileMid(String mid) {
		return communityDAO.getCommunityProfileMid( mid);
	}

	@Override
	public FollowVO getFollowerMid(String sMid, String mid) {
		return communityDAO.getFollowerMid( sMid, mid);
	}

	@Override
	public int getParentsReplyIdx(int idx) {
		return communityDAO.getParentsReplyIdx(idx);
	}

	@Override
	public ReplyVO getCommunityOneIdxReply(int idx) {
		return communityDAO.getCommunityOneIdxReply( idx);
	}

	@Override
	public int getCommunityReplyDelTextUpdate(int idx) {
		return communityDAO.getCommunityReplyDelTextUpdate( idx);
	}

	@Override
	public int setComuProHeaderImgUpdate(MultipartHttpServletRequest headerImgs, String headerImg, String mid) {
		int res = 0;
		try {
			MultipartFile fileImg = headerImgs.getFile("headerImgs");
			
			String saveFileName = "";
			// 저장되는 파일명 중복되지 않도록 처리 (날짜 + 랜덤 2자리 숫자 + 원본 파일명)
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
			UUID uid = UUID.randomUUID();
			String uuid = uid.toString().substring(0,2);
			saveFileName = sdf.format(date) + "_" + uuid + "_" + fileImg.getOriginalFilename();
			
			
			writeFiles(fileImg,saveFileName,"header");
			
			headerImg= saveFileName;
			res = communityDAO.setComuProHeaderImgUpdate(headerImg,mid);
		} catch (IOException e) {
			System.out.println("IO오류" + e.getMessage());
			e.printStackTrace();
		}
		return res;
	}

	private void writeFiles(MultipartFile fileImg, String saveFileName, String str) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = "";
		if(str.equals("header")) {
			realPath = request.getSession().getServletContext().getRealPath("/resources/data/communityProfile/");
		}
		
		byte[] data = fileImg.getBytes();
		FileOutputStream fos = new FileOutputStream(realPath + saveFileName);
		
		fos.write(data);
		fos.close();
		
	}

	@Override
	public void setHeaderImgDel(String headerImg) {
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/communityProfile/");
		String oFilePath = "";
		
		oFilePath = realPath + headerImg;
		
		fileDelete(oFilePath);
		
	}

	@Override
	public int setComuProSogeUpdate(String communityIntroduce, String mid) {
		return communityDAO.setComuProSogeUpdate(communityIntroduce, mid);
	}

	@Override
	public void setFollowUsedAlarmDel(String followerMid, String followingMid) {
		communityDAO.setFollowUsedAlarmDel( followerMid, followingMid);
	}

	@Override
	public int setFollowDelete(String followerMid, String followingMid) {
		return communityDAO.setFollowDelete( followerMid, followingMid);
	}

	@Override
	public int setFollowInput(String followerMid, String followingMid) {
		return communityDAO.setFollowInput( followerMid, followingMid);
	}

	@Override
	public int setFollowAlarmN(String sMid, String followingMid) {
		return communityDAO.setFollowAlarmN( sMid, followingMid);
	}

	@Override
	public int setFollowAlarmY(String sMid, String followingMid) {
		return communityDAO.setFollowAlarmY( sMid, followingMid);
	}

	@Override
	public List<CommunityVO> getComuBookmarkMidList(int startIndexNo, int pageSize, String mid) {
		return communityDAO.getComuBookmarkMidList( startIndexNo, pageSize, mid);
	}

	@Override
	public List<CommunityVO> getComuRegionList(String region, String sMid, int startIndexNo, int pageSize) {
		return communityDAO.getComuRegionList( region,sMid,startIndexNo,pageSize);
	}

	@Override
	public List<FollowVO> getFollowingListMid(String mid) {
		return communityDAO.getFollowingListMid( mid);
	}

	@Override
	public List<FollowVO> getFollowerListMid(String mid) {
		return communityDAO.getFollowerListMid( mid);
	}

	@Override
	public List<CommunityVO> getCommunityMediaMidList(String mid, String sMid, int startIndexNo, int pageSize) {
		return communityDAO.getCommunityMediaMidList( mid, sMid, startIndexNo, pageSize);
	}

	@Override
	public List<CommunityVO> getCommunityGoodMidList(String mid, String sMid, int startIndexNo, int pageSize) {
		return communityDAO.getCommunityGoodMidList( mid, sMid, startIndexNo, pageSize);
	}

	@Override
	public List<CommunityVO> getComuFollowingList(String sMid, int startIndexNo, int pageSize) {
		return communityDAO.getComuFollowingList( sMid, startIndexNo, pageSize);
	}

	
}
