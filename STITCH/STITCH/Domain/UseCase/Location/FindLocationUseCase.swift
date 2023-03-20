//
//  FindLocationUseCase.swift
//  STITCH
//
//  Created by neuli on 2023/02/24.
//

import Foundation

import RxSwift

protocol FindLocationUseCase {
    func fetchSearchLocations(searchText: String) -> Observable<[LocationInfo]>
}

final class DefaultFindLocationUseCase: FindLocationUseCase {
    
    // MARK: - Properties
    
    private let searchLocationRepository: SearchLocationRepository
    
    // MARK: - Initializer
    
    init(searchLocationRepository: SearchLocationRepository) {
        self.searchLocationRepository = searchLocationRepository
    }
    
    // MARK: - Methods
    
    func fetchSearchLocations(searchText: String) -> Observable<[LocationInfo]> {
        return searchLocationRepository.fetchSearchLocations(query: searchText)
    }
}
