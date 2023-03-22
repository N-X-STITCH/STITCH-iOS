//
//  MatchSection.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import Foundation

enum MatchSection: Hashable {
    case newMatch
    case createdMatchList(nickname: String)
    case none
    
    var title: String {
        switch self {
        case .newMatch: return "새롭게 열린 매치"
        case .createdMatchList(let nickname): return "생성한 매치목록"
        case .none: return ""
        }
    }
}
