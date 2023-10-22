package com.soolwhale.client.address.service;

import java.util.List;

import com.soolwhale.client.address.vo.AddressVO;

public interface AddressService {
	public List<AddressVO> addressList(String userNum);

	public int addressInsert(AddressVO avo, String userNum);
	public int countAddress(String userNum);
	public int deleteOldestAddress(String userNum);
	public int addressDelete(String addrNum);
	public int addressUpdate(AddressVO avo, String userNum) throws Exception;
}
