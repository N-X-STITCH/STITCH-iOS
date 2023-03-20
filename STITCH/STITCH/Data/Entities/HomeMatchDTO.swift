//
//  HomeMatchDTO.swift
//  STITCH
//
//  Created by neuli on 2023/03/20.
//

import Foundation

struct HomeMatchDTO: Decodable {
    let recommendedMatches: [MatchDTO]
    let newMatches: [MatchDTO]
}
