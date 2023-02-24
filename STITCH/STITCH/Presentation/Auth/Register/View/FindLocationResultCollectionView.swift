//
//  FindLocationResultCollectionView.swift
//  STITCH
//
//  Created by neuli on 2023/02/24.
//

import UIKit

final class FindLocationResultCollectionView: BaseCollectionView {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    // MARK: - Properties
    
    var locationDataSource: DataSource!
    
    // MARK: - Initializer
    
    override init(
        _ delegate: UICollectionViewDelegate,
        layout: UICollectionViewLayout
    ) {
        super.init(delegate, layout: layout)
    }
 
    
    // MARK: - Methods
    
    override func configureUI() {
        
    }
    
    override func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> {
            cell, indexPath, text in
            var content = cell.defaultContentConfiguration()
            content.text = text
            cell.contentConfiguration = content
        }
        
        locationDataSource = DataSource(collectionView: self) {
            collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
    
    func setData(_ texts: [String]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(texts)
        locationDataSource.apply(snapshot)
    }
}
