//
//  LocationResultCollectionView.swift
//  STITCH
//
//  Created by neuli on 2023/02/24.
//

import UIKit

final class LocationResultCollectionView: BaseCollectionView {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, LocationInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, LocationInfo>
    
    // MARK: - Properties
    
    var locationDataSource: DataSource!
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    override func configureUI() {
        backgroundColor = .clear
    }
    
    override func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<LocationResultCell, LocationInfo> {
            cell, indexPath, locationInfo in
            cell.location = locationInfo
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .clear
            cell.backgroundConfiguration = backgroundConfig
            
            var content = cell.defaultContentConfiguration()
            content.text = "\(locationInfo.placeName ?? "")"
            content.textProperties.font = .Body1_16 ?? .systemFont(ofSize: 16, weight: .regular)
            content.textProperties.color = .gray02
            cell.contentConfiguration = content
        }
        
        locationDataSource = DataSource(collectionView: self) {
            collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }
    }
    
    func setData(_ locations: [LocationInfo]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(locations)
        locationDataSource.apply(snapshot)
    }
}
