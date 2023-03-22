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
    var loginInfo = PublishSubject<LoginInfo>()
    
    init() {}

    func login() -> Observable<LoginInfo> {
        kakaoLogin()
        return loginInfo.asObservable()
    }
    
    func userInfo() {
        return UserApi.shared.rx.me()
            .subscribe { user in
                let loginInfo = LoginInfo(
                    id: "\(String(describing: user.id!))",
                    nickname: user.kakaoAccount?.profile?.nickname ?? "User\(Int.random(in: 0...999))",
                    profileImageURL: user.kakaoAccount?.profile?.profileImageUrl?.absoluteString ?? "",
                    loginType: .kakao
                )
                self.loginInfo.onNext(loginInfo)
            }
            .disposed(by: disposeBag)
    }
    
    func kakaoLogin() {
        kakaoLoginToken()
            .withUnretained(self)
            .subscribe(onNext: { owner, token in
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
    
    func initializeLoginInfo() {
        loginInfo.dispose()
        loginInfo = PublishSubject<LoginInfo>()
    }
}
