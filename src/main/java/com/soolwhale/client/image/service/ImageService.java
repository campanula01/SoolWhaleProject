package com.soolwhale.client.image.service;

import java.util.List;

import com.soolwhale.client.image.vo.ImageVO;
import com.soolwhale.client.project.vo.ProjectVO;

public interface ImageService {
	public List<ImageVO> imgListProject(ProjectVO pvo);
	public int imageDelete(ImageVO ivo) throws Exception;
	public List<ImageVO> imageList(ImageVO ivo);
	public int imageDeleteById(ImageVO image) throws Exception;
}
