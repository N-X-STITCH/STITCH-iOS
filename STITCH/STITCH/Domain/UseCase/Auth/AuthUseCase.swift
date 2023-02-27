//
//  AuthUseCase.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

import RxSwift

protocol AuthUseCase {
    func socialLogin(_ platform: SocialLogin) -> Observable<LoginInfo>
}

final class DefaultAuthUseCase: AuthUseCase {
    
    // MARK: - Properties
    
    private lazy var kakaoLoginService: SocialLoginService = KakaoLoginService()
    private lazy var appleLoginService: SocialLoginService = AppleLoginService()
    
    // MARK: - Initializer
    
    init() {
    }
    
    // MARK: - Methods
    
    func socialLogin(_ platform: SocialLogin) -> Observable<LoginInfo> {
        switch platform {
        case .apple:
            return appleLoginService.login()
        case .kakao:
            return kakaoLoginService.login()
        }
    }
}
