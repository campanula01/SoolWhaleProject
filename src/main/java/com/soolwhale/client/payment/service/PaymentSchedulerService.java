package com.soolwhale.client.payment.service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.soolwhale.client.payment.dto.PaymentAPIDto;
import com.soolwhale.client.payment.dto.ScheduledPayment;

import lombok.Setter;

@Service
public class PaymentSchedulerService {
	
	/*
	
	@Setter(onMethod_=@Autowired)
	private PaymentService paymentService;
	
	

	  private final Object lock = new Object();
	    private Queue<PaymentAPIDto> paymentQueue = new LinkedList<>();

	    @Autowired
	    private RestTemplate restTemplate;

	    // 결제 데이터 스케줄링
	    public void schedulePayment(PaymentAPIDto paymentApiDto) {
	        synchronized (lock) {
	            paymentQueue.add(paymentApiDto);
	        }
	    }

	    @Scheduled(fixedDelay = 60000)  // 1분마다 실행
	    public void executeScheduledPayment() {
	        synchronized (lock) {
	            while (!paymentQueue.isEmpty()) {
	                PaymentAPIDto payment = paymentQueue.poll();
	                if (payment != null) {
	                    // 결제 로직 실행
	                    boolean paymentSuccess = billByKey(payment.getCustomer_uid(), payment.getAmount(), payment.getMerchant_uid());

	                    // 결제가 성공하면 어떤 처리를 수행할 수 있습니다.
	                    if (paymentSuccess) {
	                        // 결제가 성공한 경우의 처리
	                    } else {
	                        // 결제가 실패한 경우의 처리
	                    }
	                }
	            }
	        }
	    }

	    // 실제 결제 로직을 구현합니다.
	    private boolean billByKey(String customer_uid, String amount, String merchant_uid) {
	        try {
	          
	        	PaymentAPIDto paymentApiDto = new PaymentAPIDto(customer_uid,amount,merchant_uid );
	        	ResponseEntity<Map<String, String>> response = paymentService.executeBillByKey(paymentApiDto);

	            // response를 검사하여 성공/실패 여부를 반환합니다.
	            return response.getStatusCode() == HttpStatus.OK;
	        } catch (Exception e) {
	            // 결제 처리 중 예외가 발생한 경우
	            e.printStackTrace();
	            return false;
	        }
	    }
	    

		
		*/
	
	   @Autowired
	    private PaymentService paymentService;


	    @Autowired
	    private ScheduledPaymentRepository scheduledPaymentRepository;  // 예정된 결제를 저장하기 위한 리포지토리

	    public void schedulePayment(PaymentAPIDto scheduledPaymentDto) {
	        ScheduledPayment payment = new ScheduledPayment();
	        payment.setCustomerUid(scheduledPaymentDto.getCustomerUid());
	        payment.setAmount(scheduledPaymentDto.getAmount());
	        payment.setMerchantUid(scheduledPaymentDto.getMerchantUid());
	        payment.setExecuteTimestamp(scheduledPaymentDto.getExecuteTimestamp());

	        scheduledPaymentRepository.save(payment);  // 예정된 결제를 데이터베이스에 저장
	    }

	    @Scheduled(fixedDelay = 60000)  // 1분마다 실행
	    public void executeScheduledPayment() {
	        List<ScheduledPayment> paymentsToExecute = scheduledPaymentRepository.findAllByExecuteTimestampBefore(new Timestamp(System.currentTimeMillis()));

	        for (ScheduledPayment payment : paymentsToExecute) {
	            boolean paymentSuccess = billByKey(payment.getCustomerUid(), payment.getAmount(), payment.getMerchantUid());

	            if (paymentSuccess) {
	                // 결제가 성공한 경우의 처리 (예: 데이터베이스에서 예정된 결제 삭제)
	                scheduledPaymentRepository.delete(payment);
	            } else {
	                // 결제가 실패한 경우의 처리 (예: 실패 카운트를 증가시키거나 알림 전송)
	            }
	        }
	    }

	    private boolean billByKey(String customerUid, String amount, String merchantUid) {
	        try {
	            PaymentAPIDto paymentApiDto = new PaymentAPIDto(customerUid, amount, merchantUid);
	            ResponseEntity<Map<String, String>> response = paymentService.executeBillByKey(paymentApiDto);

	            return response.getStatusCode() == HttpStatus.OK;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	    

	  
	}