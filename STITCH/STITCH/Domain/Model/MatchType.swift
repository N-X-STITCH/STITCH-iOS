//
//  MatchType.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import Foundation

enum MatchType: String, Codable {
    case match, teachMatch
    
    var isTeach: Bool {
        switch self {
        case .match: return false
        case .teachMatch: return true
        }
    }
    
    init(_ teach: Bool) {
        if teach { self = .teachMatch  }
        else { self = .match }
    }
}
