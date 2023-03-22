//
//  AppleLoginUseCase.swift
//  STITCH
//
//  Created by neuli on 2023/03/22.
//

import Foundation

import RxSwift

protocol AppleLoginUseCase {
    func revokeToken(authorizationCode: String) -> Observable<Void>
}

final class DefaultAppleLoginUseCase: AppleLoginUseCase {
    
    // MARK: - Properties
    
    private let appleLoginRepository: AppleLoginRepository
    
    // MARK: - Initializer
    
    init(appleLoginRepository: AppleLoginRepository) {
        self.appleLoginRepository = appleLoginRepository
    }
    
    func revokeToken(authorizationCode: String) -> Observable<Void> {
        return refreshToken(authorizationCode: authorizationCode)
            .flatMap { [weak self] refreshToken -> Observable<Void> in
                guard let self else { return .error(SocialLoginError.signout) }
                return self.appleLoginRepository.revokeToken(refreshToken: refreshToken)
            }
    }
    
    private func refreshToken(authorizationCode: String) -> Observable<String> {
        return appleLoginRepository.refreshToken(authorizationCode: authorizationCode)
    }
}

