//
//  DefaultNearAddressRespository.swift
//  STITCH
//
//  Created by neuli on 2023/03/16.
//

import Foundation

import RxSwift

final class DefaultNearAddressRepository: NearAddressRepository {
    
    // MARK: - Properties
    
    private let urlSessionNetworkService: URLSessionNetworkService
    private let naverCloudNetworkService: URLSessionNetworkService
    
    // MARK: - Initializer
    
    init(
        urlSessionNetworkService: URLSessionNetworkService,
        naverCloudNetworkService: URLSessionNetworkService
    ) {
        self.urlSessionNetworkService = urlSessionNetworkService
        self.naverCloudNetworkService = naverCloudNetworkService
    }
    
    // MARK: - Methods
    
    func fetchAddress(location: LocationInfo) -> Observable<LocationInfo> {
        let endpoint = LocationAPIEndpoints.fetchReverseGeoCodingAddress(location: location)
        return naverCloudNetworkService.request(with: endpoint)
            .map(ReverseGeoCodingResultDTO.self)
            .compactMap { $0.results?.first }
            .compactMap { result in
                guard let area1 = result.region?.area1?.name,
                      let area2 = result.region?.area2?.name
                else { return nil }
                return LocationInfo(address: "\(area1) \(area2)")
            }
    }
    
    func fetchNearAddresses(location: LocationInfo) -> Observable<[LocationInfo]> {
        let endpoint = LocationAPIEndpoints.fetchNearAddresses(location: location)
        return urlSessionNetworkService.request(with: endpoint)
            .map(NearAddressesDTO.self)
            .map { $0.value.map { LocationInfo(address: $0) } }
    }
    
    func fetchNearAddresses(text: String) -> Observable<[LocationInfo]> {
        let endpoint = LocationAPIEndpoints.fetchGeoCodingAddress(query: text)
        return naverCloudNetworkService.request(with: endpoint)
            .retry()
            .map(GeoCodingResultDTO.self)
            .compactMap { $0.addresses }
            .map { addresses in
                let dongAddresses = addresses.filter { !$0.addressElements[2].longName.isEmpty }
                return dongAddresses.map { LocationInfo(address: $0.jibunAddress) }
            }
    }
}
