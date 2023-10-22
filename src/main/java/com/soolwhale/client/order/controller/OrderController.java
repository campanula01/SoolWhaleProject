package com.soolwhale.client.order.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soolwhale.client.order.service.OrderService;
import com.soolwhale.client.order.vo.OrderVO;
import com.soolwhale.client.user.vo.UserVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes("order")
@RequestMapping("/supporter/*")
@Slf4j
public class OrderController {
	
	
	@Setter(onMethod_ = @Autowired)
	private OrderService orderService;

	@GetMapping(value="/orderList")
	public String orderList(Model model, HttpServletRequest request, OrderVO ovo) {
	    // HttpSession을 이용하여 세션 정보를 가져옴
	    HttpSession session = request.getSession(false);
	    UserVO user = (UserVO) session.getAttribute("login");

		
		log.info("orderList 화면 호출");
	    if (session != null && session.getAttribute("login") != null) {
	        // 세션에 로그인 정보가 존재함
	    	  log.info("userNum 값" + user.getUserNum());
	        model.addAttribute("username", user.getName()); 
	        model.addAttribute("usernum", user.getUserNum()); 
	        
	        List<OrderVO> orderList = orderService.orderList(ovo);
			model.addAttribute("orderList", orderList);
//	        InquiryVO inquiry = new InquiryVO();
//	        inquiry.setUserNum(user.getUserNum());
	        
	        return "client/supporter/orderList"; // 로그인 상태이므로 원하는 페이지로 리디렉션
	    } else {
	        // 세션에 로그인 정보가 없음
	        return "redirect:/member/login"; // 로그인 페이지로 리디렉션
	    }
			
	}
	
	@GetMapping(value="/orderListDetail")
	public String orderListDetailView() {
		log.info("orderListDetail 화면 호출");
		
		return "client/supporter/orderListDetail";
	}
	
	@GetMapping(value="/orderListDes")
	public String orderListDetail(@ModelAttribute OrderVO ovo, Model model) {
		log.info("orderListDetail 메서드로 호출 성공");
		log.info("ovo :" + ovo);
		
		OrderVO detail = orderService.orderListDetail(ovo);
		
		model.addAttribute("detail", detail);
		
		return  "client/supporter/orderListDetail";
	}
	

}
