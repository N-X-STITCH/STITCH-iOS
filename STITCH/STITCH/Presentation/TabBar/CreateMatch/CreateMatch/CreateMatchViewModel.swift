//
//  CreateMatchViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/03/05.
//

import Foundation

import RxCocoa
import RxSwift

final class CreateMatchViewModel {
    
    // MARK: - Properties
    
    struct Input {
        let completeCreateMatchButtom: Observable<Void>
    }
    
    struct Output {
        
    }
    
    private let createMatchUseCase: CreateMatchUseCase
    
    // MARK: - Initializer
    
    init(createMatchUseCase: CreateMatchUseCase) {
        self.createMatchUseCase = createMatchUseCase
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        return Output()
    }
}
