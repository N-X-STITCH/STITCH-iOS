//
//  SportCategoryCollectionView.swift
//  STITCH
//
//  Created by neuli on 2023/03/14.
//

import UIKit

final class SportCategoryCollectionView: BaseCollectionView {
    
    // MARK: - Properties
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Sport>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Sport>
    
    var sportCategoryDataSource: DataSource!
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    override func configure(delegate: UICollectionViewDelegate?) {
        register(
            SportCategoryCell.self,
            forCellWithReuseIdentifier: SportCategoryCell.reuseIdentifier
        )
        super.configure(delegate: delegate)
    }
    
    override func configureUI() {
        backgroundColor = .clear
    }
    
    override func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<SportCategoryCell, Sport> {
            cell, indexPath, sport in
            cell.set(sport: sport)
            cell.configure(cell.isSelected)
        }
        
        sportCategoryDataSource = DataSource(collectionView: self) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Sport)
            -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }
    }
    
    func setData(_ sports: [Sport]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(sports)
        sportCategoryDataSource.apply(snapshot)
    }
    
    func update(_ indexPath: IndexPath) {
        var snapshot = sportCategoryDataSource.snapshot()
        let id = Sport.allCases[indexPath.item]
        snapshot.reconfigureItems([id])
        sportCategoryDataSource.apply(snapshot)
    }
}
