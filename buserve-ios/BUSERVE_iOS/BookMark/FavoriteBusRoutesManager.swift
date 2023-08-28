//
//  FavoriteBusRoutesManager.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/24.
//

import Foundation
import Alamofire

class FavoriteBusRoutesManager {
    
    private let baseURL = "https://port-0-buserve-server-eg4e2alk9qi7fv.sel4.cloudtype.app/api/"
    private let userInfoManager = UserInfoManager(loadUseCase: LoadUserInfoUseCase())
    private var name = ""
    
    /// 즐겨찾기한 버스 노선 정보를 받아오는 함수
    func fetchFavortieBusRoutes() async throws -> BusStopRoutesData {
        let url = baseURL + "routes/favorites"
        let name = try await userInfoManager.loadUserInfo()?.name
        
        guard let unwrappedName = name else {
            throw NSError(domain: "com.umc.BUS", code: 999, userInfo: [NSLocalizedDescriptionKey: "User info not found"])
        }
        
        self.name = unwrappedName
        
        let parameters = ["name": unwrappedName] as Dictionary
        
        // Alamofire의 Future를 사용하여 async/await 패턴에 맞게 변환
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get, parameters: parameters).responseDecodable(of: BusStopRoutesData.self) { response in
                switch response.result {
                case .success(let data):
                    print("성공")
                    continuation.resume(returning: data)
                case .failure(let error):
                    print("실패")
                    print(error)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func addFavortieBusRoutes(routeID: String) async throws -> Bool {
        
        let url = baseURL + "routes/\(routeID)/favorite"
        
        let name = try await userInfoManager.loadUserInfo()?.name
        
        guard let unwrappedName = name else {
            throw NSError(domain: "com.umc.BUS", code: 999, userInfo: [NSLocalizedDescriptionKey: "User info not found"])
        }
        
        self.name = unwrappedName
        
        var urlComponents = URLComponents(string: url)!
        urlComponents.queryItems = [URLQueryItem(name: "name", value: name)]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(urlComponents.url!, method: .post, encoding: JSONEncoding.default, headers: headers)
              .responseDecodable(of: FavoriteBusDataResult.self) { response in
                switch response.result {
                case .success(let data):
                    print(data)
                    print("즐겨찾기 노선 추가 성공")
                    continuation.resume(returning: data.isSuccess)
                case .failure(let error):
                    print("즐겨찾기 노선 추가 실패")
                    print(error)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func deleteFavortieBusRoutes(routeID: String) async throws -> Bool {
        
        let url = baseURL + "routes/\(routeID)/favorite"
        
        let name = try await userInfoManager.loadUserInfo()?.name
        
        guard let unwrappedName = name else {
            throw NSError(domain: "com.umc.BUS", code: 999, userInfo: [NSLocalizedDescriptionKey: "User info not found"])
        }
        
        self.name = unwrappedName
        
        var urlComponents = URLComponents(string: url)!
        urlComponents.queryItems = [URLQueryItem(name: "name", value: name)]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(urlComponents.url!, method: .delete, encoding: JSONEncoding.default, headers: headers)
              .responseDecodable(of: FavoriteBusDataResult.self) { response in
                switch response.result {
                case .success(let data):
                    print(data)
                    print("즐겨찾기 노선 삭제 성공")
                    continuation.resume(returning: data.isSuccess)
                case .failure(let error):
                    print("즐겨찾기 노선 삭제 실패")
                    print(error)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

struct FavoriteBusDataResult: Decodable {
    let code: Int
    let isSuccess: Bool
    let message: String
}
