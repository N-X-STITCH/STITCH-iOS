//
//  SetLocationViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/12.
//

import UIKit

import NMapsMap
import RxSwift
import RxCocoa

final class SetLocationViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding16 = 16
        static let padding24 = 24
        static let padding32 = 32
    }
    
    private lazy var mapView = NMFMapView(frame: view.frame)
    
    // MARK: Properties
    
    private var marker: NMFMarker?
    private var currentLocation: NMGLatLng?
    
    private let createMatchViewModel: CreateMatchViewModel
    private let setLocationViewModel: SetLocationViewModel
    
    // MARK: - Initializer
    
    init(
        createMatchViewModel: CreateMatchViewModel,
        setLocationViewModel: SetLocationViewModel
    ) {
        self.createMatchViewModel = createMatchViewModel
        self.setLocationViewModel = setLocationViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
        mapView.touchDelegate = self
        mapView.addCameraDelegate(delegate: self)
    }
    
    override func bind() {
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(mapView)
        
        configureMapView()
    }
}

extension SetLocationViewController {
    private func configureMapView() {
        let center = mapView.projection.latlng(from: CGPoint(
            x: mapView.frame.midX, y: mapView.frame.midY)
        )
        // 화면 중앙에 마커 추가
        marker = NMFMarker(position: center)
        marker?.mapView = mapView
        
        // 현재 위치 표시
        mapView.positionMode = .direction
    }
    
    private func moveMarker(to location: NMGLatLng) {
        marker?.position = location
        marker?.mapView = mapView
    }
}

// MARK: - NMFMapViewTouchDelegate

extension SetLocationViewController: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        moveMarker(to: latlng)
    }
}

// MARK: - NMFMapViewCameraDelegate

extension SetLocationViewController: NMFMapViewCameraDelegate {
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        let center = mapView.projection.latlng(from: CGPoint(
            x: mapView.frame.midX, y: mapView.frame.midY)
        )
        currentLocation = center
    }
}

extension SetLocationViewController: NMFLocationManagerDelegate {
    func locationManager(_ locationManager: NMFLocationManager!, didUpdate newHeading: CLHeading!) {
        let location = mapView.projection.latlng(from: CGPoint(x: newHeading.x, y: newHeading.y))
        currentLocation = location
    }
}
