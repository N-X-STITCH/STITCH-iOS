//
//  MatchHeaderView.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import UIKit

final class MatchHeaderView: BaseCollectionReusableView {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "HomeHeaderAllView"
    
    private let titleLabel = UILabel().then {
        $0.text = "새롭게 열린 매치"
    }
    
    let viewAllButton = UIButton()
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    override func configureUI() {
        
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
