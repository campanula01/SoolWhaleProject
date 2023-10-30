package com.soolwhale.common.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soolwhale.client.project.service.ProjectService;
import com.soolwhale.client.project.vo.ProjectVO;

import lombok.Setter;

@Controller
@SessionAttributes("/common")
public class CommonController {
	@Setter(onMethod_ = @Autowired)
	private ProjectService projectService;

	@GetMapping("/")
	public String main(Model model) {
		
		
		List<ProjectVO> list = projectService.projectListAll();
		model.addAttribute("list", list);
	return "main";
	}

}
