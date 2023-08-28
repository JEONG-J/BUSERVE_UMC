//
//  NearByBusStopManager.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/24.
//

import Foundation
import CoreLocation
import Alamofire

struct BusStopRoutesData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [BusStopRoutesResultData]
}

struct BusStopRoutesResultData: Codable {
    let endPoint: String
    let favorite: Bool
    let routeId: String
    let routeName: String
    let startPoint: String
}

protocol NearByBusStopManagerDelegate: AnyObject {
    func didUpdateNearByBusStopRoutes(_ data: BusStopRoutesData)
    func didFailWithError(_ error: Error)
}

class NearByBusStopManager: NSObject, CLLocationManagerDelegate {
    
    private var locationManager: CLLocationManager
    private let baseURL = "https://port-0-buserve-server-eg4e2alk9qi7fv.sel4.cloudtype.app/api/"
    private let userInfoManager = UserInfoManager(loadUseCase: LoadUserInfoUseCase())
    private var name = ""
    var latestLocation: CLLocation?
    
    weak var delegate: NearByBusStopManagerDelegate?
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func nearByBusStopRoutes() async throws -> BusStopRoutesData {
        let url = baseURL + "routes/nearby"
        let name = try await userInfoManager.loadUserInfo()?.name
        
        guard let latestLocation = latestLocation else {
            throw NSError(domain: "com.umc.BUS", code: 999, userInfo: [NSLocalizedDescriptionKey: "User location not found"])
        }
        
        let latitude = latestLocation.coordinate.latitude
        let longitude = latestLocation.coordinate.longitude
        
        guard let unwrappedName = name else {
            throw NSError(domain: "com.umc.BUS", code: 999, userInfo: [NSLocalizedDescriptionKey: "User info not found"])
        }
        
        self.name = unwrappedName
        
        let parameters = ["lat": latitude,
                          "lon": longitude,
                          "name": unwrappedName] as [String : Any]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get, parameters: parameters).responseDecodable(of: BusStopRoutesData.self) { response in
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
    
    func requestLocation() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            // 권한이 거부된 경우 처리
            break
        }
    }
    
    // MARK: - CLLocationManagerDelegate

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 권한 상태가 변경될 때 호출되는 메서드
    }
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latestLocation = location
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("위도: \(latitude), 경도: \(longitude)")
            locationManager.stopUpdatingLocation()
            Task {
                do {
                    let result = try await nearByBusStopRoutes()
                    delegate?.didUpdateNearByBusStopRoutes(result)
                } catch {
                    print("Failed to get nearby bus stop routes: \(error)")
                    delegate?.didFailWithError(error)
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error)")
    }
}

