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
    private let userDefaultsService: UserDefaultsService
    
    private let userIDKey = "userIDKey"
    
    // MARK: - Initializer
    
    init(
        urlSessionNetworkService: URLSessionNetworkService,
        userDefaultsService: UserDefaultsService
    ) {
        self.urlSessionNetworkService = urlSessionNetworkService
        self.userDefaultsService = userDefaultsService
    }
    
    // MARK: - Methods
    
    func create(user: User) -> Observable<Data> {
        let userDTO = UserDTO(user: user)
        let endpoint = APIEndpoints.createUser(userDTO: userDTO)
        return urlSessionNetworkService.request(with: endpoint)
    }
    
    func save(userID: String) {
        userDefaultsService.save(value: userID, forKey: userIDKey)
    }
    
    func fetchUserIDInUserDefaults() -> Observable<String?> {
        return userDefaultsService.stringValue(forKey: userIDKey)
    }
}
