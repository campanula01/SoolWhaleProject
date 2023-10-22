package com.soolwhale.client.reward.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soolwhale.client.project.service.ProjectService;
import com.soolwhale.client.project.vo.ProjectVO;
import com.soolwhale.client.reward.service.RewardService;
import com.soolwhale.client.reward.vo.RewardVO;
import com.soolwhale.client.user.vo.UserVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes("reward")
@RequestMapping("/reward/*")
@Slf4j
public class RewardController {
	
	@Setter(onMethod_=@Autowired)
	private RewardService rewardService;
	
	@Setter(onMethod_=@Autowired)
	private ProjectService projectService;
	
	
	@GetMapping("/rewardList")
	public String rewardList(Model model, RewardVO vo,ProjectVO pvo,HttpSession session,@RequestParam("rewardValue") String rewardValue) {
		log.info("rewardList 호출 성공");
		//전체 레코드 조회
		List<RewardVO> rewardList = rewardService.rewardList(vo);
		ProjectVO projectDetail = projectService.projectDetail(pvo);
		 // 세션에서 사용자 정보 가져오기
	    String userNum = (String) session.getAttribute("login");
	    if(userNum==null) {
	    	return "/client/member/userLoginForm";
	    }

	    log.info("userNum 값: " + userNum);
	    log.info("선택된 리워드 넘: "+rewardValue);
		
		model.addAttribute("rewardList",rewardList);
		model.addAttribute("projectDetail",projectDetail);
		model.addAttribute("selectedReward",rewardValue);
		
		log.info("p:"+projectDetail);

		
		return "client/funding/fundingReward";	//WEB-INF/views/client/board/boardList.jsp
	}
	
	
	
	@PostMapping("/successInsert")
	public String rewardInsert(ProjectVO pvo) {
		
		projectService.successInsert(pvo);
		
		return "redirect:/project/projectList";
	}
	
	
	
	@PostMapping("/rewardInsert")
	@ResponseBody // JSON 응답으로 변경
	public List<RewardVO> rewardInsert(RewardVO rvo, ProjectVO pvo) {
	    log.info("리워드 정보를 DB에 저장합니다.");

	    // 리워드 정보를 DB에 저장
	    int result = rewardService.rewardInsert(rvo);

	    if (result == 1) {
	        // 저장 성공한 경우, 저장된 리워드 목록을 조회하여 반환
	        List<RewardVO> rewardList = rewardService.rewardList(rvo); // rewardList 메서드를 호출하여 리워드 목록을 가져옵니다.
	        return rewardList;
	    } else {
	        // 저장 실패 시 빈 목록 반환
	        return new ArrayList<>();
	    }
	}
	
	@PostMapping("/deleteReward")
	@ResponseBody
	public Map<String, Object> deleteReward(@RequestParam("rewardId") String rewardId) {
	    Map<String, Object> resultMap = new HashMap<>();
	    try {
	        // 리워드 삭제 로직을 수행하고 성공 여부를 판단합니다.
	        boolean success = rewardService.deleteRewardById(rewardId);

	        if (success) {
	            resultMap.put("success", true);
	            resultMap.put("message", "리워드가 삭제되었습니다.");
	        } else {
	            resultMap.put("success", false);
	            resultMap.put("message", "리워드 삭제에 실패했습니다.");
	        }
	    } catch (Exception e) {
	        resultMap.put("success", false);
	        resultMap.put("message", "서버 오류로 인해 삭제에 실패했습니다.");
	        log.error("리워드 삭제 오류", e);
	    }
	    return resultMap;
	}



}
