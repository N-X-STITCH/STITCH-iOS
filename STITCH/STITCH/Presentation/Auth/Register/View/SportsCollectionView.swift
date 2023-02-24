//
//  SportsCollectionView.swift
//  STITCH
//
//  Created by neuli on 2023/02/22.
//

import UIKit

final class SportsCollectionView: BaseCollectionView {
    
    // MARK: - Properties
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Sport>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Sport>
    
    var sportsDatasource: DataSource!
    
    // MARK: - Initializer
    
    override init(_ delegate: UICollectionViewDelegate, layout: UICollectionViewLayout) {
        super.init(delegate, layout: layout)
    }
    
    // MARK: - Methods
    
    override func configureUI() {
        backgroundColor = .background
    }
    
    override func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<SportsCell, Sport> {
            cell, indexPath, item in
            cell.set(sport: item)
        }
        
        sportsDatasource = DataSource(collectionView: self) {
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
        sportsDatasource.apply(snapshot)
    }
}
