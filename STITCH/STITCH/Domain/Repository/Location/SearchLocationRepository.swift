//
//  SearchLocationRepository.swift
//  STITCH
//
//  Created by neuli on 2023/03/17.
//

import Foundation

import RxSwift

protocol SearchLocationRepository {
    func fetchSearchLocations(query: String) -> Observable<[LocationInfo]>
}
