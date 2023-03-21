//
//  Report.swift
//  STITCH
//
//  Created by neuli on 2023/03/21.
//

import Foundation

struct Report: Codable {
    let reporterId: String
    let memberId: String
    let matchId: String
    let reason: String
    
    init(
        reporterId: String = UUID().uuidString,
        memberId: String,
        matchId: String,
        reason: String = "비매너"
    ) {
        self.reporterId = reporterId
        self.memberId = memberId
        self.matchId = matchId
        self.reason = reason
    }
}
