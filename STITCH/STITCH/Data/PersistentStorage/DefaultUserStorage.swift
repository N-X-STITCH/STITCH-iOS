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
    private let socialLoginIDKey = "socialLoginIDKey"
    private let blockMatchIDsKey = "blockMatchIDsKey"
    
    // MARK: - Initializer
    
    init(userDefaultsService: UserDefaultsService) {
        self.userDefaultsService = userDefaultsService
    }
    
    // MARK: - Methods
    
    func save(user: User) -> Observable<Void> {
        userDefaultsService.save(value: user, forKey: userIDKey)
        return Single<Void>.just(()).asObservable()
    }
    
    func fetchUser() -> Observable<User?> {
        return userDefaultsService.value(valueType: User.self, forKey: userIDKey)
    }
    
    func logout() -> Observable<Void> {
        userDefaultsService.delete(forKey: userIDKey)
        return Single<Void>.just(()).asObservable()
    }
    
    func save(socialLogin: SocialLogin) -> Observable<Void> {
        userDefaultsService.save(value: socialLogin.rawValue, forKey: socialLoginIDKey)
        return Single<Void>.just(()).asObservable()
    }
    
    func fetchSocialLogin() -> Observable<String?> {
        return userDefaultsService.value(valueType: String.self, forKey: socialLoginIDKey)
    }
    
    func removeSocialLogin() -> Observable<Void> {
        userDefaultsService.delete(forKey: socialLoginIDKey)
        return Single<Void>.just(()).asObservable()
    }
    
    func save(blockMatchIDs: [String]) -> Observable<Void> {
        userDefaultsService.save(value: blockMatchIDs, forKey: blockMatchIDsKey)
        return Single<Void>.just(()).asObservable()
    }
    
    func fetchMatchIDs() -> Observable<[String]?> {
        return userDefaultsService.value(valueType: [String].self, forKey: blockMatchIDsKey)
    }
}
