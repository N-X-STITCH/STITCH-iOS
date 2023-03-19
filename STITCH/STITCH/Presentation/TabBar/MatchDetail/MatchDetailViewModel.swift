//
//  MatchDetailViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import Foundation

import RxSwift

final class MatchDetailViewModel: ViewModel {
    
    struct Input {
        let match: Observable<Match>
    }
    
    struct Output {
        let matchInfo: Observable<MatchInfo>
    }
    
    // MARK: - Properties
    
    private let matchUseCase: MatchUseCase
    
    // MARK: - Initializer
    
    init(matchUseCase: MatchUseCase) {
        self.matchUseCase = matchUseCase
    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        
        let matchInfo = input.match
            .flatMap { [weak self] match -> Observable<MatchInfo> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.matchUseCase.fetchUser(userID: match.matchHostID)
                    .map { MatchInfo(match: match, owner: $0) }
            }
        
        return Output(
            matchInfo: matchInfo
        )
    }
}
