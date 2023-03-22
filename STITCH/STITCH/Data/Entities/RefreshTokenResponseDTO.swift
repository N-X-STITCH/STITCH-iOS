//
//  RefreshTokenResponseDTO.swift
//  STITCH
//
//  Created by neuli on 2023/03/22.
//

import Foundation

struct RefreshTokenResponseDTO: Decodable {
    let access_token: String?
    let refresh_token: String?
    let id_token: String?
}
