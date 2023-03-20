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

struct MatchAPIEndpoints {
    static func createMatch(matchDTO: MatchDTO) -> Endpoint {
        return Endpoint(
            path: "match/create",
            method: .POST,
            bodyParameters: matchDTO.toDictionary ?? [:]
        )
    }
    
    static func fetchMatch(matchID: String) -> Endpoint {
        return Endpoint(
            path: "match/info/id=\(matchID)",
            method: .GET
        )
    }
    
    static func fetchAllMatch() -> Endpoint {
        return Endpoint(
            path: "match/allMatch",
            method: .GET
        )
    }
    
    static func fetchAllTeachMatch() -> Endpoint {
        return Endpoint(
            path: "match/allTeach",
            method: .GET
        )
    }
}

struct LocationAPIEndpoints {
    static func fetchGeoCodingAddress(query: String) -> Endpoint {
        return Endpoint(
            path: "map-geocode/v2/geocode",
            method: .GET,
            queryParameters: ["query": query]
        )
    }
    
    static func fetchReverseGeoCodingAddress(location: LocationInfo) -> Endpoint {
        guard let latitude = location.latitude,
              let longitude = location.longitude
        else { return Endpoint(path: "", method: .GET) }
        
        return Endpoint(
            path: "map-reversegeocode/v2/gc",
            method: .GET,
            queryParameters: [
                "request": "coordsToaddr",
                "coords": "\(longitude),\(latitude)",
                "sourcecrs": "epsg:4326",
                "output": "json",
                "orders": "legalcode,admcode"
            ]
        )
    }
    
    static func fetchNearAddresses(location: LocationInfo) -> Endpoint {
        return Endpoint(
            path: "view/getNearAddress/address=\(location.address)",
            method: .GET
        )
    }
    
    static func fetchSearchLocations(query: String) -> Endpoint {
        return Endpoint(
            path: "",
            method: .GET,
            queryParameters: [
                "query": query,
                "display": 5,
                "sort": "random"
            ]
        )
    }
}
