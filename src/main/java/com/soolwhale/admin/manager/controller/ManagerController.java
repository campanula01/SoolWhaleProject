package com.soolwhale.admin.manager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soolwhale.admin.manager.service.ManagerService;
import com.soolwhale.admin.manager.vo.ManagerVO;
import com.soolwhale.client.inquiry.service.InquiryService;
import com.soolwhale.client.inquiry.vo.InquiryVO;
import com.soolwhale.client.payment.service.PaymentService;
import com.soolwhale.client.payment.vo.PaymentVO;
import com.soolwhale.client.project.service.ProjectService;
import com.soolwhale.client.project.vo.ProjectVO;
import com.soolwhale.client.user.service.UserService;
import com.soolwhale.client.user.vo.UserVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes("manager")
@RequestMapping("/admin/*")
@Slf4j
public class ManagerController {

	@Setter(onMethod_ = @Autowired)
	private ManagerService managerService;

	@Setter(onMethod_ = @Autowired)
	private ProjectService projectService;

	@Setter(onMethod_ = @Autowired)
	private InquiryService inquiryService;

	@Setter(onMethod_ = @Autowired)
	private UserService userService;
	
	@Setter(onMethod_ = @Autowired)
	private PaymentService paymentService;

	@GetMapping("/login")
	public String managerLogin() {
		return "/admin/adminLoginForm";
	}

	@GetMapping("/main")
	public String AnswerList() {

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
		model.addAttribute("projectList", projectList);

		return "admin/projectManagement";
	}

	@GetMapping("/inquiryListManagement")
	public String inquiryListManagement(Model model) {
		List<InquiryVO> inquiryList = inquiryService.inquiryList();
		model.addAttribute("inquiryList", inquiryList);

		return "admin/inquiryManagement";

	}
	
	@GetMapping("/paymentManagement")
	public String paymentManagement(Model model) {
		List<PaymentVO> paymentAllList = paymentService.paymentAllList();
		model.addAttribute("paymentAllList", paymentAllList);

		return "admin/paymentManagement";

	}

	@GetMapping("/userManagement")
	public String userManagement(Model model) {
		List<UserVO> userList = userService.userList();

		model.addAttribute("userList", userList);

		return "admin/userManagement";
	}

	@GetMapping("/userEdit/{userNum}")
	public String userEdit(@PathVariable String userNum, Model model) {
		UserVO userData = userService.userData(userNum);

		model.addAttribute("userData", userData);

		return "admin/userEdit";
	}

	@DeleteMapping("/deleteUser/{userNum}")
	public ResponseEntity<String> deleteUser(@PathVariable String userNum) {
		try {
			// 여기에서 userService를 사용하여 회원을 삭제하는 작업 수행
			userService.userCompleteDelete(userNum);
			return new ResponseEntity<>("회원이 성공적으로 삭제되었습니다.", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("회원 삭제 중 에러가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping("/checkProjectStatus/{userNum}")
	public ResponseEntity<String> checkProjectStatus(@PathVariable String userNum) {
	    try {
	        Integer projectStatus = projectService.checkProjectStatus(userNum);

	        if (projectStatus == null||projectStatus == 0) {
	           
	            return ResponseEntity.ok("프로젝트가 진행 중이 아닙니다. 회원을 삭제할 수 있습니다.");
	        } else {
	            // 프로젝트가 진행 중인 경우
	            return ResponseEntity.ok("프로젝트 진행 중");
	        }
	    } catch (Exception e) {
	        // 예외 발생 시 예외 메시지를 응답으로 전송
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	            .body("Error: " + e.getMessage());
	    }
	}
	
	
	 @PostMapping("/userEditComplete")
	   public String userEdit(UserVO userVO, Model model) {
	       int result = userService.editProcess(userVO);
	       if (result > 0) {
	           // 수정 성공 시

	           // 로그인 페이지로 이동
	           return "redirect:"
	           		+ "/admin/userManagement";
	       } else {
	           // 회원 가입 실패 시 실패 메시지와 함께 다시 회원 가입 페이지로 이동
	           model.addAttribute("errorMessage", "회원 수정에 실패하였습니다. 다시 시도해주세요.");
	           return "redirect:/admin/userEdit";
	       }
	   }



}
