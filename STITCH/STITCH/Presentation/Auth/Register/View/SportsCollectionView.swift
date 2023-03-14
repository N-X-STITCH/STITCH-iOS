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
    
    init(
        _ delegate: UICollectionViewDelegate,
        layout: UICollectionViewLayout,
        allowsMultipleSelection: Bool = true
    ) {
        super.init(delegate, layout: layout)
        self.allowsMultipleSelection = allowsMultipleSelection
    }
    
    // MARK: - Methods
    
    override func configure(delegate: UICollectionViewDelegate?) {
        super.configure(delegate: delegate)
    }
    
    override func configureUI() {
        backgroundColor = .background
    }
    
    override func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<SportsCell, Sport> {
            cell, indexPath, item in
            cell.set(sport: item)
            cell.configure(cell.isSelected)
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
    
    func update(_ indexPath: IndexPath) {
        var snapshot = sportsDatasource.snapshot()
        let id = Sport.allCases[indexPath.item + 1]
        snapshot.reconfigureItems([id])
        sportsDatasource.apply(snapshot)
    }
}
