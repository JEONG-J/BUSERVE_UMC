package com.example.buserve.src.reservation.controller;

import com.example.buserve.src.common.ApiResponse;
import com.example.buserve.src.reservation.dto.ReservationRequestDto;
import com.example.buserve.src.reservation.dto.ReservationResponseDto;
import com.example.buserve.src.reservation.service.ReservationService;
import com.example.buserve.src.user.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.security.Principal;
import java.util.List;

@Api(tags = {"예약 관련 API"})
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/reservations")
public class ReservationController {

    private final ReservationService reservationService;
    private final UserService userService;

    @ApiOperation(value = "예약 내역 조회", notes = "사용자의 예약 내역을 최근순으로 조회한다.")
    @GetMapping
    public ApiResponse<List<ReservationResponseDto>> getReservations(String name) {
        final Long userId = userService.getUserIdByUsername(name);
//        Long userId = getUserIdFromPrincipal(principal);
        return ApiResponse.success(reservationService.getReservations(userId));
    }

    @ApiOperation(value = "예약 생성", notes = "사용자의 예약을 생성한다.")
    @PostMapping
    public ApiResponse<ReservationResponseDto> createReservation(String name, @Valid @RequestBody ReservationRequestDto requestDto) {
        Long userId = userService.getUserIdByUsername(name);
//        Long userId = getUserIdFromPrincipal(principal);
        return ApiResponse.success(reservationService.createReservation(userId, requestDto));
    }

    @ApiOperation(value = "예약 세부 정보 조회", notes = "특정 예약의 세부 정보를 조회한다.")
    @GetMapping("/{reservationId}")
    public ApiResponse<ReservationResponseDto> getReservationDetail(String name, @PathVariable Long reservationId) {
        Long userId = userService.getUserIdByUsername(name);
//        Long userId = getUserIdFromPrincipal(principal);
        return ApiResponse.success(reservationService.getReservationDetail(userId, reservationId));
    }


    @ApiOperation(value = "예약한 버스에 탑승", notes = "해당 예약의 상태를 대기에서 탑승으로 변경한다.")
    @PutMapping("/{reservationId}/mark-boarded")
    public ApiResponse<ReservationResponseDto> completeBoarding(String name, @PathVariable Long reservationId) {
        Long userId = userService.getUserIdByUsername(name);
//        Long userId = getUserIdFromPrincipal(principal);
        return ApiResponse.success(reservationService.completeBoarding(userId, reservationId));
    }

    // 로그인한 사용자의 ID를 획득하는 메서드 (구현 필요)
    private Long getUserIdFromPrincipal(Principal principal) {
        // 로그인한 사용자의 ID를 반환하는 로직
        // 예: return ((UserDetailsImpl) ((UsernamePasswordAuthenticationToken) principal).getPrincipal()).getId();

        // 임시로 사용자 ID 1L 반환
        return 1L;
    }
}
