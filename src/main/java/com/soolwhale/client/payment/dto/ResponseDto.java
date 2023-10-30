package com.soolwhale.client.payment.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ResponseDto {
   
   private int code;
   private String message;
   
   private DataResponseMerchant response;
   
   

}