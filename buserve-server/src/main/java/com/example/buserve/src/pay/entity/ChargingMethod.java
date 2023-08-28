package com.example.buserve.src.pay.entity;

import com.example.buserve.src.user.User;
import lombok.*;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Builder
@AllArgsConstructor
public class ChargingMethod {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name; // 충전 수단 이름
    private String details; // 상세 정보

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user; // 충전 수단과 연관된 사용자

    @Column(name = "is_primary", nullable = false, columnDefinition = "boolean default false")
    private boolean isPrimary = false;


    public void setUser(User user) {
        this.user = user;
        user.getChargingMethods().add(this);

        if (user.getChargingMethods().size() == 1) {
            user.setPrimaryChargingMethod(this);
        }
    }

    public void setPrimary(boolean primary) {
        this.isPrimary = primary;
    }

    public boolean isPrimary() {
        return this.isPrimary;
    }
}
