//
//  BusMoneyDataManager.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/23.
//

import Foundation
import Alamofire

class BusMoneyDataManager {
    
    private let baseURL = "https://port-0-buserve-server-eg4e2alk9qi7fv.sel4.cloudtype.app/api/"
    private let userInfoManager = UserInfoManager(loadUseCase: LoadUserInfoUseCase())
    private var name = ""
    
    
    func fetchBusMoney() async throws -> BusMoneyData {
        
        let url = baseURL + "bus-money"
        let name = try await userInfoManager.loadUserInfo()?.name
        
        guard let unwrappedName = name else {
            throw NSError(domain: "com.umc.BUS", code: 999, userInfo: [NSLocalizedDescriptionKey: "User info not found"])
        }
        
        self.name = unwrappedName
        
        let parameters = ["name": unwrappedName] as Dictionary
        
        // Alamofire의 Future를 사용하여 async/await 패턴에 맞게 변환
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get, parameters: parameters).responseDecodable(of: BusMoneyData.self) { response in
                switch response.result {
                case .success(let data):
                    print("성공")
                    continuation.resume(returning: data)
                case .failure(let error):
                    print("실패")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func fetchBusChargingMethods() async throws -> BusChargingMethods {
        
        let url = baseURL + "charging-methods/primary"
        let parameters = ["name": name] as Dictionary
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get, parameters: parameters).responseDecodable(of: BusChargingMethods.self) { response in
                switch response.result {
                case .success(let data):
                    print("충전계좌 불러오기성공")
                    continuation.resume(returning: data)
                case .failure(let error):
                    print("충전계좌 불러오기실패")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func changeBusCharginMoney(chargeMoney: Int) async throws -> Bool {
        
        let url = baseURL + "bus-money/charge"
        var urlComponents = URLComponents(string: url)!
        
        let name = try await userInfoManager.loadUserInfo()?.name
        
        guard let unwrappedName = name else {
            throw NSError(domain: "com.umc.BUS", code: 999, userInfo: [NSLocalizedDescriptionKey: "User info not found"])
        }
        
        self.name = unwrappedName
        
        urlComponents.queryItems = [URLQueryItem(name: "name", value: name)]
        let parameters: [String: Any] = ["amount": chargeMoney]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(urlComponents.url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
              .responseDecodable(of: BusChargingMoney.self) { response in
                switch response.result {
                case .success(let data):
                    print("버스머니 충전성공")
                    print(data)
                    continuation.resume(returning: data.isSuccess)
                case .failure(let error):
                    print("버스머니 충전실패")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

struct BusMoneyData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: BusMoneyDataResultData
}

struct BusMoneyDataResultData: Codable {
    let amount: Int
}


struct BusChargingMethods: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: BusChargingMethodsResultData
}

struct BusChargingMethodsResultData: Codable {
    let id: Int
    let name: String
    let details: String
    let isPrimary: Bool
}

struct BusChargingMoney: Decodable {
    let code: Int
    let isSuccess: Bool
    let message: String
//    let result: BusChargingMoneyResultData
}

struct BusChargingMoneyResultData: Decodable {
    let amount: Int
}
