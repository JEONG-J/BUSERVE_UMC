package com.example.buserve.src.bus.controller;

import com.example.buserve.src.bus.DTO.SeatDto;
import com.example.buserve.src.bus.service.BusService;
import com.example.buserve.src.common.ApiResponse;
import com.example.buserve.src.common.ApiResponseStatus;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api(tags = {"버스 관련 API"})
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/buses")
public class BusController {

    private final BusService busService;

    // 버스 좌석 리스트 조회
    @ApiOperation(value = "버스 좌석 리스트 조회", notes = "해당 버스의 좌석 리스트를 조회한다.")
    @GetMapping("/buses/{bus_id}/seats")
    public ApiResponse<List<SeatDto>> getSeatsForBus(@PathVariable Long bus_id) {
        return ApiResponse.success(busService.getSeatsForBus(bus_id));
    }
}
