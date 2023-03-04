//
//  DefaultSignupRepository.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

import RxSwift

final class DefaultSignupRepository: SignupRepository {
    
    private let urlSessionNetworkService: URLSessionNetworkService
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    init(urlSessionNetworkService: URLSessionNetworkService) {
        self.urlSessionNetworkService = urlSessionNetworkService
    }
    
    // MARK: - Methods
    
    func createUser(user: User) -> Observable<Data> {
        let userDTO = UserDTO(user: user)
        let endpoint = APIEndpoints.createUser(userDTO: userDTO)
        return urlSessionNetworkService.request(with: endpoint)
    }
}
