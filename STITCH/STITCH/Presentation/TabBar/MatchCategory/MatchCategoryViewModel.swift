//
//  MatchCategoryViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/03/14.
//

import Foundation

import RxSwift

final class MatchCategoryViewModel: ViewModel {
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let selectSport: Observable<Sport>
        let refreshObservalble: Observable<Void>
    }
    
    struct Output {
        let allMatchObservable: Observable<[Match]>
        let teachMatchObservable: Observable<[Match]>
        let selectSportObservable: Observable<[Match]>
        let refreshMatchObservable: Observable<[Match]>
    }
    
    // MARK: - Properties
    
    private let matchUseCase: MatchUseCase
    
    // MARK: - Initializer
    
    init(matchUseCase: MatchUseCase) {
        self.matchUseCase = matchUseCase
    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        
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
            allMatchObservable: allMatchObservable,
            teachMatchObservable: teachMatchObservable,
            selectSportObservable: selectSportObservable,
            refreshMatchObservable: refreshMatchObservable
        )
    }
}
