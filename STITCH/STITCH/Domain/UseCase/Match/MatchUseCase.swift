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
    func fetchHomeMatch() -> Observable<(recommendedMatches: [MatchDetail], newMatches: [Match])>
    func deleteMatch(matchID: String) -> Observable<Void>
    func joinMatch(userID: String, matchID: String) -> Observable<Void>
    func cancelJoinMatch(userID: String, matchID: String) -> Observable<Void>
    func createReport(_ report: Report) -> Observable<Void>
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
            .flatMap { [weak self] matchInfo -> Observable<MatchInfo> in
                guard let self = self else { return .error(NetworkError.unknownError) }
                return self.userRepository.fetchUser(userID: matchInfo.match.matchHostID)
                    .map { MatchInfo(match: matchInfo.match, owner: $0, joinedUsers: matchInfo.joinedUsers) }
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
    
    func fetchHomeMatch() -> Observable<(recommendedMatches: [MatchDetail], newMatches: [Match])> {
        return matchRepository.fetchHomeMatch()
    }
    
    func deleteMatch(matchID: String) -> Observable<Void> {
        return matchRepository.deleteMatch(matchID: matchID)
    }
    
    func joinMatch(userID: String, matchID: String) -> Observable<Void> {
        return matchRepository.joinMatch(userID: userID, matchID: matchID)
    }
    
    func cancelJoinMatch(userID: String, matchID: String) -> Observable<Void> {
        return matchRepository.cancelJoinMatch(userID: userID, matchID: matchID)
    }
    
    func createReport(_ report: Report) -> Observable<Void> {
        return matchRepository.createReport(report)
    }
}
