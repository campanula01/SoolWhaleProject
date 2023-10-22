package com.soolwhale.client.point.vo;

import com.soolwhale.client.payment.vo.PaymentVO;
import com.soolwhale.client.user.vo.UserVO;

import lombok.Data;

@Data
public class PointVO {
	private String pointNum;	//포인트 번호
	private String pointSum;	//합계
	private String pointDate;	//적립 날짜
	private String pointDesc;	//적립 내용
	private String pointDelete;	//만료 날짜
	private String userNum;	//사용자 번호
	private String paymentNum;	//결제 내역 번호

	private UserVO user;
	private PaymentVO payment;
}
