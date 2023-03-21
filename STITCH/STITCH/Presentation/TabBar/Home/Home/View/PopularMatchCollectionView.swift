//
//  PopularMatchCollectionView.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import UIKit

final class PopularMatchCollectionView: BaseCollectionView {
    
    static let sectionHeaderElementKind = "sectionHeaderElementKind"
    
    // MARK: - Properties
    
    typealias PopularMatchDataSource = UICollectionViewDiffableDataSource<Int, MatchDetail>
    typealias PopularMatchSnapshot = NSDiffableDataSourceSnapshot<Int, MatchDetail>
    
    var popularMatchDataSource: PopularMatchDataSource!
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    override func configure(delegate: UICollectionViewDelegate?) {
        register(
            PopularMatchCell.self,
            forCellWithReuseIdentifier: PopularMatchCell.reuseIdentifier
        )
        register(
            PopularHeaderView.self,
            forSupplementaryViewOfKind: Self.sectionHeaderElementKind,
            withReuseIdentifier: PopularHeaderView.reuseIdentifier
        )
        super.configure(delegate: delegate)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    override func configureUI() {
        backgroundColor = .background
    }
    
    override func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<PopularMatchCell, MatchDetail> {
            cell, indexPath, matchDetail in
            cell.setMatch(matchDetail)
        }
        
        popularMatchDataSource = PopularMatchDataSource(collectionView: self) {
            collectionView, indexPath, matchInfo in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: matchInfo
            )
        }
        
        popularMatchDataSource.supplementaryViewProvider = {
            collectionView, kind, indexPath -> UICollectionReusableView in
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: PopularHeaderView.reuseIdentifier,
                for: indexPath
            ) as? PopularHeaderView else {
                fatalError("Cannot create header view")
            }
            
            return supplementaryView
        }
    }
    
    func setData(_ matchDetails: [MatchDetail]) {
        var snapshot = PopularMatchSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(matchDetails)
        popularMatchDataSource.apply(snapshot)
    }
}
