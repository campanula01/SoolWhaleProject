package com.soolwhale.client.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soolwhale.client.image.service.ImageService;
import com.soolwhale.client.image.vo.ImageVO;
import com.soolwhale.client.payment.service.PaymentService;
import com.soolwhale.client.payment.vo.PaymentVO;
import com.soolwhale.client.project.service.ProjectService;
import com.soolwhale.client.project.vo.ProjectVO;
import com.soolwhale.client.reward.service.RewardService;
import com.soolwhale.client.reward.vo.RewardVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes("project")
@RequestMapping("/project/*")
@Slf4j
public class ProjectController {
	@Setter(onMethod_ = @Autowired)
	private ProjectService projectService;
	
	@Setter(onMethod_=@Autowired)
	private RewardService rewardService;
	
	@Setter(onMethod_=@Autowired)
	private PaymentService paymentService;
	
	@Setter(onMethod_=@Autowired)
	private ImageService imageService;
	
	@GetMapping("/liquorList")
	public String projectLiquorList(Model model, ProjectVO pvo, @RequestParam String liquorType) {
		
		log.info("주종 디테일");
		
		log.info(liquorType);
		pvo.setLiquorType(liquorType);
		
		List<ProjectVO> projectList = projectService.liquorList(pvo);
		
		model.addAttribute("list",projectList);

		
	
		return "client/project/liquorList";
		
	}
	
	
	@GetMapping("/projectList")
	public String projectListView(@ModelAttribute ProjectVO pvo, Model model, @SessionAttribute("login") String userNum, @RequestParam(required = false) String sts) {
		log.info("마이프로젝트 리스트 보러가자!");
		
		pvo.setSts(sts);
		pvo.setUserNum(userNum);
		List<ProjectVO> projectList = projectService.projectList(pvo);
		model.addAttribute("projectList", projectList);
		
		log.info("리스트목록 : " + projectList);
		return "client/project/projectList";
	}
	
	@PostMapping("/projectUpdate")
	public String makerInfoView(ProjectVO pvo, Model model) {
		log.info("프로젝트 업데이트!!");
		
		ProjectVO makerInfo = projectService.projectDetail2(pvo);
		model.addAttribute("makerInfo", makerInfo);
		 
		return "client/project/makerInfo";
	}
	
	//makerInfo 정보 업데이트하기
	@PostMapping("/makerInfoUpdate")
	public String makerInfoUpdate(@ModelAttribute ProjectVO pvo, ImageVO ivo,Model model) throws Exception {
		log.info("메이커인포 정보 업데이트!");
		
		List<ImageVO> imageList = imageService.imageList(ivo);
		
		projectService.makerInfoUpdate(pvo, imageList);
		ProjectVO projectInfo = projectService.projectDetail2(pvo);
		model.addAttribute("projectInfo", projectInfo);
		
		return "client/project/projectInfo";
	}

	//projectInfo 정보 업데이트하기
	@PostMapping("/projectInfoUpdate")
	public String projectInfoUpdate(@ModelAttribute ProjectVO pvo, Model model) throws Exception {
		log.info("프로젝트인포 정보 업데이트!");
		
		projectService.projectInfoUpdate(pvo);
		ProjectVO fundingPlan = projectService.projectDetail2(pvo);
		model.addAttribute("fundingPlan", fundingPlan);
		
		return "client/project/fundingPlan";
	}

	//fundingPlan 정보 업데이트하기
	@PostMapping("/fundingPlanUpdate")
	public String fundingPlanUpdate(@ModelAttribute ProjectVO pvo, RewardVO vo, Model model){
		log.info("펀딩일정 및 정보 업데이트!");
		
		projectService.fundingPlanUpdate(pvo);
		ProjectVO rewardInsert = projectService.projectDetail2(pvo);
		List<RewardVO> rewardList = rewardService.rewardList2(vo);
		model.addAttribute("rewardInsert", rewardInsert);
		model.addAttribute("rewardList",rewardList);
		
		return "client/project/rewardInsert";
	}
	
	


	
	@GetMapping("/fundingDetailView")
	public String fundingDetailView(Model model, ProjectVO pvo, @RequestParam String projectNum) {
		log.info("펀딩 디테일");
		
		pvo.setProjectNum(projectNum);
		
		ProjectVO projectDetail = projectService.projectDetail(pvo);
		List<RewardVO> rewardDetail = rewardService.rewardDetail(pvo);
		PaymentVO projectDetailCount = paymentService.projectDetailCount(pvo);
		List<ImageVO> imageListProject = imageService.imgListProject(pvo);
		
		model.addAttribute("projectDetail", projectDetail);
		model.addAttribute("rewardDetail", rewardDetail);
		model.addAttribute("projectDetailCount", projectDetailCount);
		model.addAttribute("imageListProject",imageListProject);
		
		log.info("projectDetail: Count"+projectDetailCount);
		return "client/funding/fundingDetail";
	}
	
