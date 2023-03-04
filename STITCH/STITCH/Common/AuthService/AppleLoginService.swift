//
//  AppleLoginService.swift
//  STITCH
//
//  Created by neuli on 2023/02/27.
//

import AuthenticationServices
import Foundation

import RxSwift

final class AppleLoginService: NSObject, SocialLoginService {
    
    private let viewControoler: UIViewController
    let loginInfo = PublishSubject<LoginInfo>()
    
    init(_ viewController: UIViewController) {
        self.viewControoler = viewController
    }
    
    func login() -> Observable<LoginInfo> {
        createRequest()
        return loginInfo.asObservable()
    }
    
    func createRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension AppleLoginService: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return viewControoler.view.window!
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let loginInfo = LoginInfo(
                id: appleIDCredential.user,
                nickname: appleIDCredential.fullName?.nickname ?? "User\(Int.random(in: 0...9999))",
                profileImageURL: nil
            )
            print(loginInfo)
            self.loginInfo.onNext(loginInfo)
        default: break
        }
    }
}
