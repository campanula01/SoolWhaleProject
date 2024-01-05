package com.soolwhale.client.project.dao;

import java.sql.Timestamp;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.soolwhale.client.project.vo.ProjectVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class ProjectDaoTest {
	@Setter(onMethod_ = @Autowired)
	private ProjectDao projectDao;

	@Test
	public void projectListTest() {
	
		List<ProjectVO> list = projectDao.projectListAll();
		for(ProjectVO li:list) {
			log.info(li.toString());
		}
	}
	

	/*
	@Test
	public void recommendList() {
		ProjectVO vo = new ProjectVO();
			List<ProjectVO> pvo = projectDao.recommendRewardList();

			log.info("레코드 조회"+pvo);
		
	}
	*/
	/*
	@Test
	public void executeTimestamp() {
		String projectNum ="2310220915462660";
		
		Timestamp time= projectDao.paymentDate(projectNum);
		
		log.info("시간"+time);
	}
	*/
	@Test
	public void projectCount() {
		String userNum ="U202309222022013";
		
		try {
		    Integer i = projectDao.checkProjectStatus(userNum);
		    log.info("개수" + i);
		} catch (Exception e) {
		    log.error("예외 발생: " + e.getMessage(), e);
		}
	}
}
