//
//  SocialLoginError.swift
//  STITCH
//
//  Created by neuli on 2023/02/27.
//

import Foundation

enum SocialLoginError: LocalizedError {
    case canNotAvailableKakaoLogin
    case unknown
    
    var errorDescription: String {
        switch self {
        case .canNotAvailableKakaoLogin: return "카카오 로그인 실패"
        case .unknown: return "알 수 없는 에러입니다."
        }
    }
}
