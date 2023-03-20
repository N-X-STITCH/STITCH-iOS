//
//  UserRepository.swift
//  STITCH
//
//  Created by neuli on 2023/03/19.
//

import Foundation

import RxSwift

protocol UserRepository {
    func fetchUser(userID: String) -> Observable<User>
    func updateUser(user: User) -> Observable<User>
    func deleteUser(userID: String) -> Observable<String>
}
