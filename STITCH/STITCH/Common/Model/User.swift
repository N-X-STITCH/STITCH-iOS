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
