//
//  CreateMatchViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/03/05.
//

import Foundation

import RxCocoa
import RxSwift

final class CreateMatchViewModel {
    
    var newMatch = Match()
    
    // MARK: - Properties
    
    struct Input {
        let matchImage = BehaviorSubject<Data?>(value: nil)
        let completeFinishButtom: Observable<Void>
    }
    
    struct Output {
        let createdMatchResult: Observable<Match>
    }
    
    private let createMatchUseCase: CreateMatchUseCase
    private let userUseCase: UserUseCase
    
    // MARK: - Initializer
    
    init(
        createMatchUseCase: CreateMatchUseCase,
        userUseCase: UserUseCase
    ) {
        self.createMatchUseCase = createMatchUseCase
        self.userUseCase = userUseCase
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let matchImageURL = input.matchImage
            .asObservable()
            .withUnretained(self)
            .flatMap { owner, data in
                print(owner.newMatch.matchID)
                return owner.createMatchUseCase.uploadImage(data: data, path: owner.newMatch.matchID)
            }
            .share()
        
        let createMatchResult = Observable.combineLatest(input.completeFinishButtom, matchImageURL)
            .flatMap { [weak self] _, matchImageURL -> Observable<User> in
                guard let self = self else { return .error(NetworkError.unknownError) }
                print(matchImageURL)
                self.newMatch.matchImageURL = matchImageURL
                return self.userUseCase.fetchLocalUser()
            }
            .flatMap { [weak self] user -> Observable<Match> in
                guard let self = self else { return .error(NetworkError.unknownError) }
                self.newMatch.matchHostID = user.id
                print("===================================")
                print(self.newMatch)
                return self.createMatchUseCase.createMatch(match: self.newMatch)
            }
        
        return Output(createdMatchResult: createMatchResult)
    }
}
