package com.soolwhale.client.reward.dao;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.soolwhale.client.reward.vo.RewardVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class RewardDaoTests {
	
	@Setter(onMethod_=@Autowired)
	private RewardDao rewardDao;
	
	@Test
	public void testRewardList() {
		RewardVO bvo = new RewardVO();
		
		List<RewardVO> list = rewardDao.rewardList(bvo);
		for(RewardVO vo:list) {
			log.info(vo.toString());
			
		}
	}
	

}
