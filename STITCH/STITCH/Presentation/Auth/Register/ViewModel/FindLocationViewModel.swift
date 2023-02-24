//
//  FindLocationViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/02/24.
//

import Foundation

import RxCocoa
import RxSwift

final class FindLocationViewModel: ViewModel {
    
    struct Input {
        let configureCollectionView: Observable<Void>
    }
    
    struct Output {
        let configureCollectionViewData: Observable<[String]>
    }
    
    // MARK: - Properties
    
    private let findLocationUseCase: FindLocationUseCase
    
    // MARK: - Initializer
    
    init(findLocationUseCase: FindLocationUseCase) {
        self.findLocationUseCase = findLocationUseCase
    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        
        let configureCollectionViewData = input.configureCollectionView
            .flatMap { _ in
                return Observable.just([
                    "경기도 수원시 영통구 광교2동",
                    "경기도 수원시 영통구 광교3동",
                    "경기도 수원시 영통구 광교4동",
                    "경기도 수원시 영통구 광교5동"
                ])
            }
            .asObservable()
            
        
        return Output(configureCollectionViewData: configureCollectionViewData)
    }
}
