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
    
    func fetchMatch(matchID: String) -> Observable<MatchInfo> {
        let endpoint = MatchAPIEndpoints.fetchMatch(matchID: matchID)
        return urlSessionNetworkService.request(with: endpoint)
            .map(MatchDetailDTO.self)
            .map { matchDetailDTO in
                let match = Match(matchDTO: matchDetailDTO.match)
                let joinedUsers = matchDetailDTO.joinedMembers.map { User(userDTO: $0) }
                return MatchInfo(match: match, owner: User(), joinedUsers: joinedUsers)
            }
    }
    
    func fetchAllMatch() -> Observable<[Match]> {
        let endpoint = MatchAPIEndpoints.fetchAllMatch()
        return urlSessionNetworkService.request(with: endpoint)
            .map([MatchDTO].self)
            .map { $0.map { Match(matchDTO: $0) } }
    }
    
    func fetchAllTeachMatch() -> Observable<[Match]> {
        let endpoint = MatchAPIEndpoints.fetchAllTeachMatch()
        return urlSessionNetworkService.request(with: endpoint)
            .map([MatchDTO].self)
            .map { $0.map { Match(matchDTO: $0) } }
    }
    
    func fetchHomeMatch() -> Observable<(recommendedMatches: [MatchDetail], newMatches: [Match])> {
        let endpoint = MatchAPIEndpoints.fetchHomeMatch()
        return urlSessionNetworkService.request(with: endpoint)
            .map(HomeMatchDTO.self)
            .map {
                let recommendedMatches = $0.recommendedMatches.map {
                    MatchDetailDTO(match: $0.match, hostMember: $0.hostMember, joinedMembers: $0.joinedMembers)
                }
                let recommendedMatchDetails = recommendedMatches.map {
                    MatchDetail(matchDTO: $0.match, hostMemberDTO: $0.hostMember ?? UserDTO(), joinedMembersDTO: $0.joinedMembers)
                }
                let newMatches = $0.newMatches.map { Match(matchDTO: $0) }
                return (recommendedMatchDetails, newMatches)
            }
    }
    
    func deleteMatch(matchID: String) -> Observable<Void> {
        let endpoint = MatchAPIEndpoints.deleteMatch(matchID: matchID)
        return urlSessionNetworkService.request(with: endpoint)
            .map { _ in () }
    }
    
    func joinMatch(userID: String, matchID: String) -> Observable<Void> {
        let endpoint = MatchAPIEndpoints.joinMatch(userID: userID, joinMatchDTO: JoinMatchDTO(id: matchID))
        return urlSessionNetworkService.request(with: endpoint)
            .map { _ in () }
    }
    
    func cancelJoinMatch(userID: String, matchID: String) -> Observable<Void> {
        let endpoint = MatchAPIEndpoints.cancelJoinMatch(userID: userID, matchID: matchID)
        return urlSessionNetworkService.request(with: endpoint)
            .map { _ in () }
    }
    
    func createReport(_ report: Report) -> Observable<Void> {
        let endpoint = MatchAPIEndpoints.createReport(report: report)
        return urlSessionNetworkService.request(with: endpoint)
            .map { _ in () }
    }
}
