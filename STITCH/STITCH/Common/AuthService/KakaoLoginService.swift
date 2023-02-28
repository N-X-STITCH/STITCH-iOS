//
//  KakaoLoginService.swift
//  STITCH
//
//  Created by neuli on 2023/02/27.
//

import Foundation

import RxSwift

import RxKakaoSDKAuth
import RxKakaoSDKUser
import KakaoSDKAuth
import KakaoSDKUser

final class KakaoLoginService: SocialLoginService {

    private let disposeBag = DisposeBag()
    let loginInfo = PublishSubject<LoginInfo>()
    
    init() {}

    func login() -> Observable<LoginInfo> {
        kakaoLogin()
        return loginInfo.asObservable()
    }
    
    func userInfo() {
        return UserApi.shared.rx.me()
            .subscribe { user in
                let loginInfo = LoginInfo(
                    nickname: user.kakaoAccount?.profile?.nickname,
                    email: user.kakaoAccount?.email,
                    profileImageURL: user.kakaoAccount?.profile?.profileImageUrl?.absoluteString
                )
                self.loginInfo.onNext(loginInfo)
            }
            .disposed(by: disposeBag)
    }
    
    func kakaoLogin() {
        kakaoLoginToken()
            .withUnretained(self)
            .subscribe(onNext: { owner, token in
                print(token.accessToken)
                owner.userInfo()
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func kakaoLoginToken() -> Observable<OAuthToken> {
        if UserApi.isKakaoTalkLoginAvailable() {
            return UserApi.shared.rx.loginWithKakaoTalk()
        } else {
            return UserApi.shared.rx.loginWithKakaoAccount()
        }
    }
}
