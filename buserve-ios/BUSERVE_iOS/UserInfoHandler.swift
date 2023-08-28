//
//  UserInfoHandler.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/21.
//

import Foundation
import Security

final class UserInfoHandler: UserInfoRepository {
   
    // MARK: - Properties
    
    static let shared: UserInfoRepository = UserInfoHandler()
    
    private init() {}
 
    // MARK: - methods
    
    func saveUserInfo(name: String, email: String, token: String, socialLoginType: String) async throws -> Result<UserInfo, Error> {
        let user: UserInfo = UserInfo(name: name, email: email, socialLoginType: socialLoginType)
        print(user)
        
        do {
            let encodedData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(encodedData, forKey: "userInfo")
        } catch {
            print("Failed to encode user: \(error)")
        }

        let keychainKey = "userToken"
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: keychainKey,
                                    kSecValueData as String: token]
        
        /// 기존에 동일한 키 이름을 가진 데이터가 키체인에 있다면 삭제
        SecItemDelete(query as CFDictionary)
        
        /// 키체인에 토큰을 저장, 성공하면 errSecSuccess 를 반환
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            return .success(user)
        } else {
            let error = NSError(domain: "com.umc.keychain", code: Int(status), userInfo: [NSLocalizedDescriptionKey : "Keychain error occurred."])
            return .failure(error)
        }
    }
    
    func loadUserInfo() async throws -> Result<UserInfo, Error> {
        
        if let savedData = UserDefaults.standard.data(forKey: "userInfo") {
            do {
                let loadedUser = try JSONDecoder().decode(UserInfo.self, from: savedData)
                print("Loaded UserInfo:", loadedUser)
                return .success(loadedUser)
            } catch {
                print("Failed to decode UserInfo:", error)
                return .failure(error)
            }
        } else {
            let error = NSError(domain: "UserDefaultsError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data found for key 'userInfo'"])
            print("Error:", error.localizedDescription)
            return .failure(error)
        }
    }
    
    func deleteUserInfo() async throws -> Result<Bool, Error> {
        return .success(true)
//        if UserDefaults.standard.object(forKey: "userInfo") != nil {
//            UserDefaults.standard.removeObject(forKey: "userInfo")
//
//            // 삭제 확인
//            if UserDefaults.standard.object(forKey: "userInfo") == nil {
//                return .success(true)
//            } else {
//                let error = NSError(domain: "UserInfoError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to delete userInfo"])
//                return .failure(error)
//            }
//        } else {
//            // userInfo가 이미 없는 경우
//            let error = NSError(domain: "UserInfoError", code: 2, userInfo: [NSLocalizedDescriptionKey: "userInfo not found"])
//            return .failure(error)
//        }
    }
}
