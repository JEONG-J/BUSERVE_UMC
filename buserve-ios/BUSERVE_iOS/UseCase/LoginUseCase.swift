//
//  LoginUseCase.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/07.
//

import Foundation

struct LoginUseCase {
    let adapter: AuthenticateAdapter
    
    var adapterType: String {
        return adapter.adapterType
    }
    
    init(adapter: AuthenticateAdapter) {
        self.adapter = adapter
    }
    
    func login() async throws -> Bool {
        return try await adapter.login()
    }
}
