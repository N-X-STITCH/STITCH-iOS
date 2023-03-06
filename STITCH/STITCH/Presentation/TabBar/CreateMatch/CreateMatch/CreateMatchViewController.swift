//
//  CreateMatchViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/06.
//

import UIKit

final class CreateMatchViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding12 = 12
        static let padding16 = 16
        static let padding24 = 24
        static let padding32 = 32
        static let padding40 = 40
        static let floatingButtonWidth = 56
        static let scrollViewHeight = 350
        static let popularCollectionViewHeight = 384
        static let matchCollectionViewHeight = 1400
        static let pages = 3
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // MARK: Properties
    
    private let createMatchViewModel: CreateMatchViewModel
    
    // MARK: - Initializer
    
    init(createMatchViewModel: CreateMatchViewModel) {
        self.createMatchViewModel = createMatchViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
        // TODO: 삭제
        scrollView.delegate = self
    }
    
    override func bind() {
        
    }
    
    override func configureNavigation() {
        
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(view.snp.height).priority(.low)
        }
    }
}

extension CreateMatchViewController: UIScrollViewDelegate {
}
