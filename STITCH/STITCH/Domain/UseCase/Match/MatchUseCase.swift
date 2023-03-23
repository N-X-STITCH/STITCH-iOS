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
    private let userStorage: UserStorage
    
    // MARK: - Initializer
    
    init(
        matchRepository: MatchRepository,
        userRepository: UserRepository,
        userStorage: UserStorage
    ) {
        self.matchRepository = matchRepository
        self.userRepository = userRepository
        self.userStorage = userStorage
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
        return Observable.combineLatest(matchRepository.fetchAllMatch(), userStorage.fetchMatchIDs())
            .flatMap { (matches, blockMatchIDs) -> Observable<[Match]> in
                var matches = matches
                if let blockMatchIDs {
                    matches = matches.filter { !blockMatchIDs.contains($0.matchID) }
                }
                return Single<[Match]>.just(matches).asObservable()
            }
        
    }
    
    func fetchAllTeachMatch() -> Observable<[Match]> {
        return matchRepository.fetchAllTeachMatch()
    }
    
    func fetchUser(userID: String) -> Observable<User> {
        return userRepository.fetchUser(userID: userID)
    }
    
    func fetchHomeMatch() -> Observable<(recommendedMatches: [MatchDetail], newMatches: [Match])> {
        return Observable.combineLatest(matchRepository.fetchHomeMatch(), userStorage.fetchMatchIDs())
            .flatMap { (homeMatches, blockMatchIDs) -> Observable<(recommendedMatches: [MatchDetail], newMatches: [Match])> in
                let (recommendedMatches, newMatches) = homeMatches
                var filteredRecommendedMatches = recommendedMatches
                var filteredNewMatches = newMatches
                
                if let blockMatchIDs {
                    filteredRecommendedMatches = recommendedMatches.filter { blockMatchIDs.contains($0.match.matchID) }
                    filteredNewMatches = newMatches.filter { blockMatchIDs.contains($0.matchID) }
                }
                return Single<(recommendedMatches: [MatchDetail], newMatches: [Match])>
                    .just((filteredRecommendedMatches, filteredNewMatches)).asObservable()
            }
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
