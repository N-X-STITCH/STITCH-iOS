//
//  MatchDetailViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import Foundation

import RxSwift

final class MatchDetailViewModel: ViewModel {
    
    var user: User!
    var matchInfo: MatchInfo!
    
    struct Input {
        let match: Observable<Match>
        let matchJoinButtonTap: Observable<Void>
    }
    
    struct Output {
        let user: Observable<User>
        let matchInfo: Observable<MatchInfo>
    }
    
    // MARK: - Properties
    
    private let userUseCase: UserUseCase
    private let matchUseCase: MatchUseCase
    
    // MARK: - Initializer
    
    init(
        userUseCase: UserUseCase,
        matchUseCase: MatchUseCase
    ) {
        self.userUseCase = userUseCase
        self.matchUseCase = matchUseCase
    }
    
    // MARK: - Methods
    
    func report() -> Observable<Void> {
        return matchUseCase.createReport(Report(memberId: user.id, matchId: matchInfo.match.matchID))
    }
    
    func transform(input: Input) -> Output {
        
        let user = userUseCase.fetchLocalUser()
            .map { user in
                self.user = user
                return user
            }
            
        let matchInfo = input.match
            .flatMap { [weak self] match -> Observable<MatchInfo> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.matchUseCase.fetchMatch(matchID: match.matchID)
            }
            .map { [weak self] matchInfo in
                self?.matchInfo = matchInfo
                return matchInfo
            }
        
        return Output(
            user: user.share(),
            matchInfo: matchInfo.share()
        )
    }
}
