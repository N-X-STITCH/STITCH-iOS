//
//  UserStorage.swift
//  STITCH
//
//  Created by neuli on 2023/03/14.
//

import Foundation

import RxSwift

protocol UserStorage {
    func save(user: User) -> Observable<Void>
    func fetchUser() -> Observable<User?>
    func logout() -> Observable<Void>
}
