//
//  DefaultMatchRepository.swift
//  STITCH
//
//  Created by neuli on 2023/03/05.
//

import Foundation

import RxSwift

final class DefaultMatchRepository: MatchRepository {
    
    // MARK: - Properties
    
    private let urlSessionNetworkService: URLSessionNetworkService
    
    // MARK: - Initializer
    
    init(
        urlSessionNetworkService: URLSessionNetworkService
    ) {
        self.urlSessionNetworkService = urlSessionNetworkService
    }
    
    // MARK: - Methods
    
    func createMatch(match: Match) -> Observable<Match> {
        let matchDTO = MatchDTO(match: match)
        let endpoint = MatchAPIEndpoints.createMatch(matchDTO: matchDTO)
        return urlSessionNetworkService.request(with: endpoint)
            .map(MatchDTO.self)
            .map { Match(matchDTO: $0) }
    }
}
