//
//  MatchUseCase.swift
//  STITCH
//
//  Created by neuli on 2023/03/19.
//

import Foundation

import RxSwift

protocol MatchUseCase {
    func fetchMatch(matchID: String) -> Observable<MatchInfo>
    func fetchAllMatch() -> Observable<[Match]>
    func fetchAllTeachMatch() -> Observable<[Match]>
    func fetchUser(userID: String) -> Observable<User>
}

final class DefaultMatchUseCase: MatchUseCase {
    
    // MARK: - Properties
    
    private let matchRepository: MatchRepository
    private let userRepository: UserRepository
    
    // MARK: - Initializer
    
    init(
        matchRepository: MatchRepository,
        userRepository: UserRepository
    ) {
        self.matchRepository = matchRepository
        self.userRepository = userRepository
    }
    
    // MARK: - Methods
    
    func fetchMatch(matchID: String) -> Observable<MatchInfo> {
        return matchRepository.fetchMatch(matchID: matchID)
            .flatMap { [weak self] match -> Observable<MatchInfo> in
                guard let self = self else { return .error(NetworkError.unknownError) }
                return self.userRepository.fetchUser(userID: match.matchHostID)
                    .map { MatchInfo(match: match, owner: $0) }
            }
    }
    
    func fetchAllMatch() -> Observable<[Match]> {
        return matchRepository.fetchAllMatch()
    }
    
    func fetchAllTeachMatch() -> Observable<[Match]> {
        return matchRepository.fetchAllTeachMatch()
    }
    
    func fetchUser(userID: String) -> Observable<User> {
        return userRepository.fetchUser(userID: userID)
    }
}
