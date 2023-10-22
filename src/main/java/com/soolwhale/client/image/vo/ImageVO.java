package com.soolwhale.client.image.vo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ImageVO {
	private String detailImgNum;		//상세이미지번호
	private String projectNum;			//플젝번호
	private String registrationDate;	//등록일시
	private String imgFilename;			//실제 이미지파일명
	private String imgFile;				//이미지파일
	
	private List<MultipartFile> files;	//파일 업로드를 위한필드
	
	public ImageVO() {
		files = new ArrayList<MultipartFile>();
	}
}
