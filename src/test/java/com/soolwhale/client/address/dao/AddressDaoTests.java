package com.soolwhale.client.address.dao;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.soolwhale.client.address.dao.AddressDao;
import com.soolwhale.client.address.vo.AddressVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class AddressDaoTests {

	@Setter(onMethod_=@Autowired)
	private AddressDao addressDao;
	/*
	@Test
	public void testAddressList() {
		AddressVO avo = new AddressVO();
		String userNum="1";
		List<AddressVO> list = addressDao.addressList(avo,userNum);
		log.info(list.toString());
	}
	*/
	/*
	@Test
	public void testAddressInsert() {
		AddressVO avo = new AddressVO();
		avo.setZipcode("1234");
		avo.setAddr("주소2");
		avo.setAddrDetail("상세주소2");
		avo.setRecipient("홍길동");
		avo.setPhoneNumber("010-2121-1233");
		log.info(avo.toString());
	}
	
	public List<AddressVO> addressList(AddressVO vo);

	public int addressInsert(AddressVO avo);
	public int countAddress();
	public String deleteOldestAddress();
	*/
	
	/*
	@Test
	public void testAddressCount() {
		AddressVO avo = new AddressVO();
		
		int count = addressDao.countAddress();
		log.info(Integer.toString(count));
	}
	*/
	/*
	@Test
	public void testAddressDelete() {
		AddressVO avo = new AddressVO();
		
		String address = addressDao.deleteOldestAddress();
		log.info(address);
	}
	*/
}
