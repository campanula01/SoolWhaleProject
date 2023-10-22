package com.soolwhale.admin.manager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.soolwhale.admin.manager.vo.ManagerVO;


@Mapper
public interface ManagerDao {
	public List<ManagerVO> adminLoginList();
	public ManagerVO ManagerLoginProcess(ManagerVO login);
	
}
