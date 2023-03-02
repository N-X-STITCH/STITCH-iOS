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
        let match1 = Match(
            matchID: "1",
            ownerID: "u1",
            title: "이벤트 매치 원",
            matchImageURL: "",
            place: "",
            contents: "",
            matchType: .match,
            sport: .badminton,
            startTime: Date(),
            duration: Date(),
            fee: 5000
        )
        let user1 = User(
            id: "u1",
            nickname: "헬스장24시",
            profileImageURL: "",
            interestedSports: [.badminton],
            address: ""
        )
        let match2 = Match(
            matchID: "2",
            ownerID: "u2",
            title: "이벤트 매치 원",
            matchImageURL: "",
            place: "",
            contents: "",
            matchType: .match,
            sport: .badminton,
            startTime: Date(),
            duration: Date(),
            fee: 5000
        )
        let user2 = User(
            id: "u2",
            nickname: "헬스장24시",
            profileImageURL: "",
            interestedSports: [.badminton],
            address: ""
        )
        let match3 = Match(
            matchID: "3",
            ownerID: "u3",
            title: "이벤트 매치 원",
            matchImageURL: "",
            place: "",
            contents: "",
            matchType: .match,
            sport: .badminton,
            startTime: Date(),
            duration: Date(),
            fee: 5000
        )
        let user3 = User(
            id: "u3",
            nickname: "헬스장24시",
            profileImageURL: "",
            interestedSports: [.badminton],
            address: ""
        )
        
        return [
            MatchInfo(match: match1, owner: user1),
            MatchInfo(match: match2, owner: user2),
            MatchInfo(match: match3, owner: user3)
        ]
    }
}
