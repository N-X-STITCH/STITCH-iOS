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
    func logout() -> Observable<Void>
    func save(socialLogin: SocialLogin) -> Observable<Void>
    func fetchSocialLogin() -> Observable<String?>
    func removeSocialLogin() -> Observable<Void>
    func save(blockMatchID: String) -> Observable<Void>
    func fetchMatchIDs() -> Observable<[String]?>
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
    
    func logout() -> Observable<Void> {
        return userStorage.logout()
    }
    
    func save(socialLogin: SocialLogin) -> Observable<Void> {
        return userStorage.save(socialLogin: socialLogin)
    }
    
    func fetchSocialLogin() -> Observable<String?> {
        return userStorage.fetchSocialLogin()
    }
    
    func removeSocialLogin() -> Observable<Void> {
        return userStorage.removeSocialLogin()
    }
    
    func save(blockMatchID: String) -> Observable<Void> {
        userStorage.fetchMatchIDs()
            .flatMap { [weak self] matchIDs -> Observable<Void> in
                guard let self else { return .error(STITCHError.unknown) }
                var saveMatchIDs: [String] = []
                if let matchIDs = matchIDs {
                    saveMatchIDs = matchIDs
                    saveMatchIDs.append(blockMatchID)
                } else {
                    saveMatchIDs = [blockMatchID]
                }
                return self.userStorage.save(blockMatchIDs: saveMatchIDs)
            }
    }
    
    func fetchMatchIDs() -> Observable<[String]?> {
        return self.userStorage.fetchMatchIDs()
    }
}
