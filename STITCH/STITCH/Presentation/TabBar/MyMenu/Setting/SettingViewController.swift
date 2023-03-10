//
//  SettingViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import UIKit

final class SettingViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding12 = 12
        static let padding16 = 16
        static let padding24 = 24
        static let padding32 = 32
        static let padding40 = 40
    }
    
    private let settingTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.separatorStyle = .none
        $0.backgroundColor = .background
        $0.sectionFooterHeight = 32
    }
    
    // MARK: Properties
    
    private let settingViewModel: SettingViewModel
    
    // MARK: - Initializer
    
    init(settingViewModel: SettingViewModel) {
        self.settingViewModel = settingViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(
            SettingHeaderView.self,
            forHeaderFooterViewReuseIdentifier: SettingHeaderView.reuseIdentifier
        )
        settingTableView.register(
            SettingFooterView.self,
            forHeaderFooterViewReuseIdentifier: SettingFooterView.reuseIdentifier
        )
    }
    
    override func bind() {
    }
    
    override func configureNavigation() {
    }
    
    override func configureUI() {
        view.addSubview(settingTableView)
        settingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("클릭")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: SettingHeaderView.reuseIdentifier
        ) as? SettingHeaderView else {
            return UIView()
        }
        header.set(title: SettingSection.allCases[section].title)
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: SettingFooterView.reuseIdentifier
        ) as? SettingFooterView else {
            return UIView()
        }
        return footer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return GuideSection.allCases.count
        case 1: return AccountSection.allCases.count
        case 2: return NoneSection.allCases.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        var background = cell.defaultBackgroundConfiguration()
        content.attributedText = makeTableViewCellTitle(indexPath)
        background.backgroundColor = .background
        cell.contentConfiguration = content
        cell.backgroundConfiguration = background
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    private func makeTableViewCellTitle(_ indexPath: IndexPath) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.Body2_14 ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.gray02
        ]
        return NSAttributedString(
            string: SettingSection.allCases[indexPath.row].rowTitle(indexPath),
            attributes: attributes
        )
    }
}
