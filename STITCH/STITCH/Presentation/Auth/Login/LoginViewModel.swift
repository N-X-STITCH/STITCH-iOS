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
        let loginInfo: Observable<LoginInfo>
    }
    
    struct Output {
        let signupedUser: Observable<Bool>
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
        let signupedUser = input.loginInfo
            .withUnretained(self)
            .flatMap { owner, loginInfo in
                print("보내는 아이디")
                print(loginInfo)
                return owner.signupUseCase.isSignuped(userID: loginInfo.id)
            }
        
        return Output(signupedUser: signupedUser)
    }
}
