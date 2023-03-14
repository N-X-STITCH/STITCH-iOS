//
//  MatchCollectionView.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import UIKit

final class MatchCollectionView: BaseCollectionView {
    
    static let sectionHeaderElementKind = "sectionHeaderElementKind"
    
    // MARK: - Properties
    
    typealias MatchDataSource = UICollectionViewDiffableDataSource<MatchSection, MatchInfo>
    typealias MatchSnapshot = NSDiffableDataSourceSnapshot<MatchSection, MatchInfo>
    
    var matchDataSource: MatchDataSource!
    private let matchSection: MatchSection
    
    // MARK: - Initializer
    
    init(
        _ delegate: UICollectionViewDelegate,
        layout: UICollectionViewLayout,
        matchSection: MatchSection
    ) {
        self.matchSection = matchSection
        super.init(delegate, layout: layout)
    }
    
    // MARK: - Methods
    
    override func configure(delegate: UICollectionViewDelegate?) {
        register(
            MatchCell.self,
            forCellWithReuseIdentifier: MatchCell.reuseIdentifier
        )
        register(
            MatchHeaderView.self,
            forSupplementaryViewOfKind: Self.sectionHeaderElementKind,
            withReuseIdentifier: MatchHeaderView.reuseIdentifier
        )
        super.configure(delegate: delegate)
        showsVerticalScrollIndicator = false
    }
    
    override func configureUI() {
        backgroundColor = .background
    }
    
    override func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MatchCell, MatchInfo> {
            cell, indexPath, matchInfo in
            cell.setMatch(matchInfo)
        }
        
        matchDataSource = MatchDataSource(collectionView: self) {
            collectionView, indexPath, matchInfo in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: matchInfo
            )
        }
        
        if case .none = matchSection {
            return
        }
        
        matchDataSource.supplementaryViewProvider = {
            collectionView, kind, indexPath -> UICollectionReusableView in
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MatchHeaderView.reuseIdentifier,
                for: indexPath
            ) as? MatchHeaderView else {
                fatalError("Cannot create header view")
            }
            supplementaryView.setup(title: self.matchSection.title)
            return supplementaryView
        }
    }
    
    func setData(section: MatchSection, matchInfos: [MatchInfo]) {
        var snapshot = MatchSnapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(matchInfos)
        matchDataSource.apply(snapshot)
    }
}
