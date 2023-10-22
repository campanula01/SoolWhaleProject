package com.soolwhale.client.address.vo;

import com.soolwhale.client.point.vo.PointVO;
import com.soolwhale.client.user.vo.UserVO;

import lombok.Data;

@Data
public class AddressVO {
	private String addrNum;
	private String zipcode;
	private String addr;
	private String addrDetail;
	private String req;
	private String recipient;
	private String tel;
	private String userNum;

	//inner join 해서 사용할 값
	private PointVO point;
	private UserVO user;


}
