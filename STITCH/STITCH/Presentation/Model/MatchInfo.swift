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
    let joinedUsers: [User]
    
    init(
        match: Match,
        owner: User,
        joinedUsers: [User] = []
    ) {
        self.match = match
        self.owner = owner
        self.joinedUsers = joinedUsers
    }
}
