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
    }
    
    // MARK: - Properties
    
    private let userUseCase: UserUseCase
    
    // MARK: - Initializer
    
    init(userUseCase: UserUseCase) {
        self.userUseCase = userUseCase
    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        
        let userObservable = input.viewWillAppear
            .flatMap { [weak self] _ -> Observable<User> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.userUseCase.fetchLocalUser()
            }
        
        return Output(userObservable: userObservable)
    }
}
