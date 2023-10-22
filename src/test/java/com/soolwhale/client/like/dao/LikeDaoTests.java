package com.soolwhale.client.like.dao;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.soolwhale.client.like.vo.LikeVO;
import com.soolwhale.client.payment.dao.PaymentDao;
import com.soolwhale.client.payment.dao.PaymentDaoTests;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class LikeDaoTests {
	

	@Setter(onMethod_ = @Autowired)
	private LikeDao likeDao;
	
	
	@Test
	public void likeInsert() {
		String projectNum ="1";
		String userNum="1";
		

		int count = likeDao.likeInsert(projectNum, userNum);
		log.info("입력된 행의 수: "+count);
	}
	

}
