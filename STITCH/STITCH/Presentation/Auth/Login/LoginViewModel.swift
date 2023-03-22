//
//  LoginViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

import RxSwift

final class LoginViewModel: ViewModel {
    
    struct Input {
        let loginInfo: Observable<LoginInfo>
    }
    
    struct Output {
        let signupedUser: Observable<Bool>
        let saveSocialLoginType: Observable<Void>
    }
    
    // MARK: - Properties
    
    private let signupUseCase: SignupUseCase
    private let userUseCase: UserUseCase
    
    let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    init(
        signupUseCase: SignupUseCase,
        userUseCase: UserUseCase
    ) {
        self.signupUseCase = signupUseCase
        self.userUseCase = userUseCase
    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        let loginInfo = input.loginInfo.share()
        
        let signupedUser = loginInfo
            .withUnretained(self)
            .flatMap { owner, loginInfo in
                print("보내는 아이디")
                print(loginInfo)
                return owner.signupUseCase.isSignuped(userID: loginInfo.id)
            }
        
        let saveSocialLoginType = loginInfo
            .withUnretained(self)
            .flatMap { owner, loginInfo -> Observable<Void> in
                guard let socialLoginType = loginInfo.loginType else { return .error(SocialLoginError.unknown) }
                return owner.userUseCase.save(socialLogin: socialLoginType)
            }
        
        let isSign = signupedUser
            .flatMap { [weak self] user in
                guard let self else { return Observable<Bool>.just(true).asObservable() }
                if user.id.isEmpty {
                    return Single<Bool>.just(false).asObservable()
                } else {
                    return self.userUseCase.save(user: user).map { true }
                }
            }
        
        return Output(signupedUser: isSign, saveSocialLoginType: saveSocialLoginType)
    }
}
