//
//  MatchCategoryViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/03/14.
//

import Foundation

import RxSwift

final class MatchCategoryViewModel: ViewModel {
    
    var user: User!
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let viewWillAppear: Observable<Void>
        let selectSport: Observable<Sport>
        let refreshObservalble: Observable<Void>
    }
    
    struct Output {
        let userObservable: Observable<User>
        let viewDidLoadMatchObservable: Observable<[Match]>
        let viewRefreshMatchObservable: Observable<[Match]>
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
        
        let viewDidLoad = input.viewDidLoad.share()
        let viewWillAppear = input.viewWillAppear.share()
        let selectSport = input.selectSport.share()
        
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
        
        let viewDidLoadMatchObservable = viewDidLoad
            .flatMap { [weak self] _ -> Observable<[Match]> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.matchUseCase.fetchAllMatch()
            }
            .share()
        
        let viewRefreshObservable = Observable.of(viewWillAppear, input.refreshObservalble).merge().debug("refresh")
        
        let viewRefreshMatchObservable = Observable.combineLatest(viewRefreshObservable, selectSport)
            .skip(1)
            .flatMap { [weak self] (_, sport) -> Observable<[Match]> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.matchUseCase.fetchAllMatch()
                    .map { sport == .all ? $0 : $0.filter { $0.sport == sport } }
            }
            .share()
        
        return Output(
            userObservable: userObservable,
            viewDidLoadMatchObservable: viewDidLoadMatchObservable,
            viewRefreshMatchObservable: viewRefreshMatchObservable
        )
    }
}
