//
//  TabBarPage.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

enum TabBarPage: Int {
    case home
    case profile
    
    init?(index: Int) {
        switch index {
        case 0: self = .home
        case 1: self = .profile
        default: return nil
        }
    }
    
    var title: String {
        switch self {
        case .home: return "home"
        case .profile: return "profile"
        }
    }
    
    var pageNumber: Int {
        self.rawValue
    }
    
    // var selectedIcon: UIImage? {}
    // var deselectedIcon: UIImage? {}
}
