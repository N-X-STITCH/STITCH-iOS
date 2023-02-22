//
//  SportsCollectionView.swift
//  STITCH
//
//  Created by neuli on 2023/02/22.
//

import UIKit

final class SportsCollectionView: UICollectionView {
    
    // MARK: - Properties
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Sport>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Sport>
    
    var sportsDatasource: DataSource!
    
    // MARK: - Initializer
    
    init(_ delegate: UICollectionViewDelegate) {
        super.init(
            frame: .zero,
            collectionViewLayout: SportsCollectionViewLayout.layout()
        )
        configure(delegate: delegate)
        configureUI()
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func configure(delegate: UICollectionViewDelegate) {
        self.delegate = delegate
    }
    
    private func configureUI() {
        backgroundColor = .background
    }
    
    private func configureDataSource() {
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
