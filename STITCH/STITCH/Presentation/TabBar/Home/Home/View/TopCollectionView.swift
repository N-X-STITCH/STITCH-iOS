//
//  TopCollectionView.swift
//  STITCH
//
//  Created by neuli on 2023/03/22.
//

import UIKit

final class TopCollectionView: BaseCollectionView {
    
    // MARK: - Properties
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, BannerInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, BannerInfo>
    
    var topCollectionViewDataSource: DataSource!
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    override func configure(delegate: UICollectionViewDelegate?) {
        register(
            TopCollectionViewCell.self,
            forCellWithReuseIdentifier: TopCollectionViewCell.reuseIdentifier
        )
        super.configure(delegate: delegate)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    override func configureUI() {
        backgroundColor = .clear
    }
    
    override func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<TopCollectionViewCell, BannerInfo> {
            cell, indexPath, banner in
            cell.configure(banner: banner)
        }
        
        topCollectionViewDataSource = DataSource(collectionView: self) {
            collectionView, indexPath, bannerInfo in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: bannerInfo
            )
        }
    }
    
    func setData(_ bannerInfos: [BannerInfo]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(bannerInfos)
        topCollectionViewDataSource.apply(snapshot)
    }
}
