//
//  MatchDetail.swift
//  STITCH
//
//  Created by neuli on 2023/03/21.
//

import Foundation

struct MatchDetail: Hashable {
    let match: Match
    let hostMember: User
    let joinedMembers: [User]
    
    init(
        match: Match,
        hostMember: User,
        joinedMembers: [User] = []
    ) {
        self.match = match
        self.hostMember = hostMember
        self.joinedMembers = joinedMembers
    }
    
    init(
        matchDTO: MatchDTO,
        hostMemberDTO: UserDTO,
        joinedMembersDTO: [UserDTO] = []
    ) {
        self.match = Match(matchDTO: matchDTO)
        self.hostMember = User(userDTO: hostMemberDTO)
        self.joinedMembers = joinedMembersDTO.map { User(userDTO: $0) }
    }
}
