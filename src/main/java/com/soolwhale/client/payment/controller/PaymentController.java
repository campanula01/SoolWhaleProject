package com.soolwhale.client.payment.controller;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.soolwhale.client.address.service.AddressService;
import com.soolwhale.client.address.vo.AddressVO;
import com.soolwhale.client.payment.dto.PaymentAPIDto;
import com.soolwhale.client.payment.dto.PaymentDto;
import com.soolwhale.client.payment.dto.ResponseDto;
import com.soolwhale.client.payment.service.PaymentSchedulerService;
import com.soolwhale.client.payment.service.PaymentService;
import com.soolwhale.client.payment.vo.PaymentVO;
import com.soolwhale.client.point.service.PointService;
import com.soolwhale.client.point.vo.PointVO;
import com.soolwhale.client.project.service.ProjectService;
import com.soolwhale.client.project.vo.ProjectVO;
import com.soolwhale.client.user.service.UserService;
import com.soolwhale.client.user.vo.UserVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

//RestController는 값만 가져오므로 여기에 사용하면 안된다.
@Controller
@SessionAttributes("payment")
@RequestMapping("/payment/*")
@Slf4j
public class PaymentController {
	

	@Setter(onMethod_ = @Autowired)
	private AddressService addressService;
	// fundingReward에서 불러와야하는 데이터
	// 프로젝트 이름, 리워드 이름, 리워드 가격, 리워드 설명,
	
	@Setter(onMethod_=@Autowired)
	private PaymentService paymentService;
	
	@Setter(onMethod_=@Autowired)
	private PointService pointService;
	
	@Setter(onMethod_=@Autowired)
	private ProjectService projectService;
	
	@Setter(onMethod_=@Autowired)
	private UserService userService;
	
	@Setter(onMethod_=@Autowired)
	private PaymentSchedulerService paymentSchedulerService;
	


	@GetMapping("/fundingPayment")
	public String fundingPayment(Model model, AddressVO vo, HttpSession session, @SessionAttribute("login") String userNum) {
		 // 세션에서 사용자 정보 가져오기

		 List<AddressVO> addressList = addressService.addressList(userNum);
		    model.addAttribute("addressList", addressList);
		    log.info("addressList size: " + addressList.size());
		    if (addressList.size() > 0) {
		        log.info("First address's pointSum value: " + addressList.get(0).getPoint().getPointSum());
		    }


		 
		    List<PaymentDto> selectedProducts = (List<PaymentDto>) session.getAttribute("selectedProducts");
		    if (selectedProducts != null && !selectedProducts.isEmpty()) {
		        System.out.println("selectedProducts exists in the session!");
		        model.addAttribute("selectedProducts", selectedProducts);
		    } else {
		        System.out.println("selectedProducts does NOT exist in the session!");
		    }

		log.info("fundingPayment 페이지 불러오기");
		return "client/funding/fundingPayment";  // JSP 페이지로 반환
	}
	
	
	@PostMapping("/rewardArray")
	public ResponseEntity<String> rewardArray(@RequestBody List<PaymentDto> products, Model model, HttpSession session,@SessionAttribute("login") String userNum) {
	    System.out.println(products.size()); // 여기서 몇 개의 아이템이 들어왔는지 확인
	    // 세션에 상품 목록 추가
	    

	    
	    session.setAttribute("selectedProducts", products);
	    session.setAttribute("userNum", userNum);
	    log.info("rewardArray userNum 값: " + userNum);
	    
	    log.info("rewardArray: "+products);
	    products.forEach(product -> System.out.println(product.getName())); // 각 상품의 이름 출력
	    return ResponseEntity.ok("/SoolWhale/address/addressList");
	}


	
	@PostMapping("/paymentInsert")
	public ResponseEntity<String> paymentInsert(@RequestBody PaymentVO pvo, @SessionAttribute("login") String userNum, @RequestParam String projectNum) {
		 log.info("Received PaymentVO: " + pvo); // PaymentVO 객체의 toString() 메서드를 오버라이드해야 합니다.
	    try {
	    	log.info("insert");
	    	 // 세션에서 사용자 정보 가져오기

		    pvo.setUserNum(userNum);
		    log.info(projectNum);
		    
		    pvo.setProjectNum(projectNum);
		    pvo.setExecuteTimestamp(projectService.paymentDate(projectNum));

		    
	        int result = paymentService.paymentInsert(pvo);
	        log.info("Received PaymentVO: " + pvo);
	        
	        log.info("PaymentInsert: "+pvo);


	        if(result == pvo.getReward().size()) {
	            return ResponseEntity.ok("Inserted successfully!");
	        } else {
	            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Insert failed for some rewards.");
	        }

	    } catch(Exception e) {
	    	  log.error("ERROR: ", e);  // 오류의 스택 트레이스를 로그로 출력
	          return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("ERROR: " + e.getMessage());
	    }
	}
	
