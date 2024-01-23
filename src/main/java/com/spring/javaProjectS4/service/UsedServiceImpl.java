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

import com.spring.javaProjectS4.dao.UsedDAO;
import com.spring.javaProjectS4.vo.BtmCategoryVO;
import com.spring.javaProjectS4.vo.FollowUsedAlarmVO;
import com.spring.javaProjectS4.vo.FollowVO;
import com.spring.javaProjectS4.vo.LikeVO;
import com.spring.javaProjectS4.vo.MemberVO;
import com.spring.javaProjectS4.vo.MidCategoryVO;
import com.spring.javaProjectS4.vo.StoreVO;
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

	@Override
	public List<FollowVO> getFollowerList(String mid) {
		return usedDAO.getFollowerList(mid);
	}

	@Override
	public FollowVO getFollowerMid(String mid, String followingMid) {
		return usedDAO.getFollowerMid( mid,followingMid);
	}

	@Override
	public List<UsedVO> getSaleUsedMidList(String mid, int startIndexNo, int pageSize) {
		return usedDAO.getSaleUsedMidList( mid, startIndexNo, pageSize);
	}

	@Override
	public int setFollowInput(String followerMid, String followingMid) {
		return usedDAO.setFollowInput( followerMid, followingMid);
	}

	@Override
	public int setFollowDelete(String followerMid, String followingMid) {
		return usedDAO.setFollowDelete( followerMid, followingMid);
	}

	@Override
	public void setViewCntUpdate(int idx) {
		usedDAO.setViewCntUpdate( idx);
	}

	@Override
	public StoreVO getStoreMid(String mid) {
		return usedDAO.getStoreMid( mid);
	}

	@Override
	public List<FollowVO> getFollowingList(String mid, int startIndexNo, int pageSize) {
		return usedDAO.getFollowingList( mid,startIndexNo,pageSize);
	}

	@Override
	public List<LikeVO> getLikeMid(String mid) {
		return usedDAO.getLikeMid( mid);
	}

	@Override
	public List<FollowVO> getFollowingCheckMid(String mid) {
		return usedDAO.getFollowingCheckMid( mid);
	}

	@Override
	public UsedVO getNowUploadUsed(String mid) {
		return usedDAO.getNowUploadUsed( mid);
	}

	@Override
	public void setFollowUsedAlarmInput(int idx, String followerMid, String mid) {
		usedDAO.setFollowUsedAlarmInput( idx, followerMid,mid);
	}

	@Override
	public FollowVO getFollowCheck(String sMid, String mid) {
		return usedDAO.getFollowCheck( sMid, mid);
	}

	@Override
	public LikeVO getUsedContentLikeMidCheck(int idx, String mid) {
		return usedDAO.getUsedContentLikeMidCheck( idx, mid);
	}

	@Override
	public int setLikeInput(int idx, String mid) {
		return usedDAO.setLikeInput( idx, mid);
	}

	@Override
	public int setLikeDelete(int idx, String mid) {
		return usedDAO.setLikeDelete( idx, mid);
	}

	@Override
	public List<UsedVO> getUsedLikeMidList(String mid, int startIndexNo, int pageSize) {
		return usedDAO.getUsedLikeMidList( mid, startIndexNo, pageSize);
	}

	@Override
	public void setUpdateTotLike(int idx) {
		usedDAO.setUpdateTotLike( idx);
	}

	@Override
	public void setDeleteTotLike(int idx) {
		usedDAO.setDeleteTotLike( idx);
	}

	@Override
	public List<MemberVO> getFollowingMemList(String mid) {
		return usedDAO.getFollowingMemList( mid);
	}

	@Override
	public List<UsedVO> getFollowingUsedList(String mid) {
		return usedDAO.getFollowingUsedList( mid);
	}

	@Override
	public List<FollowVO> getFollowingAllList(String mid) {
		return usedDAO.getFollowingAllList(mid);
	}

	@Override
	public List<MemberVO> getFollowerMemList(String mid, int startIndexNo, int pageSize) {
		return usedDAO.getFollowerMemList( mid, startIndexNo, pageSize);
	}

	@Override
	public int setStoreSogeUpdate(String storeIntroduce, String mid) {
		return usedDAO.setStoreSogeUpdate( storeIntroduce, mid);
	}

	@Override
	public void setFollowUsedAlarmDel(String followerMid, String followingMid) {
		usedDAO.setFollowUsedAlarmDel( followerMid, followingMid);
	}

	@Override
	public int getUsedMidListCnt(String mid) {
		return usedDAO.getUsedMidListCnt( mid);
	}

	@Override
	public int setFollowAlarmN(String sMid, String followingMid) {
		return usedDAO.setFollowAlarmN( sMid, followingMid);
	}

	@Override
	public int setFollowAlarmY(String sMid, String followingMid) {
		return usedDAO.setFollowAlarmY( sMid, followingMid);
	}

	@Override
	public void setUsedUpUpdate(int idx) {
		usedDAO.setUsedUpUpdate(idx);
	}

	@Override
	public void setUsedIdxDelete(int idx, String imgs) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		String[] img = imgs.split("/");
		
		String oFilePath = "";
		
		// 이미지 삭제
		for(int i=0; i<img.length; i++) {
			oFilePath = realPath + "used/" + img[i];
			
			fileDelete(oFilePath);
		}
		usedDAO.setUsedIdxDelete(idx);
	}

	// 이미지 삭제
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int setStateUpdate(int idx, String state) {
		return usedDAO.setStateUpdate( idx, state);
	}

	@Override
	public int setUsedReportInput(int idx, String reason, String mid, String usedMid) {
		return usedDAO.setUsedReportInput( idx, reason, mid, usedMid);
	}

	@Override
	public void setUsedReportNoDelete(int idx) {
		usedDAO.setUsedReportNoDelete( idx);
	}

	@Override
	public void setfollowUsedAlarmDel(int idx) {
		usedDAO.setfollowUsedAlarmDel( idx);
	}
}
