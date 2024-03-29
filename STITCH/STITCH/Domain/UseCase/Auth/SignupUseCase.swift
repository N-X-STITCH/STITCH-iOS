//
//  SignupUseCase.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

import RxSwift

protocol SignupUseCase {
    func signup(user: User) -> Observable<User>
    func isSignuped(userID: String) -> Observable<User>
    func user(userID: String) -> Observable<User>
}

final class DefaultSignupUseCase: SignupUseCase {
    
    // MARK: - Properties
    
    private let signupRepository: SignupRepository
    
    // MARK: - Initializer
    
    init(signupRepository: SignupRepository) {
        self.signupRepository = signupRepository
    }
    
    // MARK: - Methods
    
    func signup(user: User) -> Observable<User> {
        return signupRepository.create(user: user)
    }
    
    func isSignuped(userID: String) -> Observable<User> {
        return signupRepository.isUser(userID: userID)
            .flatMap { [weak self] isSignuped -> Observable<User> in
                guard let self else { return .error(SocialLoginError.unknown) }
                if isSignuped {
                    return self.signupRepository.fetchUser(userID: userID)
                } else {
                    return Single<User>.just(User()).asObservable()
                }
            }
    }
    
    func user(userID: String) -> Observable<User> {
        return signupRepository.fetchUser(userID: userID)
    }
}
