//
//  HomeViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/28.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding16 = 16
    }
    
    // MARK: Properties
    
    private let homeViewModel: HomeViewModel
    
    // MARK: - Initializer
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func bind() {

    }
    
    override func configureUI() {
        view.backgroundColor = .background
    }
}
