//
//  HomeViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/02/28.
//

import Foundation

import RxSwift

final class HomeViewModel: ViewModel {
    
    var user: User!
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let refreshControl: Observable<Void>
    }
    
    struct Output {
        let userObservable: Observable<User>
        let homeMatches: Observable<(recommendedMatches: [MatchDetail], newMatches: [Match])>
        let refreshHomeMatches: Observable<(recommendedMatches: [MatchDetail], newMatches: [Match])>
    }
    
    // MARK: - Properties
    
    private let userUseCase: UserUseCase
    private let myPageUseCase: MyPageUseCase
    private let matchUseCase: MatchUseCase
    
    // MARK: - Initializer
    
    init(
        userUseCase: UserUseCase,
        myPageUseCase: MyPageUseCase,
        matchUseCase: MatchUseCase
    ) {
        self.userUseCase = userUseCase
        self.myPageUseCase = myPageUseCase
        self.matchUseCase = matchUseCase
    }
    
    func userUpdate(address: String) -> Observable<User> {
        user.address = address
        return myPageUseCase.update(user: user)
    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        
        let refreshHomeMatches = input.refreshControl
            .withUnretained(self)
            .flatMap { owner, _ in
                return owner.matchUseCase.fetchHomeMatch()
            }
        
        let homeMatches = input.viewWillAppear
            .withUnretained(self)
            .flatMap { owner, _ in
                return owner.matchUseCase.fetchHomeMatch()
            }
        
        let userObservable = input.viewWillAppear
            .flatMap { [weak self] _ -> Observable<User> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.userUseCase.fetchLocalUser()
            }
            .map { user -> User in
                self.user = user
                return user
            }
            .share()

        return Output(
            userObservable: userObservable,
            homeMatches: homeMatches,
            refreshHomeMatches: refreshHomeMatches
        )
    }
}
