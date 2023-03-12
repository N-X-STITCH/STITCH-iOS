//
//  Section.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import Foundation

enum SettingSection: CaseIterable {
    case guide, account, none
    
    var title: String {
        switch self {
        case .guide: return "안내"
        case .account: return "계정"
        case .none: return "기타"
        }
    }
    
    func rowTitle(_ indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0: return GuideSection.allCases[indexPath.row].title
        case 1: return AccountSection.allCases[indexPath.row].title
        case 2: return NoneSection.allCases[indexPath.row].title
        default: return ""
        }
    }
}

enum GuideSection: CaseIterable {
    case help, opinion
    
    var title: String {
        switch self {
        case .help: return "고객센터/도움말"
        case .opinion: return "개선 및 의견 남기기"
        }
    }
}

enum AccountSection: CaseIterable {
    case logout, secession
    
    var title: String {
        switch self {
        case .logout: return "로그아웃"
        case .secession: return "계정탈퇴"
        }
    }
}

enum NoneSection: CaseIterable {
    case version, terms, policy
    
    
    var title: String {
        switch self {
        case .version: return "현재 버전"
        case .terms: return "서비스 이용 약관"
        case .policy: return "개인정보 처리방침"
        }
    }
}
