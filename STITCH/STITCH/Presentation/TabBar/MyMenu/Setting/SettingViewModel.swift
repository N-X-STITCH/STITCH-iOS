//
//  SettingViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import Foundation

import RxSwift

final class SettingViewModel: ViewModel {
    
    var loginType: String!
    
    struct Input {
    }
    
    struct Output {
    }
    
    // MARK: - Properties
    
    private let userUseCase: UserUseCase
    private let myPageUseCase: MyPageUseCase
    private let appleLoginUseCase: AppleLoginUseCase
    
    // MARK: - Initializer
    
    init(
        userUseCase: UserUseCase,
        myPageUseCase: MyPageUseCase,
        appleLoginUseCase: AppleLoginUseCase
    ) {
        self.userUseCase = userUseCase
        self.myPageUseCase = myPageUseCase
        self.appleLoginUseCase = appleLoginUseCase
    }
    
    // MARK: - Methods
    
    func loginTypeObservable() -> Observable<String> {
        return userUseCase.fetchSocialLogin()
            .compactMap { $0 }
            .map { [weak self] loginType in
                self?.loginType = loginType
                return loginType
            }
    }
    
    func logoutResult() -> Observable<Void> {
        return userUseCase.logout()
    }
    
    func signOutResult() -> Observable<Void> {
        return myPageUseCase.deleteUser()
            .withLatestFrom(self.userUseCase.logout())
    }
    
    func revokeToken(authorizationCode: String) -> Observable<Void> {
        return appleLoginUseCase.revokeToken(authorizationCode: authorizationCode)
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
