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
        let searchTextFieldChange: Observable<String>
        let firstLocation: Observable<LocationInfo>
        let location: Observable<LocationInfo>
    }
    
    struct Output {
        let nearLocations: Observable<[LocationInfo]>
        let searchLocationResult: Observable<[LocationInfo]>
    }
    
    // MARK: - Properties
    
    private let nearAddressUseCase: NearAddressUseCase
    
    // MARK: - Initializer
    
    init(nearAddressUseCase: NearAddressUseCase) {
        self.nearAddressUseCase = nearAddressUseCase
    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        
        let nearLocations = Observable.of(input.firstLocation, input.location).merge()
            .withUnretained(self)
            .flatMap { owner, location in
                return owner.nearAddressUseCase.fetchNearAddresses(location: location)
            }
        
        let searchLocationResult = input.searchTextFieldChange
            .withUnretained(self)
            .flatMap { owner, text in
                return owner.nearAddressUseCase.fetchNearAddresses(searchText: text)
            }
        
        return Output(
            nearLocations: nearLocations,
            searchLocationResult: searchLocationResult
        )
    }
}
