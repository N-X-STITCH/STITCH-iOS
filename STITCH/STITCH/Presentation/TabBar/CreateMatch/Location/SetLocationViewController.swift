//
//  SetLocationViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/12.
//

import CoreLocation
import UIKit

import NMapsMap
import RxSwift
import RxCocoa

final class SetLocationViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding16 = 16
        static let padding20 = 20
        static let padding24 = 24
        static let padding32 = 32
    }
    
    private lazy var mapView = NMFMapView(frame: view.frame)
    
    private let gpsButton = UIButton().then {
        $0.setImage(.mapGPS, for: .normal)
    }
    
    // MARK: Properties
    
    private var marker: NMFMarker?
    private var currentLocation: NMGLatLng?
    private lazy var locationManager = CLLocationManager().then {
        $0.delegate = self
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.distanceFilter = kCLDistanceFilterNone
    }
    
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
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
//        mapView.touchDelegate = self
        mapView.addCameraDelegate(delegate: self)
    }
    
    override func bind() {
        gpsButton.rx.tap
            .withLatestFrom(locationManager.rx.didChangeLocation.asObservable())
            .withUnretained(self)
            .subscribe { owner, location in
                let location = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
                owner.currentLocation = location
                owner.moveMarker(to: location)
                owner.moveCamera(to: location)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(mapView)
        view.addSubview(gpsButton)
        
        mapView.snp.updateConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide)
            make.left.right.bottom.equalToSuperview()
        }
        
        gpsButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constant.padding20)
            make.bottom.equalToSuperview().inset(Constant.padding24)
        }
        
        configureMapView()
    }
    
    override func configureNavigation() {
        navigationController?.navigationBar.barTintColor = .background
    }
}

extension SetLocationViewController {
    private func configureMapView() {
        let center = mapView.projection.latlng(from: CGPoint(
            x: view.frame.midX, y: view.frame.midY - 50)
        )
        // 화면 중앙에 마커 추가
        marker = NMFMarker(position: center)
        marker?.iconImage = NMFOverlayImage(image: .marker ?? .strokedCheckmark)
        marker?.mapView = mapView
        
        // 현재 위치 표시
        mapView.positionMode = .direction
        
    }
    
    private func moveMarker(to location: NMGLatLng) {
        marker?.position = location
        marker?.mapView = mapView
    }
    
    private func moveCamera(to location: NMGLatLng) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: location)
        cameraUpdate.animation = .fly
        mapView.moveCamera(cameraUpdate)
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
            x: view.frame.midX, y: view.frame.midY - 50)
        )
        currentLocation = center
        moveMarker(to: center)
    }
}

// MARK: - NMFLocationManagerDelegate

extension SetLocationViewController: NMFLocationManagerDelegate {
    @nonobjc func locationManager(_ locationManager: NMFLocationManager!, didUpdate newHeading: CLHeading!) {
        let location = mapView.projection.latlng(from: CGPoint(x: newHeading.x, y: newHeading.y))
        currentLocation = location
    }
}

// MARK: - CLLocationManagerDelegate

extension SetLocationViewController: CLLocationManagerDelegate {
    
}
