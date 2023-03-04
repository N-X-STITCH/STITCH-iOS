//
//  APIEndpoints.swift
//  STITCH
//
//  Created by neuli on 2023/03/04.
//

import Foundation

struct APIEndpoints {
    static func createUser(userDTO: UserDTO) -> Endpoint {
        return Endpoint(
            path: "member",
            method: .POST,
            bodyParameters: userDTO.toDictionary ?? [:]
        )
    }
}
