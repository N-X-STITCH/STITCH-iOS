//
//  DefaultUserRepository.swift
//  STITCH
//
//  Created by neuli on 2023/03/19.
//

import Foundation

import RxSwift

final class DefaultUserRepository: UserRepository {
    
    // MARK: - Properties
    
    private let urlSessionNetworkService: URLSessionNetworkService
    
    // MARK: - Initializer
    
    init(urlSessionNetworkService: URLSessionNetworkService) {
        self.urlSessionNetworkService = urlSessionNetworkService
    }
    
    // MARK: - Methods
    
    func fetchUser(userID: String) -> Observable<User> {
        let endpoint = UserAPIEndpoints.fetchUser(userID: userID)
        return urlSessionNetworkService.request(with: endpoint)
            .map(UserDTO.self)
            .map { User(userDTO: $0) }
    }
    
    func updateUser(user: User) -> Observable<User> {
        let userDTO = UserDTO(user: user)
        let endpoint = UserAPIEndpoints.updateUser(userDTO: userDTO)
        return urlSessionNetworkService.request(with: endpoint)
            .map(UserDTO.self)
            .map { User(userDTO: $0) }
    }
    
    func deleteUser(userID: String) -> Observable<String> {
        let endpoint = UserAPIEndpoints.deleteUser(userID: userID)
        return urlSessionNetworkService.request(with: endpoint)
            .map(String.self)
    }
}
