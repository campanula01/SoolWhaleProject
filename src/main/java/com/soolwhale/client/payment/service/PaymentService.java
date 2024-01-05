package com.soolwhale.client.payment.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.springframework.data.repository.query.Param;
import org.springframework.http.ResponseEntity;

import com.soolwhale.client.payment.dto.PaymentAPIDto;
import com.soolwhale.client.payment.vo.PaymentVO;
import com.soolwhale.client.project.vo.ProjectVO;
import com.soolwhale.client.user.vo.UserVO;

public interface PaymentService {
	public int paymentInsert(PaymentVO pvo);
	public PaymentVO paymentComplete(@Param("projectNum") String projectNum);
    public PaymentVO projectDetailCount(ProjectVO vo);
	public String tokenBilling(String customer_uid, String token);
	public int paymentDelete(String paymentNum);
	public int paymentDeleteByCancel(String merchantUid);
	
	public int paymentUpdate(String merchantUid, String billingKey) throws Exception;
	public List<PaymentVO> amountList();
	public Timestamp paymentDate(String merchantUid);
	
	public String generateIamportToken();
	public String generateNewMerchantUID();
	public ResponseEntity<Map<String, String>> executeBillByKey(PaymentAPIDto paymentApiDto);
	
	public List<PaymentVO> paymentList(UserVO user);

	public List<PaymentVO> paymentListDetail(String merchantUid, UserVO user);
	public PaymentVO paymentListDetailChoice(String merchantUid, UserVO user);
	
	
	public List<PaymentVO> paymentAllList();
	
}

