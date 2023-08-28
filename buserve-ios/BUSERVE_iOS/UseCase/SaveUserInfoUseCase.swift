//
//  SetUserInfoUseCase.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/21.
//

import Foundation

struct SaveUserInfoUseCase {
    private let userInfoRepository: UserInfoRepository
    
    init(repository: UserInfoRepository = UserInfoHandler.shared) {
        self.userInfoRepository = repository
    }
   
    func execute(name: String, email: String, token: String, socialLoginType: String) async throws -> Result<UserInfo, Error> {
        return try await userInfoRepository.saveUserInfo(name: name, email: email, token: token, socialLoginType: socialLoginType)
    }
}
