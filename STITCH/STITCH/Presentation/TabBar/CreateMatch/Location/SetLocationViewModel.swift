//
//  SetLocationViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/03/12.
//

import Foundation

import RxSwift

final class SetLocationViewModel: ViewModel {
    
    struct Input {
        let searchTextObservable: Observable<String>
    }
    
    struct Output {
        let searchResultObservable: Observable<[LocationInfo]>
    }
    
    // MARK: - Properties
    
    private let findLocationUseCase: FindLocationUseCase
    
    // MARK: - Initializer
    
    init(findLocationUseCase: FindLocationUseCase) {
        self.findLocationUseCase = findLocationUseCase
    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        
        let searchResultObservable = input.searchTextObservable
            .withUnretained(self)
            .flatMap { owner, searchText -> Observable<[LocationInfo]> in
                return owner.findLocationUseCase.fetchSearchLocations(searchText: searchText)
            }
        
        return Output(searchResultObservable: searchResultObservable)
    }
}
