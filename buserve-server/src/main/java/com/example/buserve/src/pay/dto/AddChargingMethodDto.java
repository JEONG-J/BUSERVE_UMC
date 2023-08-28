package com.example.buserve.src.pay.dto;


import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AddChargingMethodDto {
    private String name; // 충전 수단 이름
    private String details; // 상세 정보
}
