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
    
    init(
        id: String,
        nickname: String,
        profileImageURL: String?,
        interestedSports: [Sport],
        address: String
    ) {
        self.id = id
        self.nickname = nickname
        self.profileImageURL = profileImageURL
        self.interestedSports = interestedSports
        self.address = address
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
    }
}
