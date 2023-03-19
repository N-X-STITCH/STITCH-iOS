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
    }
    
    struct Output {
        let allMatchObservable: Observable<[Match]>
        let teachMatchObservable: Observable<[Match]>
        let selectSportObservable: Observable<[Match]>
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
                return Single<[Match]>.just(matchs.filter { $0.sport == sport }).asObservable()
            }
        
        return Output(
            allMatchObservable: allMatchObservable,
            teachMatchObservable: teachMatchObservable,
            selectSportObservable: selectSportObservable
        )
    }
}
