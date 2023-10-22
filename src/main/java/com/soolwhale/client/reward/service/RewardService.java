package com.soolwhale.client.reward.service;

import java.util.List;

import com.soolwhale.client.project.vo.ProjectVO;
import com.soolwhale.client.reward.vo.RewardVO;

public interface RewardService {
	
	public List<RewardVO> rewardList(RewardVO vo);
	public List<RewardVO> rewardList2(RewardVO vo);
	public List<RewardVO> rewardDetail(ProjectVO vo);
	
	public int rewardInsert(RewardVO rvo);

	public int rewardDelete(RewardVO rvo);

	public boolean deleteRewardById(String rewardId);

}
