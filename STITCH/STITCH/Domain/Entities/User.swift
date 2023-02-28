//
//  User.swift
//  STITCH
//
//  Created by neuli on 2023/02/27.
//

import Foundation

struct User: Codable {
    let nickname: String?
    let email: String?
    let profileImageURL: String?
    let interestedSports: [String]?
    let location: String?
}
