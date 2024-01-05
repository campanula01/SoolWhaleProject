package com.soolwhale.client.address.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.repository.query.Param;

import com.soolwhale.client.address.vo.AddressVO;

@Mapper
public interface AddressDao {
	
	public List<AddressVO> addressList(String userNum);
	
	public int addressInsert(@Param("avo") AddressVO avo, @Param("userNum") String userNum);
	public int countAddress(String userNum);
	public int deleteOldestAddress(String userNum);
	public int addressDelete(String addrNum);
	public int addressUpdate(AddressVO avo, String userNum);
	public void userAddressDelete(String userNum);

}
