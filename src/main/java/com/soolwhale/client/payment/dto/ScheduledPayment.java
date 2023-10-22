package com.soolwhale.client.payment.dto;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name="scheduled_payments")
@Data
public class ScheduledPayment {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "customer_uid")
    private String customerUid;

    private String amount;

    @Column(name = "merchant_uid")
    private String merchantUid;

    @Column(name = "execute_timestamp")
    private Timestamp executeTimestamp;

}
