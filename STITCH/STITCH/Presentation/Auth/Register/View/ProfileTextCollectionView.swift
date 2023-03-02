//
//  ProfileTextCollectionView.swift
//  STITCH
//
//  Created by neuli on 2023/02/19.
//

import UIKit

final class ProfileTextCollectionView: BaseCollectionView {
    
    // MARK: - Properties
    
    typealias ProfileTextDataSource = UICollectionViewDiffableDataSource<Int, ProfileText>
    typealias ProfileTextSnapshot = NSDiffableDataSourceSnapshot<Int, ProfileText>
    
    var profileTextDataSource: ProfileTextDataSource!
    
    // MARK: - Initializer
    
    override init(
        _ delegate: UICollectionViewDelegate,
        layout: UICollectionViewLayout
    ) {
        super.init(delegate, layout: layout)
    }
    
    // MARK: - Methods
    
    override func configureUI() {
        backgroundColor = .background
    }
    
    override func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ProfileTextCell, ProfileText> {
            cell, indexPath, text in
            cell.setLabel(text: text)
        }
        
        profileTextDataSource = ProfileTextDataSource(collectionView: self) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: ProfileText)
            -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }
    }
    
    func setData(_ texts: [ProfileText]) {
        var snapshot = ProfileTextSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(texts)
        profileTextDataSource.apply(snapshot)
    }
}
