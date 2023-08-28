//
//  MapsViewController.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/07/24.
//

import UIKit
import NMapsMap
import MapKit
import CoreLocation
class MapsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    var locationManager = CLLocationManager()
    let marker = NMFMarker()
    
    var lat: Double?
    var lng: Double?
    
    @IBOutlet weak var locationBtn: CurrentLocationBtn!
    
    var mapView : NMFMapView = {
        let mapView = NMFMapView(frame: UIScreen.main.bounds)
        mapView.setLayerGroup(NMF_LAYER_GROUP_TRANSIT, isEnabled: true)
        mapView.allowsZooming = true
        mapView.allowsScrolling = true
        mapView.isIndoorMapEnabled = true
        mapView.zoomLevel = 15
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationBtn.setMapView(mapView)
        
        view.addSubview(mapView)
        view.addSubview(locationBtn!)
         view.bringSubviewToFront(locationBtn!)
        
         /* mapContraints */
         mapView.translatesAutoresizingMaskIntoConstraints = false
         mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
         mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
         mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
         mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
         setLoactionManager()
         }
    
         func setBtn(){
         locationBtn.sizeBtn(335, 431.33333333333326, 50, 50)
         }
         
         func setLoactionManager(){
         self.locationManager.delegate = self
         self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
         self.locationManager.requestAlwaysAuthorization()
         DispatchQueue.global().async {
         if CLLocationManager.locationServicesEnabled(){
         self.locationManager.startUpdatingLocation()
         }
         }
         }
         
         /* MapControll */
         func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
         switch locationManager.authorizationStatus{
         case .authorizedAlways, .authorizedWhenInUse:
         DispatchQueue.main.async {
         print("권한있음")
         self.mapCameraControll()
         self.mapMarker()
         }
         case .denied, .restricted:
         print("위치 서비스 권한 없음")
         locationDisable()
         case .notDetermined:
         print("위치 서비스 권한 없음")
         @unknown default:
         print("알 수 없는 상태")
         }
         }
         
         func mapCameraControll(){
         /* cameraMove */
         let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0,
         lng: locationManager.location?.coordinate.longitude ?? 0))
         cameraUpdate.animation = .easeIn
         self.mapView.moveCamera(cameraUpdate)
         }
         
         func mapMarker(){
         /* currentPosition Marker */
         marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0,
         lng:locationManager.location?.coordinate.longitude ?? 0)
         marker.iconImage = NMFOverlayImage(name: "marker.png")
         marker.captionText = "내 위치"
         marker.width = 24
         marker.height = 30
         marker.mapView = self.mapView
         }
         
         
         /* Alter */
         func locationDisable(){
         let alterController = UIAlertController(title: "위치 접근 권한이 필요합니다.", message: "이 기능을 사용하려면 '설정'에서 위치 접근 권한을 허용해주세요", preferredStyle: .alert)
         let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
         let checkAction = UIAlertAction(title: "설정으로 가기", style: .default) { (action) in
         if let url = URL(string: UIApplication.openSettingsURLString){
         UIApplication.shared.open(url, options:  [:], completionHandler: nil)
         }
         }
         alterController.addAction(cancelAction)
         alterController.addAction(checkAction)
         self.present(alterController, animated: true, completion: nil)
         }
    }
