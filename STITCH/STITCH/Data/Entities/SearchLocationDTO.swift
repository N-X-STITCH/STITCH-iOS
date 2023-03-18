//
//  SearchLocationDTO.swift
//  STITCH
//
//  Created by neuli on 2023/03/17.
//

import Foundation

struct SearchLocationDTO: Decodable {
    let items: [SearchLocationItem]?
}

struct SearchLocationItem: Decodable {
    let title: String
    let address: String
    let roadAddress: String
    let mapx: String
    let mapy: String
}
