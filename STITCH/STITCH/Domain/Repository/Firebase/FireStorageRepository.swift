//
//  FireStorageRepository.swift
//  STITCH
//
//  Created by neuli on 2023/03/16.
//

import Foundation

import RxSwift

protocol FireStorageRepository {
    func uploadImage(data: Data, path: String) -> Observable<String>
}
