package com.soolwhale.client.payment.service;

import java.sql.Timestamp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.soolwhale.client.payment.dto.PaymentAPIDto;
import com.soolwhale.client.payment.dto.ScheduledPayment;


@Service
public class PaymentSchedulerService {
	

	
	   @Autowired
	    private PaymentService paymentService;


	    @Autowired
	    private ScheduledPaymentRepository scheduledPaymentRepository;  
	    // 예정된 결제를 저장하기 위한 리포지토리

	    public void schedulePayment(PaymentAPIDto scheduledPaymentDto) {
	        ScheduledPayment payment = new ScheduledPayment();
	        payment.setCustomerUid(scheduledPaymentDto.getCustomerUid());
	        payment.setAmount(scheduledPaymentDto.getAmount());
	        payment.setMerchantUid(scheduledPaymentDto.getMerchantUid());
	        payment.setExecuteTimestamp(scheduledPaymentDto.getExecuteTimestamp());

	        scheduledPaymentRepository.save(payment);  // 예정된 결제를 데이터베이스에 저장
	    }

	    //@Scheduled(fixedDelay = 60000)  // 1분마다 실행
	    public void executeScheduledPayment() {
	        List<ScheduledPayment> paymentsToExecute = scheduledPaymentRepository.findAllByExecuteTimestampBefore(new Timestamp(System.currentTimeMillis()));

	        for (ScheduledPayment payment : paymentsToExecute) {
	            boolean paymentSuccess = billByKey(payment.getCustomerUid(), payment.getAmount(), payment.getMerchantUid());

	            if (paymentSuccess) {
	                // 결제가 성공한 경우
	                scheduledPaymentRepository.delete(payment);
	            } else {
	                // 결제가 실패한 경우
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