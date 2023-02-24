//
//  File.swift
//  STITCH
//
//  Created by neuli on 2023/02/24.
//

import UIKit

class BaseCollectionView: UICollectionView {
    
    // MARK: - Initializer
    
    init(_ delegate: UICollectionViewDelegate,
         layout: UICollectionViewLayout
    ) {
        super.init(frame: .zero, collectionViewLayout: layout)
        configure(delegate: delegate)
        configureUI()
        configureDataSource()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(delegate: UICollectionViewDelegate) {
        self.delegate = delegate
    }
    
    func configureUI() {}
    
    func configureDataSource() {}
    
}
