//
//  SignupRepository.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

import RxSwift

protocol SignupRepository {
    func createUser(user: User) -> Observable<Data>
}
