//
//  MyPageDTO.swift
//  STITCH
//
//  Created by neuli on 2023/03/21.
//

import Foundation

struct MyPageDTO: Decodable {
    let member: UserDTO
    let myMatches: [MatchDTO]
}
