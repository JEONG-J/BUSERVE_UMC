//
//  SocialLoginManager.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/07.
//

import Foundation
import UIKit

enum LoginResult {
    case success
    case failure(Error)
}

class SocialLoginManager {
    
    // MARK: - Properties
    
    static let shared = SocialLoginManager()
    
    private init() {}
    
    private(set) var isLoggedIn: Bool = false
    private var userInfoManager = UserInfoManager(loadUseCase: LoadUserInfoUseCase(), deleteUsecase: DeleteUserInfoUseCase())
    private weak var presentingViewController: UIViewController?
    var currentUseCase: LoginUseCase?
    
    var currentAdapterType: String? {
        return currentUseCase?.adapterType
    }
    
    // MARK: - methods
    
    func login(with adapter: AuthenticateAdapter) async throws -> LoginResult {
        self.currentUseCase = LoginUseCase(adapter: adapter)
        
        guard let currentUseCase = self.currentUseCase else {
            throw NSError(domain: "SocialLoginManagerError", code: 0, userInfo: [NSLocalizedDescriptionKey: "currentUseCase is nil."])
        }
        
        do {
            let result = try await currentUseCase.login()
            isLoggedIn = result
            return .success
        } catch let error {
            isLoggedIn = false
            return .failure(error)
        }
    }
    
    /// 로그아웃을 할때 동작하는 함수
    func logout() {
        if UserDefaults.standard.object(forKey: "socialLoginState") != nil {
            UserDefaults.standard.removeObject(forKey: "socialLoginState")
        }
        
        Task {
            do {
                let result = try await userInfoManager.deleteUserInfo()
                if result {
                    DispatchQueue.main.async {
                        self.isLoggedIn = false
                        self.updateRootViewController()
                    }
                } else {
                    print("로그아웃 안됨")
                }
            } catch {
                print("Error during logout:", error.localizedDescription)
            }
        }
    }
    
    func printCurrentUseCase() {
        if let currentAdapter = currentUseCase {
            print("Current use case is using \(currentAdapter.adapterType) adapter.")
        } else {
            print("No current use case.")
        }
    }
    
    /// 소셜 로그인이 되어있는지 체크하는 함수 ( 백그라운드 -> 포그라운드 or 앱을 종료 했을 때 )
    func checkLoginState() {
        if UserDefaults.standard.bool(forKey: "socialLoginState") {
            print("사용자는 로그인 상태입니다.")
            DispatchQueue.main.async {
                self.isLoggedIn = true
                self.updateRootViewController()
            }
        } else {
            print("사용자는 로그아웃 상태입니다.")
        }
    }
    
    /// 소셜 로그인의 여부에 따른 View 를 보여주는 함수
    private func updateRootViewController() {
        print("업데이트 함수 호출")
        
        // 앱의 window 참조를 가져옵니다.
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = scene.delegate as? SceneDelegate,
              let window = sceneDelegate.window else {
            print("Scene 없음")
            return
        }
        
        switch isLoggedIn {
        case false:
            print("로그인 안됨")
            let loginVC = LoginViewController()
            window.rootViewController = loginVC
        case true:
            print("로그인 성공")
            let tabBarVC = TabBarViewController()
            window.rootViewController = tabBarVC
        }
    }
}

