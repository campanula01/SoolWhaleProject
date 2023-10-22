package com.soolwhale.client.point.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.soolwhale.client.point.service.PointService;
import com.soolwhale.client.point.vo.PointVO;
import com.soolwhale.client.user.service.UserService;
import com.soolwhale.client.user.vo.UserVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes("point")
@RequestMapping("/member/*")
@Slf4j
public class PointController {


	@Setter(onMethod_ = @Autowired)
	private PointService pointService;
	
	@Setter(onMethod_ = @Autowired)
	private UserService userService;
	
	@GetMapping(value="/pointCheck")
	public String pointCheck() {
		log.info("pointCheck 화면 호출");
		
		return "client/member/pointCheck";
	};
	
	

	@GetMapping(value="/pointCheckList")
	public String pointCheckList(Model model, @SessionAttribute("user") UserVO user, PointVO pvo) {
	
		log.info("pointCheck 화면 호출");
	    if (user != null) {
	        pvo.setUser(user);
	        pvo.setUserNum(user.getUserNum());
	    	user.setUserNum(user.getUserNum());
	      
	    	log.info("uerNum" + pvo.getUserNum());
	    	 List<PointVO> pointcheck = pointService.pointCheckList(pvo.getUserNum());
	    	
	        PointVO pointsum = pointService.pointSum(user.getUserNum());
	    
	        
	        log.info("pointcheck : {}", pointcheck);
	    	log.info("pointsum 값은" +  pointsum + "입니다.");
			model.addAttribute("pointcheck", pointcheck);
			model.addAttribute("pointSum" , pointsum);

			  log.info("Controller userNum 값  " + user.getUserNum());

	        return "client/member/pointCheck"; // 로그인 상태이므로 원하는 페이지로 리디렉션
	    } else {
	        // 세션에 로그인 정보가 없음
	        return "redirect:/member/login"; // 로그인 페이지로 리디렉션
	    }
			
	}
	
	
	
	
	
	
}
