package com.soolwhale.client.reward.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.soolwhale.client.project.vo.ProjectVO;
import com.soolwhale.client.reward.vo.RewardVO;

@Mapper
public interface RewardDao {
	
	public List<RewardVO> rewardList(RewardVO vo);
	public List<RewardVO> rewardDetail(ProjectVO vo);

	public int rewardInsert(RewardVO rvo);
	public int rewardDelete(RewardVO rvo);
	
	public int deleteRewardById(@Param("rewardId") String rewardId);
}
