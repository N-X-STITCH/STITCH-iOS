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
    
    init() {
        self.id = ""
        self.nickname = ""
        self.profileImageURL = ""
        self.interestedSports = []
        self.address = ""
        self.token = ""
        self.introduce = ""
    }
    
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
        locationInfo: LocationInfo?
    ) {
        self.id = loginInfo.id
        self.nickname = loginInfo.nickname
        self.profileImageURL = loginInfo.profileImageURL
        self.interestedSports = sports
        self.address = locationInfo?.address ?? ""
        self.token = ""
        self.introduce = ""
    }
    
    init(userDTO: UserDTO) {
        self.id = userDTO.id
        self.nickname = userDTO.name
        self.profileImageURL = userDTO.imageUrl
        self.interestedSports = userDTO.sports.compactMap { Sport($0) }
        self.address = userDTO.location
        self.token = userDTO.token
        self.introduce = userDTO.introduce
    }
}
