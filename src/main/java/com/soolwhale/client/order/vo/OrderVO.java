package com.soolwhale.client.order.vo;

import com.soolwhale.client.payment.vo.PaymentVO;
import com.soolwhale.client.project.vo.ProjectVO;
import com.soolwhale.client.reward.vo.RewardVO;
import com.soolwhale.client.user.vo.UserVO;

import lombok.Data;

@Data
public class OrderVO {
	private String orderNum = "";
	
	
	private PaymentVO payment;
	private ProjectVO project;
	private RewardVO reward;
	private UserVO user;
	
}
