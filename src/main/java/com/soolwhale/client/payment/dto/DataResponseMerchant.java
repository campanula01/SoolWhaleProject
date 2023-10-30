package com.soolwhale.client.payment.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class DataResponseMerchant {
   
   private String merchantUid;
   private String status;
   private String amount;
   

}