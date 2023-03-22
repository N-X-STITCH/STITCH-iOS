//
//  SocialLoginError.swift
//  STITCH
//
//  Created by neuli on 2023/02/27.
//

import Foundation

enum SocialLoginError: LocalizedError {
    case canNotAvailableKakaoLogin
    case logout
    case signout
    case authorizationCode
    case clientSecret
    case unknown
    
    var errorDescription: String {
        switch self {
        case .canNotAvailableKakaoLogin: return "카카오 로그인 실패"
        case .logout: return "로그아웃에 실패했습니다."
        case .signout: return "탈퇴에 실패했습니다."
        case .authorizationCode: return "authrizationCode 생성 실패"
        case .clientSecret: return "client secret 생성 실패"
        case .unknown: return "알 수 없는 에러입니다."
        }
    }
}
