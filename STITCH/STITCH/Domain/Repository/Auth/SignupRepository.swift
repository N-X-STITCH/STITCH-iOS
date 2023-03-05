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
    func save(userID: String)
    func fetchUserIDInUserDefaults() -> Observable<String?>
}
