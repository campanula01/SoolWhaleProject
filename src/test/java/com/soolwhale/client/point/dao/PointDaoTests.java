package com.soolwhale.client.point.dao;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.soolwhale.client.point.vo.PointVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class PointDaoTests {
	
	@Setter(onMethod_ = @Autowired)
	private PointDao pointDao;
	/*
	@Test
	public void pointInsert() {
		PointVO vo = new PointVO();
		vo.setPointSum("10000");

		int count = pointDao.pointInsert(vo);
		log.info("입력된 행의 수: "+count);
	}
	*/
	
	@Test
	public void pointsum() {
		PointVO vo = pointDao.pointSum("U2023091911432215");
		log.info("pointvo"+vo);
	}

}