	@PostMapping("/pointInsert")
	public ResponseEntity<?> pointInsert(@RequestBody PointVO vo, HttpSession session) {
	    log.info("pointInsert");
	    log.info("PointVO: "+vo);
		 // 세션에서 사용자 정보 가져오기
	    String userNum = (String) session.getAttribute("login");

	    
	    int result = pointService.pointInsert(vo,userNum);
	    if(result == 1) {
	        log.info("point가 insert되었습니다.");
	        return ResponseEntity.ok().body("success");
	    } else {
	        log.info("point insert에 실패했습니다.");
	        return ResponseEntity.badRequest().body("failure");
	    }
	}


	@PostMapping("/fundingPayComplete")
	public ResponseEntity<String> fundingPayComplete( Model model, HttpSession session,@RequestParam String projectNum) {
		//Response 반환값 변경: 서버에서 AJAX 요청에 대한 응답을 리디렉션할 URL 문자열로 반환합니다. 그런 다음 클라이언트에서 해당 URL로 리디렉션을 수행합니다.
		


	     //session에 담긴 projectNum을 1자리에 교체
		PaymentVO paymentComplete = paymentService.paymentComplete(projectNum);
		model.addAttribute("paymentComplete",paymentComplete);
		log.info("paymentComplete Post: "+paymentComplete);
		
		session.setAttribute("paymentComplete", paymentComplete);
	
		log.info("fundingPayComplete 페이지 불러오기, 데이터 삽입");
		return ResponseEntity.ok("/SoolWhale/payment/fundingPayComplete");
	}
	
	
	
	
	
	@GetMapping("/fundingPayComplete")
	public String fundingPayCompletePage(PaymentVO pvo, ProjectVO vo,HttpSession session, Model model) {
		
		List<ProjectVO> recommendRewardList = projectService.recommendRewardList();
		model.addAttribute("recommendRewardList", recommendRewardList);
		
		log.info("recommendRewardList"+recommendRewardList);

		PaymentVO paymentComplete = (PaymentVO) session.getAttribute("paymentComplete");
		
		log.info("paymentComplete Get:"+paymentComplete);
		model.addAttribute("paymentComplete",paymentComplete);
		
		String userNum = (String) session.getAttribute("login");

		 UserVO userData =userService.userData(userNum);

	     model.addAttribute("userData", userData);
	   
		
		
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		LocalDateTime endDate = LocalDateTime.parse(paymentComplete.getProject().getEndDate(), formatter);
		
		LocalDateTime dueDateLDT = endDate.plusDays(1);
		LocalDateTime dueDeliveryDateLDT = dueDateLDT.plusMonths(1);
		LocalDateTime maxDelayDateLDT = dueDeliveryDateLDT.plusMonths(2);
		
		Date dueDate = convertDate(dueDateLDT);
		Date dueDeliveryDate = convertDate(dueDeliveryDateLDT);
		Date maxDelayDate = convertDate(maxDelayDateLDT);
		
		int dayOfMonthDueDelivery = getDayOfMonth(dueDeliveryDate);
		
		model.addAttribute("dueDate", dueDate);
		model.addAttribute("dueDeliveryDate", dueDeliveryDate);
		model.addAttribute("maxDelayDate", maxDelayDate);
		model.addAttribute("dayOfMonth", dayOfMonthDueDelivery);  // 뷰에 dayOfMonth 값을 전달합니다.
		
	   
		
		return "/client/funding/fundingPayComplete";
	}
	
	public Date convertDate(LocalDateTime localDateTime) {
	    return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
	}

