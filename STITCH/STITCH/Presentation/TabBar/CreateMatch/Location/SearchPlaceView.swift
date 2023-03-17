//
//  SearchPlaceView.swift
//  STITCH
//
//  Created by neuli on 2023/03/13.
//

import UIKit

import NMapsMap

final class SearchPlaceView: UIView {
    
    enum Constant {
        static let padding6 = 6
        static let padding16 = 16
        static let padding12 = 12
        static let padding24 = 24
        static let padding32 = 32
        static let barWidth = 40
        static let barHeight = 4
        static let radius = 2
        static let textFieldHeight = 56
        static let rowHeight = 1
        static let collectionViewHeight = UIScreen.main.bounds.height - 300
    }
    
    // MARK: - Properties
    
    private let topBarView = UIView().then {
        $0.backgroundColor = .gray10
        $0.layer.cornerRadius = CGFloat(Constant.radius)
    }
    
    let searchTextField = DefaultTextField(
        placeholder: "동명(읍, 면)으로 검색 (ex.서초동)",
        leftSearchView: true
    )
    
    private let textFieldRowView = UIView().then {
        $0.backgroundColor = .gray09
    }
    
    let searchResultTitleLabel = UILabel().then {
        $0.text = "검색 결과"
        $0.textColor = .white
        $0.font = .Subhead_16
    }
    
    lazy var locationResultCollectionView = LocationResultCollectionView(
        layout: LocationResultCollectionViewLayout.layout()
    )
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .gray12
        layer.cornerRadius = 17
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        clipsToBounds = true
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    private func configureUI() {
        addSubview(topBarView)
        addSubviews([searchTextField, textFieldRowView])
        addSubview(searchResultTitleLabel)
        addSubview(locationResultCollectionView)
        
        topBarView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.padding12)
            make.width.equalTo(Constant.barWidth)
            make.height.equalTo(Constant.barHeight)
            make.centerX.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(topBarView.snp.bottom).offset(Constant.padding6)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.textFieldHeight)
        }
        
        textFieldRowView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.rowHeight)
        }
        
        searchResultTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldRowView.snp.bottom).offset(Constant.padding32)
            make.left.equalToSuperview().offset(Constant.padding16)
        }

        locationResultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchResultTitleLabel.snp.bottom).offset(Constant.padding24)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(Constant.collectionViewHeight)
        }
    }
}
