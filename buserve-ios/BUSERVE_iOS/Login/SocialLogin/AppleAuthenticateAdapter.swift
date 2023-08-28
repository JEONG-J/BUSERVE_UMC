//
//  AppleAuthenticateAdapter.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/20.
//

import Foundation
import AuthenticationServices

final class AppleAuthenticateAdapter: NSObject, AuthenticateAdapter {
    
    private var continuation: CheckedContinuation<Bool, Error>?
    private var userInfoManager = UserInfoManager(saveUseCase: SaveUserInfoUseCase(), loadUseCase: LoadUserInfoUseCase())
    
    var adapterType: String {
        return "Apple"
    }
    
    func login() async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
           self.continuation = continuation
           
           let request = ASAuthorizationAppleIDProvider().createRequest()
           request.requestedScopes = [.fullName, .email]
           
           let controller = ASAuthorizationController(authorizationRequests: [request])
           controller.delegate = self
           controller.presentationContextProvider = self
           controller.performRequests()
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
}

extension AppleAuthenticateAdapter: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                continuation?.resume(throwing: NSError(domain: "AppleAuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid or missing credentials."]))
                continuation = nil
                return
            }
        Task {
            do {
                let userIdentifier = appleIDCredential.user
                guard let token = appleIDCredential.identityToken else {
                    print("Error: Missing identity token.")
                    return
                }
                
                guard let tokenString = String(data: token, encoding: .utf8) else {
                    print("Error: Could not convert token to string.")
                    return
                }
                
                if let savedData = UserDefaults.standard.data(forKey: "userInfo") {
                    
                    print("재 로그인")
                    
                    let loadedUser = try JSONDecoder().decode(UserInfo.self, from: savedData)
                    
                    // 이전 로그인에서 저장된 정보를 로드
                    let savedFullName = loadedUser.name
                    let savedEmail = loadedUser.email
                    
                    let result = try await userInfoManager.saveUserInfo(name: savedFullName, email: savedEmail, token: tokenString, socialLoginType: adapterType)
                    
                    continuation?.resume(returning: result)
                    continuation = nil
                    
                } else {
                    print("첫 로그인")
                    // 첫 로그인이면 Apple에서 받은 정보 사용, 아니면 저장된 정보 사용
                    let email = appleIDCredential.email
                    var fullName: String? = nil
                    if let familyName = appleIDCredential.fullName?.familyName,
                       let givenName = appleIDCredential.fullName?.givenName {
                        fullName = "\(familyName)\(givenName)"
                    } else {
                        print("Failed to retrieve full name.")
                    }

                    let result = try await userInfoManager.saveUserInfo(name: fullName ?? "정보없음", email: email  ?? "정보없음", token: tokenString, socialLoginType: adapterType)
                    
                    continuation?.resume(returning: result)
                    continuation = nil
                }
            } catch {
                print("Unexpected error:", error)
                continuation?.resume(throwing: error)
                continuation = nil
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
}

extension AppleAuthenticateAdapter: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // 필요한 window 반환. 대부분의 경우 현재 앱의 메인 window를 반환합니다.
        return UIApplication.shared.windows.first { $0.isKeyWindow }!
    }
}
