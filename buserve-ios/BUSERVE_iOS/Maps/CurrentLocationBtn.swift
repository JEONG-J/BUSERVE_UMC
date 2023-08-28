//
//  CurrentLocationBtn.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/07/28.
//

import UIKit
import CoreLocation
import NMapsMap

class CurrentLocationBtn: UIButton, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let marker = NMFMarker()
    var mapView: NMFMapView!
    
    
    
    func setMapView(_ mapView: NMFMapView) {
        self.mapView = mapView
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    func setUpView(){
        self.translatesAutoresizingMaskIntoConstraints = true
        self.layer.cornerRadius = self.layer.frame.width/2
        self.backgroundColor = .white
        self.setImage(UIImage(named: "location.png"), for: .normal)
        self.addTarget(self, action: #selector(self.locationInfor), for: .touchUpInside)
        
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 2, height: 2) // 위치조정
        self.layer.shadowRadius = 8 // 반경
        self.layer.shadowOpacity = 1 // alpha값  */
        
    }
    
    func sizeBtn(_ x: Double, _ y: Double, _ width: Double, _ height : Double){
        self.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    
        
    @objc func locationInfor(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled(){
                self.locationManager.startUpdatingLocation()
                DispatchQueue.main.async {
                    searchLocation()
                }
            }
        }
        func searchLocation(){
            var locationLatitude = self.locationManager.location?.coordinate.latitude
            var locationLogitude = self.locationManager.location?.coordinate.longitude
            
            /* camera */
            let cameraMove = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationLatitude ?? 0, lng: locationLogitude ?? 0))
            cameraMove.animation = .easeIn
            self.mapView.moveCamera(cameraMove)
            
            /* currentPosition Marker */
            marker.mapView = nil // maker init
            marker.position = NMGLatLng(lat: locationLatitude ?? 0,
                                        lng: locationLogitude ?? 0)
            marker.iconImage = NMFOverlayImage(name: "marker.png")
            marker.captionText = "내 위치"
            marker.width = 24
            marker.height = 30
            marker.mapView = mapView
            
            
        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
        }
    }

}
