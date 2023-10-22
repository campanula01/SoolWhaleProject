package com.soolwhale.client.like.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soolwhale.client.like.dao.LikeDao;
import com.soolwhale.client.like.vo.LikeVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LikeServiceImpl implements LikeService {
	
	@Setter(onMethod_=@Autowired)
	private LikeDao likeDao;
	
	@Override
	public int likeInsert(String projectNum, String userNum) {
		int result = 0;
		result = likeDao.likeInsert(projectNum,userNum);
		return result;
	}

	@Override
	public int likeDelete(String projectNum, String userNum) {
		int result = likeDao.likeDelete(projectNum, userNum);
		
		return result;
	}

	@Override
	public int likeStatus(String projectNum, String userNum) {
		int result = likeDao.likeStatus(projectNum, userNum);
		return result;
	}

	
	@Override
	public List<LikeVO> likeAllList(LikeVO lvo) {
		List<LikeVO> list= null;
		log.info("lvo : " + lvo);
		
		list = likeDao.likeAllList(lvo);
		log.info("likeAllList : " + list );
		
		return list;
	}

	@Override
	public List<LikeVO> likeAfter(LikeVO lvo) {
		List<LikeVO> list=null;
		list = likeDao.likeAfter(lvo);
		return list;
	}

	@Override
	public List<LikeVO> likeBefore(LikeVO lvo) {
		List<LikeVO> list=null;
		list = likeDao.likeBefore(lvo);
		return list;
	}
	
	@Override
	public List<LikeVO> likeIng(LikeVO lvo) {
		List<LikeVO> list=null;
		list = likeDao.likeIng(lvo);
		return list;
	}

	@Override
	public int likeDelete(LikeVO lvo) {
	    int result = 0;
	    String likeNum = lvo.getLikeNum();
	    log.info("LikeNum value: " + likeNum);
	    
	    if (likeNum != null) {
	        result = likeDao.likeDelete(likeNum);
	    }
	    return result;
	}
}
