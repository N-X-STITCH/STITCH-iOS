//
//  LocationInfo.swift
//  STITCH
//
//  Created by neuli on 2023/03/13.
//

import Foundation

struct LocationInfo: Hashable {
    let address: String
    let latitude: String?
    let longitude: String?
    
    init(
        address: String,
        latitude: String? = nil,
        longitude: String? = nil
    ) {
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
}
