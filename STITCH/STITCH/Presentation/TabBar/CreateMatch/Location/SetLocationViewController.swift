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
        static let locationHeight = 40
        static let gpsBottomPadding = 130
        static let bottomPadding = 200
        static let alpha = 0.7
    }
    
    private lazy var mapView = NMFMapView(frame: view.frame)
    
    private let locationLabel = UILabel().then {
        $0.text = "동작구"
        $0.textColor = .white
        $0.font = .Body2_14
        $0.textAlignment = .center
        $0.backgroundColor = .black.withAlphaComponent(Constant.alpha)
    }
    
    private let gpsButton = UIButton().then {
        $0.setImage(.mapGPS, for: .normal)
    }
    
    private let searchPlaceView = SearchPlaceView()
    
    // MARK: Properties
    
    private let mapLocationObservable = PublishRelay<LocationInfo>()
    
    private var marker: NMFMarker?
    private var currentLocation: NMGLatLng?
    
    private lazy var locationManager = CLLocationManager().then {
        $0.delegate = self
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.distanceFilter = kCLDistanceFilterNone
    }
    private let geocoder = CLGeocoder()
    
    private var panGestureRecognizer: UIPanGestureRecognizer!
    private var searchPlaceViewHeightConstraint: NSLayoutConstraint!
    private let minimumHeight: CGFloat = 36
    private let maximumHeight: CGFloat = UIScreen.main.bounds.height - CGFloat(Constant.bottomPadding)
    
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
        
        searchPlaceView.locationResultCollectionView.delegate = self
        mapView.addCameraDelegate(delegate: self)
        configureMapView()
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
        
        searchPlaceView.searchTextField.rx.controlEvent([.editingDidBegin])
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.showBottomSheetView()
            }
            .disposed(by: disposeBag)
        
        let mapPlacemarkObservable = mapLocationObservable
            .asObservable()
            .map { locationInfo in
                guard let latitude = locationInfo.latitude,
                      let latitude = CLLocationDegrees(latitude),
                      let longitude = locationInfo.longitude,
                      let longitude = CLLocationDegrees(longitude)
                else { return CLLocation() }
                return CLLocation(latitude: latitude, longitude: longitude)
            }
            .withUnretained(self)
            .flatMap { owner, location -> Observable<[CLPlacemark]> in
                return owner.geocoder.rx.reverseGeocodeLocation(location)
            }
            .compactMap { $0.last }
            
        mapPlacemarkObservable
            .withUnretained(self)
            .subscribe { owner, placemark in
                owner.locationLabel.text = placemark.name ?? ""
            }
            .disposed(by: disposeBag)
        
        let input = SetLocationViewModel.Input(
            viewDidLoad: Single<Void>.just(()).asObservable()
        )
        
        let output = setLocationViewModel.transform(input: input)
        
        output.configureCollectionViewData
            .withUnretained(self)
            .subscribe { owner, locations in
                owner.searchPlaceView.locationResultCollectionView.setData(locations)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(mapView)
        view.addSubview(locationLabel)
        view.addSubview(gpsButton)
        view.addSubview(searchPlaceView)
        
        mapView.snp.updateConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide)
            make.left.right.bottom.equalToSuperview()
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(Constant.locationHeight)
        }
        
        gpsButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constant.padding20)
            make.bottom.equalToSuperview().inset(Constant.gpsBottomPadding)
        }
        
        configureBottomSheetView()
    }
    
    override func configureNavigation() {
        navigationController?.navigationBar.barTintColor = .background
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
}

extension SetLocationViewController {
    
    // MARK: Map
    
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
    
    // MARK: Bottom Sheet
    
    private func configureBottomSheetView() {
        let topConstant: CGFloat = maximumHeight
        searchPlaceViewHeightConstraint = searchPlaceView.topAnchor.constraint(
            equalTo: view.layoutMarginsGuide.topAnchor,
            constant: topConstant
        )
        searchPlaceView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
        NSLayoutConstraint.activate([searchPlaceViewHeightConstraint])
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGestureRecognizer.delaysTouchesBegan = false
        panGestureRecognizer.delaysTouchesEnded = false
        searchPlaceView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let yTranslation = translation.y

        switch sender.state {
        case .changed:
            let newHeight = searchPlaceViewHeightConstraint.constant - yTranslation
            searchPlaceViewHeightConstraint.constant = max(minimumHeight, min(newHeight, maximumHeight))
            sender.setTranslation(.zero, in: view)
        case .ended:
            let velocity = sender.velocity(in: view).y
            if velocity > 0 {
                hideBottomSheetView()
            } else if velocity < 0 {
                showBottomSheetView()
            }
        default:
            break
        }
    }
    
    private func showBottomSheetView() {
        searchPlaceViewHeightConstraint.constant = minimumHeight
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideBottomSheetView() {
        searchPlaceViewHeightConstraint.constant = maximumHeight
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        hideKeyboard()
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
    
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        // 멈췄을 때
        let center = mapView.projection.latlng(from: CGPoint(
            x: view.frame.midX, y: view.frame.midY - 50)
        )
        mapLocationObservable.accept(
            LocationInfo(address: "", latitude: String(center.lat), longitude: String(center.lng))
        )
    }
}

// MARK: - NMFLocationManagerDelegate

extension SetLocationViewController: NMFLocationManagerDelegate {
}

// MARK: - CLLocationManagerDelegate

extension SetLocationViewController: CLLocationManagerDelegate {
    
}

// MARK: - UICollectionViewDelegate

extension SetLocationViewController: UICollectionViewDelegate {
    
}
