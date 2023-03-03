//
//  Badge.swift
//  STITCH
//
//  Created by neuli on 2023/03/03.
//

import UIKit

final class ClassBadge: DefaultBadgeLabel {
    
    init() {
        super.init(
            text: "클래스",
            textColor: .gray12,
            backgroundColor: .yellow05_primary
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class SportBadge: DefaultBadgeLabel {
    
    init(sport: Sport) {
        super.init(
            text: sport.name,
            textColor: .yellow05_primary,
            backgroundColor: .gray11
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(sport: Sport) {
        text = sport.name
    }
}
