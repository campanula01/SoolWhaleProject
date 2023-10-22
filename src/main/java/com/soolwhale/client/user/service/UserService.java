package com.soolwhale.client.user.service;

import javax.servlet.http.HttpServletResponse;

import com.soolwhale.client.point.vo.PointVO;
import com.soolwhale.client.user.vo.UserVO;

public interface UserService {

	UserVO LoginProcess(UserVO login);
	int JoinProcess(UserVO join);
	boolean checkPhone(String phoneNumber);
	public void checkId(String id, HttpServletResponse response) throws Exception;

	public void checkEmail(String email, HttpServletResponse response) throws Exception;

	
	public int rePwdConfirm(UserVO pass);
	public UserVO myInfoPage(UserVO uvo);
	public int userDelete(UserVO uvo) throws Exception;
	
	public UserVO userData(String userNum);
	
	int joinProcess(UserVO join);
	   public int joinPoint(PointVO pointVO);
	   
	   
			public int myInfoUpdate(UserVO uvo);
			public int upPwdConfirm(UserVO pass);
}
