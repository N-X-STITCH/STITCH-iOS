//
//  MatchInfo.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import Foundation

struct MatchInfo: Hashable {
    let match: Match
    let owner: User
    
    static func dump() -> [MatchInfo] {
        return [] 
    }
    
    static func classDump() -> [MatchInfo] {
        return []
    }
}
