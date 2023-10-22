package com.soolwhale;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;


@EnableScheduling
@SpringBootApplication
public class SoolWhaleFinalApplication {

	public static void main(String[] args) {
		SpringApplication.run(SoolWhaleFinalApplication.class, args);
	}

}
