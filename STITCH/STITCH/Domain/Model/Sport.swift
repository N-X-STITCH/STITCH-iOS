//
//  Sport.swift
//  STITCH
//
//  Created by neuli on 2023/02/22.
//

import UIKit

enum Sport: CaseIterable, Codable {
    case all, tennis, badminton, pingPong, soccer, running, mountainClimbing
    case health, basketball, baseball, golf, etc
    
    var name: String {
        switch self {
        case .all: return "전체"
        case .tennis: return "테니스"
        case .badminton: return "배드민턴"
        case .pingPong: return "탁구"
        case .soccer: return "축구"
        case .running:return "런닝"
        case .mountainClimbing: return "등산"
        case .health: return "헬스"
        case .basketball: return "농구"
        case .baseball: return "야구"
        case .golf: return "골프"
        case .etc: return "기타"
        }
    }
    
    var icon: String {
        switch self {
        case .all: return ""
        case .tennis: return "🎾"
        case .badminton: return "🏸"
        case .pingPong: return "🏓"
        case .soccer: return "⚽️"
        case .running:return "🏃‍♂️"
        case .mountainClimbing: return "🏔️"
        case .health: return "🏋️"
        case .basketball: return "🏀"
        case .baseball: return "⚾️"
        case .golf: return "⛳️"
        case .etc: return "🧘"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .all: return .all
        case .tennis: return .tennis
        case .badminton: return .badminton
        case .pingPong: return .pingpong
        case .soccer: return .soccer
        case .running: return .running
        case .mountainClimbing: return .mountainClimbing
        case .health: return .health
        case .basketball: return .basketball
        case .baseball: return .baseball
        case .golf: return .golf
        case .etc: return .etc
        }
    }
}
