package com.soolwhale.client.payment.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaymentAPIDto {
	private String amount;
	private String membershipKey;
	
	private String customerUid;

	private String buyerEmail;
    private String buyerName;
    private String buyerTel;
    private int consumPrice;
    private String merchantUid;
	private Timestamp executeTimestamp;	//결제 예정 날짜
	private String projectNum;

    
    private String scheduleAt;
    private String currency;
    
    public PaymentAPIDto(String customer_uid, String amount, String merchant_uid) {
    	this.customerUid = customer_uid;
    	this.amount = amount;
    	this.merchantUid = merchant_uid;
    }

}



