//
//  STITCHError.swift
//  STITCH
//
//  Created by neuli on 2023/03/23.
//

import Foundation

enum STITCHError: LocalizedError {
    case unknown
    
    var errorDescription: String {
        switch self {
        case .unknown: return "알 수 없는 에러입니다."
        }
    }
}
