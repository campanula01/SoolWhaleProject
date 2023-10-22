package com.soolwhale.admin.answer.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soolwhale.admin.answer.service.AnswerService;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes("answer")
@RequestMapping("/admin/*")
@Slf4j
public class AnswerController {
 
	@Setter(onMethod_ = @Autowired)
	private AnswerService answerService;
	
	
	@GetMapping(value="/answerList")
	public String AnswerList(){
		log.info("answerlist 화문 출력");
//		 아직 관리자 페이지 구현 안함
		
		return "client";
		
	}
}
