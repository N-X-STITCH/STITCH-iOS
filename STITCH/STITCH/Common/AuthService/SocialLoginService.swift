//
//  LoginRepository.swift
//  STITCH
//
//  Created by neuli on 2023/02/27.
//

import Foundation

import RxSwift

typealias AccessToken = String

protocol SocialLoginService {
    var loginInfo: PublishSubject<LoginInfo> { get }
    func login() -> Observable<LoginInfo>
}
