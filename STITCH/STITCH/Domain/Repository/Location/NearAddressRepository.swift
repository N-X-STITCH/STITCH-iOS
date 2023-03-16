//
//  NearAddressRepository.swift
//  STITCH
//
//  Created by neuli on 2023/03/16.
//

import Foundation

import RxSwift

protocol NearAddressRepository {
    func fetchAddress(location: LocationInfo) -> Observable<LocationInfo>
    func fetchNearAddresses(location: LocationInfo) -> Observable<[LocationInfo]>
    func fetchNearAddresses(text: String) -> Observable<[LocationInfo]>
}
