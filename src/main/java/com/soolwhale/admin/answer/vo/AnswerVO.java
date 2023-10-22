package com.soolwhale.admin.answer.vo;

import com.soolwhale.client.inquiry.vo.InquiryVO;

import lombok.Data;

@Data
public class AnswerVO {
	private String answerNum;
	private String answerData;
	private String inquiryNum;
	private String inquireA;
	private String aModifyDate;
	private String managerName;
	private String managerNum ; // 관리자 번호 
	
	private InquiryVO inquiry;
}
