package com.example.buserve.src.pay.service;

import com.example.buserve.src.pay.dto.ChargingMethodInfoDto;
import com.example.buserve.src.pay.entity.ChargingMethod;
import com.example.buserve.src.pay.repository.ChargingMethodRepository;
import com.example.buserve.src.user.User;
import com.example.buserve.src.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ChargingMethodService {
    private final ChargingMethodRepository chargingMethodRepository;
    private final UserRepository userRepository;

    public List<ChargingMethod> getAllChargingMethods(Long userId) {
        // 사용자 ID를 기반으로 충전 수단을 찾습니다.
        return chargingMethodRepository.findByUserId(userId);
    }

    public ChargingMethod getChargingMethod(Long userId, Long id) {
        // 사용자 ID와 충전 수단 ID를 기반으로 충전 수단을 찾습니다.
        return chargingMethodRepository.findByUserIdAndId(userId, id)
                .orElseThrow(() -> new IllegalArgumentException("Charging method not found"));
    }

    public ChargingMethod addChargingMethod(Long userId, ChargingMethod chargingMethod) {
        // 사용자를 찾습니다.
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        // 사용자와 충전 수단을 연결합니다.
        chargingMethod.setUser(user);

        return chargingMethodRepository.save(chargingMethod);
    }


    public void deleteChargingMethod(Long userId, Long id) {
        // 먼저 사용자 ID와 일치하는 충전 수단이 있는지 확인합니다.
        ChargingMethod chargingMethod = getChargingMethod(userId, id);
        chargingMethodRepository.delete(chargingMethod);
    }

    public List<ChargingMethodInfoDto> convertToDto(List<ChargingMethod> chargingMethods) {
        return chargingMethods.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    public ChargingMethodInfoDto convertToDto(ChargingMethod chargingMethod) {
        return new ChargingMethodInfoDto(chargingMethod.getId(), chargingMethod.getName(), chargingMethod.getDetails(), chargingMethod.isPrimary());
    }

    @Transactional
    public void setPrimaryChargingMethod(Long userId, Long chargingMethodId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        ChargingMethod chargingMethod = chargingMethodRepository.findById(chargingMethodId).orElseThrow(() -> new RuntimeException("Charging method not found"));

        user.setPrimaryChargingMethod(chargingMethod);
    }

    public ChargingMethod getPrimaryChargingMethod(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        return user.getPrimaryChargingMethod();
    }
}

