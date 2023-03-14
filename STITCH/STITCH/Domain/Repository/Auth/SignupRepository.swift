//
//  SignupRepository.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

import RxSwift

protocol SignupRepository {
    func create(user: User) -> Observable<User>
    func isUser(userID: String) -> Observable<Bool>
    func fetchUser(userID: String) -> Observable<User>
}