	@GetMapping("/fundingList")
	public String fundingList() {
		
		log.info("fundingPayment 페이지 불러오기");
		return "client/payment/fundingList";
	}
	
	  // 검색 결과 페이지에 대한 요청 처리
    @GetMapping("/search")
    public String searchProjects(@RequestParam("search_text") String keyword, Model model) {
        List<ProjectVO> projectVO = projectService.searchProjects(keyword);

        // 검색된 프로젝트들을 Model 객체에 추가하여 JSP로 전달
        model.addAttribute("project", projectVO);

        // 검색 결과를 표시할 JSP 파일의 이름 (예: searchResult.jsp)
        // 해당 JSP 파일을 만들어야 함
        return "client/common/searchResult";
    }

    @GetMapping("/newProjectInsertView")
    public String newProjectInsertView(@SessionAttribute("login") String userNum, Model model) {
        model.addAttribute("userNum", userNum);
        return "client/project/newProjectInsert";
    }

	@PostMapping("/newProjectInsert")
	public String newProjectInsert(@ModelAttribute ProjectVO pvo, Model model) throws Exception{
		log.info("새로운 프로젝트 생성!");
		
		projectService.projectInfoInsert(pvo);
		
		ProjectVO projectInfo = projectService.projectDetail2(pvo);
		model.addAttribute("projectInfo", projectInfo);
		
		return "client/project/projectInfo";
	}
	
	
	@PostMapping("/projectDelete")
	public String projectDelete(ProjectVO pvo, RewardVO rvo, ImageVO ivo) throws Exception{
		log.info("프로젝트 삭제하기");
		List<ImageVO> imageList = imageService.imageList(ivo);

		for (ImageVO image : imageList) {
	        // 각 이미지 삭제 (서비스에서 이 메서드를 구현해야 함)
	        imageService.imageDeleteById(image);
	    }
		
		rewardService.rewardDelete(rvo);
		imageService.imageDelete(ivo);
		projectService.deleteProject(pvo);
		
		return "redirect:/project/projectList";
	}
	
	@GetMapping("/projectAccept")
	public String projectAccept(ProjectVO pvo) {
		projectService.projectAccept(pvo);
		
		return "redirect:/admin/projectManagement";
	}
	
	@GetMapping("/projectRefuse")
	public String projectRefuse(ProjectVO pvo) {
		projectService.projectRefuse(pvo);
		
		return "redirect:/admin/projectManagement";
	}
	
	@GetMapping("/preview")
	public String preview(Model model, ProjectVO pvo, @RequestParam String projectNum) {
		
		pvo.setProjectNum(projectNum);
		
		ProjectVO projectDetail = projectService.projectDetail(pvo);
		List<RewardVO> rewardDetail = rewardService.rewardDetail(pvo);
		PaymentVO projectDetailCount = paymentService.projectDetailCount(pvo);
		List<ImageVO> imageListProject = imageService.imgListProject(pvo);
		
		model.addAttribute("projectDetail", projectDetail);
		model.addAttribute("rewardDetail", rewardDetail);
		model.addAttribute("projectDetailCount", projectDetailCount);
		model.addAttribute("imageListProject",imageListProject);
		
		return "client/project/preview";
	}
	
	@PostMapping("/makerInfoUpdateBack")
	public String makerInfoUpdateBack(ProjectVO pvo, Model model) throws Exception{
		
		ProjectVO makerInfo = projectService.projectDetail2(pvo);
		model.addAttribute("makerInfo", makerInfo);
		
		return "client/project/makerInfo";
	}
	

	//projectInfo 정보 업데이트하기
	@PostMapping("/projectInfoUpdateBack")
	public String projectInfoUpdateBack(@ModelAttribute ProjectVO pvo, Model model) throws Exception {
		
		ProjectVO projectInfo = projectService.projectDetail2(pvo);
		model.addAttribute("projectInfo", projectInfo);
		
		return "client/project/projectInfo";
	}

	//fundingPlan 정보 업데이트하기
	@PostMapping("/fundingPlanUpdateBack")
	public String fundingPlanUpdateBack(@ModelAttribute ProjectVO pvo, RewardVO vo, Model model){
		
		ProjectVO fundingPlan = projectService.projectDetail2(pvo);
		model.addAttribute("fundingPlan", fundingPlan);
		
		return "client/project/fundingPlan";
	}
	
	@GetMapping("/projectSellingList")
	public String projectSellingList(@ModelAttribute ProjectVO pvo, Model model, @SessionAttribute("login") String userNum, @RequestParam(required = false) String sts) {
		log.info("판매현황 리스트!");
		
		pvo.setSts(sts);
		pvo.setUserNum(userNum);
		List<ProjectVO> projectList = projectService.projectSellingList(pvo);
		List<PaymentVO> amountList = paymentService.amountList();
		model.addAttribute("projectList", projectList);
		model.addAttribute("amountList", amountList);
		
		log.info("리스트목록 : " + projectList);
		log.info("총가격 리스트: " + amountList);
		return "client/project/projectSellingList";
	}
	
	
}