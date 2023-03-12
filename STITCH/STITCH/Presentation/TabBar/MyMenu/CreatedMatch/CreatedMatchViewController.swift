//
//  CreatedMatchViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import UIKit

final class CreatedMatchViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding12 = 12
        static let padding16 = 16
        static let padding24 = 24
        static let padding32 = 32
        static let padding40 = 40
    }
    
    
    // MARK: Properties
    
    private let createdMatchViewModel: CreatedMatchViewModel
    
    // MARK: - Initializer
    
    init(createdMatchViewModel: CreatedMatchViewModel) {
        self.createdMatchViewModel = createdMatchViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
    }
    
    override func bind() {
    }
    
    override func configureNavigation() {
    }
    
    override func configureUI() {
    }
}
