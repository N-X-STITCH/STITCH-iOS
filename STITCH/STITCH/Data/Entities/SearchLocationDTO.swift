//
//  SearchLocationDTO.swift
//  STITCH
//
//  Created by neuli on 2023/03/17.
//

import Foundation

struct SearchLocationDTO: Decodable {
    let meta: Meta
    let documents: [Document]
}

struct Meta: Decodable {
    let same_name: SearchName
}

struct SearchName: Decodable {
    let region: [String]
    let keyword: String
    let selected_region: String
}

struct Document: Decodable {
    let place_name: String
    let address_name: String
    let road_address_name: String
    let x: String // longitude
    let y: String // latitude
}
