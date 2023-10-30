package com.soolwhale.client.user.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soolwhale.client.like.service.LikeService;
import com.soolwhale.client.like.vo.LikeVO;
import com.soolwhale.client.point.service.PointService;
import com.soolwhale.client.point.vo.PointVO;
import com.soolwhale.client.user.service.UserService;
import com.soolwhale.client.user.vo.UserVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes("user")
@RequestMapping(value = "/member/*")
@Slf4j
public class UserController {

	@Setter(onMethod_ = @Autowired)
	private UserService userService;

	@GetMapping("/login")
	public String userLoginForm(Model model) {
		log.info("userLoginForm 화면");

		return "/client/member/userLoginForm";
	}

	@PostMapping("/login")
	public String loginProcess(UserVO login, Model model, RedirectAttributes ras, HttpSession session) {
		UserVO userLogin = userService.LoginProcess(login);

		if (userLogin != null) {

			

			session.setAttribute("userNickname", userLogin.getUserNickname()); // 로그인한 사용자의 닉네임을 세션에 저장

			session.setAttribute("user", userLogin); // 세션에 로그인 정보 저장
			
			session.setAttribute("userNum", userLogin.getUserNum());		
		
			session.setAttribute("login", userLogin.getUserNum()); // 예: 사용자 ID만 저장. 실제로는 다른 필요한 최소한의 정보로 수정해야 합니다.
			
			
			String prevPage = (String) session.getAttribute("prevPage");
			
			session.removeAttribute("prevPage");
			

			return "redirect:" + (prevPage != null ? prevPage : "/");
			
		} else {
			ras.addFlashAttribute("errorMsg", "ID와 비밀번호를 확인해주세요");
			return "redirect:/member/login";
		}
	}
	@RequestMapping("/login")
	public String naver() {
		return "/login"; // 수정: 슬래시(/)를 제거하여 상대 경로로 변경
	}

	@RequestMapping(value = "/callback", method = RequestMethod.GET)
	public String callBack() {
		return "/SoolWhale/client/member/callback";
	}

	@RequestMapping(value = "/naverSave", method = RequestMethod.POST)
	public @ResponseBody String naverSave(@RequestParam("n_email") String n_email,
			@RequestParam("n_gender") String n_gender, @RequestParam("n_name") String n_name,
			@RequestParam("n_nickName") String n_nickName, HttpSession session) {

		// 사용자 정보 저장
		UserVO userLogin = new UserVO();
		userLogin.setEmail(n_email);
		userLogin.setSex(n_gender);
		userLogin.setName(n_name);
		userLogin.setUserNickname(n_nickName);

		// 세션에 사용자 정보 저장
		session.setAttribute("login", userLogin);

		return "ok";
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		log.info("admin 로그인 아웃 처리");
		session.invalidate();
		return "redirect:/";

	}

	@GetMapping("/join")
	public String userJoinForm(Model model) {
		log.info("userJoinForm 화면");

		return "/client/member/userJoinForm";
	}

	 @PostMapping("/join")
	   public String userJoin(UserVO userVO, Model model) {
	       int result = userService.joinProcess(userVO);
	       if (result > 0) {
	           // 회원 가입 성공 시

	           // 로그인 페이지로 이동
	           return "redirect:/member/login";
	       } else {
	           // 회원 가입 실패 시 실패 메시지와 함께 다시 회원 가입 페이지로 이동
	           model.addAttribute("errorMessage", "회원 가입에 실패하였습니다. 다시 시도해주세요.");
	           return "redirect:/member/join";
	       }
	   }
	   
	@PostMapping("/sendVerificationCode")
	@ResponseBody
	public String sendVerificationCode(@RequestParam("phoneNumber") String phoneNumber, HttpSession session) {
		try {
			// send_msg 메서드를 사용하여 인증번호 전송
			String rand = sendRandomMessage(phoneNumber);
			send_msg(phoneNumber, rand);

			// 생성한 인증번호와 함께 휴대폰 번호를 세션에 저장
			session.setAttribute("verificationCode", rand);
			session.setAttribute("phoneNumber", phoneNumber); // 추가된 부분

			// 성공적으로 전송되었음을 클라이언트에게 응답
			return "성공";
		} catch (Exception e) {
			e.printStackTrace();
			// 인증번호 전송 중 오류가 발생한 경우 클라이언트에게 오류 메시지 응답
			return "오류";
		}
	}

