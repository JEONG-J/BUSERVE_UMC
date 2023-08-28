//
//  ReserveBusMarker.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/08/10.
//

import UIKit
import NMapsMap
import CoreLocation
import MapKit
import FloatingPanel


class ReserveBusMarker: MapsViewController, FloatingPanelControllerDelegate {
    
    var reserveLat : Double? //예약한 버스 정류장 위도 <<-- 수정하면 됨
    var reserveLng : Double? //예약한 버스 정류장 경도 << -- 수정하면 됨
    
    var naverCoordinates: [NMGLatLng] = []
    var pathOverlay = NMFPath()
    
    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationBtn.translatesAutoresizingMaskIntoConstraints = true
        mapPathSetup(mapView)
        sheet()
        setBtn()
    }
    
    func mapPathSetup(_ mapView : NMFMapView){
        guard let currentLocation = locationBtn.locationManager.location else {
            print("Failed to get current location")
            return
        }
        
        let currentLat = currentLocation.coordinate.latitude
        let currentLng = currentLocation.coordinate.longitude
        
        
        let sourceCoordinate = CLLocationCoordinate2D(latitude: currentLat, longitude: currentLng) // 현재위치 좌표
        let destinationReserveCoordinate = CLLocationCoordinate2D(latitude: reserveLat ?? 0 , longitude: reserveLng ?? 0) // 예약한 버스정류장 위치 좌표
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationReserveCoordinate)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlaceMark)
        
        let destinationMark = NMFMarker()
        destinationMark.position = NMGLatLng(lat: reserveLat ?? 0, lng: reserveLng ?? 0)
        destinationMark.iconImage = NMFOverlayImage(name: "reserveBus.png")
        destinationMark.captionText = "예약한 버스정류장"
        destinationMark.isHideCollidedSymbols = true
        destinationMark.width = 34
        destinationMark.height = 34
        destinationMark.mapView = mapView
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .walking
        
        DispatchQueue.global().async(){
            let directions = MKDirections(request: directionRequest)
            directions.calculate{ (response, error) in
                guard let response = response else{
                    if let error = error{
                        print(error) // 에러 표시 alert 추가 고민 중
                    }
                    return
                }
                let route = response.routes[0]
                
                var coordinates: [CLLocationCoordinate2D] = Array(repeating: CLLocationCoordinate2D(), count: route.polyline.pointCount)
                route.polyline.getCoordinates(&coordinates, range: NSRange(location: 0, length: route.polyline.pointCount))
                
                for coordinate in coordinates{
                    let naverCoordinate = NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude)
                    self.naverCoordinates.append(naverCoordinate)
                }
                self.pathOverlay.path = NMGLineString(points: self.naverCoordinates)
                self.pathOverlay.color = .red
                self.pathOverlay.mapView = mapView
            }
        }
    }
  
    override func mapCameraControll() {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: (reserveLat ?? locationManager.location?.coordinate.latitude)!,
                                                           lng: (reserveLng ?? locationManager.location?.coordinate.longitude)!))
        cameraUpdate.animation = .easeIn
        mapView.moveCamera(cameraUpdate)
    }
    
    
    private func sheet(){
        let apper = SurfaceAppearance()
        apper.cornerRadius = 16.0
        
        let fpc = FloatingPanelController()
        fpc.delegate = self
        fpc.layout = SetFloatingPanelLayout()
        guard let contentVC = storyboard?.instantiateViewController(withIdentifier: "SheetViewController") as? SheetViewController
        else{
            return
        }
        contentVC.delegate = self
        
        fpc.surfaceView.appearance = apper
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        
        
    }
    
    func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        let yPos = fpc.surfaceView.frame.origin.y
        self.locationBtn.frame.origin.y = yPos - self.locationBtn.frame.height - 15
        print(yPos - self.locationBtn.frame.height - 10)
    }
}

class SetFloatingPanelLayout: FloatingPanelLayout{
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    let anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.43, edge: .bottom, referenceGuide: .safeArea),
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 10, edge: .bottom, referenceGuide: .safeArea),
    ]
}

extension ReserveBusMarker: SheetViewDelegate {
    
    func updateCoordinatesAndRefreshUI(lat: Double, lng: Double) {
        // 위도, 경도 업데이트
        self.reserveLat = lat
        self.reserveLng = lng

        mapCameraControll()
        mapPathSetup(mapView)
    }
}
