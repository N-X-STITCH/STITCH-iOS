//
//  LoginUseCase.swift
//  STITCH
//
//  Created by neuli on 2023/03/14.
//

import Foundation

import RxSwift

protocol UserUseCase {
    func save(user: User)
    func savedUser() -> Observable<User?>
}

final class DefaultUserUseCase: UserUseCase {
    
    // MARK: - Properties
    
    private let userStorage: UserStorage
    
    // MARK: - Initializer
    
    init(userStorage: UserStorage) {
        self.userStorage = userStorage
    }
    
    // MARK: - Methods
    
    func save(user: User) {
        userStorage.save(user: user)
    }
    
    func savedUser() -> Observable<User?> {
        return userStorage.fetchUser()
    }
}
