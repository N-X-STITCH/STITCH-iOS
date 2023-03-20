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
}
