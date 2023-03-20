//
//  SelectPhotoView.swift
//  STITCH
//
//  Created by neuli on 2023/03/06.
//

import UIKit

final class SelectPhotoView: UIControl {
    
    enum Constant {
        static let borderWidth = 1
        static let iconWidth = 32
        static let labelHeight = 20
        static let radius24 = 24
        static let padding4 = 4
        static let padding20 = 20
    }
    
    // MARK: - Properties
    
    lazy var photoView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let photoIconView = UIImageView(image: .gallery)
    
    private let photoLabel = UILabel().then {
        $0.font = .Body2_14
        $0.textColor = .gray09
        $0.text = "사진 추가 (선택)"
        $0.textAlignment = .center
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func configureUI() {
        backgroundColor = .gray12
        layer.borderWidth = CGFloat(Constant.borderWidth)
        layer.borderColor = UIColor.gray11.cgColor
        layer.cornerRadius = CGFloat(Constant.radius24)
        clipsToBounds = true
        
        addSubview(photoIconView)
        addSubview(photoLabel)
        addSubview(photoView)
        
        photoIconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.padding20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(Constant.iconWidth)
        }
        
        photoLabel.snp.makeConstraints { make in
            make.top.equalTo(photoIconView.snp.bottom).offset(Constant.padding4)
            make.left.right.equalToSuperview()
            make.height.equalTo(Constant.labelHeight)
        }
        
        photoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
