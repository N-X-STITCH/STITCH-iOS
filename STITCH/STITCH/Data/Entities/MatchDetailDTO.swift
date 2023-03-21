//
//  MatchDetailDTO.swift
//  STITCH
//
//  Created by neuli on 2023/03/21.
//

import Foundation

struct MatchDetailDTO: Decodable {
    let match: MatchDTO
    let hostMember: UserDTO?
    let joinedMembers: [UserDTO]
}
