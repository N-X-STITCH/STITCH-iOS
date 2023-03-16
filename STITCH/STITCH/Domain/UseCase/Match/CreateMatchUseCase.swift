//
//  CreateMatchUseCase.swift
//  STITCH
//
//  Created by neuli on 2023/03/05.
//

import Foundation

import RxSwift

protocol CreateMatchUseCase {
    func uploadImage(data: Data, path: String) -> Observable<String>
}

final class DefaultCreateMatchUseCase: CreateMatchUseCase {
    
    // MARK: - Properties
    
    private let matchRepository: MatchRepository
    private let fireStorageRepository: FireStorageRepository
    
    // MARK: - Initializer
    
    init(
        matchRepository: MatchRepository,
        fireStorageRepository: FireStorageRepository
    ) {
        self.matchRepository = matchRepository
        self.fireStorageRepository = fireStorageRepository
    }
    
    // MARK: - Methods
    
    func uploadImage(data: Data, path: String) -> Observable<String> {
        return fireStorageRepository.uploadImage(data: data, path: path)
    }
}
