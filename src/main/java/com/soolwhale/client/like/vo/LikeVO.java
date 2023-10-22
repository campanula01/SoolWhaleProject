package com.soolwhale.client.like.vo;

import com.soolwhale.client.project.vo.ProjectVO;
import com.soolwhale.client.user.vo.UserVO;

import lombok.Data;

@Data
public class LikeVO {
	private String likeNum;
	private String projectNum;
	private String userNum;
	
	
	
	private ProjectVO project;
	private UserVO user;
}
