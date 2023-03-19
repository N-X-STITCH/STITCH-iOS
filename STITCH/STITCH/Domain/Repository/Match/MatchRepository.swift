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
}
