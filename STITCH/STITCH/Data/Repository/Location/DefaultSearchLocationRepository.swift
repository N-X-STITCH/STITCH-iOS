//
//  DefaultSearchLocationRepository.swift
//  STITCH
//
//  Created by neuli on 2023/03/17.
//

import Foundation

import RxSwift

final class DefaultSearchLocationRepository: SearchLocationRepository {
    
    // MARK: - Properties
    
    private let searchAPINetworkService: URLSessionNetworkService
    
    // MARK: - Initializer
    
    init(searchAPINetworkService: URLSessionNetworkService) {
        self.searchAPINetworkService = searchAPINetworkService
    }
    
    // MARK: - Methods
    
    func fetchSearchLocations(query: String) -> Observable<[LocationInfo]> {
        let endpoint = LocationAPIEndpoints.fetchSearchLocations(query: query)
        return searchAPINetworkService.request(with: endpoint)
            .map(SearchLocationDTO.self)
            .compactMap { $0.documents }
            .map {
                return $0.map { document in
                    LocationInfo(
                        address: document.address_name,
                        placeName: document.place_name,
                        roadAddress: document.road_address_name,
                        latitude: document.y,
                        longitude: document.x
                    )
                }
            }
    }
}
