//
//  APIKey.swift
//  STITCH
//
//  Created by neuli on 2023/03/15.
//

import Foundation

struct ServiceAPIKey: Codable {
    let naver: Naver
    let naverCloud: NaverCloud
}

struct Naver: Codable {
    let clientID: String
    let clientSecret: String
}

struct NaverCloud: Codable {
    let cloudClientID: String
    let cloudClientSecret: String
}

struct APIKey {
    static var naverAPIKey: Naver {
        guard let serviceInfoURL = Bundle.main.url(forResource: "Service-Info", withExtension: "plist"),
              let data = try? Data(contentsOf: serviceInfoURL),
              let apiKey = try? PropertyListDecoder().decode(ServiceAPIKey.self, from: data)
        else { return Naver(clientID: "", clientSecret: "") }
        return apiKey.naver
    }
    
    static var naverCloudAPIKey: NaverCloud {
        guard let serviceInfoURL = Bundle.main.url(forResource: "Service-Info", withExtension: "plist"),
              let data = try? Data(contentsOf: serviceInfoURL),
              let apiKey = try? PropertyListDecoder().decode(ServiceAPIKey.self, from: data)
        else { return NaverCloud(cloudClientID: "", cloudClientSecret: "") }
        return apiKey.naverCloud
    }
}
