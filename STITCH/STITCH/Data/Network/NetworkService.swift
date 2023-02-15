//
//  NetworkService.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Combine
import Foundation

protocol URLSessionNetworkService {
    func request(with endpoint: Requestable) -> AnyPublisher<Data, NetworkError>
}

final class DefaultURLSessionNetworkService: URLSessionNetworkService {
    
    private let config: NetworkConfigurable
    
    init(config: NetworkConfigurable) {
        self.config = config
    }
    
    func request(with endpoint: Requestable) -> AnyPublisher<Data, NetworkError> {
        guard let request = try? endpoint.urlRequest(with: config) else {
            return Fail(error: NetworkError.invalidURLError)
                .eraseToAnyPublisher()
        }
        
        return self.request(with: request)
    }
    
    private func request(with request: URLRequest) -> AnyPublisher<Data, NetworkError> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...299: return data
                    default: throw self.makeError(by: httpResponse.statusCode)
                    }
                } else {
                    throw self.makeError(by: 500)
                }
            }
            .mapError { _ in self.makeError(by: 0) }
            .eraseToAnyPublisher()
    }
    
    private func makeError(by statusCode: Int) -> NetworkError {
        if let networkError = NetworkError(rawValue: statusCode) {
            return networkError
        } else {
            return .unknownError
        }
    }
}
