//
//  ProfileText.swift
//  STITCH
//
//  Created by neuli on 2023/02/23.
//

import Foundation

enum ProfileText: CaseIterable {
    case a, b, c, d, e, f, g, h, i, j
    
    var text: String {
        switch self {
        case .a: return "삶과 운동의 균형이 중요하다 생각해요"
        case .b: return "새로운 사람들과 다양한 경험을 해보고 싶어요"
        case .c: return "반복되는 일상에 특별함을 원해요"
        case .d: return "끊임없이 배우고 성장하려고 해요"
        case .e: return "혼자 하기 두려웠던 것들을 함께 해보고싶어요"
        case .f: return "결과보다 시작이 더 중요하다고 생각해요"
        case .g: return "몰랐던 나의 운동 취미를 발굴 해내고 싶어요"
        case .h: return "경험을 통해 다양한 가치들을 얻는다고 생각해요"
        case .i: return "내 삶을 내가 좋아하는 것으로 채울래요!"
        case .j: return "관심 운동을 더 깊게 파고들고 싶어요"
        }
    }
}
