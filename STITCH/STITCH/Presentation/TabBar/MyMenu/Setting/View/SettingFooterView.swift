//
//  SettingFooterView.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import UIKit

final class SettingFooterView: UITableViewHeaderFooterView {
    
    enum Constant {
        static let padding24 = 24
        static let height = 8
    }
    
    static let reuseIdentifier = "SettingFooterView"
    
    private let footerView = UIView().then {
        $0.backgroundColor = .gray12
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: Self.reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(footerView)
        footerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.padding24)
            make.left.right.equalToSuperview()
            make.height.equalTo(Constant.height)
        }
    }
}
