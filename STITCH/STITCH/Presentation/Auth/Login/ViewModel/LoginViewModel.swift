//
//  LoginViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

import RxSwift

final class LoginViewModel: ViewModel {
    
    struct Input {
        let kakaoLoginTap: Observable<Void>
        let appleLoginTap: Observable<Void>
    }
    
    struct Output {}
    
    // MARK: - Properties
    
    private let authUseCase: AuthUseCase
    
    // MARK: - Initializer
    
    init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
//        let kakaoLoginResult = input.kakaoLoginTap
        return Output()
    }
}
