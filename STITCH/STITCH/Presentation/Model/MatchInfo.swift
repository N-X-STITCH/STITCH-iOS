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
            ownerID: "w1",
            title: "테니스 같이 해요.",
            matchImageURL: "https://post-phinf.pstatic.net/MjAxNzA2MDFfMjUx/MDAxNDk2Mjc4MDY1MTc4.f_UIrFq3xMTuVu2gh0oARIPesxuZ0-4xXuV-pZyUlkgg.cjVBlCFq2MWBrksIqsivAcabkuJgYwGlqXbY9SrGf54g.JPEG/1.jpg?type=w1200",
            place: "강남역 테니스장",
            contents: "컨텐츠 내용 컨텐츠 내용 컨텐츠 내용 컨텐츠 내용 컨텐츠 내용 컨텐츠 내용 컨텐츠 내용 컨텐츠 내용 컨텐츠 내용 ",
            matchType: .classMatch,
            sport: .tennis,
            startTime: Date(),
            duration: Date(),
            fee: 5000
        )
        let owner1 = User(
            id: "w1",
            nickname: "내가 주인",
            profileImageURL: "https://openimage.interpark.com/goods_image_big/4/1/7/5/8564064175_l.jpg",
            interestedSports: [.tennis],
            address: ""
        )
        let match2 = Match(
            matchID: "2",
            ownerID: "w2",
            title: "테니스 같이 해요.",
            matchImageURL: "https://post-phinf.pstatic.net/MjAxNzA2MDFfMjUx/MDAxNDk2Mjc4MDY1MTc4.f_UIrFq3xMTuVu2gh0oARIPesxuZ0-4xXuV-pZyUlkgg.cjVBlCFq2MWBrksIqsivAcabkuJgYwGlqXbY9SrGf54g.JPEG/1.jpg?type=w1200",
            place: "강남역 테니스장",
            contents: "컨텐츠 내용 컨텐츠 내용 컨텐츠 내용 컨텐츠 내용 컨텐츠 내용 컨텐츠 내용 컨텐츠 내용 컨텐츠 내용 컨텐츠 내용 ",
            matchType: .classMatch,
            sport: .tennis,
            startTime: Date(),
            duration: Date(),
            fee: 5000
        )
        let owner2 = User(
            id: "w2",
            nickname: "내가 안주인",
            profileImageURL: "https://openimage.interpark.com/goods_image_big/4/1/7/5/8564064175_l.jpg",
            interestedSports: [.tennis],
            address: ""
        )
        let matchInfo1 = MatchInfo(match: match1, owner: owner1)
        let matchInfo2 = MatchInfo(match: match2, owner: owner2)
        return [matchInfo1, matchInfo2] 
    }
    
    static func classDump() -> [MatchInfo] {
        return []
    }
}
