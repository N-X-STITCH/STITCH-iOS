//
//  CreateMatchUseCase.swift
//  STITCH
//
//  Created by neuli on 2023/03/05.
//

import Foundation

import RxSwift

protocol CreateMatchUseCase {
    func uploadImage(data: Data?, path: String) -> Observable<String>
    func createMatch(match: Match) -> Observable<Match>
}

final class DefaultCreateMatchUseCase: CreateMatchUseCase {
    
    // MARK: - Properties
    
    private let matchRepository: MatchRepository
    private let fireStorageRepository: FireStorageRepository
    
    // MARK: - Initializer
    
    init(
        matchRepository: MatchRepository,
        fireStorageRepository: FireStorageRepository
    ) {
        self.matchRepository = matchRepository
        self.fireStorageRepository = fireStorageRepository
    }
    
    // MARK: - Methods
    
    func uploadImage(data: Data?, path: String) -> Observable<String> {
        if let data {
            return fireStorageRepository.uploadImage(data: data, path: path)
        } else {
            return Single<String>.just("").asObservable()
        }
    }
    
    func createMatch(match: Match) -> Observable<Match> {
        return matchRepository.createMatch(match: match)
    }
}
