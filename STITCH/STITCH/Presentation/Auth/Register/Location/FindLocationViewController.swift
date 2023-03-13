//
//  FindLocationViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/20.
//

import CoreLocation
import UIKit

import RxSwift

final class FindLocationViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let textFieldHeight = 56
        static let rowHeight = 1
        static let buttonHeight = 32
        static let radius16 = 16
        static let padding2 = 2
        static let padding8 = 8
        static let padding16 = 16
        static let padding24 = 24
        static let padding32 = 32
    }
    
    private let searchTextField = DefaultTextField(
        placeholder: "동명(읍, 면)으로 검색 (ex.서초동)",
        leftSearchView: true
    )
    
    private let textFieldRowView = UIView().then {
        $0.backgroundColor = .gray09
    }
    
    private let searchButton = DefaultButton(
        title: " 현재위치로 찾기",
        font: .Caption1_12,
        icon: .gps,
        radius: Constant.radius16
    )
    
    private let searchResultTitleLabel = UILabel().then {
        $0.text = "현재위치 결과"
        $0.textColor = .white
        $0.font = .Subhead_16
    }
    
    private lazy var locationResultCollectionView = LocationResultCollectionView(
        self,
        layout: LocationResultCollectionViewLayout.layout()
    )
    
    // MARK: Properties
    
    private let findLocationViewModel: FindLocationViewModel
    
    private lazy var locationManager = CLLocationManager().then {
        $0.delegate = self
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.distanceFilter = kCLDistanceFilterNone
    }
    
    // MARK: - Initializer
    
    init(findLocationViewModel: FindLocationViewModel) {
        self.findLocationViewModel = findLocationViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
        // TODO: 권한을 받아 온 후에 근처 리스트
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func bind() {
        locationManager.rx.didChangeAuthorization.asObservable()
            .filter { $0 == .authorizedAlways || $0 == .authorizedWhenInUse }
            .subscribe { authorizationStatus in
                print(authorizationStatus)
            }
            .disposed(by: disposeBag)
        
        locationManager.rx.didChangeLocation.asObservable()
            .take(1)
            .subscribe { location in
                print(location.coordinate.longitude, location.coordinate.latitude)
            }
            .disposed(by: disposeBag)
        
        locationManager.rx.didFailWithError.asObservable()
            .subscribe { error in
                print("locationManager Failed: \(error.debugDescription)")
            }
            .disposed(by: disposeBag)
        
        
        let input = FindLocationViewModel.Input(
            configureCollectionView: Single<Void>.just(()).asObservable()
        )
        
        let output = findLocationViewModel.transform(input: input)
        
        output.configureCollectionViewData
            .withUnretained(self)
            .subscribe { owner, locations in
                owner.locationResultCollectionView.setData(locations)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(searchTextField)
        view.addSubview(textFieldRowView)
        view.addSubview(searchButton)
        view.addSubview(searchResultTitleLabel)
        view.addSubview(locationResultCollectionView)
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.textFieldHeight)
        }
        
        textFieldRowView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.rowHeight)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldRowView.snp.bottom).offset(Constant.padding24)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.buttonHeight)
        }
        
        searchResultTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(Constant.padding32)
            make.left.equalToSuperview().offset(Constant.padding16)
        }
        
        locationResultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchResultTitleLabel.snp.bottom).offset(Constant.padding24)
            make.left.equalToSuperview()
            make.right.bottom.equalToSuperview().inset(Constant.padding16)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension FindLocationViewController: UICollectionViewDelegate {
    
}

// MARK: - CLLocationManagerDelegate

extension FindLocationViewController: CLLocationManagerDelegate {
    func findAddress(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) {
            marks, error in
            if let error {
                print("주소 geocode 에러: \(error.localizedDescription)")
                return
            }
            if let mark: CLPlacemark = marks?.last {
                print("== CoreLocation Framework ==")
                print("subThoroughfare : \(mark.subThoroughfare ?? "")")
                print("country : \(mark.country ?? "")")
                print("administrativeArea : \(mark.administrativeArea ?? "")")
                print("locality : \(mark.locality ?? "")")
                print("name : \(mark.name ?? "")")
                print("description : \(mark.description)")
            }
        }
    }
}
