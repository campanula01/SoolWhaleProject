package com.soolwhale.client.point.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.soolwhale.client.point.vo.PointVO;

@Mapper
public interface PointDao {
	
	public int pointInsert(PointVO vo, String userNum);

	public List<PointVO> pointCheckList(String userNum);
	public PointVO pointSum(String userNum);
	
	public void userPointDelete(String userNum);
}
