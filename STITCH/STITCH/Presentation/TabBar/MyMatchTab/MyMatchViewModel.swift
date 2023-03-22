//
//  MyMatchViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/03/21.
//

import Foundation

import RxSwift

final class MyMatchViewModel: ViewModel {
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let refreshObservalble: Observable<Void>
    }
    
    struct Output {
        let myMatchObservable: Observable<[Match]>
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
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        
        let callMyMatch = Observable.of(input.viewDidLoad, input.refreshObservalble).merge()
        
        let myMatchObservable = callMyMatch
            .flatMap { [weak self] _ -> Observable<User> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.userUseCase.fetchLocalUser()
            }
            .flatMap { [weak self] _ -> Observable<[Match]> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.myPageUseCase.myMatch()
            }
            .share()
        
        return Output(
            myMatchObservable: myMatchObservable
        )
    }
}
