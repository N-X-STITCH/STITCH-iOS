//
//  UserDTO.swift
//  STITCH
//
//  Created by neuli on 2023/03/04.
//

import Foundation

struct UserDTO: Codable {
    let id: String
    let type: String
    let name: String
    let location: String
    let imageUrl: String
    let sports: [String]
    let token: String
    let introduce: String
    
    init(user: User) {
        self.id = user.id
        self.type = "member"
        self.name = user.nickname
        self.location = user.address
        self.imageUrl = user.profileImageURL ?? ""
        self.sports = user.interestedSports.map { $0.name }
        self.token = user.token
        self.introduce = user.introduce
    }
}
