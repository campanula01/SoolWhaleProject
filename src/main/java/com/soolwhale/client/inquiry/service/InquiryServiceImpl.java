package com.soolwhale.client.inquiry.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soolwhale.client.inquiry.dao.InquiryDao;
import com.soolwhale.client.inquiry.vo.InquiryVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class InquiryServiceImpl implements InquiryService {

	
	@Setter(onMethod_ = @Autowired)
	private InquiryDao inquiryDao;
	@Override
	public List<InquiryVO> inquiryList(InquiryVO ivo) {
		log.info("inquiryD");
		List<InquiryVO> list = null;
		list = inquiryDao.inquiryList(ivo);
		return list;
	}

	@Override
	public int inquiryInsert(InquiryVO ivo){
		log.info("inquiryInsert 호출");
		int result=0;
		result = inquiryDao.inquiryInsert(ivo);
		
		return result;
	}

	@Override
	public InquiryVO inquiryDetail(InquiryVO ivo) {
		log.info("inquiryDetail 호출 성공 ");
		
		InquiryVO inquiry = inquiryDao.inquiryDetail(ivo);
		
		if(inquiry != null) {
			inquiry.setInquiryQ(inquiry.getInquiryQ().toString().replaceAll("\n", "<br />"));
		}
		
		
		return inquiry;
	}
	
	@Override
	public InquiryVO updateForm(InquiryVO ivo) {
		InquiryVO updateDate =  null;
		
		updateDate = inquiryDao.inquiryDetail(ivo);
		
		log.info("updateForm 의 updateDate" + updateDate);
		
		return updateDate;
	}
	
	@Override
	public int inquiryUpdate(InquiryVO ivo) throws Exception {
		
		log.info("update 메서드 호출");
		
		int result = 0;
		
		
		result = inquiryDao.inquiryUpdate(ivo);
		return result;
	}
	
	
	@Override
	public int questionDelete(InquiryVO ivo) throws Exception {

			int result = 0;
			
			result = inquiryDao.questionDelete(ivo);
			return result;
		
	}
	
	
	
	
	
	
	
	
	
	
	

	@Override
	public List<InquiryVO> inquiryList() {
		List<InquiryVO> list = null;
		list = inquiryDao.inquiryListManagement();
		return list;
	}
}