	// send_msg 메서드를 이용하여 랜덤한 인증번호를 생성하고 문자 메시지 전송
	private String sendRandomMessage(String phoneNumber) {
		Random rand = new Random();
		StringBuilder numStr = new StringBuilder();
		for (int i = 0; i < 6; i++) {
			rand = new Random(); // 상태 초기화
			String ran = Integer.toString(rand.nextInt(10));
			numStr.append(ran);
		}

		return numStr.toString();
	}

	@SuppressWarnings("unchecked")
	private void send_msg(String phoneNumber, String rand) {
		// 호스트 URL
		String hostNameUrl = "https://sens.apigw.ntruss.com";
		// 요청 URL
		String requestUrl = "/sms/v2/services/";
		// 요청 URL Type
		String requestUrlType = "/messages";
		// 개인 인증키
		String accessKey = "HIWMDreyw22nglomUBGA";
		// 2차 인증을 위해 서비스마다 할당되는 service secret
		String secretKey = "rtRe0Xrs8H64jwBnzg34oewgDzV37wdC1pqA8cGM";
		// 프로젝트에 할당된 SMS 서비스 ID
		String serviceId = "ncp:sms:kr:315333884410:soolwhale";
		// 요청 method
		String method = "POST";
		// current timestamp (epoch)
		String timestamp = Long.toString(System.currentTimeMillis());
		requestUrl += serviceId + requestUrlType;
		String apiUrl = hostNameUrl + requestUrl;

		// JSON 을 활용한 body data 생성
		JSONObject bodyJson = new JSONObject();
		JSONObject toJson = new JSONObject();
		JSONArray toArr = new JSONArray();

		// toJson.put("subject",""); // Optional, messages.subject 개별 메시지 제목, LMS,
		// MMS에서만 사용 가능
		// toJson.put("content","sms test in spring 111"); // Optional, messages.content
		// 개별 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
		toJson.put("to", phoneNumber); // Mandatory(필수), messages.to 수신번호, -를 제외한 숫자만 입력 가능
		toArr.add(toJson);

		bodyJson.put("type", "SMS"); // Madantory, 메시지 Type (SMS | LMS | MMS), (소문자 가능)
		// bodyJson.put("contentType",""); // Optional, 메시지 내용 Type (AD | COMM) * AD:
		// 광고용, COMM: 일반용 (default: COMM) * 광고용 메시지 발송 시 불법 스팸 방지를 위한 정보통신망법 (제 50조)가
		// 적용됩니다.
		// bodyJson.put("countryCode","82"); // Optional, 국가 전화번호, (default: 82)
		bodyJson.put("from", "01095420860"); // Mandatory, 발신번호, 사전 등록된 발신번호만 사용 가능
		// bodyJson.put("subject",""); // Optional, 기본 메시지 제목, LMS, MMS에서만 사용 가능
		bodyJson.put("content", "술고래 본인 확인 문자입니다. [" + rand + "] " + "를 입력해주세요"); // Mandatory(필수), 기본 메시지 내용, SMS: 최대
																					// 80byte, LMS, MMS: 최대
		// 2000byte
		bodyJson.put("messages", toArr);

		// String body = bodyJson.toJSONString();
		String body = bodyJson.toString();

		System.out.println(body);

		try {
			URL url = new URL(apiUrl);

			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setUseCaches(false);
			con.setDoOutput(true);
			con.setDoInput(true);
			con.setRequestProperty("content-type", "application/json");
			con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
			con.setRequestProperty("x-ncp-iam-access-key", accessKey);
			con.setRequestProperty("x-ncp-apigw-signature-v2",
					makeSignature(requestUrl, timestamp, method, accessKey, secretKey));
			con.setRequestMethod(method);
			con.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());

			wr.write(body.getBytes());
			wr.flush();
			wr.close();

			int responseCode = con.getResponseCode();
			BufferedReader br;
			System.out.println("responseCode" + " " + responseCode);
			if (responseCode == 202) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}

			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();

