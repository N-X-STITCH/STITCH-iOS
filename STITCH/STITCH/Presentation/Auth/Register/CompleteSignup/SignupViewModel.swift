//
//  SignupViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/02/24.
//

import Foundation

import RxCocoa
import RxSwift

final class SignupViewModel {
    
    // MARK: - Properties
    
    var loginInfo: LoginInfo? = nil
    var sports: [Sport] = []
    var location: String? = nil
    
    struct Input {
        let signupButtonTap: Observable<Void>
    }
    
    struct Output {
        let signupResult: Observable<Void>
    }
    
    private let signupUseCase: SignupUseCase
    private let userUseCase: UserUseCase
    
    // MARK: - Initializer
    
    init(
        signupUseCase: SignupUseCase,
        userUseCase: UserUseCase
    ) {
        self.signupUseCase = signupUseCase
        self.userUseCase = userUseCase
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let signupResult = input.signupButtonTap
            .withUnretained(self)
            .flatMap { owner, _ -> Observable<User> in
                let user = owner.makeUser()
                return owner.signupUseCase.signup(user: user)
            }
            .withUnretained(self)
            .flatMap { owner, user in
                return owner.userUseCase.save(user: user)
            }
        
        return Output(signupResult: signupResult)
    }
    
    private func makeUser() -> User {
        guard let loginInfo = loginInfo else { fatalError("cannot create userInfo") }
        let user = User(
            loginInfo: loginInfo,
            sports: sports,
            address: location ?? ""
        )
        return user
    }
}
