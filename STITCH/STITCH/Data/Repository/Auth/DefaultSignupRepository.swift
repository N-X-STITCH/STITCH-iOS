//
//  DefaultSignupRepository.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

import RxSwift

final class DefaultSignupRepository: SignupRepository {
    
    // MARK: - Properties
    
    private let urlSessionNetworkService: URLSessionNetworkService
    
    // MARK: - Initializer
    
    init(urlSessionNetworkService: URLSessionNetworkService) {
        self.urlSessionNetworkService = urlSessionNetworkService
    }
    
    // MARK: - Methods
    
    func create(user: User) -> Observable<User> {
        let userDTO = UserDTO(user: user)
        let endpoint = UserAPIEndpoints.createUser(userDTO: userDTO)
        return urlSessionNetworkService.request(with: endpoint)
            .map(UserDTO.self)
            .map { User(userDTO: $0) }
    }
    
    func isUser(userID: String) -> Observable<Bool> {
        let endpoint = UserAPIEndpoints.isUser(userID: userID)
        return urlSessionNetworkService.request(with: endpoint)
            .map(Bool.self)
    }
    
    func fetchUser(userID: String) -> Observable<User> {
        let endpoint = UserAPIEndpoints.fetchUser(userID: userID)
        return urlSessionNetworkService.request(with: endpoint)
            .map(UserDTO.self)
            .map { User(userDTO: $0) }
    }
}
