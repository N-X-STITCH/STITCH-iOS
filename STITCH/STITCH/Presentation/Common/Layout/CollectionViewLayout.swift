//
//  CollectionViewLayout.swift
//  STITCH
//
//  Created by neuli on 2023/02/19.
//

import UIKit

enum ProfileTextCollectionViewLayout {
    
    enum Constant {
        static let cellHeight = 44
        static let inset = 12
    }
    
    static func layout() -> UICollectionViewLayout {
        let sectionProvider = {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(CGFloat(Constant.cellHeight))
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 0,
                bottom: CGFloat(Constant.inset),
                trailing: 0
            )
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(CGFloat(Constant.cellHeight))
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}

enum SportsCollectionViewLayout {
    
    enum Constant {
        static let cellHeight = 88
        static let spacing8 = 8
    }
    
    static func layout() -> UICollectionViewLayout {
        let sectionProvider = {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(CGFloat(Constant.cellHeight)),
                heightDimension: .absolute(CGFloat(Constant.cellHeight))
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.edgeSpacing = .init(leading: .fixed(8), top: nil, trailing: .fixed(8), bottom: .fixed(16))
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(CGFloat(Constant.cellHeight + Constant.spacing8 * 2))
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section

        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}

enum LocationResultCollectionViewLayout {
    static func layout() -> UICollectionViewLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        listConfiguration.backgroundColor = .background
        listConfiguration.separatorConfiguration.color = .gray11
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}
