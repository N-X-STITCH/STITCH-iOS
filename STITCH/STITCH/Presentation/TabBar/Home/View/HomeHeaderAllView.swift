//
//  HomeHeaderAllView.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import UIKit

final class HomeHeaderAllView: BaseCollectionReusableView {
    
    static let reuseIdentifier = "HomeHeaderAllView"
    
    private let titleLabel = UILabel().then {
        $0.text = "지금 인기있는 매치"
    }
    
    let viewAllButton = UIButton()
    
    override func configureUI() {
        
    }
}
