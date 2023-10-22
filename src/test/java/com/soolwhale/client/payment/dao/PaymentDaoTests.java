package com.soolwhale.client.payment.dao;

import java.sql.Timestamp;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.soolwhale.client.payment.vo.PaymentVO;
import com.soolwhale.client.project.vo.ProjectVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class PaymentDaoTests {

	@Setter(onMethod_ = @Autowired)
	private PaymentDao paymentDao;
	
	/*
	@Test
	public void paymentInsert() {
		PaymentVO pvo = new PaymentVO();
		pvo.setAddPoint("100");
		pvo.setUsePoint("101");
		pvo.setDeliveryCharge("3000");
		pvo.setAddrNum("1");
		pvo.setPayAmount("100000");
		pvo.setSingleReward("1");

		String userNum="1";
		int count = paymentDao.paymentInsert(pvo,userNum);
		log.info("입력된 행의 수: "+count);
	}
	
	
	*/
	/*
	@Test
	public void paymentComplete() {

	    PaymentVO paymentComplete = paymentDao.paymentComplete("1");
	    log.info("레코드 조회" + paymentComplete.toString());
		
		
		
	}
	*/
	/*
	@Test
	public void projectDetailCountTest() {
		ProjectVO vo = new ProjectVO();
		PaymentVO projectDetailCount = paymentDao.projectDetailCount(vo);
		log.info("레코드 조회"+projectDetailCount.toString());
	}
	*/
	
	/*
	@Test
	public void testAddressDelete() {
		PaymentVO pvo = new PaymentVO();
		
		
		log.info("payment"+paymentDao.paymentDelete("1"));
	}
	*/
	
	@Test
	public void testExecute() {
		String merchantUid = "merchantNew_fa3e2c1f82cc4356abda0e75b29b";
		
		Timestamp time = paymentDao.paymentDate(merchantUid);
		log.info("날짜"+time);
	}
}
