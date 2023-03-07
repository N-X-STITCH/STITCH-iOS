//
//  MatchTypeCollectionView.swift
//  STITCH
//
//  Created by neuli on 2023/03/05.
//

import UIKit

final class MatchTypeCollectionView: BaseCollectionView {
    
    // MARK: - Properties
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, CreateMatchType>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, CreateMatchType>
    
    var matchTypeDataSource: DataSource!
    
    // MARK: - Initializer
    
    override init(
        _ delegate: UICollectionViewDelegate,
        layout: UICollectionViewLayout
    ) {
        super.init(delegate, layout: layout)
    }
    
    // MARK: - Methods
    
    override func configure(delegate: UICollectionViewDelegate) {
        register(
            MatchTypeCell.self,
            forCellWithReuseIdentifier: MatchTypeCell.reuseIdentifier
        )
        super.configure(delegate: delegate)
    }
    
    override func configureUI() {
        backgroundColor = .background
    }
    
    override func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MatchTypeCell, CreateMatchType> {
            cell, indexPath, matchType in
            cell.set(matchType: matchType)
            cell.configure(cell.isSelected)
        }
        
        matchTypeDataSource = DataSource(collectionView: self) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: CreateMatchType)
            -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }
    }
    
    func setData(_ matchTypes: [CreateMatchType]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(matchTypes)
        matchTypeDataSource.apply(snapshot)
    }
    
    func update(_ indexPath: IndexPath) {
        var snapshot = matchTypeDataSource.snapshot()
        let id = CreateMatchType.allCases[indexPath.item]
        snapshot.reconfigureItems([id])
        matchTypeDataSource.apply(snapshot)
    }
}
