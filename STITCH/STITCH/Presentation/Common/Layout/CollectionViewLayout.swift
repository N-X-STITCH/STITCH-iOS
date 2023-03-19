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
            item.edgeSpacing = .init(leading: .fixed(10), top: nil, trailing: .fixed(10), bottom: .fixed(16))
            
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
        listConfiguration.backgroundColor = .clear
        listConfiguration.separatorConfiguration.color = .gray11
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

enum PopularCollectionViewLayout {
    
    enum Constant {
        static let padding16 = 16
        static let headerHeight = 44
        static let groupFractionalWidth = 0.9
        static let groupHeight = 340
    }
    
    static func layout() -> UICollectionViewLayout {
        let sectionProvider = {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(CGFloat(Constant.groupHeight))
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .absolute(CGFloat(Constant.groupHeight))
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            group.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 0,
                bottom: 0,
                trailing: CGFloat(Constant.padding16)
            )
            
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(CGFloat(Constant.headerHeight))
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: PopularMatchCollectionView.sectionHeaderElementKind,
                alignment: .top
            )
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [sectionHeader]
            section.orthogonalScrollingBehavior = .groupPaging
            
            return section
        }
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        return UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider,
            configuration: configuration
        )
    }
}

enum MatchCollectionViewLayout {
    
    enum Constant {
        static let padding16 = 16
        static let padding24 = 24
        static let headerHeight = 84
        static let groupHeight = 112
    }
    
    static func layout(matchSection: MatchSection) -> UICollectionViewLayout {
        let sectionProvider = {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(CGFloat(Constant.groupHeight))
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            group.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 0,
                bottom: CGFloat(Constant.padding24),
                trailing: 0
            )
            
            if matchSection != .none {
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(CGFloat(Constant.headerHeight))
                )
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: MatchCollectionView.sectionHeaderElementKind,
                    alignment: .top
                )
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = CGFloat(Constant.padding24)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            } else {
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = CGFloat(Constant.padding24)
                return section
            }
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}

enum MatchTypeCollectionViewLayout {
    
    enum Constant {
        static let padding12 = 12
        static let groupHeight = 80
    }
    
    static func layout() -> UICollectionViewLayout {
        let sectionProvider = {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(CGFloat(Constant.groupHeight))
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(CGFloat(Constant.groupHeight))
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            group.edgeSpacing = NSCollectionLayoutEdgeSpacing(
                leading: nil, top: nil, trailing: nil, bottom: .fixed(CGFloat(Constant.padding12))
            )
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}

enum SportCategoryCollectionViewLayout {
    
    enum Constant {
        static let padding12 = 12
        static let groupWidth = 52
        static let groupHeight = 74
    }
    
    static func layout() -> UICollectionViewLayout {
        let sectionProvider = {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(CGFloat(Constant.groupWidth)),
                heightDimension: .absolute(CGFloat(Constant.groupHeight))
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(CGFloat(Constant.groupWidth)),
                heightDimension: .absolute(CGFloat(Constant.groupHeight))
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            group.edgeSpacing = NSCollectionLayoutEdgeSpacing(
                leading: .fixed(CGFloat(Constant.padding12)), top: nil, trailing: nil, bottom: nil
            )
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}
