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
            path: "member/isMember",
            method: .GET,
            queryParameters: ["": userID]
        )
    }
    
    static func fetchUser(userID: String) -> Endpoint {
        return Endpoint(
            path: "member/info",
            method: .GET,
            queryParameters: ["": userID]
        )
    }
}
