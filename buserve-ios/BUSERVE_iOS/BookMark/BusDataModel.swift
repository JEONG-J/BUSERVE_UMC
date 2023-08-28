//
//  BusDataModel.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/07/31.
//

import Foundation

struct BusDataModel {
    let uid = UUID()
    let busNumber: String
    let Departure: String
    let Arrival: String
    var isBookmark: Bool
    let busRouteId: String
}
