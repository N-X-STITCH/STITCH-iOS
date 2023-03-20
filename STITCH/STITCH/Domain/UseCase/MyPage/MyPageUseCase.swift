//
//  MyPageUseCase.swift
//  STITCH
//
//  Created by neuli on 2023/03/20.
//

import Foundation

import RxSwift

protocol MyPageUseCase {
    func uploadImage(data: Data?, path: String) -> Observable<String>
    func update(user: User) -> Observable<User>
    func deleteUser() -> Observable<String>
}

final class DefaultMyPageUseCase: MyPageUseCase {
    
    // MARK: - Properties
    
    private let userRepository: UserRepository
    private let userStorage: UserStorage
    private let fireStorageRepository: FireStorageRepository
    
    // MARK: - Initializer
    
    init(
        userRepository: UserRepository,
        userStorage: UserStorage,
        fireStorageRepository: FireStorageRepository
    ) {
        self.userRepository = userRepository
        self.userStorage = userStorage
        self.fireStorageRepository = fireStorageRepository
    }
    
    // MARK: - Methods

    func uploadImage(data: Data?, path: String) -> Observable<String> {
        if let data {
            return fireStorageRepository.uploadImage(data: data, path: path)
        } else {
            return Single<String>.just("").asObservable()
        }
    }
    
    func update(user: User) -> Observable<User> {
        let _ = userStorage.save(user: user)
        return userRepository.updateUser(user: user)
    }
    
    func deleteUser() -> Observable<String> {
        userStorage.fetchUser()
            .compactMap { $0 }
            .flatMap { [weak self] user -> Observable<String> in
                guard let self else { return .error(SocialLoginError.signout) }
                return self.userRepository.deleteUser(userID: user.id)
            }
    }
}
