package com.soolwhale.client.payment.dto;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaymentDto implements Serializable {
	private static final long serialVersionUID = 1L;

	private String name;
    private int quantity;
    private int pricePerUnit;
    private int amount;
    private int deliveryCharge;
    private String rewardTitle;
    private String rewardDesc;
    private int finalSumPriceDetail;
    private String rewardNum;
    private String projectNum;
    private int additionalDonation;
    
}