			System.out.println(response.toString());

		} catch (Exception e) {
			System.out.println(e);
		}

	}

	@PostMapping("/phoneAuthOk")
	@ResponseBody
	public Map<String, Object> phoneAuthOk(@RequestParam("identityVerification") String identityVerification,
			HttpSession session) {
		String verificationCode = (String) session.getAttribute("verificationCode");
		Map<String, Object> response = new HashMap<>();

		if (verificationCode != null && verificationCode.trim().equals(identityVerification.trim())) {

			String phoneNumber = (String) session.getAttribute("phoneNumber");

			// phoneNumber가 null인 경우의 로직 추가
			if (phoneNumber == null) {
				response.put("success", false);
				response.put("message", "세션에서 핸드폰 번호를 가져오는 데 실패했습니다.");
				return response;
			}

			if (userService.checkPhone(phoneNumber)) {
				response.put("success", false); // 핸드폰 번호 중복됨
				response.put("message", "이미 등록된 핸드폰 번호입니다.");
			} else {
				response.put("success", true); // 인증 및 중복 체크 성공
			}

		} else {
			response.put("success", false); // 인증 실패
			response.put("message", "인증 코드가 일치하지 않습니다.");
		}

		return response;
	}

	public static String makeSignature(String url, String timestamp, String method, String accessKey, String secretKey)
			throws NoSuchAlgorithmException, InvalidKeyException {

		String space = " ";
		String newLine = "\n";

		String message = new StringBuilder().append(method).append(space).append(url).append(newLine).append(timestamp)
				.append(newLine).append(accessKey).toString();

		SecretKeySpec signingKey;
		String encodeBase64String;
		try {
			signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
			Mac mac = Mac.getInstance("HmacSHA256");
			mac.init(signingKey);
			byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
			encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
		} catch (UnsupportedEncodingException e) {
			encodeBase64String = e.toString();
		}

		return encodeBase64String;
	}

	// 아이디 중복 검사(AJAX)
	@RequestMapping(value = "/checkId", method = RequestMethod.POST)
	public void checkId(@RequestParam("id") String id, HttpServletResponse response) throws Exception {
		userService.checkId(id, response);
	}

	// 이메일 중복 검사(AJAX)
	@RequestMapping(value = "/checkEmail", method = RequestMethod.POST)
	public void checkEmail(@RequestParam("email") String email, HttpServletResponse response) throws Exception {
		userService.checkEmail(email, response);
	}


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@Setter(onMethod_ = @Autowired)
	private PointService pointService;
	

	@Setter(onMethod_ = @Autowired)
	private LikeService likeService;
	

	@GetMapping(value="/myInfoMain")
	public String myInfoMain(Model model, @SessionAttribute(name = "user", required = false)UserVO user, HttpSession session, PointVO pvo, LikeVO lvo){
		log.info("myInfoMain 화면 호출");
		
		if(user != null) {
		
			   pvo.setUser(user);
		        pvo.setUserNum(user.getUserNum());
		    	user.setUserNum(user.getUserNum());
		       
		    	log.info("uerNum" + pvo.getUserNum());

		        PointVO pointsum = pointService.pointSum(user.getUserNum());
		    	log.info("pointsum 값은" +  pointsum + "입니다.");
				model.addAttribute("pointSum" , pointsum);
				List<LikeVO> likeAllList = likeService.likeAllList(lvo);
				user.setUserNum(user.getUserNum());
				log.info("LikeAllList-true : " + likeAllList );
				
				model.addAttribute("likeAllList", likeAllList);
				model.addAttribute("userNum" , user.getUserNum());
			
				  log.info("Controller userNum 값  " + user.getUserNum());
		
		return "client/member/myInfoMain";
		}else {
			return "redirect:/member/login";
		}
	};



	@PostMapping ("/userDelete")
    public String userDelete(@SessionAttribute("user") UserVO user,  HttpSession session, Model model, RedirectAttributes redirectAttributes) throws Exception{

		log.info("user 탈퇴" );
		
		int result = 0;
        result = userService.userDelete(user);
        log.info("email : " + user.getEmail());
        if(result == 1) {
        	log.info("user 로그아웃 처리");
    		session.invalidate();
    		return "redirect:/";
        }else {
        	
        	return "client/member/myInfo";
        }
         
         
        
  
    }

	@ResponseBody
	@PostMapping(value="/rePwConfirm", produces="text/plain; chardset=UTF-8" )
	public String repwdConfirm(UserVO pass , HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		UserVO user = (UserVO) session.getAttribute("login");
		log.info("repwConfirm 메서드 호출 성공 0일치 1불일치");
		log.info("user" + pass.getUserNum());
		log.info("email" + user.getEmail());
		String value="";
		int result=0;

		//입력 성공에 대한 상태값 저장
		result= userService.rePwdConfirm(pass);
		
		if(result==1) {
			value="성공";
		}else {
			value="실패";
		}
		log.info("result="+result);
		log.info("return" + value);
		return value;	//value값 자체를 브라우저에 출력
	};

	

