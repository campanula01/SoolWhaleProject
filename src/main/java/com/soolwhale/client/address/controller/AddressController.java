package com.soolwhale.client.address.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soolwhale.client.address.service.AddressService;
import com.soolwhale.client.address.vo.AddressVO;
import com.soolwhale.client.point.service.PointService;
import com.soolwhale.client.point.vo.PointVO;
import com.soolwhale.client.user.service.UserService;
import com.soolwhale.client.user.vo.UserVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes("address")
@RequestMapping("/address/*")
@Slf4j
public class AddressController {
	
	
	@Setter(onMethod_=@Autowired)
	private AddressService addressService;
	
	@Setter(onMethod_=@Autowired)
	private UserService userService;
	
	@Setter(onMethod_=@Autowired)
	private PointService pointService;
	
	
	@GetMapping("/addressList")
	public String addressList(Model model, AddressVO vo, HttpSession session) {
	    log.info("addressList 호출 성공");
	    String userNum = (String) session.getAttribute("login");
	    
	    if (userNum == null) {
	        log.error("User is not logged in!");
	        return "/client/member/userLoginForm";
	    }
	    
	    // 세션에서 사용자 정보 가져오기


	    log.info("userNum 값: " + userNum);

	    List<AddressVO> addressList = addressService.addressList(userNum);
	    UserVO userData =userService.userData(userNum);
	    PointVO pointSum = pointService.pointSum(userNum);
	    log.info("addressList 값: " + addressList);
	    log.info("userData 값: " + userData);
	    log.info("pointSum 값: " + pointSum);
	    
	    model.addAttribute("addressList", addressList);
        model.addAttribute("userData", userData);
        model.addAttribute("pointSum", pointSum);

	    if(addressList.isEmpty()) {
	        log.warn("No address found for userNum: " + userNum);
	        // 여기에 필요한 처리를 추가할 수 있습니다.
	    } else {
	       
	    }

	    return "/client/funding/fundingPayment"; 
	}
	@PostMapping("/addressInsert")
	@ResponseBody
	public Map<String, Object> addressInsert(AddressVO avo, Model model, @SessionAttribute("login") String userNum) {
	    Map<String, Object> response = new HashMap<>();
	    int result=0;

	    
	    result = addressService.addressInsert(avo, userNum);

	    response.put("success", result == 1);
	    // 추가적으로 필요한 정보가 있다면 response에 넣어줍니다.

	    return response;
	}
	
	@DeleteMapping(value="/{addrNum}")
	public ResponseEntity<String> addressDelete(@PathVariable("addrNum") String addrNum) {
	    log.info("삭제 호출");
	    
	    int result = addressService.addressDelete(addrNum);
	    
	    if (result == 1) {
	        return ResponseEntity.ok().body("SUCCESS");
	    } else {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("FAILURE");
	    }
	}
	
	@PostMapping("/addressUpdate")
	@ResponseBody
	public Map<String, Object> addressUpdate(AddressVO avo, Model model,@SessionAttribute("login") String userNum) throws Exception {
	    log.info("addressUpdate 호출 성공");

	    Map<String, Object> response = new HashMap<>();
	    int result=0;

	   
	    result = addressService.addressUpdate(avo, userNum);

	    response.put("success", result == 1);
	    // 추가적으로 필요한 정보가 있다면 response에 넣어줍니다.

	    return response;
	}

	

	
}
