//
//  User.swift
//  STITCH
//
//  Created by neuli on 2023/02/27.
//

import Foundation

struct User: Hashable, Codable {
    let id: String
    let nickname: String
    let profileImageURL: String?
    let interestedSports: [Sport]
    let address: String
    let token: String
    let introduce: String
    
    init(
        id: String,
        nickname: String,
        profileImageURL: String?,
        interestedSports: [Sport],
        address: String,
        token: String,
        introduce: String
    ) {
        self.id = id
        self.nickname = nickname
        self.profileImageURL = profileImageURL
        self.interestedSports = interestedSports
        self.address = address
        self.token = token
        self.introduce = introduce
    }
    
    init(
        loginInfo: LoginInfo,
        sports: [Sport],
        address: String
    ) {
        self.id = loginInfo.id
        self.nickname = loginInfo.nickname
        self.profileImageURL = loginInfo.profileImageURL
        self.interestedSports = sports
        self.address = address
        self.token = ""
        self.introduce = ""
    }
}
