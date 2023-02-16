//
//  SingInUseCase.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Combine
import Foundation

protocol SignInUseCase {
    
}

final class DefaultSignInUseCase: SignInUseCase {
    
    // MARK: - Properties
    
    private let authRepository: AuthRepository
    
    // MARK: - Initializer
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    // MARK: - Methods
}
