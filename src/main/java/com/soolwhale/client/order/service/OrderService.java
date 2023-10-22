package com.soolwhale.client.order.service;

import java.util.List;

import com.soolwhale.client.order.vo.OrderVO;

public interface OrderService {
	public List<OrderVO> orderList(OrderVO ovo);
	
	public OrderVO orderListDetail(OrderVO ovo);
	
}
