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
    
    private let naverAPINetworkService: URLSessionNetworkService
    
    // MARK: - Initializer
    
    init(naverAPINetworkService: URLSessionNetworkService) {
        self.naverAPINetworkService = naverAPINetworkService
    }
    
    // MARK: - Methods
    
    func fetchSearchLocations(query: String) -> Observable<[LocationInfo]> {
        let endpoint = LocationAPIEndpoints.fetchSearchLocations(query: query)
        return naverAPINetworkService.request(with: endpoint)
            .map(SearchLocationDTO.self)
            .compactMap { $0.items }
            .map {
                return $0.map {
                    let title = $0.title.replacingOccurrences(of: "<b>", with: "")
                        .replacingOccurrences(of: "</b>", with: "")
                    return LocationInfo(
                        address: "\($0.address), \(title)",
                        roadAddress: $0.roadAddress,
                        katechX: $0.mapx,
                        katechY: $0.mapy
                    ) }
            }
    }
}
