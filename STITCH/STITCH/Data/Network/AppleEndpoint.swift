//
//  AppleEndpoin.swift
//  STITCH
//
//  Created by neuli on 2023/03/22.
//

import Foundation

final class AppleEndpoint: AppleRequestable {
    
    let path: String
    let method: HTTPMethodType
    let headerParameters: [String: String]
    let queryParameters: [String: Any]
    let bodyParameters: [String: Any]
    
    init(
        path: String,
        method: HTTPMethodType,
        headerParameters: [String: String] = ["Content-Type": "application/json"],
        queryParameters: [String: Any] = [:],
        bodyParameters: [String: Any] = [:]
    ) {
        self.path = path
        self.method = method
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
    }
}

protocol AppleRequestable: Requestable {
    var path: String { get }
    var method: HTTPMethodType { get }
    var headerParameters: [String: String] { get }
    var queryParameters: [String: Any] { get }
    var bodyParameters: [String: Any] { get }
    
    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

extension AppleRequestable {
    func url(with config: NetworkConfigurable) throws -> URL {
        let baseURL = config.baseURL.absoluteString
        let endpoint = baseURL.appending(path)
        
        guard var urlComponents = URLComponents(string: endpoint) else {
            throw NetworkError.invalidURLError
        }
        var urlQueryItems: [URLQueryItem] = []
        
        queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }
        config.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        guard let url = urlComponents.url else { throw NetworkError.invalidURLError }
        return url
    }
    
    public func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)
        var allHeaders: [String: String] = config.headers
        headerParameters.forEach { allHeaders.updateValue($1, forKey: $0) }
        
        if !bodyParameters.isEmpty {
            var urlComponents = URLComponents()
            urlComponents.queryItems = bodyParameters.map { (key, value) in
                URLQueryItem(name: key, value: (value as! String))
            }
            urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
}
