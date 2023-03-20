//
//  CoordinatorEvent.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

enum CoordinatorEvent: Equatable {
    // default
    case next
    case dismiss
    case pop
    case send(locationInfo: LocationInfo)
    
    // login
    case showHome
    case showLogin
    
    // Sign up
    case findLocation
    
    // Create Match
    case selectMatchType
    case setLocation
    case created(match: Match)
    
    // MyPage
    case setting
    case version
}
