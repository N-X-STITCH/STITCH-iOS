//
//  CoordinatorEvent.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

enum CoordinatorEvent {
    // default
    case next
    case dismiss
    case pop
    
    // login
    case showHome
    
    // Sign up
    case findLocation
    
    // Create Match
    case selectMatchType
    case setLocation
    
    // MyPage
    case setting
}
