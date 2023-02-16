//
//  NetworkService.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

import RxSwift
import RxCocoa

protocol URLSessionNetworkService {
    func request(with endpoint: Requestable) -> Observable<Data>
}

final class DefaultURLSessionNetworkService: URLSessionNetworkService {
    
    // MARK: - Properties
    
    private let config: NetworkConfigurable
    
    // MARK: - Initializer
    
    init(config: NetworkConfigurable) {
        self.config = config
    }
    
    // MARK: - Methods
    
    func request(with endpoint: Requestable) -> Observable<Data> {
        guard let request = try? endpoint.urlRequest(with: config) else {
            return .error(NetworkError.invalidURLError)
        }
        
        return URLSession.shared.rx
            .data(request: request)
    }
}
