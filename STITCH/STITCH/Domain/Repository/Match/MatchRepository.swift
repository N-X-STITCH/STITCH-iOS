//
//  MatchRepository.swift
//  STITCH
//
//  Created by neuli on 2023/03/05.
//

import Foundation

import RxSwift

protocol MatchRepository {
    func createMatch(match: Match) -> Observable<Match>
    func fetchMatch(matchID: String) -> Observable<MatchInfo>
    func fetchAllMatch() -> Observable<[Match]>
    func fetchAllTeachMatch() -> Observable<[Match]>
    func fetchHomeMatch() -> Observable<(recommendedMatches: [MatchDetail], newMatches: [Match])>
    func deleteMatch(matchID: String) -> Observable<Void>
    func joinMatch(userID: String, matchID: String) -> Observable<Void>
    func cancelJoinMatch(userID: String, matchID: String) -> Observable<Void>
    func createReport(_ report: Report) -> Observable<Void>
}
