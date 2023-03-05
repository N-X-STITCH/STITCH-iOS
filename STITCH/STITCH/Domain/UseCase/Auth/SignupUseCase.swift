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
}
