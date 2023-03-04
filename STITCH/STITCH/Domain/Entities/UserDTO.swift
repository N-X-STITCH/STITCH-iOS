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
    let location: String
    let imageUrl: String
    let name: String
    let sports: [String]
    
    init(user: User) {
        self.id = user.id
        self.type = "member"
        self.location = user.address
        self.imageUrl = user.profileImageURL ?? ""
        self.name = user.nickname
        self.sports = user.interestedSports.map { $0.name }
    }
}
