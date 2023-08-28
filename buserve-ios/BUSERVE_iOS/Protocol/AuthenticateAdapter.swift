//
//  AuthenticateAdapter.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/07.
//

import Foundation

protocol AuthenticateAdapter {
    var adapterType: String { get }
    
    func login() async throws -> Bool
    
    func checkLoginState() async -> Bool
}
