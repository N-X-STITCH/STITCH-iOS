//
//  LocationInfo.swift
//  STITCH
//
//  Created by neuli on 2023/03/13.
//

import CoreLocation
import Foundation
import MapKit

struct LocationInfo: Hashable {
    var address: String
    var roadAddress: String?
    var latitude: String?
    var longitude: String?
    var katechX: String?
    var katechY: String?
    
    init(
        address: String,
        roadAddress: String? = nil,
        latitude: String? = nil,
        longitude: String? = nil,
        katechX: String? = nil,
        katechY: String? = nil
    ) {
        self.address = address
        self.roadAddress = roadAddress
        self.latitude = latitude
        self.longitude = longitude
        self.katechX = katechX
        self.katechY = katechY
    }
    
    mutating func convertKatechToGEO() {
        guard let katechX = katechX,
              let katechX = Double(katechX),
              let katechY = katechY,
              let katechY = Double(katechY)
        else { return }
        
        let geoTrans = GeoTrans()
        geoTrans.set()
        let katech = GeoTransPoint(katechX, katechY)
        let geo = geoTrans.convert(1, 0, katech)
        latitude = "\(geo.getY())"
        longitude = "\(geo.getX())"
    }
}
