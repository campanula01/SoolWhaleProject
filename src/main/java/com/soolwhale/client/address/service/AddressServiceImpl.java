package com.soolwhale.client.address.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soolwhale.client.address.dao.AddressDao;
import com.soolwhale.client.address.vo.AddressVO;

import lombok.Setter;

@Service
public class AddressServiceImpl implements AddressService {
	
	@Setter(onMethod_=@Autowired)
	private AddressDao addressDao;


	@Override
	public List<AddressVO> addressList(String userNum) {
		List<AddressVO> list =null;
		list = addressDao.addressList(userNum);
		return list;
	}

	/**@Transactional이 적용되어 있을 때, 이 두 연산 중 하나라도 실패하면 전체 트랜잭션이 롤백되어 데이터베이스는 원래의 상태로 돌아갑니다. 
	 * 즉, 데이터의 일관성과 무결성이 보장됩니다.*/
	@Override
	@Transactional
	public int addressInsert(AddressVO avo,String userNum) {
		int result=0;
		
		result=addressDao.addressInsert(avo, userNum);
		if (addressDao.countAddress(userNum) > 5) {
			addressDao.deleteOldestAddress(userNum);
        }
		return result;
	}

	@Override
	public int countAddress(String userNum) {
		return addressDao.countAddress(userNum);
	}

	@Override
	public int deleteOldestAddress(String userNum) {
		int result=0;
		result=addressDao.deleteOldestAddress(userNum);
		return result;
	}

	@Override
	public int addressDelete(String addrNum) {
		int result=0;
		result = addressDao.addressDelete(addrNum);
		return result;
	}

	@Override
	public int addressUpdate(AddressVO avo, String userNum) throws Exception {
		int result = 0;
		result = addressDao.addressUpdate(avo,userNum);
		return result;
	}

}
