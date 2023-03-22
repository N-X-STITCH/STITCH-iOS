//
//  APIKey.swift
//  STITCH
//
//  Created by neuli on 2023/03/15.
//

import Foundation

struct ServiceAPIKey: Codable {
    let privateAuthKey: String
    let clientID: String
    let clientSecret: String
    let cloudClientID: String
    let cloudClientSecret: String
}

struct APIKey {
    static var privateAuthKey: String {
        guard let serviceInfoURL = Bundle.main.url(forResource: "Service-Info", withExtension: "plist"),
              let data = try? Data(contentsOf: serviceInfoURL),
              let apiKey = try? PropertyListDecoder().decode(ServiceAPIKey.self, from: data)
        else { return "" }
        return apiKey.privateAuthKey
    }
    
    static var naverClientID: String {
        guard let serviceInfoURL = Bundle.main.url(forResource: "Service-Info", withExtension: "plist"),
              let data = try? Data(contentsOf: serviceInfoURL),
              let apiKey = try? PropertyListDecoder().decode(ServiceAPIKey.self, from: data)
        else { return "" }
        return apiKey.clientID
    }
    
    static var naverClientSecret: String {
        guard let serviceInfoURL = Bundle.main.url(forResource: "Service-Info", withExtension: "plist"),
              let data = try? Data(contentsOf: serviceInfoURL),
              let apiKey = try? PropertyListDecoder().decode(ServiceAPIKey.self, from: data)
        else { return "" }
        return apiKey.clientSecret
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
