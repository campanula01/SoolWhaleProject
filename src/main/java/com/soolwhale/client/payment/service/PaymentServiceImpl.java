package com.soolwhale.client.payment.service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.soolwhale.client.payment.dao.PaymentDao;
import com.soolwhale.client.payment.dto.PaymentAPIDto;
import com.soolwhale.client.payment.dto.ResponseDto;
import com.soolwhale.client.payment.vo.PaymentVO;
import com.soolwhale.client.project.vo.ProjectVO;
import com.soolwhale.client.user.vo.UserVO;
import com.soolwhale.common.dao.CommonDao;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PaymentServiceImpl implements PaymentService {
	
	@Setter(onMethod_=@Autowired)
	private PaymentDao paymentDao;
	
	@Setter(onMethod_=@Autowired)
	private CommonDao commonDao;

/*
	@Value("${iamport.api-key}")
	private String IAMPORT_API_KEY;

	@Value("${iamport.api-secret}")
	private String IAMPORT_API_SECRET;	
	*/
	
	@Value("${IAMPORT_API_KEY:}")
	private String IAMPORT_API_KEY;

	@Value("${IAMPORT_API_SECRET:}")
	private String IAMPORT_API_SECRET;


	@Transactional
    @Override
    public int paymentInsert(PaymentVO pvo) {
		log.info("Processing PaymentVO in Service: " + pvo); // PaymentVO 객체의 toString() 메서드를 오버라이드해야 합니다.
        int result = 0;
   

        if(pvo.getReward()!=null) {
        	log.info("Rewards received: " + pvo.getReward());
        for (String rewardValue : pvo.getReward()) {
        	log.info("Processing rewardValue: " + rewardValue);
        	pvo.setSingleReward(rewardValue); 
            result += paymentDao.paymentInsert(pvo);
        }
        
        }else {
        	System.out.println("reward값이 없습니다.");
        }
        return result;
    }



	@Override
	public PaymentVO paymentComplete(@Param("projectNum") String projectNum) {
		PaymentVO paymentComplete = paymentDao.paymentComplete(projectNum);
		log.info("PaymentVO for paymentComplete: " + projectNum);
		log.info("Processing paymentComplete: " + paymentComplete);
		return paymentComplete;
	}



	@Override
	public PaymentVO projectDetailCount(ProjectVO vo) {
		PaymentVO projectDetailCount = paymentDao.projectDetailCount(vo);
		
		return projectDetailCount;
	}



	@Override
	public String tokenBilling(String customer_uid, String token) {
	    String url = "https://api.iamport.kr/subscribe/customers/" + customer_uid;
	    
	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Authorization", token); // 토큰을 헤더에 추가
	    HttpEntity<String> entity = new HttpEntity<>(headers);
	    
	    RestTemplate restTemplate = new RestTemplate();
	    try {
	        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
	        if (response.getStatusCode() == HttpStatus.OK) {
	            // 이 부분에서 response body를 파싱하여 필요한 정보를 추출할 수 있습니다.
	            // 예제에서는 간단히 성공 메시지를 반환합니다.
	            return "Success";
	        } else {
	            // 실패 시의 로직을 여기에 작성합니다.
	            return "Failed: " + response.getBody();
	        }
	    } catch (Exception e) {
	        // 요청 중 오류 발생 시의 로직을 여기에 작성합니다.
	        return "Error: " + e.getMessage();
	    }
	}

	 @Autowired
	 private RestTemplate restTemplate;

	 public String generateIamportToken() {
	        String authUrl = "https://api.iamport.kr/users/getToken";

	        HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(MediaType.APPLICATION_JSON);

	        // 요청 본문 생성
	        Map<String, String> body = new HashMap<>();
	        body.put("imp_key", IAMPORT_API_KEY);   // 환경 변수에서 값을 가져옴
	        body.put("imp_secret", IAMPORT_API_SECRET); // 환경 변수에서 값을 가져옴

	        HttpEntity<Map<String, String>> entity = new HttpEntity<>(body, headers);

	        ResponseEntity<Map> response;
	        try {
	            response = restTemplate.postForEntity(authUrl, entity, Map.class);
	        } catch (HttpClientErrorException | HttpServerErrorException e) {
	            // 요청 실패 처리
	            System.err.println("IAMPORT token request failed: " + e.getRawStatusCode() + " - " + e.getStatusText());
	            System.err.println("Response body: " + e.getResponseBodyAsString());
	            return null;
	        }


	        if (response.getStatusCode() == HttpStatus.OK) {
	            Map<String, Object> responseBody = response.getBody();
	            if (responseBody != null && responseBody.containsKey("response")) {
	                Map<String, Object> tokenData = (Map<String, Object>) responseBody.get("response");
	                if (tokenData.containsKey("access_token")) {
	                    return (String) tokenData.get("access_token");
	                }
	            }
	        }
	        
	        System.out.println("IAMPORT token generation failed.");
	        return null;
	    }


	@Override
	public int paymentDelete(String paymentNum) {
		int result=0;
		result = paymentDao.paymentDelete(paymentNum);
		return result;
	}
	
	@Transactional
	@Override
	public int paymentDeleteByCancel(String merchantUid) {
		int result = 0;
		result = paymentDao.paymentDeleteByCancel(merchantUid);

		return result;
	}


	 


	  @Override 
	  public List<PaymentVO> paymentList(UserVO user) {
	  
	  log.info("paymentDao 호출");
	  List<PaymentVO> list = null;
	  list = paymentDao.paymentList(user);
	  return list;
	  
	  }
	  
	  
	  
	  
	  @Override 
	  public List<PaymentVO> paymentListDetail(String merchantUid, UserVO user) {
	  
	  
	  List<PaymentVO> detail = paymentDao.paymentListDetail( merchantUid,  user);
	  
	 
	  return detail;
	  
	  }

	  public PaymentVO paymentListDetailChoice(String merchantUid,UserVO user){
		  
		  PaymentVO detail =(PaymentVO) paymentDao.paymentListDetailChoice(merchantUid,  user);
		  return detail;
		  
	  }




	@Override
	public int paymentUpdate(String merchantUid, String billingKey) throws Exception {
		int payment = paymentDao.paymentUpdate(merchantUid, billingKey);
		return payment;
	}


	@Override
	public List<PaymentVO> amountList() {
		List<PaymentVO> list = null;
		list = paymentDao.amountList();
		return list;
	}


    public String generateNewMerchantUID() {
        String uuidPart = UUID.randomUUID().toString().replace("-", "").substring(0, 28); // UUID에서 '-'를 제거하고 앞 28자만 사용
        return "merchantNew_" + uuidPart;
    }
    
	@Override
	public ResponseEntity<Map<String, String>> executeBillByKey(PaymentAPIDto paymentApiDto) {
		
		log.info("billByKey 함수 호출");
	    String customer_uid = paymentApiDto.getCustomerUid();
	    int amount = Integer.parseInt(paymentApiDto.getAmount());
	 // 여기에서 새로운 merchant_uid를 생성하거나 확인하는 로직 추가
	    String merchant_uid = generateNewMerchantUID();
	    System.out.println("customer_uid: " + customer_uid); 
	    System.out.println("merchant_uid: " + merchant_uid);  
	    String url = "https://api.iamport.kr/subscribe/payments/again";
	    
	    HttpHeaders headers = new HttpHeaders();
	    
	    //API 요청을 보낼 때 인증을 제공
	    headers.set("Authorization", generateIamportToken());  
	    
	    MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
	    body.add("customer_uid", customer_uid);
	    body.add("merchant_uid", merchant_uid);
	    body.add("amount", amount);
	    body.add("name", "정기 결제 테스트 상품");
	    
	    
	    System.out.println("merChant_uid:"+merchant_uid);	//찍힘
	    log.info("payment"+paymentApiDto);
	    HttpEntity<MultiValueMap<String, Object>> entity = new HttpEntity<>(body, headers);
	    
	    try {
	        ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);
	        System.out.println("Iamport response: " + response.getBody());  // API 응답 로깅
	        System.out.println("paymentDto: "+paymentApiDto);
	        
	        System.out.println("try Updated merchant_uid: " + merchant_uid);	//찍힘
	        
	        // 응답 파싱 responseDto 사용
	        ObjectMapper objectMapper = new ObjectMapper();
	        
	        //Java 객체를 JSON으로 변환하기 (직렬화):writeValueAsString
	        //Json을 java객체로 (역직렬화): readValue
	        //code, message, response
	        ResponseDto ResponseDto = objectMapper.readValue(response.getBody(), ResponseDto.class);
	        System.out.println("<=============================================>");
	        //ResponseDto를 확인
	        System.out.println("ResponseDto: "+ResponseDto);
	        
	        
	        //update해서 다시 set 해줌.
	    
	        
	        //null값이 나옴.
	        System.out.println("Updated merchant_uid: " + merchant_uid);
	        
	        if (response.getStatusCode() == HttpStatus.OK) {
	        	log.info("구매이 제대로 작동");
	        	
	        	//키(Key)와 값(Value)의 쌍으로 데이터 저장: 각 항목은 키와 값의 쌍으로 저장되며, 키는 고유해야 합니다.

//순서가 보장되지 않음: HashMap에 데이터를 추가할 때 순서가 보장되지 않습니다. 순서를 보장하고 싶다면 LinkedHashMap을 사용해야 합니다.
	        	Map<String, String> responseBody = new HashMap<>();
	            responseBody.put("message", "Billing by key was successful");
	            responseBody.put("merchant_uid", merchant_uid);
	            
	            int updatePayment = paymentUpdate(merchant_uid, customer_uid);
	            
	            if (updatePayment <= 0) {
	                System.out.println("update에 실패했습니다.");
	            }
	            return ResponseEntity.ok(responseBody);
	        } else {
	        	log.info("구매가 제대로 작동x");
	        	
	        	
	        	Map<String, String> errorBody = new HashMap<>();
	            errorBody.put("message", "Billing by key failed");
	            return ResponseEntity.status(response.getStatusCode()).body(errorBody);
	        
	        }
	    } catch (HttpClientErrorException | HttpServerErrorException e) {
	    	
	    	  System.out.println("Error during Iamport request: " + e.getResponseBodyAsString());  // 에러 로깅
	          Map<String, String> errorBody = new HashMap<>();
	          errorBody.put("message", "Error during Iamport request");
	          errorBody.put("error", e.getResponseBodyAsString());
	          return ResponseEntity.status(e.getStatusCode()).body(errorBody);
	    } catch (Exception e) {
	    	
	    	
	    	System.out.println("Unexpected error: " + e.getMessage());  // 예기치 않은 에러 로깅
	        Map<String, String> errorBody = new HashMap<>();
	        errorBody.put("message", "Unexpected server error");
	        errorBody.put("error", e.getMessage());
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorBody);
	    }
	    

	}


	


	@Override
	public Timestamp paymentDate(String merchantUid) {
		Timestamp timestamp =paymentDao.paymentDate(merchantUid);
		return timestamp;
	}



	@Override
	public List<PaymentVO> paymentAllList() {
		List<PaymentVO> list = null;
		list = paymentDao.paymentAllList();
		return list;
	}

	


}
