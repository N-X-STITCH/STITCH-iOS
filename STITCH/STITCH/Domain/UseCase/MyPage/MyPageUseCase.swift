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
    func myMatch() -> Observable<[Match]>
    func myCreatedMatch() -> Observable<[Match]>
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
    
    func myMatch() -> Observable<[Match]> {
        userStorage.fetchUser()
            .compactMap { $0 }
            .flatMap { [weak self] user -> Observable<[Match]> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.userRepository.myMatch(userID: user.id)
            }
    }
    
    func myCreatedMatch() -> Observable<[Match]> {
        userStorage.fetchUser()
            .compactMap { $0 }
            .flatMap { [weak self] user -> Observable<[Match]> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.userRepository.myCreatedMatch(userID: user.id)
            }
    }
}
