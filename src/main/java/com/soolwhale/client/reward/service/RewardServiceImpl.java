package com.soolwhale.client.reward.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soolwhale.client.project.vo.ProjectVO;
import com.soolwhale.client.reward.dao.RewardDao;
import com.soolwhale.client.reward.vo.RewardVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class RewardServiceImpl implements RewardService{

	@Setter(onMethod_=@Autowired)
	private RewardDao rewardDao;
	
	@Override
	public List<RewardVO> rewardList(RewardVO vo) {
		List<RewardVO> list = null;
		list = rewardDao.rewardList(vo);
		return list;
	}
	
	@Override
	public List<RewardVO> rewardList2(RewardVO vo) {
		List<RewardVO> list = null;
		list = rewardDao.rewardList(vo);
		return list;
	}
	
	@Override
	public int rewardInsert(RewardVO rvo) {
		int result = 0;
		result = rewardDao.rewardInsert(rvo);
		return result;
	}

	@Override
	public List<RewardVO> rewardDetail(ProjectVO vo) {
		List<RewardVO> list = null;
		list = rewardDao.rewardDetail(vo);
		return list;
	}
	
	@Override
	public int rewardDelete(RewardVO rvo) {
		int result = 0;
		result = rewardDao.rewardDelete(rvo);
		return result;
	}

	@Override
	public boolean deleteRewardById(String rewardId) {
	    try {
	    	log.info("리워드아이디!!"+rewardId);
	        int result = rewardDao.deleteRewardById(rewardId);
	        return result > 0;
	    } catch (Exception e) {
	        log.info("리워드 삭제 오류", e);
	        return false;
	    }
	}

	
	

}
