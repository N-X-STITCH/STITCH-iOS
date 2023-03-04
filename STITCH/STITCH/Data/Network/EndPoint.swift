//
//  EndPoint.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

enum HTTPMethodType: String {
    case GET, POST, PUT, PATCH, DELETE
}

final class Endpoint: Requestable {
    
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

protocol Requestable {
    var path: String { get }
    var method: HTTPMethodType { get }
    var headerParameters: [String: String] { get }
    var queryParameters: [String: Any] { get }
    var bodyParameters: [String: Any] { get }
    
    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

extension Requestable {
    func url(with config: NetworkConfigurable) throws -> URL {
        let baseURL = config.baseURL.absoluteString.last != "/"
        ? config.baseURL.absoluteString + "/" : config.baseURL.absoluteString
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
            let httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
            urlRequest.httpBody = httpBody
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
}
