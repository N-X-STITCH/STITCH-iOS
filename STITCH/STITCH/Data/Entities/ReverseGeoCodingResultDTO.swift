//
//  ReverseGeoCodingResultDTO.swift
//  STITCH
//
//  Created by neuli on 2023/03/16.
//

import Foundation

struct ReverseGeoCodingResultDTO: Decodable {
    let results: [ReverseGeoCodingResult]?
}

struct ReverseGeoCodingResult: Decodable {
    let name: String?
    let code: ReverseGeoCodingCode?
    let region: ReverseGeoCodingRegion?
}

struct ReverseGeoCodingCode: Decodable {
    let id: String?
    let type: String?
    let mappingId: String?
}

struct ReverseGeoCodingRegion: Decodable {
    let area1: ReverseGeoCodingArea?
    let area2: ReverseGeoCodingArea?
}

struct ReverseGeoCodingArea: Decodable {
    let name: String?
}
