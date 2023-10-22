package com.soolwhale.client.user.service;


import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soolwhale.client.point.vo.PointVO;
import com.soolwhale.client.user.dao.UserDao;
import com.soolwhale.client.user.vo.UserVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserServiceImpl implements UserService {

    @Setter(onMethod_ = @Autowired)
    private UserDao userDao;

    @Override
    public UserVO LoginProcess(UserVO login) {
        UserVO userLogin = userDao.loginProcess(login);

        return userLogin;
    }

    @Override
    public int JoinProcess(UserVO join) {
        int result = userDao.joinProcess(join);
        // 회원 가입 성공 시 양수의 정수 반환, 실패 시 0 또는 음수 반환
        return result;
    }

	@Override
	public boolean checkPhone(String phoneNumber) {
	    return userDao.checkPhone(phoneNumber) > 0;
	}
    
	public void checkId(String id, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		out.println(userDao.checkId(id));
		out.close();
	}

	// 이메일 중복 검사(AJAX)
	@Override
	public void checkEmail(String email, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		out.println(userDao.checkEmail(email));
		out.close();
	}


	

	
	

	@Override
	public UserVO userData(String userNum) {
		UserVO uvo = userDao.userData(userNum);
		return uvo;
	}

	 private boolean isJoinPointCalled = false; // 중복 호출 방지 플래그
	   @Override
	    public int joinProcess(UserVO join) {
	        int result = userDao.joinProcess(join);

	        if (result > 0) { // 회원가입 성공 시
	            // 회원에게 3000 포인트 추가
	            PointVO pointVO = new PointVO();
	            pointVO.setPointSum("3000"); // pointSum은 String 타입
	            
	            // 회원가입 후에 생성된 userNum을 가져와서 pointVO에 설정
	            String userNum = join.getUserNum(); // 혹은 userNum을 가져올 수 있는 방법을 사용
	            pointVO.setUserNum(userNum);
	            
	            // 필요한 경우, 다른 필드들도 설정해주세요.

	            // 중복 호출 방지 로직
	            if (!isJoinPointCalled) {
	                userDao.joinPoint(pointVO);
	                isJoinPointCalled = true; // 호출되었음을 표시
	            }
	        }

	        return result;
	    }

	    @Override
	    public int joinPoint(PointVO pointVO) {
	        return userDao.joinPoint(pointVO);
	    }

	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
			@Override
			public int rePwdConfirm(UserVO pass) {
				int result = 0;
				
				result = userDao.rePwdConfirm(pass);
				
				return result;
			}

			@Override
			public UserVO myInfoPage(UserVO uvo) {
				
				
				UserVO userData = userDao.myInfoPage(uvo);

				
				return userData;
				
			}

			@Override
			public int userDelete(UserVO uvo) {
				int result = 0;
				result = userDao.userDelete(uvo);
				return result;
			}
		

			@Override
			public int myInfoUpdate(UserVO uvo) {
				log.info("update");
				int result = 0;
				result = userDao.myInfoUpdate(uvo);
				
				return result;
			}
			@Override
			public int upPwdConfirm(UserVO pass) {
				log.info("kjdlfjksjfl");
				int result = 0;
				
				result = userDao.rePwdConfirm(pass);
				
				return result;
			}

	    
	    
	    
	    
	    

}
