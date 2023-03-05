//
//  TabBarPage.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import UIKit

enum TabBarPage: Int {
    case home
    case category
    case myMatch
    case myMenu
    
    init?(index: Int) {
        switch index {
        case 0: self = .home
        case 1: self = .category
        case 3: self = .myMatch
        case 2: self = .myMenu
        default: return nil
        }
    }
    
    var title: String {
        switch self {
        case .home: return "홈"
        case .category: return "카테고리"
        case .myMatch: return "마이매치"
        case .myMenu: return "마이메뉴"
        }
    }
    
    var pageNumber: Int {
        self.rawValue
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .home: return .homeSelect
        case .category: return .categorySelect
        case .myMatch: return .myMatchSelect
        case .myMenu: return .mymenuSelect
        }
    }
    
    var deselectedIcon: UIImage? {
        switch self {
        case .home: return .home
        case .category: return .category
        case .myMatch: return .myMatch
        case .myMenu: return .mymenu?.withTintColor(.yellow05_primary)
        }
    }
}
