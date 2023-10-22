package com.soolwhale.client.like.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soolwhale.client.like.service.LikeService;
import com.soolwhale.client.like.vo.LikeVO;
import com.soolwhale.client.user.vo.UserVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller

@RequestMapping("/supporter/*")
@Slf4j
public class LikeController {
	
	@Setter(onMethod_ = @Autowired)
	private LikeService likeService;
	
	@GetMapping(value="/soolLike")
	public String soolLike() {
		log.info("soolLike 화면 호출");
		
		return "client/supporter/soolLike";
	}
	
	
	@PostMapping("/likeInsert")
	public String likeInsert(@Param("projectNum") String projectNum,@SessionAttribute("login") String userNum) {
		log.info("likeInsert!");
		
		
	    
		likeService.likeInsert(projectNum, userNum);
		
		return "/client/funding/fundingDetail";
	}
	
	@PostMapping("/likeDelete")
	public String likeDelete(@ModelAttribute LikeVO lvo, RedirectAttributes ras,@RequestParam("projectNum") String projectNum, @SessionAttribute("login") String userNum) throws Exception {
		log.info("likeDelete 호출 성공");

		int result= likeService.likeDelete(projectNum, userNum);

		return "/client/funding/fundingDetail";
	}
	
	
	
	
	@PostMapping("/likeStatus")
	public ResponseEntity<Integer> likeStatus(@RequestParam("projectNum") String projectNum, HttpSession session) {
		String userNum = (String) session.getAttribute("login");
		System.out.println(userNum);
		
		 if (userNum == null) {
		        // 로그인 객체가 null인 경우 적절한 응답을 반환합니다. 
		        // 예: 권한이 없음을 나타내는 상태 코드를 반환합니다.
			 return new ResponseEntity<>(3, HttpStatus.OK);
		    }
		int result = likeService.likeStatus(projectNum, userNum);
	    return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	
	
	

	
	@GetMapping(value="/likeAllList")
	public String likeAllList(@ModelAttribute LikeVO lvo, Model model, 
			@SessionAttribute(name = "user", required = false)UserVO user,
			HttpSession session) {
		log.info("likeAll 호출");
		log.info("session" + session);
		
		if (user != null) {
			lvo.setUserNum(user.getUserNum()); 
			
		List<LikeVO> likeAllList = likeService.likeAllList(lvo);
		user.setUserNum(user.getUserNum());
		log.info("LikeAllList-true : " + likeAllList );
		
		model.addAttribute("likeAllList", likeAllList);
		model.addAttribute("userNum" , user.getUserNum());
		
		return "client/supporter/soolLike";
		
		}else {
	        // 세션에 로그인 정보가 없음
	        return "redirect:/member/login"; // 로그인 페이지로 리디렉션
	    }
	
	}

	@GetMapping(value="/likeAfter")
	public String likeAfter(@ModelAttribute LikeVO lvo, Model model,
			@SessionAttribute(name = "user", required = false)UserVO user,
			HttpSession session) {
		log.info("likeAfter 호출");
		
		if(user != null) {
			lvo.setUserNum(user.getUserNum());
		List<LikeVO> likeAfter = likeService.likeAfter(lvo);
		
		model.addAttribute("likeAfter", likeAfter);
		
		
		return "client/supporter/soolLikeafter";
		}
		else {
	        // 세션에 로그인 정보가 없음
	        return "redirect:/member/login"; // 로그인 페이지로 리디렉션
	    }
	
	}
	
	@GetMapping(value="/likeBefore")
	public String likeBefore(@ModelAttribute LikeVO lvo, Model model,
			@SessionAttribute(name = "user", required = false)UserVO user,
			HttpSession session) {
		log.info("likeBefore 호출");
		
		if(user != null ) {
			lvo.setUserNum(user.getUserNum());
		List<LikeVO> likeBefore = likeService.likeBefore(lvo);
		
		model.addAttribute("likeBefore", likeBefore);
		
		
		return "client/supporter/soolLikebefore";
		}
		else {
	        // 세션에 로그인 정보가 없음
	        return "redirect:/member/login"; // 로그인 페이지로 리디렉션
	    }
	}
	
	@GetMapping(value="/likeIng")
	public String likeIng(@ModelAttribute LikeVO lvo, Model model,
			@SessionAttribute(name = "user", required = false)UserVO user,
			HttpSession session) {
		log.info("likeIng 호출");
		
		 if(user != null) {
			 lvo.setUserNum(user.getUserNum());
		List<LikeVO> likeIng = likeService.likeIng(lvo);
		
		model.addAttribute("likeIng", likeIng);
		
		
		return "client/supporter/soolLikeing";
		 }else {
		        // 세션에 로그인 정보가 없음
		        return "redirect:/member/login"; // 로그인 페이지로 리디렉션
		    }
	
	}
	
}
