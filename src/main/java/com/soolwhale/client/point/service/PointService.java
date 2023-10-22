package com.soolwhale.client.point.service;

import java.util.List;

import com.soolwhale.client.point.vo.PointVO;

public interface PointService {

	public int pointInsert(PointVO vo, String userNum);
	

	public PointVO pointSum(String userNum);

	

	 public List<PointVO> pointCheckList(String userNum);
}
