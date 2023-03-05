//
//  Match.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import Foundation

struct Match: Codable, Hashable {
    let matchID: String
    let ownerID: String
    let title: String
    let matchImageURL: String
    let place: String
    let contents: String
    let matchType: MatchType
    let sport: Sport
    let startTime: Date
    let duration: Date
    let fee: Int
}
