//
//  SettingHeaderView.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import UIKit

final class SettingHeaderView: UITableViewHeaderFooterView {
    
    enum Constant {
        static let padding8 = 8
        static let padding16 = 16
        static let padding24 = 24
        static let padding32 = 32
    }
    
    static let reuseIdentifier = "SettingHeaderView"
    
    private let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .Headline_20
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: Self.reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.padding24)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.bottom.equalToSuperview().inset(Constant.padding24)
        }
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
}
