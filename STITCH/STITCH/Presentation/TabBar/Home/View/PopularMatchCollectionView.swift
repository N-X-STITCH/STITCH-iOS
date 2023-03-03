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
    
    typealias PopularMatchDataSource = UICollectionViewDiffableDataSource<Int, MatchInfo>
    typealias PopularMatchSnapshot = NSDiffableDataSourceSnapshot<Int, MatchInfo>
    
    var popularMatchDataSource: PopularMatchDataSource!
    
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
        let cellRegistration = UICollectionView.CellRegistration<PopularMatchCell, MatchInfo> {
            cell, indexPath, matchInfo in
            cell.setMatch(matchInfo)
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
    
    func setData(_ matchInfos: [MatchInfo]) {
        var snapshot = PopularMatchSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(matchInfos)
        popularMatchDataSource.apply(snapshot)
    }
}
