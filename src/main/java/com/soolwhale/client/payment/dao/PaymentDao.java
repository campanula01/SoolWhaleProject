package com.soolwhale.client.payment.dao;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.repository.query.Param;

import com.soolwhale.client.payment.vo.PaymentVO;
import com.soolwhale.client.project.vo.ProjectVO;
import com.soolwhale.client.user.vo.UserVO;

@Mapper
public interface PaymentDao {
	 public int paymentInsert(PaymentVO pvo);

	public PaymentVO paymentComplete(@Param("projectNum") String projectNum);
	public PaymentVO projectDetailCount(ProjectVO vo);
	public Timestamp paymentDate(String merchantUid);
	
	public int paymentDelete(String paymentNum);
	public int paymentDeleteByCancel(String merchantUid);
	
	
	public int paymentUpdate(String merchantUid, String billingKey);
	
	public List<PaymentVO> paymentList();

	public List<PaymentVO> amountList();
	
	

	public List<PaymentVO> paymentList(UserVO user);
	
	public List<PaymentVO> paymentListDetail(String merchantUid, UserVO user);
	public PaymentVO paymentListDetailChoice(String merchantUid, UserVO user);
	
	
	
}

