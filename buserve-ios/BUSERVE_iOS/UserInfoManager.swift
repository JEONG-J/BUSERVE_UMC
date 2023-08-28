//
//  UserInfoManager.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/21.
//

import Foundation

final class UserInfoManager {
    
    private let saveUserInfoUseCase: SaveUserInfoUseCase?
    private let loadUserInfoUseCase: LoadUserInfoUseCase?
    private let deleteUserInfoUsecase: DeleteUserInfoUseCase?
    
    init(saveUseCase: SaveUserInfoUseCase? = nil, loadUseCase: LoadUserInfoUseCase? = nil, deleteUsecase: DeleteUserInfoUseCase? = nil) {
        self.saveUserInfoUseCase = saveUseCase
        self.loadUserInfoUseCase = loadUseCase
        self.deleteUserInfoUsecase = deleteUsecase
    }

    func saveUserInfo(name: String, email: String, token: String, socialLoginType: String) async throws -> Bool {
        guard let useCase = saveUserInfoUseCase else {
            print("SaveUserInfoUseCase is not initialized.")
            return false
        }
        
        do {
            let result = try await useCase.execute(name: name, email: email, token: token, socialLoginType: socialLoginType)
            switch result {
            case .success(let userInfo):
                // 저장 성공 시 UI 업데이트 또는 다른 알림 메소드 호출 등
                print("Successfully saved user info:", userInfo)
                return true
            case .failure(let error):
                // 오류 처리, 예: 사용자에게 오류 메시지 표시
                print("Error:", error.localizedDescription)
                return false
            }
        } catch {
            print("Unknown error occurred:", error.localizedDescription)
            return false
        }
    }
    
    func loadUserInfo() async throws -> UserInfo? {
        guard let useCase = loadUserInfoUseCase else {
            throw NSError(domain: "InitializationError", code: 0, userInfo: [NSLocalizedDescriptionKey: "LoadUserInfoUseCase is not initialized."])
        }
        
        let result = try await useCase.execute()
        
        switch result {
        case .success(let userInfo):
            return userInfo
        case .failure(let error):
            throw error
        }
    }
    
    func deleteUserInfo() async throws -> Bool {
        guard let useCase = deleteUserInfoUsecase else {
            print("DeleteUserInfoUseCase is not initialized.")
            return false
        }
        
        do {
            let result = try await useCase.execute()
            switch result {
            case .success(let deleteUserInfo):
                // UI 업데이트나 다른 로직 수행
                print("Successfully deleted user info:", deleteUserInfo)
                return true
            case .failure(let error):
                // 오류 처리, 예: 사용자에게 오류 메시지 표시
                print("Error:", error.localizedDescription)
                return false
            }
        } catch {
            print("Error loading user info:", error.localizedDescription)
            return false
        }
    }
}
