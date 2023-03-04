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
        let signupResult: Observable<Data>
    }
    
    private let signupUseCase: SignupUseCase
    
    // MARK: - Initializer
    
    init(signupUseCase: SignupUseCase) {
        self.signupUseCase = signupUseCase
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let signupResult = input.signupButtonTap
            .withUnretained(self)
            .flatMap { owner, _ -> Observable<Data> in
                let user = owner.makeUser()
                return owner.signupUseCase.signup(user: user)
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
