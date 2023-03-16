//
//  Match.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import Foundation

struct Match: Codable, Hashable {
    let matchID: String
    let hostID: String
    let title: String
    let matchImageURL: String
    let place: String
    let contents: String
    let matchType: MatchType
    let sport: Sport
    let startDate: Date
    let duration: Int
    let headCount: Int
    let maxHeadCount: Int
    let fee: Int
    
    init(
        matchID: String,
        hostID: String,
        title: String,
        matchImageURL: String,
        place: String,
        contents: String,
        matchType: MatchType,
        sport: Sport,
        startTime: Date,
        duration: Int,
        headCount: Int = 1,
        maxHeadCount: Int,
        fee: Int = 0
    ) {
        self.matchID = matchID
        self.hostID = hostID
        self.title = title
        self.matchImageURL = matchImageURL
        self.place = place
        self.contents = contents
        self.matchType = matchType
        self.sport = sport
        self.startDate = startTime
        self.duration = duration
        self.headCount = headCount
        self.maxHeadCount = maxHeadCount
        self.fee = fee
    }
}
