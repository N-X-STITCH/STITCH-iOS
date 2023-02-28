//
//  TabBarPage.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import UIKit

enum TabBarPage: Int {
    case home
    case crew
    case myMenu
    
    init?(index: Int) {
        switch index {
        case 0: self = .home
        case 1: self = .crew
        case 2: self = .myMenu
        default: return nil
        }
    }
    
    var title: String {
        switch self {
        case .home: return "홈"
        case .crew: return "크류"
        case .myMenu: return "마이메뉴"
        }
    }
    
    var pageNumber: Int {
        self.rawValue
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .home: return UIImage.homeSelect
        case .crew: return UIImage.peopleSelect
        case .myMenu: return UIImage.mymenu
        }
    }
    
    var deselectedIcon: UIImage? {
        switch self {
        case .home: return UIImage.home
        case .crew: return UIImage.people
        case .myMenu: return UIImage.mymenu?.withTintColor(.yellow05_primary)
        }
    }
}
