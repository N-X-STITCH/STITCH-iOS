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
    
    struct Output {
        let loginResult: Observable<LoginInfo>
    }
    
    // MARK: - Properties
    
    private let authUseCase: AuthUseCase
    
    let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        let kakaoLoginResult = input.kakaoLoginTap
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.authUseCase.socialLogin(.kakao)
            }

        return Output(loginResult: kakaoLoginResult)
    }
}
