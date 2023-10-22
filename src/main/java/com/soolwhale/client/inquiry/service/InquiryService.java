package com.soolwhale.client.inquiry.service;

import java.util.List;

import com.soolwhale.client.inquiry.vo.InquiryVO;

public interface InquiryService {
	public List<InquiryVO> inquiryList(InquiryVO ivo);
	public int inquiryInsert(InquiryVO ivo);
	public InquiryVO inquiryDetail(InquiryVO ivo); //update 폼 겸용
	
	public int inquiryUpdate(InquiryVO ivo) throws Exception;
	
	public InquiryVO updateForm(InquiryVO ivo);
	
	public int questionDelete(InquiryVO vo) throws Exception;
	
	public List<InquiryVO> inquiryList();
}
