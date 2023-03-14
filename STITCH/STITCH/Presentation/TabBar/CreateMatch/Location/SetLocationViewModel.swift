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
        let viewDidLoad: Observable<Void>
    }
    
    struct Output {
        let configureCollectionViewData: Observable<[LocationInfo]>
    }
    
    // MARK: - Properties
    
    private let findLocationUseCase: FindLocationUseCase
    
    // MARK: - Initializer
    
    init(findLocationUseCase: FindLocationUseCase) {
        self.findLocationUseCase = findLocationUseCase
    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        
        let configureCollectionViewData = input.viewDidLoad
            .flatMap { _ in
                return Observable.just([
                    LocationInfo(address: "경기도 수원시 영통구 광교2동"),
                    LocationInfo(address: "경기도 수원시 영통구 광교3동"),
                    LocationInfo(address: "경기도 수원시 영통구 광교4동"),
                    LocationInfo(address: "경기도 수원시 영통구 광교5동")
                ])
            }
            .asObservable()
            
        
        return Output(configureCollectionViewData: configureCollectionViewData)
    }
}
