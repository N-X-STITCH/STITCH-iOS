//
//  LoginViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

import RxSwift

final class LoginViewModel {
    
    struct Input {}
    struct Output {}
    
    // MARK: - Properties
    
    private let signInUseCase: SignInUseCase
    
    // MARK: - Initializer
    
    init(signInUseCase: SignInUseCase) {
        self.signInUseCase = signInUseCase
    }
    
    
    // MARK: - Methods
}