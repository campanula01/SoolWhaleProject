package com.soolwhale.admin.manager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soolwhale.admin.manager.service.ManagerService;
import com.soolwhale.admin.manager.vo.ManagerVO;
import com.soolwhale.client.inquiry.service.InquiryService;
import com.soolwhale.client.inquiry.vo.InquiryVO;
import com.soolwhale.client.project.service.ProjectService;
import com.soolwhale.client.project.vo.ProjectVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes("manager")
@RequestMapping("/admin/*")
@Slf4j
public class ManagerController {
	
	@Setter(onMethod_= @Autowired)
	private ManagerService managerService;
	
	@Setter(onMethod_= @Autowired)
	private ProjectService projectService;
	
	@Setter(onMethod_= @Autowired)
	private InquiryService inquiryService;
	
	@GetMapping("/login")
	public String managerLogin() {
		return "/admin/adminLoginForm";
	}
	
	  @GetMapping("/main")
	   public String AnswerList(){
	  
	      return "/admin/adminMain";
	      
	   }
	
	  @GetMapping("/adminAnswer")
	  public String adminAnswer() {
		  return "/admin/adminAnswer";
	  }
	  
	  @GetMapping("/adminMIManager")
	  public String adminMIManager() {
		  return "/admin/adminMIManager";
	  }
	  
	
	@PostMapping("/login")
	public String ManagerloginProcess(ManagerVO login, Model model, RedirectAttributes ras, HttpSession session) {
		ManagerVO managerLogin = managerService.ManagerLoginProcess(login);
		
		if (managerLogin != null) {
			session.setAttribute("login", managerLogin); // 세션에 로그인 정보 저장
			// System.out.println("Returned userLogin object: " + managerLogin);
		     session.setAttribute("managerNum", managerLogin.getManagerNum());
		     // System.out.println("User logged in with userNum: " + userLogin.getUserNum());
			return "redirect:/admin/main"; // 로그인 성공 시 메인 페이지로 이동
		} else {
			ras.addFlashAttribute("errorMsg", "ID와 비밀번호를 확인해주세요");
			return "redirect:/admin/login"; // 로그인 실패 시 로그인 페이지로 이동
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		log.info("manager 로그인 아웃 처리");
		session.invalidate();
		return "redirect:/admin/login";
	}
	
	@GetMapping("/projectManagement")
	public String projectManagement(Model model) {
		List<ProjectVO> projectList = projectService.projectListAll();
		model.addAttribute("projectList",projectList);
		
		return "admin/projectManagement";
	}
	
	
	@GetMapping("/inquiryListManagement")
	public String inquiryListManagement(Model model){
		List<InquiryVO> inquiryList = inquiryService.inquiryList();
		model.addAttribute("inquiryList",inquiryList);
		
		return "admin/inquiryManagement";
		
	}
	
	
	
	

}
