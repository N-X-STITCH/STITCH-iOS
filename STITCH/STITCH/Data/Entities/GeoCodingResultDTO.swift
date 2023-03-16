//
//  GeoCodingResultDTO.swift
//  STITCH
//
//  Created by neuli on 2023/03/16.
//

import Foundation

struct GeoCodingResultDTO: Decodable {
    let addresses: [GeoCodingAddress]?
}

struct GeoCodingAddress: Decodable {
    let jibunAddress: String
    let addressElements: [GeoCodingAddressElement]
}

struct GeoCodingAddressElement: Decodable {
    let types: [String]
    let longName: String
    let shortName: String
}
