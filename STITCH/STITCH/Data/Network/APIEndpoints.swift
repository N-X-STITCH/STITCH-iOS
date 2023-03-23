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
            path: "/member",
            method: .POST,
            bodyParameters: userDTO.toDictionary ?? [:]
        )
    }
    
    static func isUser(userID: String) -> Endpoint {
        return Endpoint(
            path: "/member/isMember/id=\(userID)",
            method: .GET
        )
    }
    
    static func fetchUser(userID: String) -> Endpoint {
        return Endpoint(
            path: "/member/info/id=\(userID)",
            method: .GET
        )
    }
    
    static func updateUser(userDTO: UserDTO) -> Endpoint {
        return Endpoint(
            path: "/member/update",
            method: .PUT,
            bodyParameters: userDTO.toDictionary ?? [:]
        )
    }
    
    static func deleteUser(userID: String) -> Endpoint {
        return Endpoint(
            path: "/member/delete/id=\(userID)",
            method: .DELETE
        )
    }
    
    static func fetchMyPage(userID: String) -> Endpoint {
        return Endpoint(
            path: "/view/myPage/id=\(userID)",
            method: .GET
        )
    }
    
    static func fetchMyMatch(userID: String) -> Endpoint {
        return Endpoint(
            path: "/view/myMatch/id=\(userID)",
            method: .GET
        )
    }
}

struct AuthAPIEndpoints {
    static func refreshToken(authorizationCode: String, clientSecret: String) -> AppleEndpoint {
        return AppleEndpoint(
            path: "auth/token",
            method: .POST,
            headerParameters: ["Content-Type": "application/x-www-form-urlencoded"],
            bodyParameters: [
                "code": authorizationCode,
                "client_id": "com.neuli.STITCH",
                "client_secret": clientSecret,
                "grant_type": "authorization_code"
            ]
        )
    }
    
    static func revokeToken(refreshToken: String, clientSecret: String) -> AppleEndpoint {
        return AppleEndpoint(
            path: "auth/revoke",
            method: .POST,
            headerParameters: ["Content-Type": "application/x-www-form-urlencoded"],
            bodyParameters: [
                "token": refreshToken,
                "client_id": Bundle.main.bundleIdentifier!,
                "client_secret": clientSecret,
                "grant_type": "refresh_token"
            ]
        )
    }
}

struct MatchAPIEndpoints {
    static func createMatch(matchDTO: MatchDTO) -> Endpoint {
        return Endpoint(
            path: "/match/create",
            method: .POST,
            bodyParameters: matchDTO.toDictionary ?? [:]
        )
    }
    
    static func fetchMatch(matchID: String) -> Endpoint {
        return Endpoint(
            path: "/match/info/id=\(matchID)",
            method: .GET
        )
    }
    
    static func fetchAllMatch() -> Endpoint {
        return Endpoint(
            path: "/match/allMatch",
            method: .GET
        )
    }
    
    static func fetchAllTeachMatch() -> Endpoint {
        return Endpoint(
            path: "/match/allTeach",
            method: .GET
        )
    }
    
    static func fetchHomeMatch() -> Endpoint {
        return Endpoint(
            path: "/match/home",
            method: .GET
        )
    }
    
    static func deleteMatch(matchID: String) -> Endpoint {
        return Endpoint(
            path: "/match/delete/\(matchID)",
            method: .DELETE
        )
    }
    
    static func joinMatch(userID: String, joinMatchDTO: JoinMatchDTO) -> Endpoint {
        return Endpoint(
            path: "/match/join/id=\(userID)",
            method: .PUT,
            bodyParameters: joinMatchDTO.toDictionary ?? [:]
        )
    }
    
    static func cancelJoinMatch(userID: String, matchID: String) -> Endpoint {
        return Endpoint(
            path: "/match/leave",
            method: .DELETE,
            queryParameters: ["memberId": userID, "matchId": matchID]
        )
    }
    
    static func createReport(report: Report) -> Endpoint {
        return Endpoint(
            path: "/report",
            method: .POST,
            bodyParameters: report.toDictionary ?? [:]
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
            path: "/view/getNearAddress/address=\(location.address)",
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
