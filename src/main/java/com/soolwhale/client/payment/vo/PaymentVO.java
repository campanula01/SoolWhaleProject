package com.soolwhale.client.payment.vo;

import java.sql.Timestamp;
import java.util.List;

import com.soolwhale.client.address.vo.AddressVO;
import com.soolwhale.client.project.vo.ProjectVO;
import com.soolwhale.client.reward.vo.RewardVO;
import com.soolwhale.client.user.vo.UserVO;

import lombok.Data;

@Data
public class PaymentVO {
	
	private String paymentNum;	//결제내역번호
	private String usePoint;	//사용포인트
	private String deliveryCharge;	//배송비
	private String paymentDate;	//결제일시
	private String addrNum;	//배송지 번호
	private String userNum;	//사용자 번호
	private String deliveryYN;	//주문상태
	private String payAmount;	//결제금액
	private String paymentMethod;	//결제수단
	private String addPoint; //적립포인트
	private String projectNum;
	private String billingKey;
	private String merchantUid;
	private String additionalDonation;
	private List<String> reward;	//여러 리워드
	private Timestamp executeTimestamp;	//결제 예정 날짜
	private String status;
	
	private String singleReward;
	private String paymentCount;
	private String totalAmount;	//결제 테이블에서 결제한 총 합
	
	private AddressVO address;
	private RewardVO rewardr;
	private ProjectVO project;
	private UserVO user;

	
	


	
	public void setSingleReward(String singleReward) {
	    this.singleReward = singleReward;
	}

	

}
