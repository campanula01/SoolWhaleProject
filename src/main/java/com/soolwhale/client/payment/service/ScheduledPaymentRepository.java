package com.soolwhale.client.payment.service;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.soolwhale.client.payment.dto.ScheduledPayment;

import java.sql.Timestamp;
import java.util.List;

@Repository
public interface ScheduledPaymentRepository extends JpaRepository<ScheduledPayment, Long> {

    // 현재 시간보다 이전에 예정된 모든 결제를 조회
    List<ScheduledPayment> findAllByExecuteTimestampBefore(Timestamp executeTime);
}
