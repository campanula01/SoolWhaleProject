package com.soolwhale.client.point.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soolwhale.client.point.dao.PointDao;
import com.soolwhale.client.point.vo.PointVO;

import lombok.Setter;

@Service
public class PointServiceImpl implements PointService {

	@Setter(onMethod_=@Autowired)
	private PointDao pointDao;
	
	@Override
	public int pointInsert(PointVO vo,String userNum) {
		 int result = 0;

		 result = pointDao.pointInsert(vo,userNum);
	        return result;
	}
	
	@Override
	public List<PointVO> pointCheckList(String userNum) {
		List<PointVO> list = null;
		list = pointDao.pointCheckList(userNum);
		//log.info("Service userNum :" + userNum);
		return list;
	}
	
	@Override
	public PointVO pointSum(String userNum) {
		PointVO pvo = new PointVO();
		
		pvo = pointDao.pointSum(userNum);
		return pvo;
	}
}