@GetMapping(value = "/pwConfirm")
public String pwConfirm(Model model,  @SessionAttribute(name = "user", required = false)UserVO user, HttpSession session) {
	  // HttpSession을 이용하여 세션 정보를 가져옴
   
	log.info("pwConfirm 화면 호출");
    if (user != null) {
        // 세션에 로그인 정보가 존재함
    	  log.info("userNum 값" + user.getUserNum());
    	  log.info("userEmail :" + user.getEmail());
    	  
        model.addAttribute("username", user.getName()); 
        model.addAttribute("usernum", user.getUserNum()); 
        session.setAttribute("login", user);
       
		model.addAttribute("password", user.getPassword());
		

		return "client/member/pwConfirm"; // 로그인 상태이므로 원하는 페이지로 리디렉션
    } else {
        // 세션에 로그인 정보가 없음
        return "redirect:/member/login"; // 로그인 페이지로 리디렉션
    }
		


	}




@GetMapping(value="/myInfo")
public String myInfoPage(Model model, @SessionAttribute(name = "user", required = false)UserVO user, HttpSession session) {
	log.info("myinfo 화면 호출");
    if (user != null) {
        // 세션에 로그인 정보가 존재함
   
     
		model.addAttribute("password", user.getPassword());
		
		log.info("myInfo 화면 호출" );
		log.info("uvo = " + user);
		
		
		UserVO userData = userService.myInfoPage(user);
		
		model.addAttribute("userData", userData);
		
		return "client/member/myInfo"; // 로그인 상태이므로 원하는 페이지로 리디렉션
    } else {
        // 세션에 로그인 정보가 없음
        return "redirect:/member/login"; // 로그인 페이지로 리디렉션
    }
		


	}

@PostMapping(value="/myInfo")
public String myInfoPage(Model model,@SessionAttribute("user") UserVO user, HttpServletRequest request) {
	

	log.info("pwConfirm 화면 호출");
    if (user != null) {

        model.addAttribute("username", user.getName()); 
        model.addAttribute("usernum", user.getUserNum()); 
      
       
		model.addAttribute("password", user.getPassword());
		log.info("myInfo 화면 호출" );
		//log.info("uvo = " + uvo);
		
		
		UserVO userData = userService.myInfoPage(user);
		
		model.addAttribute("userData", userData);
		

		return "client/member/myInfo"; // 로그인 상태이므로 원하는 페이지로 리디렉션
    } else {
        // 세션에 로그인 정보가 없음
        return "redirect:/member/login"; // 로그인 페이지로 리디렉션
    }
		


	}


	@PostMapping(value="/myInfoUpdate")
	public String myInfoUpdate(Model model,@SessionAttribute("user") UserVO user) {
		log.info("myInfoUpdate 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = userService.myInfoUpdate(user);
		
		if(result == 1) {
			url = "/SoolWhale/member/myInfo";
		}else {
			
			url ="/";
		}
		
		return "redirect:" + url;
		
	
		
		
	}

	@ResponseBody
	@PostMapping(value="/upPwdConfirm", produces="text/plain; chardset=UTF-8" )
	public String upPwdConfirm(@SessionAttribute("user") UserVO user) {
			log.info("uppwConfirm 메서드 호출 성공 0일치 1불일치");
		log.info("user" + user.getUserNum());
		log.info("email" + user.getEmail());
		String value="";
		int result=0;

		//입력 성공에 대한 상태값 저장
		result= userService.upPwdConfirm(user);
		
		
		if(result==1) {
			log.info("컨틀롤러성공");
			value="성공";
			log.info("컨틀롤러성공");
		}else {
			log.info("컨틀롤러실패");
			value="실패";
		}
		log.info("result="+result);
		log.info("return" + value);
		return value;	//value값 자체를 브라우저에 출력
		
		
	};
	
	
	
	
	
	

}
