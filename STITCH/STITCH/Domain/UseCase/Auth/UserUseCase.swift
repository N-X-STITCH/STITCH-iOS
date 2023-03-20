//
//  LoginUseCase.swift
//  STITCH
//
//  Created by neuli on 2023/03/14.
//

import Foundation

import RxSwift

protocol UserUseCase {
    func fetchLocalUser() -> Observable<User>
    func save(user: User) -> Observable<Void>
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
    
    func fetchLocalUser() -> Observable<User> {
        return userStorage.fetchUser().compactMap { $0 }
    }
    
    func save(user: User) -> Observable<Void> {
        return userStorage.save(user: user)
    }
    
    func savedUser() -> Observable<User?> {
        return userStorage.fetchUser()
    }
}
