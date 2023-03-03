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
            matchImageURL: "https://mblogthumb-phinf.pstatic.net/MjAyMDAxMDNfMjk1/MDAxNTc4MDU2NjI4NjI2.MUVIQyHNte2dhSL5oT-zVBebmIBO4LOhW6BxeMRQlOcg.fZJZ1JuU7W19m49Gx3WtbVcNPPq7JoiAOcRo0rrRFKUg.PNG.amoripse/1w132w.png?type=w800",
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
            matchImageURL: "https://m.figurepresso.com/web/product/big/201910/a645e9c7dea62231fa75f1b019b52635.jpg",
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
            title: "이벤트 매치 3",
            matchImageURL: "https://e1.pngegg.com/pngimages/252/85/png-clipart-stitch-stitch-illustration-thumbnail.png",
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
    
    static func classDump() -> [MatchInfo] {
        let match1 = Match(
            matchID: "01",
            ownerID: "u01",
            title: "이벤트 매치 원",
            matchImageURL: "https://img.danawa.com/prod_img/500000/657/615/img/4615657_1.jpg?shrink=330:330&_v=20161102155734",
            place: "",
            contents: "내용",
            matchType: .classMatch,
            sport: .badminton,
            startTime: Date(),
            duration: Date(),
            fee: 5000
        )
        let user1 = User(
            id: "u01",
            nickname: "헬스장24시",
            profileImageURL: "",
            interestedSports: [.badminton],
            address: ""
        )
        let match2 = Match(
            matchID: "02",
            ownerID: "u02",
            title: "이벤트 매치 원",
            matchImageURL: "https://demo.ycart.kr/shopboth_farm_max5_001/data/editor/1612/cd2f39a0598c81712450b871c218164f_1482469221_493.jpg",
            place: "",
            contents: "00000000",
            matchType: .classMatch,
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
            matchID: "03",
            ownerID: "u03",
            title: "이벤트 매치 쓰리",
            matchImageURL: "https://blog.kakaocdn.net/dn/pbATv/btqxtXkCDlt/DwhLZCFllImV3OOYWassZ0/img.jpg",
            place: "",
            contents: "",
            matchType: .classMatch,
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
