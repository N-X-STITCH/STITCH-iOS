//
//  CreateMatchUseCase.swift
//  STITCH
//
//  Created by neuli on 2023/03/05.
//

import Foundation

import RxSwift

protocol CreateMatchUseCase {
    
}

final class DefaultCreateMatchUseCase: CreateMatchUseCase {
    
    // MARK: - Properties
    
    private let matchRepository: MatchRepository
    
    // MARK: - Initializer
    
    init(matchRepository: MatchRepository) {
        self.matchRepository = matchRepository
    }
    
    // MARK: - Methods
}
