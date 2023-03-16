//
//  NearAddressUseCase.swift
//  STITCH
//
//  Created by neuli on 2023/03/16.
//

import Foundation

import RxSwift

protocol NearAddressUseCase {
    func fetchNearAddresses(location: LocationInfo) -> Observable<[LocationInfo]>
    func fetchNearAddresses(searchText text: String) -> Observable<[LocationInfo]>
}

final class DefaultNearAddressUseCase: NearAddressUseCase {
    
    // MARK: - Properties
    
    private let nearAddressRepository: NearAddressRepository
    
    // MARK: - Initializer
    
    init(nearAddressRepository: NearAddressRepository) {
        self.nearAddressRepository = nearAddressRepository
    }
    
    // MARK: - Methods
    
    func fetchNearAddresses(location: LocationInfo) -> Observable<[LocationInfo]> {
        return nearAddressRepository.fetchAddress(location: location)
            .withUnretained(self)
            .flatMap { owner, location in
                owner.nearAddressRepository.fetchNearAddresses(location: location)
            }
    }
    
    func fetchNearAddresses(searchText text: String) -> Observable<[LocationInfo]> {
        return nearAddressRepository.fetchNearAddresses(text: text)
    }
}
