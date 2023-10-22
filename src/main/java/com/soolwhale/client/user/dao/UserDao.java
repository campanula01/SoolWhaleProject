package com.soolwhale.client.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.soolwhale.client.point.vo.PointVO;
import com.soolwhale.client.user.vo.UserVO;

@Mapper
public interface UserDao {

	
	
	
	public UserVO loginProcess(UserVO login);
	public List<UserVO> UserList();
	public int joinProcess(UserVO join);
	public int checkPhone(String phoneNumber);
    int checkId(String id);
    int checkEmail(String email);

	public int rePwdConfirm(UserVO pass);
	public UserVO myInfoPage(UserVO uvo);
	public int userDelete(UserVO uvo) ;
	public int myInfoUpdate(UserVO uvo);
	public int upPwdConfirm(UserVO pass);
	
	public UserVO userData(String userNum);

     int joinPoint(PointVO pointVO);
}

