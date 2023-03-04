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
        let kakaoLoginInfo: Observable<LoginInfo>
        let appleLoginInfo: Observable<LoginInfo>
    }
    
    struct Output {
//        let loginResult: Observable<LoginInfo>
    }
    
    // MARK: - Properties
    
    private let signupUseCase: SignupUseCase
    
    let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    init(signupUseCase: SignupUseCase) {
        self.signupUseCase = signupUseCase
    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {

        return Output()
    }
}
