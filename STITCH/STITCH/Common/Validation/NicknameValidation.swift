//
//  NicknameValidation.swift
//  STITCH
//
//  Created by neuli on 2023/02/23.
//

import Foundation

enum NicknameValidation {
    case ok
    case invalidWord
    case minLength
    case maxLength
    case duplication
    
    static let regexp = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]*$"
    
    var message: String {
        switch self {
        case .ok: return ""
        case .invalidWord: return "닉네임은 띄어쓰기 없이 한글, 영문, 숫자만 가능합니다."
        case .minLength: return "두글자 이상 입력해주세요."
        case .maxLength: return "제한된 글자 수를 초과했습니다."
        case .duplication: return "이미 등록된 닉네임입니다."
        }
    }
    
    var isEnabled: Bool {
        switch self {
        case .ok: return true
        default: return false
        }
    }
}
