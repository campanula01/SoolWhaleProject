package com.soolwhale.client.img.dao;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.soolwhale.client.image.dao.ImageDao;
import com.soolwhale.client.image.vo.ImageVO;
import com.soolwhale.client.project.vo.ProjectVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class ImageDaoTests {

	@Setter(onMethod_=@Autowired)
	private ImageDao imageDao;
	
	@Test
	public void testimgList() {
		ProjectVO pvo = new ProjectVO();
		pvo.setProjectNum("1");
		List<ImageVO> list = imageDao.imgListProject(pvo);
		log.info(list.toString());
	}
	
}
