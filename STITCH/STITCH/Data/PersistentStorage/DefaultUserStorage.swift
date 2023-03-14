//
//  DefaultUserStorage.swift
//  STITCH
//
//  Created by neuli on 2023/03/14.
//

import Foundation

import RxSwift

final class DefaultUserStorage: UserStorage {
    
    // MARK: - Properties
    
    private let userDefaultsService: UserDefaultsService
    
    private let userIDKey = "userIDKey"
    
    // MARK: - Initializer
    
    init(userDefaultsService: UserDefaultsService) {
        self.userDefaultsService = userDefaultsService
    }
    
    // MARK: - Methods
    
    func save(user: User) {
        userDefaultsService.save(value: user, forKey: userIDKey)
    }
    
    func fetchUser() -> Observable<User?> {
        return userDefaultsService.value(valueType: User.self, forKey: userIDKey)
    }
}
