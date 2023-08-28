//
//  KakaoAuthenticateAdapter.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/23.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

final class KakaoAuthenticateAdapter: NSObject, AuthenticateAdapter {

    private var continuation: CheckedContinuation<Bool, Error>?
    private var userInfoManager = UserInfoManager(saveUseCase: SaveUserInfoUseCase(), loadUseCase: LoadUserInfoUseCase())
    
    var adapterType: String {
        return "Kakao"
    }
    
    func login() async throws -> Bool {
        if UserApi.isKakaoTalkLoginAvailable() {
            // Kakao 토큰 가져오기
            let token = try await fetchKakaoToken()
            print("Received Token: \(token)")

            // Kakao 사용자 닉네임,이메일 가져오기
            let userInfo = try await fetchKakaoUserInfo()
            print("Received Nickname: \(userInfo)")
            
            // TODO: token과 nickname을 이용한 추가 로직을 여기에 작성
            let result = try await userInfoManager.saveUserInfo(name: userInfo.nickname, email: userInfo.email ?? "정보 없음", token: token, socialLoginType: adapterType)
            
            // 모든 작업이 성공적으로 완료되면 true 반환
            return result
        } else {
            // KakaoTalk 로그인이 사용 가능하지 않을 경우의 예외 처리를 여기에 추가하세요.
            throw NSError(domain: "KakaoLoginError", code: -2, userInfo: [NSLocalizedDescriptionKey: "KakaoTalk login is not available."])
            return false
        }
    }
    
    /// 유저 정보가 있는지 없는지 체크하는 함수 ( 있다면 로그인을 했었다 라고 가정 )
    func checkLoginState() async -> Bool {
        do {
            if let _ = try await userInfoManager.loadUserInfo() {
                // 유저 정보가 있으면 로그인 상태라고 판단
                return true
            } else {
                // 유저 정보가 없으면 로그아웃 상태라고 판단
                return false
            }
        } catch let error {
            print("Error loading user info:", error)
            // 오류가 발생하면 로그아웃 상태라고 판단
            return false
        }
    }

    private func fetchKakaoToken() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let token = oauthToken?.accessToken {
                        continuation.resume(returning: token)
                    } else {
                        let noTokenError = NSError(domain: "KakaoTokenError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No OAuth token received."])
                        continuation.resume(throwing: noTokenError)
                    }
                }
            }
        }
    }
    
    private func fetchKakaoUserInfo() async throws -> (nickname: String, email: String?) {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.me { (user, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let nickname = user?.kakaoAccount?.profile?.nickname,
                          let email = user?.kakaoAccount?.email {
                    continuation.resume(returning: (nickname, email))
                } else {
                    let detailsError = NSError(domain: "KakaoUserInfoError", code: -2, userInfo: [NSLocalizedDescriptionKey: "Unable to fetch user details."])
                    continuation.resume(throwing: detailsError)
                }
            }
        }
    }
}
