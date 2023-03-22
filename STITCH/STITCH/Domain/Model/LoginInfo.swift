//
//  LoginInfo.swift
//  STITCH
//
//  Created by neuli on 2023/02/27.
//

import Foundation

struct LoginInfo {
    let id: String
    let nickname: String
    let profileImageURL: String?
    let loginType: SocialLogin?
    let authorizationCode: String?
    
    init(
        id: String,
        nickname: String,
        profileImageURL: String? = nil,
        loginType: SocialLogin? = nil,
        authorizationCode: String? = nil
    ) {
        self.id = id
        self.nickname = nickname
        self.profileImageURL = profileImageURL
        self.loginType = loginType
        self.authorizationCode = authorizationCode
    }
}
