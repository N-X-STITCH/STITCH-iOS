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
        let allMatchObservable: Observable<[Match]>
        let teachMatchObservable: Observable<[Match]>
        let selectSportObservable: Observable<[Match]>
        let refreshMatchObservable: Observable<[Match]>
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
        
        let viewDidLoad = input.viewDidLoad.share()
        
        let allMatchObservable = viewDidLoad
            .flatMap { [weak self] _ -> Observable<[Match]> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.matchUseCase.fetchAllMatch()
            }
            .share()
        
        let teachMatchObservable = viewDidLoad
            .flatMap { [weak self] _ -> Observable<[Match]> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.matchUseCase.fetchAllTeachMatch()
            }
        
        let selectSportObservable = Observable.combineLatest(allMatchObservable, input.selectSport)
            .flatMap { (matchs, sport) -> Observable<[Match]> in
                if sport == .all {
                    return Single<[Match]>.just(matchs).asObservable()
                }
                return Single<[Match]>.just(matchs.filter { $0.sport == sport }).asObservable()
            }
        
        let refreshMatchObservable = input.refreshObservalble
            .flatMap { [weak self] _ -> Observable<[Match]> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.matchUseCase.fetchAllMatch()
            }
        
        return Output(
            userObservable: userObservable,
            allMatchObservable: allMatchObservable,
            teachMatchObservable: teachMatchObservable,
            selectSportObservable: selectSportObservable,
            refreshMatchObservable: refreshMatchObservable
        )
    }
}
