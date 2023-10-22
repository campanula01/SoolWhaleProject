package com.soolwhale.client.image.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.soolwhale.client.address.controller.AddressController;
import com.soolwhale.client.address.service.AddressService;
import com.soolwhale.client.image.service.ImageService;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes("address")
@RequestMapping("/image/*")
@Slf4j
public class ImageController {

	@Setter(onMethod_=@Autowired)
	private ImageService imageService;
	
	
}
