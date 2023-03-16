//
//  LocationError.swift
//  STITCH
//
//  Created by neuli on 2023/03/16.
//

import Foundation

enum LocationError: LocalizedError {
    case failGetLocations
    
    var errorDescription: String? {
        switch self {
        case .failGetLocations: return "위치 정보를 가져오는데 실패했습니다"
        }
    }
}
