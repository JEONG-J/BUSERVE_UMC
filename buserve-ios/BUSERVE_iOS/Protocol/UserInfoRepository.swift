//
//  UserInfoRepository.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/21.
//

import Foundation

protocol UserInfoRepository {
    
    func saveUserInfo(name: String, email: String, token: String, socialLoginType: String) async throws -> Result<UserInfo, Error>
    
    func loadUserInfo() async throws -> Result<UserInfo, Error>
    
    func deleteUserInfo() async throws -> Result<Bool, Error>
}
