//
//  SignupRepository.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

import RxSwift

protocol SignupRepository {
    func create(user: User) -> Observable<Data>
    func isUser(userID: String) -> Observable<Data>
    func fetchUser(userID: String) -> Observable<Data>
}
