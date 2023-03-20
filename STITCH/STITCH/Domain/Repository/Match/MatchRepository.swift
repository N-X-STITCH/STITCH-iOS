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
    func fetchHomeMatch() -> Observable<(recommendedMatches: [Match], newMatches: [Match])>
}
