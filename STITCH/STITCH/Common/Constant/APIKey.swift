//
//  APIKey.swift
//  STITCH
//
//  Created by neuli on 2023/03/15.
//

import Foundation

struct ServiceAPIKey: Codable {
    let kakaoAPIKey: String
    let privateAuthKey: String
    let cloudClientID: String
    let cloudClientSecret: String
}

struct APIKey {
    static var kakaoAPIKey: String {
        guard let serviceInfoURL = Bundle.main.url(forResource: "Service-Info", withExtension: "plist"),
              let data = try? Data(contentsOf: serviceInfoURL),
              let apiKey = try? PropertyListDecoder().decode(ServiceAPIKey.self, from: data)
        else { return "" }
        return apiKey.kakaoAPIKey
    }
    
    static var privateAuthKey: String {
        guard let serviceInfoURL = Bundle.main.url(forResource: "Service-Info", withExtension: "plist"),
              let data = try? Data(contentsOf: serviceInfoURL),
              let apiKey = try? PropertyListDecoder().decode(ServiceAPIKey.self, from: data)
        else { return "" }
        return apiKey.privateAuthKey
    }
    
    static var naverCloudClientID: String {
        guard let serviceInfoURL = Bundle.main.url(forResource: "Service-Info", withExtension: "plist"),
              let data = try? Data(contentsOf: serviceInfoURL),
              let apiKey = try? PropertyListDecoder().decode(ServiceAPIKey.self, from: data)
        else { return "" }
        return apiKey.cloudClientID
    }
    
    static var naverCloudClientSecret: String {
        guard let serviceInfoURL = Bundle.main.url(forResource: "Service-Info", withExtension: "plist"),
              let data = try? Data(contentsOf: serviceInfoURL),
              let apiKey = try? PropertyListDecoder().decode(ServiceAPIKey.self, from: data)
        else { return "" }
        return apiKey.cloudClientSecret
    }
}
