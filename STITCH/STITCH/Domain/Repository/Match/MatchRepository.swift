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
    func fetchMatch(matchID: String) -> Observable<Match>
    func fetchAllMatch() -> Observable<[Match]>
    func fetchAllTeachMatch() -> Observable<[Match]>
}
