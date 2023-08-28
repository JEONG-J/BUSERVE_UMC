//
//  DeleteUserInfoUseCase.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/21.
//

import Foundation

struct DeleteUserInfoUseCase {
    private let userInfoRepository: UserInfoRepository
    
    init(repository: UserInfoRepository = UserInfoHandler.shared) {
        self.userInfoRepository = repository
    }
   
    func execute() async throws -> Result<Bool, Error> {
        return try await userInfoRepository.deleteUserInfo()
    }
}
