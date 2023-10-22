package com.soolwhale.client.image.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.soolwhale.client.image.vo.ImageVO;
import com.soolwhale.client.project.vo.ProjectVO;

@Mapper
public interface ImageDao {
	
	public List<ImageVO> imageList(ImageVO ivo);
	public int multipleImageInsert(@Param("images") List<ImageVO> images);
	
	public List<ImageVO> imgListProject(ProjectVO pvo);
	public int imageDelete(ImageVO ivo);
	public List<ImageVO> imageListByProjectNum(ImageVO ivo);
	public int imageDeleteById(ImageVO image);

}