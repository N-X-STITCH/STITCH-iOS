//
//  AppleLoginService.swift
//  STITCH
//
//  Created by neuli on 2023/02/27.
//

import Foundation

import RxSwift

final class AppleLoginService: SocialLoginService {
    
    init() {}
    
    func login() -> RxSwift.Observable<LoginInfo> {
        return Observable.error(SocialLoginError.unknown)
    }
}
