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
    func login() -> Observable<LoginInfo>
}