	public int getDayOfMonth(Date date) {
	    java.util.Calendar cal = java.util.Calendar.getInstance();
	    cal.setTime(date);
	    return cal.get(java.util.Calendar.DAY_OF_MONTH);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@Value("${IAMPORT_API_KEY:}")
	private String IAMPORT_API_KEY;

	@Value("${IAMPORT_API_SECRET:}")
	private String IAMPORT_API_SECRET;

	
	 // RestTemplate 빈 주입
    private final RestTemplate restTemplate;
 


    private String iamportToken;
    
    @Autowired
    public PaymentController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

	
	/*api*/
	 /*빌링키 발급*/

    @PostMapping("/saveScheduledPayment")
    public ResponseEntity<?> saveScheduledPayment(@RequestBody PaymentAPIDto paymentApiDto) {
        try {
        	String projectNum=paymentApiDto.getProjectNum();
        	log.info("Received projectNum in PaymentAPIDto: " + projectNum);

        	paymentApiDto.setExecuteTimestamp(projectService.paymentDate(projectNum));
        	log.info("paymentApiDto: "+projectService.paymentDate(projectNum));
            paymentSchedulerService.schedulePayment(paymentApiDto);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    
	@PostMapping("/billByKey")
	public ResponseEntity<Map<String, String>> billByKey(@RequestBody PaymentAPIDto paymentApiDto) {
		return paymentService.executeBillByKey(paymentApiDto);
		
		
	}

    
	

    
	 @PostMapping("/cancel")
	 public ResponseEntity<String> paymentDeleteAndPurchaseReturn(@RequestBody PaymentVO pvo) {

		 System.out.println("cancel 매핑 시작");
		 
	     // Iamport API의 URL
	     String url = "https://api.iamport.kr/payments/cancel";

	     // Create headers
	     HttpHeaders headers = new HttpHeaders();
	     headers.set("Authorization", paymentService.generateIamportToken());
	     headers.set("Content-Type", "application/json");

	     // Extract merchant_uid from the PaymentVO
	     Map<String, Object> body = new HashMap<>();
	     String merchantUid = pvo.getMerchantUid();
	     System.out.println("merchantUid:"+merchantUid);
	     
	     body.put("merchant_uid", merchantUid);
	     System.out.println("merchantUid:"+merchantUid);

	     HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

	     try {
	         ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);
	         
		        System.out.println("response:"+response);


	         if (response.getStatusCode() == HttpStatus.OK) {
	             int deleteResult = paymentService.paymentDeleteByCancel(merchantUid);
	    	     System.out.println("merchantUid:"+merchantUid);
	             System.out.println("테이블 데이터 삭제");
	             if (deleteResult > 0) {
	            	 return ResponseEntity.ok("{\"message\":\"Success\"}");

	             } else {
	                 log.error("Failed to delete information from the payment table");
	                 return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to delete payment info");
	             }
	         } else {
	             log.info("Cancel operation did not work properly.");
	             return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to cancel payment with Iamport");
	         }
	     } catch (HttpClientErrorException | HttpServerErrorException e) {
	         log.error("Error occurred during Iamport request: " + e.getResponseBodyAsString());
	         return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE).body("Error communicating with Iamport");
	     } catch (Exception e) {
	         log.error("Unexpected error: " + e.getMessage());
	         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Unexpected error occurred");
	     }
	 }


    
		@GetMapping(value="/paymentListDes")
		public String paymentListDetail(@ModelAttribute PaymentVO pvo, Model model, @SessionAttribute(name = "user", required = false)UserVO user, HttpSession session) {
		    log.info("orderListDetail 메서드로 호출 성공");
		    
		    if(user != null ) {
		        String merchantUid = pvo.getMerchantUid();
		        String userNum = user.getUserNum();
		        pvo.setUserNum(user.getUserNum());
		        log.info("user :  : " + userNum);
		        List<PaymentVO> detail = paymentService.paymentListDetail(merchantUid, user); // user 객체 전달
		        PaymentVO choice =(PaymentVO) paymentService.paymentListDetailChoice(merchantUid,user);
		        model.addAttribute("userNum", userNum);
		        model.addAttribute("merchantUid" , merchantUid);
		        model.addAttribute("detail", detail);
		        model.addAttribute("choice", choice);
		        
		        return  "client/supporter/orderListDetail";
		    } else {
		        return "redirect:/member/login";
		    }
		}
		
		@GetMapping(value="/paymentList")
		public String paymentList(Model model,@SessionAttribute(name = "user", required = false)UserVO user, HttpSession session, PaymentVO pvo) {
			
			log.info("paymentList 화면 호출");
		    if (user != null) {
		        // 세션에 로그인 정보가 존재함
		    	  log.info("userNum 값" + user.getUserNum());
		        
		        List<PaymentVO> paymentList = paymentService.paymentList(user);
		        Collections.reverse(paymentList); 
		        pvo.setUser(user);
		        pvo.setUserNum(user.getUserNum());
		        pvo.setMerchantUid(pvo.getMerchantUid());
				model.addAttribute("paymentList", paymentList);
				model.addAttribute("merchantUid", pvo.getMerchantUid());
				model.addAttribute("userNum" , pvo.getUserNum());
		        return "client/supporter/orderList"; // 로그인 상태이므로 원하는 페이지로 리디렉션
		    } else {
		        // 세션에 로그인 정보가 없음
		        return "redirect:/member/login"; // 로그인 페이지로 리디렉션
		    }
				
		}
	
	
}
