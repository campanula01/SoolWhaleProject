package com.soolwhale.client.project.vo;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.soolwhale.client.image.vo.ImageVO;
import com.soolwhale.client.reward.vo.RewardVO;

import lombok.Data;

@Data
public class ProjectVO {
	private String projectNum;	//프로젝트 번호
	private String title;	//제목
	private String projectDesc;	 //요약,설명 wDesc
	private String firstImgFilename = "";	//대표 이미지 파일명(진짜 파일명)
	private MultipartFile firstImg;	//대표 이미지 명 (파일 업로드를 위한 필드)
	private String firstVideo;	//대표 영상 파일명(진짜 파일명)
	private MultipartFile firstVideoFile;	//대표영상파일 필드
	private String targetAmount;	//목표 금액
	private String startDate;	//시작일
	private String endDate;	//종료일
	private String sts;	//진행현황
	private String createDate;	//생성일시
	private String liquorType;	//주종
	private String pModifyDate;	//수정일시
	private String makerName;	//창작자 이름
	private String makerDesc;	//창작자(메이커) 소개
	private String userNum;	//사용자 
	private String profilImgFilename = "";	//창작자 프로필 이미지 파일명(진짜 파일명)
	private MultipartFile profilImg;	//창작자 프로필 이미지(파일 업로드를 위한 필드)

	private String payDate;
	private Timestamp executeTimestamp;
	private String remainDate;
	private List<RewardVO> reward;
	
	private List<ImageVO> images;
	
	public ProjectVO() {
		images = new ArrayList<ImageVO>();
	}
	
}
