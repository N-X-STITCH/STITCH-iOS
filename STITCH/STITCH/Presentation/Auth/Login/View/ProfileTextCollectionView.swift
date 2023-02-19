//
//  ProfileTextCollectionView.swift
//  STITCH
//
//  Created by neuli on 2023/02/19.
//

import UIKit

final class ProfileTextCollectionView: UICollectionView {
    
    // MARK: - Properties
    
    typealias ProfileTextDataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias ProfileTextSnapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    var profileTextDataSource: ProfileTextDataSource!
    
    // MARK: - Initializer
    
    init(_ delegate: UICollectionViewDelegate) {
        super.init(
            frame: .zero,
            collectionViewLayout: ProfileTextCollectionViewLayout.layout()
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
        let cellRegistration = UICollectionView.CellRegistration<ProfileTextCell, String> {
            cell, indexPath, text in
            cell.setLabel(text: text)
        }
        
        profileTextDataSource = ProfileTextDataSource(collectionView: self) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: String)
            -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }
    }
    
    func setData(_ texts: [String]) {
        var snapshot = ProfileTextSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(texts)
        profileTextDataSource.apply(snapshot)
    }
}
