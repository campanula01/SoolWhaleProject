package com.soolwhale.client.reward.vo;



import lombok.Data;

@Data
public class RewardVO {
	private String reward;	//리워드 번호
	private String projectNum;	//프로젝트 번호
	private String rewardName;	//리워드 명
	private String rewardDesc;	//리워드 설명
	private String deliveryCharge;	//배송비 여부
	private String amount;	//리워드 금액
	
}
