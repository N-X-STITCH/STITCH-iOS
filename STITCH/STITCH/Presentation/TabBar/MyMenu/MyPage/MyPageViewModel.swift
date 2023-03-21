//
//  MyPageViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import Foundation

import RxSwift

final class MyPageViewModel: ViewModel {
    
    struct Input {
        let viewWillAppear: Observable<Bool>
    }
    
    struct Output {
        let userObservable: Observable<User>
        let myMatch: Observable<[Match]>
    }
    
    // MARK: - Properties
    
    private let userUseCase: UserUseCase
    private let myPageUseCase: MyPageUseCase
    
    // MARK: - Initializer
    
    init(
        userUseCase: UserUseCase,
        myPageUseCase: MyPageUseCase
    ) {
        self.userUseCase = userUseCase
        self.myPageUseCase = myPageUseCase
    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        
        let userObservable = input.viewWillAppear
            .flatMap { [weak self] _ -> Observable<User> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.userUseCase.fetchLocalUser()
            }
        
        let myMatch = input.viewWillAppear
            .flatMap { [weak self] _ -> Observable<[Match]> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.myPageUseCase.myMatch()
            }
        
        return Output(
            userObservable: userObservable,
            myMatch: myMatch
        )
    }
}
