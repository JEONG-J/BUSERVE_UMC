package com.example.buserve.src.bus.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class Stop {
    @Id
    private String id;
    private String stopName;    // 정류장 이름
    private String stopNumber;  // 정류장 번호
    private String latitude;    // 정류장 위도
    private String longitude;   // 정류장 경도

    @OneToMany(mappedBy = "stop")
    private List<RouteStop> routeStops = new ArrayList<>();

    public Stop(String id, String stopName, String stopNumber, String latitude, String longitude) {
        this.id = id;
        this.stopName = stopName;
        this.stopNumber = stopNumber;
        this.latitude = latitude;
        this.longitude = longitude;
    }
}
