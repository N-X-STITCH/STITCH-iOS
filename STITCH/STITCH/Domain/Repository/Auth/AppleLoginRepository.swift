//
//  AppleLoginRepository.swift
//  STITCH
//
//  Created by neuli on 2023/03/22.
//

import Foundation

import RxSwift

protocol AppleLoginRepository {
    func refreshToken(authorizationCode: String) -> Observable<String>
    func revokeToken(refreshToken: String) -> Observable<Void>
}
