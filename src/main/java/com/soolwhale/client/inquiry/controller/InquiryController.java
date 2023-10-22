package com.soolwhale.client.inquiry.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soolwhale.client.inquiry.service.InquiryService;

import com.soolwhale.client.inquiry.vo.InquiryVO;
import com.soolwhale.client.user.service.UserService;
import com.soolwhale.client.user.vo.UserVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member/*")
@Slf4j
public class InquiryController {

	
	@Setter(onMethod_ = @Autowired)
	private InquiryService inquiryService;
	
	
	@Setter(onMethod_ = @Autowired)
	private UserService userService;
	

	

	

	@GetMapping(value="/questionList")
	public String inquirylist(Model model, @SessionAttribute(name = "user", required = false)UserVO user,  InquiryVO ivo,HttpSession session ) {
	     
		//UserVO users = (UserVO) session.getAttribute("user");
		System.out.println("questionList 호출 성공");
		System.out.println("user : " + user);
		
	    if (user != null) {
	
	    	ivo.setUser(user);
	    	ivo.setUserNum(user.getUserNum());
			        
	        List<InquiryVO> inquiryList = inquiryService.inquiryList(ivo);
	        
	       log.info("리스트 확인 : {}", inquiryList);
			model.addAttribute("inquiryList", inquiryList);
			model.addAttribute("user" , user);
			model.addAttribute("userNum", user.getUserNum());
			return "client/member/questionList"; // 로그인 상태이므로 원하는 페이지로 리디렉션
	    } else {
	        // 세션에 로그인 정보가 없음
	        return "redirect:/member/login"; // 로그인 페이지로 리디렉션
	    }
	}
	
	
	@GetMapping("/questionForm")
	public String questionForm(Model model, @SessionAttribute(name = "user", required = false)UserVO user,  InquiryVO ivo,HttpSession session ) {
		log.info("questionForm 호출 성공");
		
		
		System.out.println("user : " + user);
		model.addAttribute("user" , user);
		
		if(user != null) {
		
		return "client/member/questionForm";
		}
		else {
			return "redirect:/member/login";
		}
	}
	
	
	
	
	@GetMapping(value="/questionInsert")
	public String inquiryInsert(InquiryVO ivo, Model model,  @SessionAttribute(name = "user", required = false)UserVO user, HttpSession session) throws Exception{
		log.info("questionInsert 화면 호출");
	
		if(user != null) {
		int result = 0;
		String url = "";
		
		result = inquiryService.inquiryInsert(ivo);
		ivo.setUser(user);
		if(result == 1) {
			url = "/member/questionList";
		}else {
			url = "/client/member/questionForm";
			
		}
		return "redirect:"+url;
		}
		else {
			return "redirect:/member/login";
		}
		
	}	
	@GetMapping("/questionDetail")
	public String inquiryDetail(@ModelAttribute InquiryVO ivo, Model model,@SessionAttribute(name = "user", required = false)UserVO user, HttpSession session ) {
		
	
	    if (user != null) {
	    	
			log.info("inquiryDetail 메서드 호출 성공");
			log.info("uvo" + user);
		
			
			InquiryVO inquiry = inquiryService.inquiryDetail(ivo);
			ivo.setUser(user);
			ivo.setUserNum(user.getUserNum());
			ivo.setInquiryNum(ivo.getInquiryNum());
			log.info("ivo : " + ivo );
			model.addAttribute("user", user); // user 객체를 모델에 추가
			model.addAttribute("inquiry", inquiry);
			model.addAttribute("iquNum" , ivo.getInquiryNum());
			model.addAttribute(user.getUserNum());
			model.addAttribute(ivo.getUserNum());
			
			return "/client/member/questionDetail";
	        
	        // 로그인 상태이므로 원하는 페이지로 리디렉션
	    } else {
	        // 세션에 로그인 정보가 없음
	        return "redirect:/member/login"; // 로그인 페이지로 리디렉션
	    }
	}
	
	
	@GetMapping(value = "/questionUpdate")
	public String inquiryUpdate(@ModelAttribute InquiryVO ivo,  @SessionAttribute("user") UserVO user )  throws Exception {
		log.info("inquiryUpdate 호출 성공 ");
		log.info("inquiry_num :" + ivo.getInquiryNum());
		
		int result = 0;
		String url="";
		ivo.setUser(user);
		
		result = inquiryService.inquiryUpdate(ivo);
		
		if(result == 1 ) {
			url = "client/member/questionList";
		}else {
			url = "client/member/questionDetail";
		}
		
		
		return "redirect:" + url;
	}

	@GetMapping(value = "/questionUpdateform")
	public String inquiryUpdateForm(@ModelAttribute InquiryVO ivo, 
			@SessionAttribute(name = "user", required = false)UserVO user, 
			HttpSession session , Model model,
			@RequestParam("inquiryNum") String inquiryNum)  throws Exception {
		
		log.info("updateForm 호출!");
		log.info("inquiryNum = " + ivo.getInquiryNum());
		
		
		InquiryVO updateData = inquiryService.updateForm(ivo);
		
		ivo.setInquiryQ(ivo.getInquiryQ());
		ivo.setInquiryTitle(ivo.getInquiryTitle());
		model.addAttribute("updateData", updateData);
		model.addAttribute("inquiryQ", ivo.getInquiryQ());
		model.addAttribute("inquiryTitle", ivo.getInquiryTitle());
		model.addAttribute("inquiryNum", inquiryNum);
		
		
		
		return "client/member/questionUpdate";
	}
	
	
	@GetMapping(value = "/inquiryUpdate")
	public String inquiryUpdate(@ModelAttribute InquiryVO ivo,
			@SessionAttribute(name = "user", required = false)UserVO user,
			HttpSession session,Model model,
			@RequestParam("inquiryNum") String inquiryNum
			)  throws Exception {
		
		
		log.info("inquiryUpdate 호출 성공 ");
		log.info("inquiry_num :" +inquiryNum);
	
		if(user != null) {
		
		
		int result = 0;
		ivo.setUser(user);
		ivo.setInquiryNum(inquiryNum);
		ivo.setInquiryQ(ivo.getInquiryQ());
		ivo.setInquiryTitle(ivo.getInquiryTitle());
		ivo.setCat(ivo.getCat());
		ivo.setUserType(ivo.getUserType());
		ivo.setUserNum(ivo.getUserNum());
		log.info("ivo", ivo);
		log.info("ivo: {}", ivo);
		model.addAttribute("inquiryQ", ivo.getInquiryQ());
		model.addAttribute("inquiryTitle", ivo.getInquiryTitle());
		model.addAttribute("cat", ivo.getCat());
		model.addAttribute("userType", ivo.getUserType());
		model.addAttribute("userNum", ivo.getUserNum());
		
		
		
		result = inquiryService.inquiryUpdate(ivo);
		
		if(result == 1 ) {
			return  "redirect:/member/questionList";
		}else {
			log.info("수정안됨" );
			return "client/member/questionUpdate";
		}
		
		
		
		} else {
	        // 세션에 로그인 정보가 없음
	        return "redirect:/member/login"; // 로그인 페이지로 리디렉션
	    }
			
	}
	@GetMapping("/questionDelete")
	public String questionDelete(@ModelAttribute InquiryVO ivo,
			@SessionAttribute(name = "user", required = false)UserVO user,
			HttpSession session,Model model,
			@RequestParam("inquiryNum") String inquiryNum
			) throws Exception {
		
		log.info("questionDelete 호출 성공");
		
		if(user != null) {
		
		int result=0;
		String url ="";
		
		result = inquiryService.questionDelete(ivo);
		
		
		if(result == 1) {
			return  "client/member/questionList";
		}else {
			return "client/member/questionUpdate";
		}	
		}
		 else {
		        // 세션에 로그인 정보가 없음
		        return "redirect:/member/login"; // 로그인 페이지로 리디렉션
		    }
		
	}
}

