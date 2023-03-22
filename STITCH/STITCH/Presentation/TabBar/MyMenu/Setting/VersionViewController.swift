//
//  VersionViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/20.
//

import UIKit

final class VersionViewController: BaseViewController, BackButtonProtocol {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding16 = 16
    }
    
    var backButton: UIButton!
    
    private let versionLabel = DefaultTitleLabel(text: "")
    
    // MARK: - Initializer
    
    override init() {
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return }
        versionLabel.text = version
        addBackButtonTap()
    }
    
    override func bind() {
    }
    
    override func configureNavigation() {
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(versionLabel)
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(Constant.padding16)
            make.left.equalToSuperview().offset(Constant.padding16)
        }
    }
}
