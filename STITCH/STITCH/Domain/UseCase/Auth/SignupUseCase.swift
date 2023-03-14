//
//  SignupUseCase.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

import RxSwift

protocol SignupUseCase {
    func signup(user: User) -> Observable<Data>
    func isSignuped(userID: String) -> Observable<Bool>
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
    
    func signup(user: User) -> Observable<Data> {
        return signupRepository.create(user: user)
    }
    
    func isSignuped(userID: String) -> Observable<Bool> {
        return signupRepository.isUser(userID: userID)
            .map(Bool.self)
    }
    
    func user(userID: String) -> Observable<User> {
        return signupRepository.fetchUser(userID: userID)
            .map(User.self)
    }
}
