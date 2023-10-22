package com.soolwhale.admin.manager.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soolwhale.admin.manager.dao.ManagerDao;
import com.soolwhale.admin.manager.vo.ManagerVO;

import lombok.Setter;

@Service
public class ManagerServiceImpl implements ManagerService {

	
	
	@Setter(onMethod_ = @Autowired)
    private ManagerDao managerDao;

	@Override
	public ManagerVO ManagerLoginProcess(ManagerVO login) {
		
		ManagerVO managerLogoin = managerDao.ManagerLoginProcess(login);
		
		return managerLogoin;
	}

 
}
