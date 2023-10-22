package com.soolwhale.client.image.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soolwhale.client.image.dao.ImageDao;
import com.soolwhale.client.image.vo.ImageVO;
import com.soolwhale.client.project.file.FileUploadUtil;
import com.soolwhale.client.project.vo.ProjectVO;

import lombok.Setter;

@Service
public class ImageServiceImpl implements ImageService {

	
	@Setter(onMethod_=@Autowired)
	private ImageDao imageDao;
	
	@Override
	public List<ImageVO> imgListProject(ProjectVO pvo) {
		List<ImageVO> list =null;
		list = imageDao.imgListProject(pvo);
		return list;
	}
	
	@Override
	public int imageDelete(ImageVO ivo) throws Exception{
		int result = 0;
		result = imageDao.imageDelete(ivo);
		return result;
	}

	@Override
	public List<ImageVO> imageList(ImageVO ivo) {
		List<ImageVO> list=null;
		list = imageDao.imageListByProjectNum(ivo);
		return list;
	}

	@Override
	public int imageDeleteById(ImageVO image) throws Exception {
		int result =0;
		if(!image.getImgFilename().isEmpty()) {
			FileUploadUtil.DetailFileDelete(image.getImgFilename());
		}
		result = imageDao.imageDeleteById(image);
		return result;
	}

}
