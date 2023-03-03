//
//  HomeMatchSection.swift
//  STITCH
//
//  Created by neuli on 2023/03/03.
//

import Foundation

enum HomeMatchSection: Hashable, CaseIterable {
    case match, classMatch
    
    var title: String {
        switch self {
        case .match:
            return "새롭게 열린 매치"
        case .classMatch:
            return "새롭게 열린 Teach 매치"
        }
    }
}
