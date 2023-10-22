package com.soolwhale.client.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soolwhale.client.order.dao.OrderDao;
import com.soolwhale.client.order.vo.OrderVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class OrderServiceImpl implements OrderService {

	@Setter(onMethod_ = @Autowired)
	private OrderDao orderDao;
	
	@Override
	public List<OrderVO> orderList(OrderVO ovo) {
		
		log.info("orderDao 호출");
		List<OrderVO> list = null;
		list = orderDao.orderList(ovo);
		return list;
		
	}
	
	public OrderVO orderListDetail(OrderVO ovo) {
		
		
		OrderVO detail = orderDao.orderListDetail(ovo);
	
		
		return detail;
		
	}

}
