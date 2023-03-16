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
    
    private let id = UUID().uuidString
    var title: String = ""
    var matchImageURL: String = ""
    var place: String = ""
    var contents: String = ""
    var matchType: MatchType? = nil
    var sport: Sport? = nil
    var startDate: Date? = nil
    var startTime: (hour: Int, minute: Int)? = nil
    var duration: Int = 30
    var maxHeadCount: Int = 1
    var fee: Int = 0
    
    // MARK: - Properties
    
    struct Input {
        let matchImage: Observable<Data>
        let matchTitle: Observable<String>
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
        let matchImage = input.matchImage
        
        return Output()
    }
}
