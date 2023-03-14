//
//  APIEndpoints.swift
//  STITCH
//
//  Created by neuli on 2023/03/04.
//

import Foundation

struct UserAPIEndpoints {
    static func createUser(userDTO: UserDTO) -> Endpoint {
        return Endpoint(
            path: "member",
            method: .POST,
            bodyParameters: userDTO.toDictionary ?? [:]
        )
    }
    
    static func isUser(userID: String) -> Endpoint {
        return Endpoint(
            path: "member/isMember/id=\(userID)",
            method: .GET
        )
    }
    
    static func fetchUser(userID: String) -> Endpoint {
        return Endpoint(
            path: "member/info/id=\(userID)",
            method: .GET
        )
    }
}
