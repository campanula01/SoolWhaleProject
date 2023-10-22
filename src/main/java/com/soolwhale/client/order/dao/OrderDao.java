package com.soolwhale.client.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.soolwhale.client.order.vo.OrderVO;

@Mapper
public interface OrderDao {
	public List<OrderVO> orderList(OrderVO ovo);
	
	public OrderVO orderListDetail(OrderVO ovo);
	
}
